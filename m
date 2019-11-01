From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties for mmc
Date: Fri,  1 Nov 2019 11:35:49 +0530
Message-ID: <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

Add optional properties for mmc hosts which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..87a83d966851 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -212,6 +212,98 @@ properties:
     description:
       eMMC HS400 enhanced strobe mode is supported
 
+  # Below mentioned are the clock (phase) delays which are to be configured
+  # in the controller while switching to particular speed mode. The range
+  # of values are 0 to 359 degrees.
+
+  clk-phase-legacy:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for Legacy Mode.
+
+  clk-phase-mmc-hs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair degrees for MMC HS.
+
+  clk-phase-sd-hs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SD HS.
+
+  clk-phase-uhs-sdr12:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR12.
+
+  clk-phase-uhs-sdr25:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR25.
+
+  clk-phase-uhs-sdr50:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR50.
+
+  clk-phase-uhs-sdr104:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR104.
+
+  clk-phase-uhs-ddr50:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SD DDR50.
+
+  clk-phase-mmc-ddr52:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC DDR52.
+
+  clk-phase-mmc-hs200:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC HS200.
+
+  clk-phase-mmc-hs400:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC HS400.
+
   dsr:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1
