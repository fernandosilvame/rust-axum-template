use axum::response::IntoResponse;
use axum::Json;
use axum::Router;
use axum::routing::get;
use hyper::StatusCode;
use serde_json::json;

pub fn router() -> Router {
    Router::new()
        .route("/api/v1/service/status", get(status))
}

pub async fn status() -> impl IntoResponse {
    let version = env!("CARGO_PKG_VERSION");

    let response = json!({
        "data": {
            "version": version,
        },
        "message": "Service is running..."
    });
    (StatusCode::OK, Json(response))
}