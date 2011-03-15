From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Re-Resubmission
Date: Tue, 15 Mar 2011 10:40:41 +0100
Message-ID: <20110315094041.GA32015@pengutronix.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
 <20101116150022.GA27726@void.printf.net>
 <27884BED0E3C489C8849EE12A803F536@AN00536>
 <m3oc9pnt6g.fsf@pullcord.laptop.org>
 <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org>
 <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <1299773604.1682.21.camel@apple-mac>
 <m37hc1rsrp.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35684 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1COJkn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 05:40:43 -0400
Content-Disposition: inline
In-Reply-To: <m37hc1rsrp.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> linux-mmc@ folks, any strong opinions on this driver?  My impression is
> that it looks reasonable, but has some areas of being pretty far from
> standard CodingStyle.

I totally agree (sadly it is hard to review because of its size) and I am s=
till
not convinced of the sysfs-entry. Then again, it is a working driver.

> I'm leaning towards merging it as-is and then
> working on incremental fixes; please yell if that sounds like a bad idea.

What about staging? From my all overall impression, the driver would fit th=
ere.
Also, there are more people lurking around fixing coding-style than here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1/NBkACgkQD27XaX1/VRvI1ACaA2HKoxA3HnRArPPM/RWQDBS4
N6wAoKwZwxTp/l5HuAAo4BhssJTuiV1I
=9FNR
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
