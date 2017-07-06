From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Thu, 6 Jul 2017 08:38:43 +0200
Message-ID: <20170706063843.GC1418@katana>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
 <TY1PR06MB0992844258B8EE4C70C403D2D8D40@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR06MB0992844258B8EE4C70C403D2D8D40@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan.kloetzke@technisat.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, KOUEI ABE <kouei.abe.cp@renesas.com>, DUNG NGUYEN <dung.nguyen.aj@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I and Dung-san are testing this patch.
> However, this original code doesn't run by our test cases.
> Do you know how this original code runs?
> Anyway, we will try to make a test case somehow now.

Thank you very much, Shimoda-san. I got it tested because a card needed
re-tuning during a transfer.

It might work if you manually induce an error bit in the driver
somewhere. I'll try to find a good sport later, too. However, I am away
=66rom my boards today and tomorrow.


--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlld2vMACgkQFA3kzBSg
KbYDmw//XZjuQzyK0ZzGIApzQsZsRpwv7Yg7bJDFOXTTLzxDhhBbMZkyNCTF7+6p
3+JklzKhBUxWEMtFq/O/vkx1vEuZrOv1ZWxwqIguvZMyfgFBRZy4wh3Il5U6KmCp
tF4p08sb8UY5hlnH52eUUyzf82OZjfFpFDRxXU/KNpUfFs8/QhiIAHA4ZNRLQbon
OM501uGHiKbJmRwY7LSTII6uK+I6ereoZKbtYjTyV26BrZ9rzW1HK2/rJVQ9DPWY
ZWK8r3rFLKaOYOKOvri+wC7qpRxUxHodPivwOWHhmH9fwaYBTbbJOCX4E/XetTaL
K60rqp1fZ10mrR503iHmXYA22yTw9rjncK+zcw1LkPj5qtpUvb1svPQg4JyyTRwK
RnVHP7O3NMMBktEwhOSzs/o4hU48m5gAtuSpHyvtTVK5H2fcJfBAst6IDzwUoI3U
7R6MscjdDHubiwRkzpa1OYR7P9kvqhi9Ml1Bg3h9WshDypGH1YcndzYS9PoiVz79
EINpxII0aXKZEbINrwkmIt1AWFluhGjMo1ZKxlQsUVBCD68N7INu7uIcKHWyK8fQ
1W6DiIDnc4YpKC9NAMKOyc1f1Ze/aqCwMAXgrnAco4/1tw62U5/QGN/InmEYV7c6
hkKnKCFiIP6AdMg3NKhkxyHN+7XP/kcBs0I6e2a8XvfMIz0j5e0=
=YNFx
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
