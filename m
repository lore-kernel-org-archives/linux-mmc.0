From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 12/15] ARM: dts: sun9i: Use sun9i specific mmc compatible
Date: Thu, 21 Jan 2016 13:26:39 +0800
Message-ID: <1453354002-28366-13-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54946 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934163AbcAUFdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:41 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

sun9i/A80 MMC controllers have a larger FIFO, and the FIFO DMA
trigger levels can be increased. Also, the mmc module clock parent
has a higher clock rate, and the sample and output delay phases
are different.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index e838f206f2a0..f4f61b02be1a 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -543,7 +543,7 @@
 		};
 
 		mmc0: mmc@01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&mmc_config_clk 0>, <&mmc0_clk 0>,
 				 <&mmc0_clk 1>, <&mmc0_clk 2>;
@@ -557,7 +557,7 @@
 		};
 
 		mmc1: mmc@01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&mmc_config_clk 1>, <&mmc1_clk 0>,
 				 <&mmc1_clk 1>, <&mmc1_clk 2>;
@@ -571,7 +571,7 @@
 		};
 
 		mmc2: mmc@01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&mmc_config_clk 2>, <&mmc2_clk 0>,
 				 <&mmc2_clk 1>, <&mmc2_clk 2>;
@@ -585,7 +585,7 @@
 		};
 
 		mmc3: mmc@01c12000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&mmc_config_clk 3>, <&mmc3_clk 0>,
 				 <&mmc3_clk 1>, <&mmc3_clk 2>;
-- 
2.7.0.rc3

