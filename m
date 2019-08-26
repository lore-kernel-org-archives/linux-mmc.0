From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
Date: Mon, 26 Aug 2019 11:46:19 +0930
Message-ID: <20190826021620.11915-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The example node in the binding uses the AST2500 compatible string for
the SD controller with a 64kiB ranges property, but the SD controller is
allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
the example to correctly reflect the hardware in the AST2500, however it
should be noted that the MMIO region is reduced to 64kiB in the AST2600
where a second SD controller block has been introduced into the address
space.

Also add the IBM copyright header that I left out of the initial patch.

Suggested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
Hi Ulf, this is the follow-up fix as discussed here:

http://patchwork.ozlabs.org/patch/1143090/

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 570f8c72662b..200de9396036 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2019 IBM Corp.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
@@ -84,7 +85,7 @@ examples:
             reg = <0x1e740000 0x100>;
             #address-cells = <1>;
             #size-cells = <1>;
-            ranges = <0 0x1e740000 0x10000>;
+            ranges = <0 0x1e740000 0x20000>;
             clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
 
             sdhci0: sdhci@100 {
-- 
2.20.1
