From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH] ARM: dts: r8a7793: Add MMCIF0
Date: Wed, 16 Mar 2016 18:10:37 +0100
Message-ID: <1458148237-21902-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37106 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbcCPRKn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 13:10:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Same as on r8a7794.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 63f811d..33413e8 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -509,6 +509,18 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	mmcif0: mmcif@ee200000 {
+		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		dma-names = "tx", "rx";
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.6.4

