From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 9/9] omap_hsmmc: remove unused slot_id parameter
Date: Thu, 2 Oct 2014 11:42:52 -0500
Message-ID: <20141002164252.GE7933@saruman>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
 <1411983179-28677-10-git-send-email-afenkart@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59502 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbaJBQmt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Oct 2014 12:42:49 -0400
Content-Disposition: inline
In-Reply-To: <1411983179-28677-10-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com

--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 11:32:59AM +0200, Andreas Fenkart wrote:
> omap_hsmmc only supports one slot. So slot id is always zero, and
> slot id is never used in the callbacks

I wonder if this will break slot multiplexing on n8x0.

--=20
balbi

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULYCMAAoJEIaOsuA1yqRECXwP/0ckbZofZAUvU0vR271fZ0Oa
e5K95GSqH+cSWG6hZbX2cNOV/GBSlFgnkLacHNAHZBoMbjAtbkMeAiaBMIVqIOd5
ZIoVOfH/m/LHgbfLPV44+QB3zqfYXpRgfwwOolbqxZ5ZTTd3V9/K49tslfHMYBai
mxIT0deEZjB4yPxg/JLT0SjQxjkhSpmqAdhBtdglzwiGe0wvZuLJMDxogQLPXO7b
N/cKc57i1DxaweDfpdKM+zfvr3ZbziJV+L/psyuq510QCeLbRQ50JWBlbeZmd9qJ
kZg0POukgS+WwvlYaKCj0fql/k2xZdZwKl7+lmxx73p/SlpHZJHPbW85k+hCCZ/K
dhqYDZnMMnMW/oa2IcwjCoxUI6nrjfMgIaMaYOHqLXqhx2Eo0oSJLeO/EXnVDYIp
txZs4uqHj3FCwfI5LezTO+lFXyxSMabmyC0ehy9uPIaDPHZf0LzoicDEftWEieYV
pY6uf5VO9v7YrMCjtJX0A8ga4B+xWOrp9QZqhNRH3Q9Ys+3DWgQfLsb9IR5uhXf0
V1CBpAoeDRwNPXh2wjfm1N2tpxku1t+gzBTD2omO6osKT36ybgThpcdMZvBbdeG0
6Nx0dVqjVfh2Uni6XDmHqT3BCdWahfb2h6HvnjmnufUMbFkVD0EQFR7Atdb8Vc59
qrtGHUAgi4u42B9KcHb2
=fgLD
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
