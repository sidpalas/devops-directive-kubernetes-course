const fs = require("fs");

const { Pool } = require("pg");

databaseUrl =
  process.env.DATABASE_URL ||
  fs.readFileSync(process.env.DATABASE_URL_FILE, "utf8");

const pool = new Pool({
  connectionString: databaseUrl,
});

// the pool will emit an error on behalf of any idle clients
// it contains if a backend error or network partition happens
pool.on("error", (err, client) => {
  console.error("Unexpected error on idle client", err);
  process.exit(-1);
});

const getDateTimeAndRequests = async () => {
  const client = await pool.connect();
  try {
    const result = await client.query(`
      SELECT 
      NOW() AS current_time, 
      COUNT(*) AS request_count
      FROM public.request 
      WHERE api_name = 'node';
    `);
    const currentTime = result.rows[0].current_time;
    const requestCount = result.rows[0].request_count;

    return {
      currentTime,
      requestCount,
    };
  } catch (err) {
    console.log(err.stack);
  } finally {
    client.release();
  }
};

const insertRequest = async () => {
  const client = await pool.connect();
  try {
    const res = await client.query(
      "INSERT INTO request (api_name) VALUES ('node');",
    );
    return;
  } catch (err) {
    console.log(err.stack);
  } finally {
    client.release();
  }
};

module.exports = { getDateTimeAndRequests, insertRequest };
