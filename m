From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch to mmc3 for onboard eMMC
Date: Thu, 21 Jan 2016 13:26:36 +0800
Message-ID: <1453354002-28366-10-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54942 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933342AbcAUFdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:41 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
instance can use eMMC hardware reset.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index ea69fb8ad4d8..4ec0c8679b2e 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -61,12 +61,14 @@
 };
 
 /* eMMC on core board */
-&mmc2 {
+&mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
+	pinctrl-0 = <&mmc3_8bit_emmc_pins>;
 	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
-- 
2.7.0.rc3

