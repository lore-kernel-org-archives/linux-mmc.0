From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Tue, 29 Aug 2017 16:58:52 +0200
Message-ID: <20170829145852.j4epebxsb2j2i3d2@ninjato>
References: <1504014726-17288-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z5sftoae2et6npj6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45305 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdH2O6x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Aug 2017 10:58:53 -0400
Content-Disposition: inline
In-Reply-To: <1504014726-17288-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--z5sftoae2et6npj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 02:52:06PM +0100, Biju Das wrote:
> Add support for r8a7743/5 SoC.Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
>=20
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> DT binding patch for r8a7743/5 SoC is applied for mmc next. But the drive=
r patch=20
> is still not applied for mmc next.So resending the driver patch.

Didn't Chris Paterson volunteer to write a new patch introducing Gen2
generic compatibles? Or did I misunderstand?

>=20
> This patch is compiled and tested against mmc/next.
>=20
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/=
renesas_sdhi_sys_dmac.c
> index 160fbb2..df44654 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -98,6 +98,8 @@
>  	{ .compatible =3D "renesas,sdhi-r7s72100", .data =3D &of_rz_compatible,=
 },
>  	{ .compatible =3D "renesas,sdhi-r8a7778", .data =3D &of_rcar_gen1_compa=
tible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7779", .data =3D &of_rcar_gen1_compa=
tible, },
> +	{ .compatible =3D "renesas,sdhi-r8a7743", .data =3D &of_rcar_gen2_compa=
tible, },
> +	{ .compatible =3D "renesas,sdhi-r8a7745", .data =3D &of_rcar_gen2_compa=
tible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7790", .data =3D &of_rcar_gen2_compa=
tible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7791", .data =3D &of_rcar_gen2_compa=
tible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7792", .data =3D &of_rcar_gen2_compa=
tible, },
> --=20
> 1.9.1
>=20

--z5sftoae2et6npj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlgSgACgkQFA3kzBSg
KbZ5ThAAlD3ZhYWaZ8Jxb8AHuexvK8iUfdBx8okC5H912oaNfVNS2g5YzXBnmnHK
+/ZbTc32kQO5sbQfU1rHWhlJaRmNbe+3/A+xlKjAqQ/QLgbPADWyCzLuLI82LQyb
9m4j8rt9TZ6xBFWL1Xq0ZiYpRPxLThBS91lDYMPcNDqPglCI6NV62ZFfroXJFtX5
kwgxY1uTvtyzeamsSztIcnCwzFPonZcgee+cIybRETbjERd9kMSrQFZVzI90caUd
ykcanZ5rjLXluJx6WX7UMSkbP+xOAfWDEn17/tSaV/I5bEC72FKvu1qM5PKgCC/B
4MlwFRFNSGb3BkE86mpUOWeb2feBgGrDiVxm6nbPDxYuKFQ5bXsmpI7z57A+h/d2
JQYtw4fajxzIOvrel7klf7G0g0Oe/FqzP9agtjIvG7JVVVXpS7McvsbZ8FQMoEtx
lLyOw/0Repa9yhDm79N5N+O0ej+A9rrmzvfI+tmFh1f6Egmx0dMIoBxCqWhRdF2Z
1znJ+ZvhVcB8xp5sEFIETFyFkIUfBtB6aCy2sxL22+TgkZx6AWN9an0Zhnr+AlOu
yWx5oSuQTkexL+gbFm/+HwW9Gm0Ob4QYyplffv0Q+N4Wfjeq7erCMlPjJP8uG7k8
q3MyqOKQMwzkbeknL89Dbt72G3bOMGpWeorPCQsUogepfR0Mto4=
=KVCQ
-----END PGP SIGNATURE-----

--z5sftoae2et6npj6--
