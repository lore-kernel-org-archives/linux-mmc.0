From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Tue, 10 Jan 2017 23:30:43 +0100
Message-ID: <20170110223043.GA2710@katana>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:33970 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755667AbdAJWat (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Jan 2017 17:30:49 -0500
Content-Disposition: inline
In-Reply-To: <20170110210848.GA25542@bigcity.dyn.berto.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Oddly enough the error are only printed when I insert the SD card in the=
=20
> mmc0 slot. I can insert/eject the card multiple times in mmc1 and no=20
> error but the first insertion in mmc0 and boom. Only difference I can=20
> see are the clock speed between mmc0 and mmc1.

Can you try this patch?

=46rom: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 13 Nov 2016 11:10:09 +0100
Subject: [PATCH] pinctrl: pfc: r8a7795: WIP: hardcode TDSEL value

Otherwise, AC-180M won't get probed with SDR50 and EMMY-W1 has more
tuning errors with SDR104.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/=
pfc-r8a7795.c
index 3f58bfd676ce94..3e3f7585efe8b3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5416,6 +5416,9 @@ static int r8a7795_pinmux_init(struct sh_pfc *pfc)
 		pr_info("%s: R-Car H3 >=3D ES2.0\n", __func__);
 		// FIXME Fixup r8a7795_pinmux_info for ES2.0
 	}
+
+#define TDSEL 0xe60603c0
+	sh_pfc_write_reg(pfc, TDSEL, 32, 0xc3);
 	return 0;
 }
=20
--=20
2.10.2



--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYdWCTAAoJEBQN5MwUoCm222IP/jpVh9+UQZsNYTmj5+PKWEmO
nULPpqBU8+Byt8iUR6B6QmZHE/mxCAe9KcN4BL0uTfaPSqSc+abEdTDfBV+dltOj
2hlGiRupy4in2i6uM5oTuSjbhxBHYC8cZdMzdoFoy9Y24CNLQMrgIDRaCKeodUJJ
6yKx8JnLQ+A8pEObYCJ84ysFmzdP7g1jQxyWj9pGvBHgXP2lcYKtCSt15FKr6hgp
EUMekcTbHPYHvO56D44VFDCsWzcPt8gpHRIxO0s0WsVbA49AuYa3mcsdohqhZIn8
BQeHdhOjr3F2Ta/mZwIQii9vganRgLt7kT1EU+phKdGUeaBQ/peS+kKIPdi7woqu
BOMtohX0mR5RPEAHcZ1YJZTvAw7yUoWzY3IDLVgfp3MRWwhfhI3R8WCHvTelXQEu
+yWqzRqRZdUO8Lr3ci1L5G4C51Jf+waP0MXibc7KLyuORf1XDX/FkQvZb9Y45MwG
0Dmik9DlYQdCmtdtkBdHdLWCE0KLDtMKwiOVYz+k1NJDmvr4bxmixF/WXOHAR+1z
dJSiVK/+Qz/gaKp8ZHEUXd/8HE2PMM8xjVNgTgcurI3/YM/PGafJ7OB196f6RUf9
rXjNdynJ+40xGtHO4xrk4wTH5UeBgN6DRHBD3Bz/BWpUw2EpdqQwdL9mScqciBrw
7pCxBOsvlbvllclVcyab
=UwxU
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
