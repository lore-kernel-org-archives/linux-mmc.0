From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 14:40:58 +0100
Message-ID: <20101215134058.GI3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-5-git-send-email-olof@lixom.net>
 <20101215083546.GA16459@pengutronix.de>
 <20101215084307.GA29717@lixom.net>
 <20101215084634.GB29717@lixom.net>
 <20101215103730.GB3515@pengutronix.de>
 <20101215114000.GC2500@lixom.net>
 <20101215115911.GH3515@pengutronix.de>
 <20101215130355.GA4124@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38845 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0LONlD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 08:41:03 -0500
Content-Disposition: inline
In-Reply-To: <20101215130355.GA4124@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I'll whip up the changes and see how invasive it gets as a -pltfm
> driver. It shouldn't be too bad. I'll repost the series that way, but
> I will still keep the quirks for now and do a pass reworking these as
> well as others separately (see below).

Sounds great!

> Anyway, I wonder if it does makes some sense to add a sdhci_ops callback
> for fixing up the mmc settings after setting the defaults in host_add,
> and for not just -pltfm. A handful of quirks are already only used for
> overriding defaults, and they could be freed up. There's a few more that
> are only used by a single driver and are suitable for handling through
> overloaded register read/write functions.

Yes, exactly. I'd think more than 50% of the quirks can go away.

> I'll do a first pass, but it might take me a week or two due to other
> more pressing things.

I perfectly understand. Thanks for looking into it.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0IxWoACgkQD27XaX1/VRvMuwCgiXPIq+Do1fIO+U30yLXgRlYe
9u0AoIJDFSW1g+VLEgj/QPlZ9A0koV0Y
=8fFB
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
