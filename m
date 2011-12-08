From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [MXS MMC v2 1/4] Fix grammatical error in comment
Date: Thu,  8 Dec 2011 09:17:44 +0100
Message-ID: <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323328267.git.LW@KARO-electronics.de>
References: <cover.1323328267.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1323328267.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323328267.git.LW@KARO-electronics.de>
References: <cover.1323328267.git.LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-mmc@vger.kernel.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
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
