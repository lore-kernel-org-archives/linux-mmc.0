From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v5] ARM: dts: r8a7793: Add MMCIF0
Date: Thu,  5 May 2016 17:31:45 +0200
Message-ID: <1462462305-27890-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36806 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbcEEPcA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2016 11:32:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Now with enhanced ePAPR compliance and Acked-by.

CU
Uli


Changes since v4:
- ePAPR compliance

Changes since v3:
- set power-domains = <&sysc R8A7793_PD_ALWAYS_ON>

Changes since v2:
- change back to one DMA controller
- use GIC_SPI
- add max-frequency


 arch/arm/boot/dts/r8a7793.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 1dd6d20..76c8435 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -543,6 +543,19 @@
 		status = "disabled";
 	};
 
+	mmcif0: mmc@ee200000 {
+		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
+		dma-names = "tx", "rx";
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		reg-io-width = <4>;
+		status = "disabled";
+		max-frequency = <97500000>;
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.4

