From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/9] mmc: tmio: Add UHS-I mode support
Date: Thu, 18 Aug 2016 20:41:40 +0200
Message-ID: <20160818184139.GA1472@tetsubishi>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
 <20160817190804.GA11930@tetsubishi>
 <CAMuHMdV31WewDgV8c6gGdssSvXO4sX2hCcV3w6SMxD-eyUc9Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36212 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbcHSCcB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 Aug 2016 22:32:01 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdV31WewDgV8c6gGdssSvXO4sX2hCcV3w6SMxD-eyUc9Cw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'll try to remove it. Note that sh73a0-kzm9g.dts also uses broken-cd,
> without ill effects.

This one does have a seperate card-detect-irq (which is not populated
for sdhi2) while the other one only has one, generic irq. That's at
least a difference.

We could try to see if there are unexpected card-detect events by
instrumenting mmc_detect_change() in tmio_mmc_pio.c, but my feeling is
that the card_busy change you reverted is only making something visible
which went wrong before the change, also.

So, it might be worth to protect the whole voltage_switch and card_busy
functionality with TMIO_MMC_MIN_RCAR2?


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXtgFjAAoJEBQN5MwUoCm2MOcP/3Hm8WpM8WeZRke+AzZS+LIk
hCQzoADIbeF7AvQYgPltE/B5vtADz4WSS+G0EtwSGLtLRbPYWSORDO2kLpHdvqJN
Qv/azQHhPGTofM4JwovCf+9CXGfR/0f7JtutE999BPY9r8clF0PosNyergib/lNO
BPCDHNZVv7k44fZ4p46hTBgwev8ZWE+5ApwB5kclnRHyX835vlZDrrtAmlqWydmX
D52Jo48NvF3QC8CJAxYWqDlv3MVS5VpznrKdcV2JjmJDQDkFjdzNSyhdDBiLKV/G
QfjI0JUFkMnl3ndy5xDchxbd94HJ2LhdJSEkfenQxEM6Ry8dbV4N7rBXrslll10B
deITPQQ3hEYLS/cw6FpKo4xlz42YaVvAdCwK0FD55pdq9l4Yf/GhZypRSmqSwpLe
L3zIpvCTEsBfy9OTt5kBDNwMbq/tDqBg2k0eD38ZMRsm9Zt2GlWoJXo3cpFQTn+M
Mkw7kd0yT5Rwf5crGR90tmVV+A7G9OVKh/NAEeFuPj+zLrSIKHMJA/5hxADEFxt1
mnFUuspGBe2VklodVnTc28iPs1rbDT7vlqotIKETGWlR/Dqi60JOlf4oLIP6oU+B
Spfh0QwvWZJzcPLhCZCMj0YaT4sZKI838uRRKKzrZBQTSU58CHvLqWpl1r8WvD8A
uSsL3AJLpa78OVTYWsg+
=u8O+
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
