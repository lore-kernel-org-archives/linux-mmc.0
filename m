From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: mmc does not work in qemu n900
Date: Fri, 25 Dec 2015 13:57:42 +0100
Message-ID: <201512251357.42592@pali>
References: <201501262204.59305@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2962180.Slt3vhpVaT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37110 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbbLYM5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Dec 2015 07:57:45 -0500
In-Reply-To: <201501262204.59305@pali>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

--nextPart2962180.Slt3vhpVaT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 26 January 2015 22:04:59 Pali Roh=C3=A1r wrote:
> Hello,
>=20
> for unknown reason kernel in qemu n900 machine is not able to
> detect internal eMMC memory. External SD card is detected without
> problem.
>=20
> If I apply this one-line patch eMMC in qemu start working:
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9584bff..0d4461c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2337,6 +2337,9 @@ static int mmc_rescan_try_freq(
>  		return 0;
>  	if (!mmc_attach_sd(host))
>  		return 0;
> +
> +	mmc_go_idle(host);
> +
>  	if (!mmc_attach_mmc(host))
>  		return 0;
>=20
> I played with mmc and qemu n900 a bit and also this simple patch
> (without first) fix problem (that mmc is not detected by kernel):
>=20
> diff --git a/drivers/mmc/core/mmc_ops.c
> b/drivers/mmc/core/mmc_ops.c
> index 3b044c5..0c93a2c 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -157,6 +157,10 @@ int mmc_send_op_cond(
>=20
>  	BUG_ON(!host);
>=20
> +	/* reset mmc before calling op_cond */
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +
>  	cmd.opcode =3D MMC_SEND_OP_COND;
>  	cmd.arg =3D mmc_host_is_spi(host) ? 0 : ocr;
>  	cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>=20
>=20
> I have no idea where is problem. I also do not understand mmc
> kernel code, but second patch I have on my HDD since 2.6.37.
>=20
> Can somebody with knowledge of mmc subsystem look at this
> problem? Why any of these two patches fix problem when mmc is not
> detected by kernel in qemu (machine n900)? Detection of mmc fails
> because function mmc_send_op_cond() without one of above patches
> fails.

I will bring this tread to front again as mmc without one of provided=20
patches does not work with 4.4-rc6 kernel in N900 qemu.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2962180.Slt3vhpVaT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZ9PUYACgkQi/DJPQPkQ1J45ACfWL+dJBWRpwXbiZxs8Wim6MPs
PacAni7VFT4mgShLoz6DC4Qjgy/xVjF9
=JmHL
-----END PGP SIGNATURE-----

--nextPart2962180.Slt3vhpVaT--
