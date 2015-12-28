From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Mon, 28 Dec 2015 15:54:35 +0100
Message-ID: <201512281554.35277@pali>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <201512281528.48097@pali> <2889805.FbnHzlrmH7@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1462562.2i7ttkgGjo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33131 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbL1Oyi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 09:54:38 -0500
In-Reply-To: <2889805.FbnHzlrmH7@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

--nextPart1462562.2i7ttkgGjo
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 28 December 2015 15:41:01 Arnd Bergmann wrote:
> On Monday 28 December 2015 15:28:48 Pali Roh=C3=A1r wrote:
> > On Monday 28 December 2015 15:14:50 Arnd Bergmann wrote:
> > > On Friday 25 December 2015 13:53:11 Pali Roh=C3=A1r wrote:
> > > > On Monday 18 May 2015 17:07:57 Arnd Bergmann wrote:
> > > > > On Monday 18 May 2015 08:06:07 Tony Lindgren wrote:
> > > > > > * Arnd Bergmann <arnd@arndb.de> [150515 14:26]:
> > > > > > > On Friday 15 May 2015 23:22:37 Pali Roh=C3=A1r wrote:
> > > > > > If setting up the generic binding is expected to take a
> > > > > > while, you can naturally pass it in pdata while waiting
> > > > > > for the generic binding to get merged.
> > > > >=20
> > > > > Yes, good idea. So the n900 machine can use auxdata to pass
> > > > > this for the time being, while the binding and generic
> > > > > implementation is being worked out.
> > > >=20
> > > > Ok, so what is needed to finish this patch series?
> > >=20
> > > I don't know where we are at this point. Has either the auxdata
> > > approach or the generic binding been worked on at all?
> >=20
> > What are auxdata data?
>=20
> I mean you can add the platform data to the omap_auxdata_lookup[]
> table for this board.

But can I mix data from omap3-n900.dts and omap_auxdata_lookup[]?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1462562.2i7ttkgGjo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaBTSsACgkQi/DJPQPkQ1Jb2QCfdwd/e+byXqV/1EVIgCckss2L
CvYAn1wx/n6aQNWfLQvG+sgFCjn7cp57
=VUBW
-----END PGP SIGNATURE-----

--nextPart1462562.2i7ttkgGjo--
