From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Mon, 18 Apr 2016 18:02:56 +0200
Message-ID: <1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 6843f46..aea9294 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -510,6 +510,42 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+		       <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
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
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
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
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
2.7.4
