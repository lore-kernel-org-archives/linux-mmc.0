From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: mmc does not work in qemu n900
Date: Sun, 8 Feb 2015 00:02:57 +0100
Message-ID: <201502080002.57075@pali>
References: <201501262204.59305@pali> <201501271017.39808@pali> <201501301523.34410@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1539135.VP2RAJ4k6J";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35286 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbBGXDA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Feb 2015 18:03:00 -0500
In-Reply-To: <201501301523.34410@pali>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>

--nextPart1539135.VP2RAJ4k6J
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 30 January 2015 15:23:34 Pali Roh=C3=A1r wrote:
> On Tuesday 27 January 2015 10:17:39 Pali Roh=C3=A1r wrote:
> > On Tuesday 27 January 2015 00:21:04 Aaro Koskinen wrote:
> > > Hi,
> > >=20
> > > On Mon, Jan 26, 2015 at 10:04:59PM +0100, Pali Roh=C3=A1r wrote:
> > > > problem? Why any of these two patches fix problem when
> > > > mmc is not detected by kernel in qemu (machine n900)?
> > > > Detection of mmc fails because function
> > > > mmc_send_op_cond() without one of above patches fails.
> > >=20
> > > Has it ever worked? It could be just that QEMU's emulation
> > > is broken. Since the kernel works on actual HW, you
> > > probably should contact QEMU maintainers.
> > >=20
> > > I don't see n900 in Debian's QEMU. There's n800 and n810
> > > but I couldn't boot any of my kernels with those...
> > >=20
> > > A.
> >=20
> > It worked with stock Nokia kernel (2.6.28).
> >=20
> > N900 qemu support is not in upstream qemu project, but in
> > linaro qemu version. You can find it e.g. in ubuntu:
> > http://packages.ubuntu.com/source/precise-updates/qemu-linar
> > o
>=20
> Here is another alternative patch which enable internal eMMC
> support in qemu n900:
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9584bff..225df49 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2330,13 +2330,13 @@ static int mmc_rescan_try_freq(struct
> mmc_host *host, unsigned freq)
>  	sdio_reset(host);
>  	mmc_go_idle(host);
>=20
> -	mmc_send_if_cond(host, host->ocr_avail);
> -
> -	/* Order's important: probe SDIO, then SD, then MMC */
> -	if (!mmc_attach_sdio(host))
> -		return 0;
> -	if (!mmc_attach_sd(host))
> -		return 0;
> +//	mmc_send_if_cond(host, host->ocr_avail);
> +//
> +//	/* Order's important: probe SDIO, then SD, then MMC */
> +//	if (!mmc_attach_sdio(host))
> +//		return 0;
> +//	if (!mmc_attach_sd(host))
> +//		return 0;
>  	if (!mmc_attach_mmc(host))
>  		return 0;
>=20
> It just disable SDIO and SD code. It looks like using some
> SDIO or SD commands on mmc controller in qemu cause
> problems...
>=20
> Any idea?

Pavel, see this email thread:
http://www.spinics.net/lists/linux-mmc/msg30424.html

You had problem with mounting mmc device as rootfs on (real)=20
Nokia N900. Can you test one of those 3 patches which I sent to=20
this email thread? If it change something for your kernel or=20
userspace? I would like to know if I found another bug in qemu or=20
same as you had...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1539135.VP2RAJ4k6J
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTWmaEACgkQi/DJPQPkQ1LGtwCffOVMOKl4g8Z0AAk6tXP6t7s7
14cAn3jani8PIX6DOpqO3M7Yop7SELnu
=vHkT
-----END PGP SIGNATURE-----

--nextPart1539135.VP2RAJ4k6J--
