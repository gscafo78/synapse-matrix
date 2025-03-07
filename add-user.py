import requests
import argparse
import os

def create_user(base_url, admin_token, user_id, display_name):
    url = f"{base_url}/_synapse/admin/v2/users/{user_id}"
    headers = {
        "Authorization": f"Bearer {admin_token}",
        "Content-Type": "application/json"
    }
    data = {
        "displayname": display_name
    }
    response = requests.put(url, headers=headers, json=data)
    if response.status_code == 201:
        print(f"User successfully created: {display_name}")
    else:
        print(f"Error updating display name: {response.text}")

def main():
    parser = argparse.ArgumentParser(description="Add a new user to Synapse Matrix")
    parser.add_argument("-n", "--name", required=True, help="User's first name")
    parser.add_argument("-s", "--surname", required=True, help="User's last name")
    parser.add_argument("-p", "--password", required=True, help="User's password")
    parser.add_argument("-H", "--host", required=True, help="Matrix server host (e.g., matrixacd.duckdns.org)")
    args = parser.parse_args()

    base_url = "http://127.0.0.1:8008"
    admin_token = os.getenv("TOKEN_ADMIN")
    if not admin_token:
        print("Error: The TOKEN_ADMIN environment variable is not set.")
        return

    name = args.name.capitalize()
    surname = args.surname.lower().replace(" ", "")
    username = f"{surname}_{name[0].lower()}"
    display_name = f"{name} {args.surname.upper()}"

    create_user(base_url, admin_token, f"@{username}:{args.host}", display_name)

if __name__ == "__main__":
    main()