package main

import (
	"io/ioutil"
	"log"
	"os"
	"time"

	"github.com/gin-gonic/gin"

	"api-golang/database"
)

func init() {
	databaseUrl := os.Getenv("DATABASE_URL")
	if databaseUrl == "" {
		content, err := ioutil.ReadFile(os.Getenv("DATABASE_URL_FILE"))
		if err != nil {
			log.Fatal(err)
		}
		databaseUrl = string(content)
	}

	errDB := database.InitDB(databaseUrl)
	if errDB != nil {
		log.Fatalf("⛔ Unable to connect to database: %v\n", errDB)
	} else {
		log.Println("DATABASE CONNECTED 🥇")
	}

}

func main() {

	r := gin.Default()
	var tm time.Time
	var reqCount int

	r.GET("/", func(c *gin.Context) {
		database.InsertView(c)
		tm, reqCount = database.GetTimeAndRequestCount(c)
		c.JSON(200, gin.H{
			"api":          "go",
			"currentTime":  tm,
			"requestCount": reqCount,
		})
	})

	r.GET("/ping", func(c *gin.Context) {
		_, _ = database.GetTimeAndRequestCount(c)
		c.JSON(200, "pong")
	})

	port := os.Getenv("PORT")
	if port == "" {
		// Defaulting to 8000 to deconflict with unprivileged nginx container
		port = "8000"
	}

	r.Run(":" + port) // listen and serve on 0.0.0.0:8000 (or "PORT" env var if set)}
}