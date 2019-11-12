From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Tue, 12 Nov 2019 21:49:52 +0100
Message-ID: <20191112204952.GA2976@kunai>
References: <20191112134808.23546-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112134808.23546-1-erosca@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 02:48:08PM +0100, Eugeniu Rosca wrote:
> From: Harish Jenny K N <harish_kandiga@mentor.com>
>=20
> Enable MMC_CAP_ERASE capability in the driver to allow
> erase/discard/trim requests.
>=20
> Suggested-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> [erosca: Forward-port and test on v5.4-rc7 using H3ULCB-KF:
>          "blkdiscard /dev/mmcblk0" passes with this patch applied
>          and complains otherwise:
> 	 "BLKDISCARD ioctl failed: Operation not supported"]
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Looks good to me. Just a generic question, probably more for Ulf:

Why does this CAP_ERASE exist? As I understand, the driver only needs to
set the flag and no further handling is required. Why would a driver not
set this flag and not support erase/trim commands?

Kind regards,

   Wolfram


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3LGusACgkQFA3kzBSg
KbYKkw//VxC8isy0WeY7yOM8Eu1mt8LljuDDozsi46StVWx608b6GQAsLW34WLCs
sFTSRhYuQkld3iiYD+mFiQ/4X/W6Wj7c45SaIQ9doP+2EjT592pUMaSNhMTrPt84
XP48vZKZa4SOyEkP/TUSkAXqgFZsqO3Kos/qceqJb02il5N+biuEmFQM6rwj71sx
P71aDgWiq1eKVej8WEHn4t/A+UNsUbQpVmqvyyUXYm7KVgM5PZjogQBzc6Y8p+12
gI6AlUm0h5Nl8o7NDM6jy1VgP+UgZ8qjTTylFcYr6wSKKiUvJNb+U0Imd+txY8DZ
gtoWBuMDPQEAdngoX9jbw6Q9zFI41eJ6fM1LX5UnVO5VxopY+WRqiLfmp4u356tT
T2e/VNX9ZnGTrYWazo3jmpDpL0DoAPhbfgRkrpAG98vtNujOb3xtejglxbPfUYx+
8aXP3a0htCkgsaap34hHeAu4UiOyuZsh6Ie4iHukMP+S3m+5+vX9uXEi7ZQHgiLC
t9ANcKGUki2syaauaCZSSon0E0offhnuNqb6SRHla3rKAptSKNwoqlnDz2LoIUIV
Z+I/YUl2PNcHAJk1IkqIJwnBeMZKVUlMPdi38VlDdFQG0kXdCb6dABe7Km4kOr/e
AgdIusuIpZxP90NAGtgBm3JPiDEzEHxOEVobI7kJNKMCISgWYto=
=vVLb
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
