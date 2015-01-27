From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: mmc does not work in qemu n900
Date: Tue, 27 Jan 2015 10:17:39 +0100
Message-ID: <201501271017.39808@pali>
References: <201501262204.59305@pali> <20150126232104.GA591@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3624498.3u5NPSciRH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:41287 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbbA0JRn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 04:17:43 -0500
In-Reply-To: <20150126232104.GA591@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>

--nextPart3624498.3u5NPSciRH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 27 January 2015 00:21:04 Aaro Koskinen wrote:
> Hi,
>=20
> On Mon, Jan 26, 2015 at 10:04:59PM +0100, Pali Roh=C3=A1r wrote:
> > problem? Why any of these two patches fix problem when mmc
> > is not detected by kernel in qemu (machine n900)? Detection
> > of mmc fails because function mmc_send_op_cond() without
> > one of above patches fails.
>=20
> Has it ever worked? It could be just that QEMU's emulation is
> broken. Since the kernel works on actual HW, you probably
> should contact QEMU maintainers.
>=20
> I don't see n900 in Debian's QEMU. There's n800 and n810 but
> I couldn't boot any of my kernels with those...
>=20
> A.

It worked with stock Nokia kernel (2.6.28).

N900 qemu support is not in upstream qemu project, but in linaro=20
qemu version. You can find it e.g. in ubuntu:=20
http://packages.ubuntu.com/source/precise-updates/qemu-linaro

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3624498.3u5NPSciRH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTHV7MACgkQi/DJPQPkQ1LygACgktog4ZN6eiBFunf4oHJg++L7
YB8Anj18iqcIQul5UazicnXc+5iSKFNz
=ASR4
-----END PGP SIGNATURE-----

--nextPart3624498.3u5NPSciRH--
