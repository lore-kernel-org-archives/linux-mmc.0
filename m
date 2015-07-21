From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] mmc:Fix error handling in the function mmc_blk_remove
Date: Tue, 21 Jul 2015 22:05:08 +0100
Message-ID: <1437512708.29812.12.camel@decadent.org.uk>
References: <1437504701-24429-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-stpvt92EIH8po3/vrQfz"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437504701-24429-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>, ulf.hansson@linaro.org
Cc: kuninori.morimoto.gx@renesas.com, jh80.chung@samsung.com, adrian.hunter@intel.com, chuanxiao.dong@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--=-stpvt92EIH8po3/vrQfz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-07-21 at 14:51 -0400, Nicholas Krause wrote:
> This fixes error handling in the function mmc_blk_remove by
> checking the return value of the call to mmc_blk_part_switch
> and if it has failed by returning a error code we now print
> out on the console to the user that removed the mmc device
> has failed before returning immediately.
> v2
> Change pr_crit to preferred dev_crit for when printing to console
> in device functions
> Remove unneeded return statement after dev_crit statement due to
> removal functions always needing to complete successfully
>=20
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/card/block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c9c3d20..5b50ddf 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2505,10 +2505,10 @@ static void mmc_blk_remove(struct mmc_card *card)
>  {
>  > 	> struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
> =20
> -> 	> mmc_blk_remove_parts(card, md);

No.

Ben.

>  	pm_runtime_get_sync(&card->dev);
>  > 	> mmc_claim_host(card->host);
> -> 	> mmc_blk_part_switch(card, md);
> +> 	> if (mmc_blk_part_switch(card, md))
> +> 	> 	> dev_crit(&card->dev, "Unable to successfully remove due to faile=
d mmc_blk_part_switch call\n");
>  > 	> mmc_release_host(card->host);
>  > 	> if (card->type !=3D MMC_TYPE_SD_COMBO)
>  > 	> 	> pm_runtime_disable(&card->dev);
--=20
Ben Hutchings
No political challenge can be met by shopping. - George Monbiot


--=-stpvt92EIH8po3/vrQfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVa60BOe/yOyVhhEJAQqcJQ//Xz94niPcgG1bn3LuGm+NFkrxz5QAx5hR
pJB+UClkgmvAWTuiK0cPiypbtolasmRs8uDpp9J9/s8Fj4PY+VTkazp0e1k3Mdae
Qky8AYElgN7U55dtLBQWmvsH2xJktPBHf9SJz288OjpBsCElskhoPBIGE/erqFAj
Zz1qxBT6QUU65kMXKPmUn5P/Oq5QaG8cSrAnGUdouvgkkXk8SRD2Aryr6Taah/jg
mlx6UF7UWbyx0yfUAWEPqVtOoZZLUTJrkCBO5eiuN6bVPhHDJiUkA2Wr21pc61lj
gcSV5zoC0BxoiohY2bQbYCc5MtiY75JQVL5wyPBRwhstWW80SRmFaq/Cuy+qWs6Y
okwH7nd0OfMKAcWE7cn8LaUOUaW0KClPLPC1zuufkkR3+NAPhaqjbgsosYMNGPJk
By//72uA4HMvPSabjo26gKaOmQrfBeb0JHAfY02ZpZM+MFt8PPfyLn3zXRziqF7s
xBuV1N8mSc0FArm+Y6H9M9lH8IGaQcfjaw9Rg3CkaUsOxDHifJsyEPd9vAM1F0Um
hcAvlHHaqEqrfMnLI84VOzReeS4n/jWSFQ/8XcXIXvYQXi/F55znjQwdAoTf/AoG
0DHJxeaSNpM00Y6v2WqAaB32ZhpaipfuqzF4equyYjOrCAv6mFOfEn/0USwI3DM1
L1CrN2LDAZw=
=1hZ6
-----END PGP SIGNATURE-----

--=-stpvt92EIH8po3/vrQfz--
