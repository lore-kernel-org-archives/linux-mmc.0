From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add broken-cd devicetree property
Date: Sat, 06 Apr 2013 15:58:35 +0200
Message-ID: <51602A0B.6020405@pengutronix.de>
References: <1365255828-6416-1-git-send-email-aletes.xgr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HCNMDXQBCIVHPJXULAEX"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365255828-6416-1-git-send-email-aletes.xgr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: cjb@laptop.org, shawn.guo@linaro.org, marex@denx.de, fabio.estevam@freescale.com, otavio@ossystems.com.br, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HCNMDXQBCIVHPJXULAEX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/06/2013 03:43 PM, Alexandre Pereira da Silva wrote:
> In case of broken card detect support, assume the card is non-removable=


According to the documentation broken card detect is something different
than non-removable:

>   - broken-cd: There is no card detection available; polling must be us=
ed.
>   - non-removable: non-removable slot (like eMMC); assume always presen=
t.

But mxs-mmc set MMC_CAP_NEEDS_POLL unconditionally.

http://lxr.free-electrons.com/source/drivers/mmc/host/mxs-mmc.c#L682

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HCNMDXQBCIVHPJXULAEX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFgKg4ACgkQjTAFq1RaXHPIaACfd7jUqxvocgaC4UhYsGtVmKiI
gf8AnR/GKb2mebHmiyDLAw+DK26FJCzh
=KrLK
-----END PGP SIGNATURE-----

------enig2HCNMDXQBCIVHPJXULAEX--
