From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 6/7] ARM: mvebu: Update the SDHCI node on Armada 38x
Date: Wed, 21 Jan 2015 10:32:05 +0100
Message-ID: <1421832726-21656-7-git-send-email-gregory.clement@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35003 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752321AbbAUJcc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 04:32:32 -0500
In-Reply-To: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

The binding of the armada-380-sdhci has been extended with a new
register in order to be able to use the SDR50 and DDR50 mode. This
commit add the resource associated to this new register for the
Armada 38x.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 71d4eca5b497..474b2ebf4a82 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -515,7 +515,10 @@
 
 			sdhci@d8000 {
 				compatible = "marvell,armada-380-sdhci";
-				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
+				reg-names = "sdhci", "mbus", "conf-sdio3";
+				reg = <0xd8000 0x1000>,
+					<0xdc000 0x100>,
+					<0x18454 0x4>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				mrvl,clk-delay-cycles = <0x1F>;
-- 
1.9.1

