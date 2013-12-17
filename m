From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
Date: Tue, 17 Dec 2013 13:43:19 +0000
Message-ID: <20131217134319.GC3185@sirena.org.uk>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AE3cR03RMyqqQrte"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59888 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3LQNnZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 08:43:25 -0500
Content-Disposition: inline
In-Reply-To: <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <cjb@laptop.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, linux-arm-kernel@lists.infradead.org


--AE3cR03RMyqqQrte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 14, 2013 at 10:58:11PM +0100, Hans de Goede wrote:

> +config MMC_SUNXI
> +	tristate "Allwinner sunxi SD/MMC Host Controller support"
> +	depends on ARCH_SUNXI

This should be ARCH_SUNXI || COMPILE_TEST to increase build coverage
especially for people doing subsystem or kernel global work.

> +	default y

As others pointed out this shouldn't be here, consider multiplatform
kernels.

--AE3cR03RMyqqQrte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsFT0AAoJELSic+t+oim9zREQAJPU7/wIWH3IrbxKlTg1Yja6
v9pIjdQIsrCx9Syt3g+dYzuqAdsD/iC1J+oin2Gwjy0EprgWZBOxa6QebBx+pcIx
5IAo7vrDBtRYneLYxu8wP4ykFW1TBhNrhh2JR44f28rWhy+rBhCn6FrtC3ZhH1Fg
7AzLB71n6NVKJT7EsSXJsOmrVQJcjLSvl8m6y3bMcNCx55Q3GU5BE5SmUs0TZGuS
ik6/7E8CVmuWq+AHwtbpH6iexyqk46M7f1vs7OHavOm5ONPK60P+z7vn7uoGh6Qp
xnhikgooGBg9heM7mbBBafXzCVIouJCHS0TBNyqVxmIaZiEcfkMiO/6cUqRYvZK3
O1p7aE4fV11iEyL85v47SY7GL9kGpU3yin2nZMbpKWwr51qEQQa2x1sPMYqs1VyP
gmLfXyZzvrpe8RXdaoL7SlVJu3eZq6Z2cwen/hZ2+h70FB9IKjD6bhfLegzsIhOR
vMVBmT+kQlBvdGqh2/jOA5F9C8+cx0TW7V+3JrFJVaUjHxmSjaOA9M27zSKltDZ8
ODn/p7m1XfplnQuQuPwMADY/b/RSTRn1RhE/RgkDjzHSawJz6551B6A3BrD8xNsf
7SitnWR4z+j9SLtORjOp84W8IPceYMMXOcN+C9fe4t15v1mAAxpsZy4d08DZbEab
U7BZRiUgpSiaRPs+sjLe
=9wdG
-----END PGP SIGNATURE-----

--AE3cR03RMyqqQrte--
