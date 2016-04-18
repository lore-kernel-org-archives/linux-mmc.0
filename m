From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2] ARM: dts: r8a7793: Add MMCIF0
Date: Mon, 18 Apr 2016 18:02:40 +0200
Message-ID: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34541 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbcDRQCp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 12:02:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Same as on r8a7794.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
This revision adds the missing dma-names and power-domains entires spotted
by Sergei and Simon.

CU
Uli


 arch/arm/boot/dts/r8a7793.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bf70c46..6843f46 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -510,6 +510,19 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	mmcif0: mmcif@ee200000 {
+		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.4

