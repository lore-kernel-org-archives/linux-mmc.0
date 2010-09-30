From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Thu, 30 Sep 2010 12:19:38 +0200
Message-ID: <20100930101938.GE2655@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
 <1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
 <4CA3AE89.2030107@pelagicore.com>
 <20100930081605.GA2655@pengutronix.de>
 <4CA45E6D.4070308@pelagicore.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37128 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab0I3KTl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 06:19:41 -0400
Content-Disposition: inline
In-Reply-To: <4CA45E6D.4070308@pelagicore.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors@pelagicore.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2010 at 11:54:53AM +0200, Richard R=F6jfors wrote:
> On 09/30/2010 10:16 AM, Wolfram Sang wrote:
> >Hi Richard,
> >
> >On Wed, Sep 29, 2010 at 11:24:25PM +0200, Richard R=F6jfors wrote:
> >>On 09/29/2010 10:07 PM, Wolfram Sang wrote:
> >>>We need to carry some information per host, e.g. the clock. Add a
> >>>structure for it and initialize it in the generic part. Also do not use
> >>>the parent of the platform_device (if it is available), this breaks the
> >>>clock-matching on ARM.
> >>
> >>The reason it's there is for instance a case when the shdci device is e=
xposed
> >>from a MFD device which sits on top of PCI. Then the parent (PCI device)
> >>is the device that is DMA capable. This patch will break such usage.
> >
> >I feared that there is a reason. The problem I see is now, that the pare=
nt gets
> >always set (from drivers/base/platform.c):
>=20
> Then we obviously need to pass more information in the platform_data to b=
e able
> to chose which device to be used.

Yeah, that was my idea, too.

> >So, sdhci-plftm cannot access the platform_data connected to the original
> >platform_device via host->mmc->parent.
>=20
> You're right it wouldn't. But isn't it a bit risky even if you could acce=
ss it,
> in the long the platform_data coild point to something that is in the __d=
evinit section
> or similar?

The use-case we see now is in the custom init() call, i.e. setting up
GPIO, enabling clocks. That is in the same section. Accessing
platform_data later is in deed always risky and should not be done,
sdhci-pltfm is no special case here.

> What about extend the struct you defined with the pieces needed, and acce=
ss it via
> sdhci_priv?

At the moment, I don't think this is needed. Will think more about it
(and the other comments) next week, already preparing for a long weekend
\o/

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkykZDoACgkQD27XaX1/VRvsLQCgvE69QxB7kdAiRo46/aGFf/Zi
FoEAoIZUE5YVzNev7pzWCtRZCWkQoV+d
=GsdV
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
