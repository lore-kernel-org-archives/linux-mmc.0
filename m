From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/7] regulator: add pbias regulator support
Date: Wed, 11 Dec 2013 22:46:52 +0000
Message-ID: <20131211224652.GB11044@sirena.org.uk>
References: <20131210104005.GB29268@sirena.org.uk>
 <1386686098-7779-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46947 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3LKWrR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 17:47:17 -0500
Content-Disposition: inline
In-Reply-To: <1386686098-7779-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2013 at 08:04:58PM +0530, Balaji T K wrote:
> pbias register controls internal power supply to sd card i/o pads
> in most OMAPs (OMAP2-5, DRA7).
> Control bits for selecting voltage level and
> enabling/disabling are in the same PBIAS register.

This looks OK from a regulator API point of view but I expect a new
version is required to address Tony's concerns.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqOtZAAoJELSic+t+oim9cA0P/iA283lESfe07m7rzjtqnHx5
BK/WJeoCdWrfw7NI3mIZq6baFef9xOPUy1eWoPCCJTCuhRNCxsYjmEngb2jDryMa
iXsbmmtXV8YQvQQTvLc01YhJSwPEjEsoTOgGtaoJyFpMscgZsNOyJDsj3ykGGQFt
jj7IzBtQTrdpuhAfvAsfUzYyvEzDyJzFKY9eUExoVFcT/zov6mjBaegbP71Wro5T
jm/WgaEEsnksTyryg3acRw0J/Sk9Iwgskb6pTcfQsA3jeHGyZesHrEweGI4Zgk9w
EhiskmLjjua+eTFRdpTexW10IuFQdjrDhIy6vz7EqTZHxJLsOmczaSV5jW60/Sfu
c6PPVM81vqTN4di4lRG8JPAz6lHBdde1ud/yffMdUa9CYCqOoMnRwOChsywmsDJ/
JIFR2XkkqOVABftCQw/OVCjbO3NfaI4ayf1174AyOQjIVK2aeWxBATIqIKKy7yQv
TmI07McdCG3BP2LY7bA4kL7Fy6fKZKpQXAjsw6PnLxubD3Lk3YdlLrzaynPv1jmF
mK9yUCZUHjCstGRWLoyv3JS1t8WBDmYcG3m2AAVzr+3uL+Pnd3+vEktxU6hrxIV+
19GcK8VABVm8htKPykWcOLvqaafEXO5DtvrxrEsFdArM14S3eVJZt+P/WWE1WlOE
1uTS+UhRORFH7l653f/o
=wwgm
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
