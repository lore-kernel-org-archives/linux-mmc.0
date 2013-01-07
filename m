From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon, 7 Jan 2013 11:25:27 +0000
Message-ID: <20130107112527.GD4544@opensource.wolfsonmicro.com>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <rainer.kaluscha@web.de>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2013 at 01:38:50PM +0800, Kevin Liu wrote:
> Introduce a regulator_is_dummy function to check whether the
> regulator is dummy.

No, we've been through this repeatedly.  Whatever problem you're trying
to bodge around is going to be a problem with some real physical
regulators too.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6rCaAAoJELSic+t+oim9/5sP/iTU5w8hezXC5uUp8M1NBtGX
f9TwtnFgEOrkbE04sPE6uw1b37H2R7sA3EUy37LmDpDty8xfFt+6P2cmECHTGT/8
Nzx5f6tU957XPd1ogY+AqxuPwBu0FaffL3QCzQpO6a3Ygu6ZSOsqLPiwGyhAdUCK
/jT0wDwnNNMUn4Ogsaz59ju56rUisarMh08APxl4WQ1CmPEq3oTyfWbcoJ6um7MO
MKT+xOrjXAhy8aHMNhoSm2I4ETW4ZOUCm6jb/AYLxn0kElakqIqnqwcYqLy6jK96
wm+t3IHC8NahcXg7TBOFOe/cPbYqzLHbK7rG7fSNKMY+volu3aXVjQTzFKVxBWRy
z8RnklzTfkj4PB6JU4261pPTY5RLdCSTHN48NvKa350//QApXepfmXPLZVov6wXh
dm8s6e/Y+lRErsU2hU8r7sidHjaDjTsqpn9QDnvm4L8b71gm11DzvErxaTEW4wcw
ommyo7EDEKpB++fmNDKtqj4xLgHMCPsSBX59Rsm4X4LpbMxsWQ5OpoKseqJweB5M
5kuGj7mBDHiq9qtZme7TEqjOacbAN44LSLMlNR1dZcot1/xBJkYr694WXREgh7fU
uYjDj+PSx8sWs2E95vXAzRsR+owJtedRpKWbRIPV0paoWMTilXxyxiomYgts/qRU
tNv6MHyHMBDJlWdkNZEm
=+/ca
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
