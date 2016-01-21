From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 08/15] ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
Date: Thu, 21 Jan 2016 13:26:35 +0800
Message-ID: <1453354002-28366-9-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54939 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbcAUFdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:41 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

mmc2 and mmc3 are available on the same pins, with different mux values.
However, only mmc3 supports 8 bit DDR transfer modes.

Since preference for mmc3 over mmc2 is due to DDR transfer modes, just
set the drive strength to 40mA, which is needed for DDR.

This pinmux setting also includes the hardware reset pin for emmc.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b6ad7850fac6..1867af24ff52 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -709,6 +709,16 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc3_8bit_emmc_pins: mmc3@1 {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+						 "PC10", "PC11", "PC12",
+						 "PC13", "PC14", "PC15",
+						 "PC24";
+				allwinner,function = "mmc3";
+				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			gmac_pins_mii_a: gmac_mii@0 {
 				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
 						"PA8", "PA9", "PA11",
-- 
2.7.0.rc3

