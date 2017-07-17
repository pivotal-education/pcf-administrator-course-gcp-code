resource "google_service_account" "opsman_service_account" {
  account_id   = "${var.env_name}-opsman"
  display_name = "${var.env_name} Ops Manager VM Service Account"
}

resource "google_project_iam_policy" "opsman_service_account_project" {
  project     = "${var.project}"
  policy_data = "${data.google_iam_policy.opsman_policy.policy_data}"
}

data "google_iam_policy" "opsman_policy" {
  binding {
    role = "roles/iam.serviceAccountActor"

    members = [
      "serviceAccount:${google_service_account.opsman_service_account.email}",
    ]
  }

  binding {
    role = "roles/compute.instanceAdmin.v1"

    members = [
      "serviceAccount:${google_service_account.opsman_service_account.email}",
    ]
  }

  binding {
    role = "roles/compute.networkAdmin"

    members = [
      "serviceAccount:${google_service_account.opsman_service_account.email}",
    ]
  }

  binding {
    role = "roles/compute.storageAdmin"

    members = [
      "serviceAccount:${google_service_account.opsman_service_account.email}",
    ]
  }

  binding {
    role = "roles/storage.admin"

    members = [
      "serviceAccount:${google_service_account.opsman_service_account.email}",
    ]
  }
}
