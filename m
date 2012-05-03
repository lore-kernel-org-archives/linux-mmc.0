From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Thu, 3 May 2012 16:32:39 +0100
Message-ID: <20120503153239.GN3955@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7fwXp2o0gOrkU5lS"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7fwXp2o0gOrkU5lS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 05:05:34PM +0200, Guennadi Liakhovetski wrote:

> -	if (regulator == NULL || IS_ERR(regulator))
> +	if (IS_ERR_OR_NULL(regulator))

The bigger question here is why we're accepting NULL in the first place.

--7fwXp2o0gOrkU5lS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoqUQAAoJEBus8iNuMP3drXIQAI6CJ+XzFOIdFyKDpz5SsNIR
Qi1te2FgSSJ77oT/R88PSgM+8h6R0suCy50fyYEa6T79eYNQ/oumrad4cTHmlesf
8hz1rXqtMQ8PBvlAt9RKaDXzOk2vTq3s2FSb0+DBMLK32LVp/LNjQpssruMfcKtK
JbsZX3IH9JihDMO+eeMmCcYgMEPK/grP3C58lwZRIK8qVD/jG2yaiwzQRvyeTXhe
dJ0jYI3RlDIK6TTeJjOSIUM24mJI+NT+YpB8PfCP8+W50JiL30o5EPjv84McCx4i
7GstplezWDcc0yXRHK1n1S+7zWQo5jYU805pSsNV+EpxHoSRw97oPn9eukpEKUf0
5l4nNlVRF3y7TbMXP3vLvw7Nq5NuPaTLDjdm/OVq6G3V1ZiYvXBahvanseYRAmXk
dlv4lVS8uo4SsJbP74XvTumf0hGZSJkakilk2U2wHWkR7+PIoZi8FROG/CKlWOwc
WfLB5r8VfkHmFWkBPWwviv4wHJWuvqlPjmOubfhizH+zI4/rmUhgtXnrwqZL8h5+
5HDQefuJ/nPoC24Tbm8xqGO0LdexAVhpsYgaKGIiMSADOPdA5cvqe6QxcNkHFdoc
1s+WUa55hxJsMp18RARUT5/Urw15P9JJcFxFb60LR9YBGyPvYa8H6XikyVR12uYQ
R2cbws1oYUdatd+SasdE
=nkJ1
-----END PGP SIGNATURE-----

--7fwXp2o0gOrkU5lS--
