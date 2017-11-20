From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 6/6] mmc: tmio: move mmc_of_parse() out of
 tmio_mmc_host_probe()
Date: Mon, 20 Nov 2017 21:47:11 +0100
Message-ID: <20171120204711.vze5j6lvpkl5op3z@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-7-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ddzgtkuntpjy7d7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510042172-27220-7-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--5ddzgtkuntpjy7d7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:32PM +0900, Masahiro Yamada wrote:
> mmc_of_parse() parses various DT properties and sets capability flags
> accordingly.  However, drivers have no chance to run platform init
> code depending on such flags because mmc_of_parse() is called from
> tmio_mmc_host_probe().
>=20
> Move mmc_of_parse() out of tmio_mmc_host_probe() so that drivers can
> handle capabilities before mmc_add_host().
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I'll just add this:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

because you wanted to still try which solution is better.


--5ddzgtkuntpjy7d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTP08ACgkQFA3kzBSg
Kbb4IQ/+Oq/I/eSh9wkJ2+/w3nGF9ujLToAtiOJH97L6xYgYjKSFwWNSjHIM9O4v
Vs19YW2f4wwkbVpRLYnjINV8sQCU4IoFsUy83S9cWlplel4SJaeRLYaoAKBhhsLY
HN/WXVJrh7Bse1jmo1kNHNKYV5YKbqXpJMRpLEBkBzCJIKN/u6YkkBO3OuyKn+Op
gyZAhNyFMcfAHdAPrNMjeJ3MmmIzwmr5p9dMur8hIbqktyRHMgMBea25XEwJ8cbV
HrQp2OSdb2NhKP8aW3WXV4f/JlUroePPydLiS755zIxxK2gvDHKLSUblNTAIi7iv
R2YmdPxzy4DlwnDCC53/+hf6nGcf/VjPbk55wN4JHP863LhNmXraLx3t8f6Huunh
Mp/ja7rnkRxBokWCYzG7BvHIl7VOrxVwJrvZiP+IqHL1dWLpDRuA8tUo6G+khcq0
0XnKzgYiYbRtPaNdqlZyKBrqmRW5tAo7GCyvqVzx4EVwL8e1Fbg/v/CpFVIbxfny
39gOD4dCQQKnE9motMXGrr6ypcHyYHg8xeToCgCtNrNKWX2hEcEOzi0puS7AGWl3
nH28gEoZCp08sq3SgMlfAEk5Vuvgt6e7Vfh7OR9ZQb6oVcagWIe5ZVgo5TvOTdot
s+2z4xEF25biDkGJ4Ukz72ZeOJ+SYDBlu1VcZ6bpOUh16gRdbWo=
=72Gm
-----END PGP SIGNATURE-----

--5ddzgtkuntpjy7d7--
