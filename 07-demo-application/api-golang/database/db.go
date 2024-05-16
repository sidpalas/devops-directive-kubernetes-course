package database

import (
	"context"
	"fmt"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgxpool"
)

var pool *pgxpool.Pool

// InitDB initialize the database pool and returns error
func InitDB(connString string) error {
	var err error
	pool, err = pgxpool.New(context.Background(), connString)
	if err != nil {
		return err
	}
	return nil
}

func InsertView(ctx *gin.Context) {
	_, err := pool.Exec(ctx, "INSERT INTO request (api_name) VALUES ('go');")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Query failed: %v\n", err)
		os.Exit(1)
	}
}

func GetTimeAndRequestCount(ctx *gin.Context) (time.Time, int) {
	var tm time.Time
	var reqCount int
	err := pool.QueryRow(ctx, "SELECT NOW() AS current_time, COUNT(*) AS request_count FROM public.request WHERE api_name = 'go';").Scan(&tm, &reqCount)
	if err != nil {
		fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
		os.Exit(1)
	}
	return tm, reqCount
}
