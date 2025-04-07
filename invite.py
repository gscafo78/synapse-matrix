import requests
import time

access_token = "syt_c3lzYWRt_IXhihJVzNgzUBJCSHsTM_3PIdse"
room_id = "!thLXNJrAxFQBBurwSq:matrixacd.duckdns.org"
server_url = "http://127.0.0.1:8008"
users = [
    "@acquarelli_e:matrixacd.duckdns.org",
    # "@argenio_l:matrixacd.duckdns.org",
    # "@barbato_s:matrixacd.duckdns.org",
    # "@cavone_v:matrixacd.duckdns.org",
    # "@dangelo_g:matrixacd.duckdns.org",
    # "@depascalis_a:matrixacd.duckdns.org",
    # "@digi:matrixacd.duckdns.org",
    "@dileo_p:matrixacd.duckdns.org",
    # "@esse:matrixacd.duckdns.org",
    # "@federico_f:matrixacd.duckdns.org",
    "@ferrara_a:matrixacd.duckdns.org",
    # "@filosa_r:matrixacd.duckdns.org",
    # "@furno_c:matrixacd.duckdns.org",
    # "@gscafo78:matrixacd.duckdns.org",
    # "@losito_a:matrixacd.duckdns.org",
    # "@miriello_m:matrixacd.duckdns.org",
    "@moretti_r:matrixacd.duckdns.org",
    # "@nikpelle:matrixacd.duckdns.org",
    "@orlando_a:matrixacd.duckdns.org",
    # "@ruiu_s:matrixacd.duckdns.org",
    # "@squitieri_c:matrixacd.duckdns.org",
    "@tonielli_m:matrixacd.duckdns.org"
]

for user in users:
    response = requests.post(
        f"{server_url}/_matrix/client/r0/rooms/{room_id}/invite",
        headers={"Authorization": f"Bearer {access_token}"},
        json={"user_id": user}
    )
    print(f"Invito a {user}:", "Successo" if response.status_code == 200 else "Fallito")
    time.sleep(2)  # Pausa di 5 secondi tra una richiesta e l'altra