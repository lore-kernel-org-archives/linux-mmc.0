From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon, 7 Jan 2013 13:18:05 +0000
Message-ID: <20130107131805.GE4544@opensource.wolfsonmicro.com>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
 <20130107112527.GD4544@opensource.wolfsonmicro.com>
 <CADz5_gJvtgwA9c88wZcjQArmKiAtB7CLHvRAxkDNUnNpM8Z8Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48381 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754251Ab3AGNSI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 08:18:08 -0500
Content-Disposition: inline
In-Reply-To: <CADz5_gJvtgwA9c88wZcjQArmKiAtB7CLHvRAxkDNUnNpM8Z8Qg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <rainer.kaluscha@web.de>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2013 at 06:36:36AM -0500, Kevin Liu wrote:
> 2013/1/7 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > No, we've been through this repeatedly.  Whatever problem you're trying
> > to bodge around is going to be a problem with some real physical
> > regulators too.

> Then the only way is MUST define the regulator rather than let dummy
> regulator handle it, right?

To repeat once again, dummy regulators should never be used in
production.  They are purely a crutch to help get boot going - it is
expected that things like this and cpufreq might fail.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6ssGAAoJELSic+t+oim90ScQAJh1G+uLQwDc6xeBUMOaJW+p
YsFUWe7Y/1jApHFEvgI5XztNFHCO+uS9QIGmFgE6UUN3/h51DdtPww4IIQGPYcAG
AbSpPN6Fhv2kupEH7hnnL7MXM4gVjjLvgLNHQtC7IH/oV93N5uA8J0CIAuGd+IYD
X38365GYj7DJNePJZ9InQfOii4h3MkeMmDkYfjFq+RRfm6hN670iD35l5YZ3tuVM
+ay1olvRFBQW+ysiohM6/QzJrf/ukHAGbyD1CPwaJIgbF8LY75xPDjmkJFZA9Xfl
QkH1Gesc0IK3rKNY7yYz3s8cpC99vBiZ+ebevZeFaAA9DK2Mc0quLHbOqChNyrdm
f+x5RfxzKo4RUyQL1raRL+sfI/5X0Uno1Sp2Wz/30/TSTKM9m9jRkpsvMC1vdQsK
7uxbJ7f/fHl3ZODVSz9ST4Cn2TvRQKa/5uQB5d2G0WociCVGlvn2xADAnpD0g3cV
ZJD978ph9vqhowvpuBvMLsd9z2OEP0tM9u307KDlIPZ6Qw7t0IvvfDoohxmbUoM+
6qd/COOR8u88KBTXL0S0fdLtjQGC86M3Q77nE+pi+RJoupbp/IKTPm1ZhhBSZIVW
MLseUVwxw1l7I5F3Vx29mptIlhZ+1A/tooBF5qSWFcTqPe6R+iZqspiL7fkRJLWX
oUqiry5KR+H5akDEN7jk
=x/NF
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
