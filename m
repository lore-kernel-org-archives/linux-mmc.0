From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 11:37:30 +0100
Message-ID: <20101215103730.GB3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-5-git-send-email-olof@lixom.net>
 <20101215083546.GA16459@pengutronix.de>
 <20101215084307.GA29717@lixom.net>
 <20101215084634.GB29717@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40585 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab0LOKhf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 05:37:35 -0500
Content-Disposition: inline
In-Reply-To: <20101215084634.GB29717@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Still, I don't see the point -- the amount of code would be about the
> same between wrapping it with a coat of workarounds and op structures,
> gpio setup, etc, and just doing a separate simple driver. The code shared
> is really just the resource allocation pieces.

? Saving 150 out of 260 lines does not count? Having a central point for
bug-fixes in that part of the code?

If there is something yet missing in sdhci-pltfm which you need, it
probably is worth adding it there. Chances are good that other
pltfm-users might want that, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0ImmoACgkQD27XaX1/VRsfnACgqU6/MxXR9wyZzgFoT6D8MA+n
F00AnA9iWf94quFxKcnWOyAA119g7mbv
=jw1+
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
