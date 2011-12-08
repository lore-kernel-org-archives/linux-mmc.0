From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v3 1/4] mmc: mxs-mmc: Fix grammatical error in comment
Date: Thu,  8 Dec 2011 10:44:13 +0100
Message-ID: <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323336236.git.LW@KARO-electronics.de>
References: <cover.1323336236.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:53813 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1LHJo3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 04:44:29 -0500
In-Reply-To: <cover.1323336236.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323336236.git.LW@KARO-electronics.de>
References: <cover.1323336236.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-m=
x28.c
index da6e4aa..fc86b04 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -554,7 +554,7 @@ static struct clk rtc_clk =3D {
 	.parent =3D &ref_xtal_clk,
 };
=20
-/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
+/* usb_clk gate is controlled in DIGCTRL rather than CLKCTRL */
 static struct clk usb0_clk =3D {
 	.enable_reg =3D DIGCTRL_BASE_ADDR,
 	.enable_shift =3D 2,
--=20
1.5.6.5

