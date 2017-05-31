From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
Date: Wed, 31 May 2017 22:21:28 +0200
Message-ID: <20170531202128.GA3791@katana>
References: <20170530090346.19088-1-wsa+renesas@sang-engineering.com>
 <20170530200218.q4s2dlrxusrdgpm2@ninjato>
 <20170531195611.GE22266@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59162 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdEaUVa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 31 May 2017 16:21:30 -0400
Content-Disposition: inline
In-Reply-To: <20170531195611.GE22266@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thanks, sorry for the clash - we seem to often hit the SDHI driver
> at about the same time.

Yes, but given the amount of refactoring done, the rebase work is
surprisingly small. So, I am all fine :) Thanks!


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkvJcMACgkQFA3kzBSg
KbZohQ//V1q7btDuqcSWsU7YCbCXsXQWwHZP2BXbRawokEixAgNkNvzvg2IP8+O0
0hnodRwCh3r1wEGApzMJM6COSSyYE26MuokOBkPoSuvrWELnKVRQOSd8SzQiktTm
rvV6QPb9Ru3qLT8iJhBKEnyBUH8eP4Si3KPUsaouMVBNrN0IbatWX879Orye7FXc
Fn0Jkv3XG2p/a4Xx9F9awmgZaGl2HX+fdxR7WqY+dQtAkBULZ0MHSyz4yuvMgMN8
kWjhqn9PVdGinv1uXfI7HccqNoQWlQNFVMokG9ORfiZNn16HEh7nrJjfJe/pRsMB
rA7T9FFWwMr4iLrakYKW4nHdHkO8QqHEpwCD5HuDIvh2zATZBeKDXbjFY4sYJeu1
CqBvm25WnFAbszTIB4H6X1dEK28HhXQZ4JXGop0PlzMFoHTYNQZ4ExpqEdfHHx6V
YV0Azy+0nievPb/YtFKVtPtfCGdSn6cvK0Z2dkVrsR0T5BfbBxnah6OichNuPcOt
UsFLlSWMAsalJihWPOfUjco5MIOWVsxViQdHM1SEVkQiG0q17JFnLxRp6ZEIXR31
f5GBRlmlIHNcdM/Qgz7dnindN/zmYwPHUZRi6lLA6OewEbECbE6IaUmKDQ8eW1QG
pn4252koJgJSr25jPhJbVR4Ne0/Yf8GTvNI+siG7j96bOFd1b8M=
=91OX
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
