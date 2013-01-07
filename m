From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon, 7 Jan 2013 13:22:16 +0000
Message-ID: <20130107132216.GF4544@opensource.wolfsonmicro.com>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
 <20130107112527.GD4544@opensource.wolfsonmicro.com>
 <50EABFFE.9070908@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44464 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817Ab3AGNWS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 08:22:18 -0500
Content-Disposition: inline
In-Reply-To: <50EABFFE.9070908@web.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dr. Rainer Kaluscha" <rainer.kaluscha@web.de>
Cc: Kevin Liu <kliu5@marvell.com>, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2013 at 01:30:54PM +0100, Dr. Rainer Kaluscha wrote:

> The problem is that *only* a dummy regulator is available which
> refuses to do any regulation at all.
> So sdhci/mmc should better behave as no regulator was available at all.
> This may happen if e.g. in a precompiled kernel of some linux distro
> regulator support (including dummy) is enabled but the machine
> running that kernel doesn't have a known hardware regulator. This
> results in sdhci/mmc failing to enable the SD card reader though it
> would work well without regulator support in the kernel.

Production systems should not enable the dummy regulators, it's that
simple.  They're a crutch to get things booting but they're going to
cause problems in production.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6swBAAoJELSic+t+oim9R/cP/1eKxBVj0jotpYqJZIyVFv2U
QCurzQUkjPW6kfPlSQZmpwHVPPU3j7yR1Vxjox3i15e1s11vDLWHi0iKeSX7CpE9
dHfZJOAD+fNmemKCu6m2eCpc5xDYyvwfS3zJP2GxMDLjXeyApaYVqQ/YuQ7UrxoN
5Y7ZzRv2j/KKTHCmcy5XyA74my6HrDTXn+APSYAuyL3HFuhOqhLHuy+1n6G1WHxo
snNI5adx/GKbbzo5Y7oQPJovXUYM9dLJ0oEFtp2iU9ltjrkzoFMwgiRFx2C2PyEn
VJDGnD19qaQRO+dLkpk0RKL02Pigzc+uqB2Ea+HDZ7sjjovPjG6kIb73VyPiraXb
ZJiSvFtVtW4fY+ZMB6+IMc23FiNhOHbywa6turOSzHAedDzfzMZg1IAxHVs3JwPS
b8P/buGQNFh9UAuiuXMozD2+Pg51sTuweA35e0BW+8QrzmwCGWGy4SBbxPcQ6Oma
LHqhnMf0kGSbMzKkZWkNavR9cMYhhBKGmY37rbWb1Oak26M3CpVuNry+EDj9AFEr
iDMHxz/g729P1hmFmsoLiqX2YZIAbktu3RMdPPkg+AwxE9I9SsTsUsO93pyfK01P
4gRYx9dxJ1ZZ5cQmZBJ2xiRl5r6PXK31+z6Moi/T/68XUQ59+v6+kZSb2kVm63v+
zSJJz/jXA1Yde+j8Mv7X
=M6vg
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
