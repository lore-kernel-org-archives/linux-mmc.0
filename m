From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH] mmc: sunxi: Use devm_reset_control_get_optional() for reset control
Date: Tue, 03 Mar 2015 11:06:24 +0100
Message-ID: <1772084.aQtZdtMheX@dizzy-6.o2s.ch>
References: <1425347080-1789-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7754619.W0O9WZNYlK"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kolab.o2s.ch ([77.109.136.180]:36688 "EHLO kolab.o2s.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbbCCKGn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Mar 2015 05:06:43 -0500
In-Reply-To: <1425347080-1789-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, stable@vger.kernel.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--nextPart7754619.W0O9WZNYlK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Acked-by: David Lanzend=F6rfer <david.lanzendoerfer@o2s.ch>

> The reset control for the sunxi mmc controller is optional. Some
> newer platforms (sun6i, sun8i, sun9i) have it, while older ones
> (sun4i, sun5i, sun7i) don't.
>=20
> Use the properly stubbed _optional version so the driver does not
> fail to compile when RESET_CONTROLLER=3Dn.
>=20
> This patch also adds a check for deferred probing on the reset
> control.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: <stable@vger.kernel.org> # 3.16+
> ---
>=20
> Arnd had some proposals about the reset control API.
> Not sure if the sunxi-mmc driver was on that list.
>=20
> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> index e8a4218b5726..459ed1b601db 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -930,7 +930,9 @@ static int sunxi_mmc_resource_request(struct
> sunxi_mmc_host *host, return PTR_ERR(host->clk_sample);
>  =09}
>=20
> -=09host->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
> +=09host->reset =3D devm_reset_control_get_optional(&pdev->dev, "ahb"=
);
> +=09if (PTR_ERR(host->reset) =3D=3D -EPROBE_DEFER)
> +=09=09return PTR_ERR(host->reset);
>=20
>  =09ret =3D clk_prepare_enable(host->clk_ahb);
>  =09if (ret) {

=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart7754619.W0O9WZNYlK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlT1h60ACgkQAeZw77btGjpSpQCdEFUqlvq9Gf/aMYS03hS0SYSD
/0sAoK0FHcsMnLIgyNno1w7rJ3jMizBl
=4S+J
-----END PGP SIGNATURE-----

--nextPart7754619.W0O9WZNYlK--

