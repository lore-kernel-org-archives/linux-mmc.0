From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au
 sizes
Date: Mon, 13 Jan 2014 13:41:18 +0100
Message-ID: <20140113124117.GD2586@katana>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56894 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbaAMMlW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 07:41:22 -0500
Content-Disposition: inline
In-Reply-To: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 02:16:25AM +0100, Wolfram Sang wrote:
> This reverts and updates commit 77776fd0a4cc541b9a528eacc1d31ca47eb1ae7a
> ("mmc: sd: fix the maximum au_size for SD3.0"). The au_size for SD3.0
> cannot be achieved by a simple bit shift, so this needs to be
> implemented differently. Also, don't print the warning in case of 0
> since 'not defined' is different from 'invalid'.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
>=20

Ping! Chris are you there? This got reviewed and acked, and I'd even
think this could be suitable for stable.


--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS097tAAoJEBQN5MwUoCm27K8P/2P5T51UL6e9+C7/iwpPw7LQ
mZx+KtaBS0ThmgjkAc8mFnn3vH9M76EBaTg5CPIxVF0h3T96DDWLQEZxezyqtgsa
rMqxXbr7034S50epmYmK776cgY9Ub4Bj3li46AJVcdpI/H74kqFm0RshStKUCEqB
MnUVC67ucCXRAaJwMCjOGMukq2zHaxUJR9+WllrKf/X/9+a1iib8GKin4PBmGQH3
UkRVRuP3t1XdwVzN+mhIGUlctpaEg6Z+D8oMYGEnS9yzj+x3fJXBF3dZpMweiCRB
iDELtWNPArXK5kWkBWTasvkkEVBZcGiGlpUnI5Zweod/Qdokg0103MkzdJdhiMvP
6qXET22nWvkqgoQPr939i4TABcQFuIKb7VskvVfCof04cQp972LRUKhJDWmb8czB
Th954KngGSTLXxN5W4OCcz1PllLW724Zvb2sZODl0S18Z9i1sSqdtXhEBsg2xK+U
9R2vwakX2ErmvGztkEkYQ7WEV65gp8sfUuCSJnEdIITrvdFOtIzaE3luAh7kxbEy
xw4lolZm2O2yGU/ryfs77R69Jj08zMDltYifBeNDdXy99agnsJVQH4RDvtpk9IaG
epUXTednK35/uZWyjTcgL49/LBngOOJ4ljZUOdiL8n9nizjBTPvR2pl+JQitubF7
V89Stn2/JVss1+bUvn6X
=v80V
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
