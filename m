From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Wed, 20 Aug 2014 16:10:14 +0200
Message-ID: <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5207536148215424027=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408541960-14788-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============5207536148215424027==
Content-Type: multipart/signed; boundary="nextPart2679549.LirVWx1bSs"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2679549.LirVWx1bSs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi
> Declare ERASE capability so we can use filesystems with the discard
> option and the fstrim tool.
I totally agree with you that information about such capabilities shoul=
d be
exposed but maybe it would be wiser to use DT instead of hardcoding it?=

I mean a WiFi device won't support erase functionality...
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/0682=
10.html

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> index 024f67c..7bf5c1c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device=
 *pdev)
> /* 400kHz ~ 50MHz */
>  =09mmc->f_min=09=09=3D   400000;
>  =09mmc->f_max=09=09=3D 50000000;
> -=09mmc->caps=09       |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSP=
EED;
> +=09mmc->caps=09       |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSP=
EED |
> +=09=09=09=09  MMC_CAP_ERASE;
>=20
>  =09ret =3D mmc_of_parse(mmc);
>  =09if (ret)

=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart2679549.LirVWx1bSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlP0rEwACgkQAeZw77btGjoskgCffEFflv/5FMeeQC7If4uEr+BM
Ht0AmwfyvW721rypo+87qxGvnYLBaerj
=w04k
-----END PGP SIGNATURE-----

--nextPart2679549.LirVWx1bSs--



--===============5207536148215424027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5207536148215424027==--
