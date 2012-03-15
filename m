From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 1/8] mmc: omap: Enable Auto CMD12
Date: Thu, 15 Mar 2012 16:57:51 +0200
Message-ID: <20120315145750.GQ28447@arwen.pp.htv.fi>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-2-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:53845 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932396Ab2COO6C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:58:02 -0400
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so3043799lag.36
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 07:58:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331822022-26714-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 08:03:35PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>=20
> Enable Auto-CMD12 for multi block read/write on HSMMC
> Tested on OMAP4430, OMAP3430 and OMAP2430 SDP
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>

BTW, since patches are flowing through you now, they should have your
SoB line.

--=20
balbi

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgNuAAoJEIaOsuA1yqREB/cP/2e+IZdPjyCEvur9PauACBdj
8yaPz6eFBtp0teX2ATuzKVzkQrUHHoc7qig9kvN9mrc/XAxfNHLXuUE1RBTv2Yc6
gNXwaHr/hvYdfXP72PFSEQvyTd/XK0mPUY2VpyOHvvq4KcZLn+tlguD2gdgOWaH6
T87Q0aPoM6DQe8rnFMo9sEXjC796gJR8OqI31GOm1/91nG/TsbKqI9JDrtVTcepT
ukp0pVmTNVdB1OftDH/ZTV8pAqY5ddHedQZe/zqCom+ANSiV+9zjsquBuZptEC1c
0JTLqAYEKuTVwk21gonILrqmThVib8z7Eq29C9hTaT0JmPm65Oqtcd8BZUc/RZZ2
pHFs3ox+L1Tx9XJ4EkFOks4kJ65/chCZAWL0E0qBPcQ69gakCIFXbUbYf0wi2Swb
/d1PYr56ne+GbJ/IJen9244/UihBcDNeVKzTCF9QeKjPhXqx88DhygXa2l7jpsr7
UKUdqJuhfhS6k2iT8siW8lkfiYzz+tQGR6q1s7F4Pe3xAlDuWCHUMcqZUSerZ3Zx
2Qw1LLxmSXxXqnghoPI8NRWkouoy0nPF23zeK5r8gvmQxmMKlPDxnvjKuHyRyO1Q
Qy76yVCYBLxl2Uo03C9XkFJ9K+ZJKzVQYDit8yLGNoV3UNI0CemHLLtBao+wGQXD
zvQMOyrSQ9NQcyp1uths
=XGFy
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
