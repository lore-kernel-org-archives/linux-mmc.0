From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 2/3] dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123] fallback compatibility strings
Date: Wed, 18 Oct 2017 09:00:22 +0200
Message-ID: <20171018070023.3878-3-horms+renesas@verge.net.au>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:57269 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbdJRHBE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Oct 2017 03:01:04 -0400
In-Reply-To: <20171018070023.3878-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility strings for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4
* Corrected typo in changelog
* Added comma to "When compatible with the generic version, nodes must list"
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index b63392d9cc47..3c6762430fd9 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -10,7 +10,7 @@ described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
 optional bindings can be used.
 
 Required properties:
-- compatible:	"renesas,sdhi-shmobile" - a generic sh-mobile SDHI unit
+- compatible: should contain one or more of the following:
 		"renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
 		"renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
 		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
@@ -26,6 +26,16 @@ Required properties:
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
+		"renesas,sdhi-shmobile" - a generic sh-mobile SDHI controller
+		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
+		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
+					   SDHI controller
+		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 SDHI controller
+
+
+		When compatible with the generic version, nodes must list
+		the SoC-specific version corresponding to the platform
+		first followed by the generic version.
 
 - clocks: Most controllers only have 1 clock source per channel. However, on
 	  some variations of this controller, the internal card detection
@@ -47,7 +57,7 @@ Optional properties:
 Example: R8A7790 (R-Car H2) SDHI controller nodes
 
 	sdhi0: sd@ee100000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790", "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 314>;
@@ -61,7 +71,7 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 	};
 
 	sdhi1: sd@ee120000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790", "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 313>;
@@ -75,7 +85,7 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 	};
 
 	sdhi2: sd@ee140000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790", "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 312>;
@@ -89,7 +99,7 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 	};
 
 	sdhi3: sd@ee160000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790", "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0

