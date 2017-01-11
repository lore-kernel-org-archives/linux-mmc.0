From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 11 Jan 2017 16:05:21 +0100
Message-ID: <20170111150521.GA1486@katana>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
 <20170110223043.GA2710@katana>
 <20170111083541.GB25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41024 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755354AbdAKPFZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Jan 2017 10:05:25 -0500
Content-Disposition: inline
In-Reply-To: <20170111083541.GB25542@bigcity.dyn.berto.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

> I'm doing my tests on Koelsch so I'm afraid setting the TDSEL in=20
> pfc-r8a7795.c won't do much ;-) Nevertheless I tried to mimic the patch=
=20
> for Koelsch but found the documentation lacking and where unable to do=20
> so. That is I found a TDSEL register but no documentation of its=20
> content.

Sorry, that slipped through. Actually, I sent a patch for H2:

https://patchwork.kernel.org/patch/9434323/

I wanted to do some TDSEL testing on other Gen2 boards in Brussels,
provided that people could bring some. So, if you could bring that
Koelsch board, that would be really helpful.

I assume that you created a similar patch to the above for Koelsch and
the issue still remained? :(

Regards,

   Wolfram


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYdkmxAAoJEBQN5MwUoCm2n+MP/3DN5sAuCunhi08RUK/dsTdL
3T4I220J6FfV2rk4wqvoGzXO+qIYQIePils2cLOuHBM29LxVQajlOwkIsopmB+XP
410TsdKSA3aVdEV0ZbC0dRBWCrdgaS4X+GRli+rwjaM4X6b1/3JcWERWJEAYcU22
GAL+VQVp8s+emFjZsnTOEDqUFJbJ8EGgSRkrFqVLk3eXDx4dTz3yttfTqe02upfX
+SBYXSTzF7Nlb9JnKUiKOF92f7fFlIqaHVhuhVqQGTqReTbH+HWbuyaANI0otr/v
84y0w4fs1vO+VD7WVEPE1XfQTRAfvd9sDDdGO5GZibBnX1Bq3O1gvrizQxpxShdp
WqjSD/GWcvvbK3+HqZW1QLqfZYPZZSh/qsBECucxK2lImioGLvxUE0Tjw0hyaLNg
OY96uivuWBgz4gHDrXQ+H0BfMmg9/BzVjwhwMhtTiC2JrSLmCgyDYL581LvW4l3m
RbppXsnz+rizNQwp2/KTYTpGth3FxHhhkc2Pe5wFNIpFBKzc3kH+cytXnYmPAKwF
4ExIKv5PPe68IIduLl/QmBqjD3IuMmFNwYr2r4qxwTIBzCw6hIosumVuiUnzEDaa
ojUfX/PgMlm+6AZSuRIIiSwLRKjt99YGRdOsAiCRhHyGuPjZDHwjuYyTa5+4oFlo
5u66vNNt3Cz8WjMJlOHo
=CmGy
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
