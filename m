From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Wed, 16 Mar 2016 18:11:36 +0100
Message-ID: <1458148297-22159-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1458148297-22159-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148297-22159-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index b7f32d3..009ce38 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -509,6 +509,39 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+		       <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	sdhi1: sd@ee140000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+		       <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	sdhi2: sd@ee160000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+		       <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
2.6.4
