From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v6 4/8] dt-bindings: mmc: Add optional generic properties for mmc
Date: Wed, 20 Nov 2019 12:17:25 +0530
Message-ID: <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, rajan.vaja@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

Add optional properties for mmc hosts which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..305b2016bc17 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -333,6 +333,18 @@ patternProperties:
     required:
       - reg
 
+  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    minItems: 2
+    maxItems: 2
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 359
+    description:
+      Set the clock (phase) delays which are to be configured in the
+      controller while switching to particular speed mode. These values
+      are in pair of degrees.
+
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
@@ -351,6 +363,7 @@ examples:
         keep-power-in-suspend;
         wakeup-source;
         mmc-pwrseq = <&sdhci0_pwrseq>;
+        clk-phase-sd-hs = <63>, <72>;
     };
 
   - |
-- 
2.17.1
