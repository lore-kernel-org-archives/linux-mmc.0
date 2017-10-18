From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 1/3] dt-bindings: mmc: renesas_sdhi: provide example in bindings documentation
Date: Wed, 18 Oct 2017 09:00:21 +0200
Message-ID: <20171018070023.3878-2-horms+renesas@verge.net.au>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:57261 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdJRHBC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Oct 2017 03:01:02 -0400
In-Reply-To: <20171018070023.3878-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Provide an example of the usage of the DT bindings for TMIO
in their documentation. The example given is for the r8a7790 (R-Car H2).

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3
* Updated example to newer upstream DTS which uses newer CPG/MSSR bindings.

v2
* Correct description of example, it is for the r8a7790 (R-Car H2)
  rather than the r8a7779 (R-Car H1)
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 54ef642f23a0..b63392d9cc47 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -43,3 +43,61 @@ Optional properties:
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
+
+Example: R8A7790 (R-Car H2) SDHI controller nodes
+
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7790";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 314>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+		       <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <195000000>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 314>;
+		status = "disabled";
+	};
+
+	sdhi1: sd@ee120000 {
+		compatible = "renesas,sdhi-r8a7790";
+		reg = <0 0xee120000 0 0x328>;
+		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 313>;
+		dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
+		       <&dmac1 0xc9>, <&dmac1 0xca>;
+		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <195000000>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 313>;
+		status = "disabled";
+	};
+
+	sdhi2: sd@ee140000 {
+		compatible = "renesas,sdhi-r8a7790";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 312>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+		       <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 312>;
+		status = "disabled";
+	};
+
+	sdhi3: sd@ee160000 {
+		compatible = "renesas,sdhi-r8a7790";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 311>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+		       <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 311>;
+		status = "disabled";
+	};
-- 
2.11.0

