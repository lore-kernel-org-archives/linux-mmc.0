From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Date: Thu, 24 Mar 2016 11:02:06 +0000
Message-ID: <20160324110206.GT2566@sirena.org.uk>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <20160324095332.GS2566@sirena.org.uk>
 <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWqLLCFKF5W9Ovgk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33728 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbcCXLC2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 07:02:28 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>


--aWqLLCFKF5W9Ovgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2016 at 07:25:35PM +0900, Krzysztof Kozlowski wrote:
> On Thu, Mar 24, 2016 at 6:53 PM, Mark Brown <broonie@kernel.org> wrote:

> > Why does this regulator even have voltage constraints configured?  Is
> > there any intention that it should ever be varied at runtime?

> Good question. I was also wondering that, if tetting it by 5 mV lower
> causes failure, then the constraints are actually fixed at 3.755 V. I
> do not know the answer. Boards schematics do not specify the
> requirement here, datasheet for PMIC says default value of 3.4V. Heh,

For some reason people seem to frequently want to put the maximum
voltage range for the regulator into the constraints even though that is
almost certainly broken and generally nonsensical.

> maybe the regulator driver is missing proper starting value for 'vsel'
> (datasheet says values in register start from 0x40 -> 3 V). Something
> looks wrong here...

It's possible it's just broken and has never been tested.

--aWqLLCFKF5W9Ovgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW88ktAAoJECTWi3JdVIfQOQoH/iCTkVsV2hkFwx94EST0UrQr
FVw0+GHiO8SDtvjTNDC/c4+3gurlUfr2YD7hTzLJYrAtClh8VdbZSzES2DaguGXr
cXk6rejnNQ5MwrGiYY478bTMTu7RwDdy/50DGOWm4zhlmsMH/HkVPfi5zRuPSpyj
XYnwaPqEttOcnHdM8W/coaKZ59/UsZUSaT/xt0Ykr/7DDvDpTkIZs+EM2IaB7Zdy
s9m0HRus/3yEU8puXnb4o8oQ3V4olyC7cdjhZJRImkLBJsCYcp/9zBdwqhnOCghe
MRHTbnbmTeXCjZFAhywVWBMfCufs2c1711DW+Lx0RAY3r+5VTPXvuzzSKjMlvv8=
=gX4j
-----END PGP SIGNATURE-----

--aWqLLCFKF5W9Ovgk--
