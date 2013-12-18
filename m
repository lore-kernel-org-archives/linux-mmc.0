From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au
 sizes
Date: Wed, 18 Dec 2013 13:30:32 +0100
Message-ID: <20131218123032.GF3314@katana>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57693 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab3LRMaj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Dec 2013 07:30:39 -0500
Content-Disposition: inline
In-Reply-To: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>


--aYDVKSzuImP48n7V
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

Ping.


--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsZVoAAoJEBQN5MwUoCm27akP/3ycMGPScEGZAVCS4HBSIPRZ
agkX4yxaBhOsslV1/CGXWdcYe1M4ve/9jqhlmPMEqAYzGTbYWILU8hujxpPv+r7N
OkUUOHR3TgpxfyCuSdno04CMrja6XSbgvwqx0o5pH1Bw34k9pwRcaakhhXC2qbGt
/j+peLrO9iFvGeYn3cSjQOPis8GXoZI0anug6fM6sVnQWYJQfdEwLT0zoootxJvF
jAV5+qewyQy3AUsAfe/3AOvOoe45ICX7Q+MIpsfVihi59yGglK+7rwXDZxau33+h
XVBiRvfrIjdFRzuhf1+dL/92ytkTzvbWraLfo6P3pA+aD2awl7gO6ZqJoG+dn9Vr
A+GnHtFHDOqOtamMhNP71L55c2OZMC13yucjlbAClVqfY2GGrHg2l/7po0E9kqso
Oz/xcDPSRWSa6JLMpZzREFtZMkD/Y3UVP+EK9SlVxjjw2SolCS6/mcoK3gX0t71C
O7Z7Nex3f1Fvd2JYBqF/9uIKPsfRoM9axE8PRx3rjeeeIPNAnvJKyLP+8hZZC5pa
IC6P+UJFJXEpqF876mrJS8QdJN6W7iXDatzftnFtJnu8QBMKmbbhbX13KzVvvxzp
azlxEqGsjNPaO8BgDpK9yJGDWH3FLS9J5tfBUS5tUY5leyogmL/gAAU9rApJbMTR
sC+8c/xS4VwhMJC6ReHy
=ItKk
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
