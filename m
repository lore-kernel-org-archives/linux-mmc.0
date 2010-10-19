From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Tue, 19 Oct 2010 04:29:50 +0200
Message-ID: <20101019022950.GC3485@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de> <1287138064-21385-6-git-send-email-w.sang@pengutronix.de> <20101018161355.GA21088@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab0JSC3w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 22:29:52 -0400
Content-Disposition: inline
In-Reply-To: <20101018161355.GA21088@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> > -#define ESDHC_HOST_CONTROL_RES	0x05
> > +#include "sdhci-esdhc.c"
>=20
> Stephen reports a -next build failure after this patch.  Presumably this
> should be sdhci-esdhc.h?  It's confusing that no-one else hit this.

Uh, ouch, one brown paper bag, please! Yeah, confusing, that is.

Regarding your patch:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky9Ap4ACgkQD27XaX1/VRu4lQCdGVyJZdXgjwTJyevmBhU2nSg/
saEAn3uBuWBOofTXy/bSs9xo+X6bwZKX
=JkdO
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
