From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 5/7] ARM: mvebu: Use macros for interrupt flags on Armada 38x sdhci node
Date: Fri, 23 Jan 2015 17:46:25 +0100
Message-ID: <1422031587-18212-6-git-send-email-gregory.clement@free-electrons.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52332 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755847AbbAWQqj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 11:46:39 -0500
In-Reply-To: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Instead of hardcoding the values of the interrupt flags, use the
macros provided by <include/dt-bindings/interrupt-controller/irq.h>
and <include/dt-bindings/interrupt-controller/arm-gic.h> for the
Armada 38x SDHCI node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 79c4acf186e2..71d4eca5b497 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -516,7 +516,7 @@
 			sdhci@d8000 {
 				compatible = "marvell,armada-380-sdhci";
 				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
-				interrupts = <0 25 0x4>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				mrvl,clk-delay-cycles = <0x1F>;
 				status = "disabled";
-- 
2.1.0

