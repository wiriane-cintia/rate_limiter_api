## **Rate Limiter API**
This project implements a **Rate Limiting System** using **Elixir** and **Phoenix Framework**. It limits the number of requests per second per IP address, ensuring fair usage and protecting the system from abuse. The implementation uses **ETS (Erlang Term Storage)** for high-performance request tracking.

---

### **Features**
- **IP-based rate limiting**: Limits the number of requests per second for each IP address.
- **Customizable limit**: Easily configure the maximum allowed requests per second.
- **Real-time processing**: Efficiently handles concurrent requests.
- **High-performance**: Built using **ETS**, ensuring minimal overhead.
- **Error handling**: Returns `429 Too Many Requests` for users exceeding the limit.

---

### **Advantages**
- **Scalability**: Built with Elixir’s concurrency model to handle a large number of requests efficiently.
- **Customizable**: Easily adjust the rate-limiting threshold.
- **Simple Integration**: Can be extended for other projects requiring rate limiting.
- **Security**: Prevents abusive usage and protects critical resources.

---

### **Endpoints**
1. **GET `/api/test`**
   - **Purpose**: Test the rate-limiting system.
   - **Success Response**: 
     ```json
     {
       "message": "Request allowed"
     }
     ```
   - **Error Response**:
     ```json
     {
       "error": "Rate limit exceeded"
     }
     ```

---

### **Setup Instructions**

#### **Prerequisites**
- **Elixir**: [Install Elixir](https://elixir-lang.org/install.html)
- **Phoenix Framework**: Install Phoenix with:
  ```bash
  mix archive.install hex phx_new
  ```
- **PostgreSQL**: Ensure PostgreSQL is installed and running.
- **Docker** (Optional): Use Docker if you prefer containerized environments.
- **Apache Benchmark (ab)**: Install `ab` for stress testing:
  ```bash
  sudo apt update
  sudo apt install apache2-utils
  ```

---

#### **Clone the Repository**
```bash
git clone https://github.com/wiriane-cintia/rate_limiter.git
cd rate_limiter
```

---

#### **Setup Environment**
1. **Install dependencies**:
   ```bash
   mix deps.get
   ```
2. **Setup database**:
   Edit the `config/dev.exs` file and update your PostgreSQL credentials:
   ```elixir
   config :rate_limiter, RateLimiter.Repo,
     username: "your_username",
     password: "your_password",
     database: "rate_limiter_dev",
     hostname: "localhost",
     show_sensitive_data_on_connection_error: true,
     pool_size: 10
   ```
3. **Create and migrate the database**:
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

---

#### **Run the Server**
1. Start the Phoenix server:
   ```bash
   mix phx.server
   ```
2. The server will run on `http://localhost:4000`.

---

### **Testing the API**
#### **Basic Test**
1. Use `curl` to test the endpoint:
   ```bash
   curl http://localhost:4000/api/test
   ```
2. If the rate limit is exceeded, you will receive:
   ```json
   {
     "error": "Rate limit exceeded"
   }
   ```

---

#### **Load Testing with Apache Benchmark**
1. To simulate multiple requests:
   ```bash
   ab -n 20 -c 10 http://localhost:4000/api/test
   ```
   - `-n 20`: Total number of requests.
   - `-c 10`: Number of concurrent requests.
2. Expected output:
   - **Successful requests** (allowed):
     ```
     Complete requests: 20
     Failed requests: 15
     Non-2xx responses: 15
     ```
   - **Failed requests** correspond to rate-limited responses (`429 Too Many Requests`).

---

### **Customize Rate Limit**
1. Open `lib/rate_limiter/rate_limiter.ex` and adjust:
   ```elixir
   @max_requests_per_second 5
   ```
2. Restart the server for changes to take effect:
   ```bash
   mix phx.server
   ```

---
