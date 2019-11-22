From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] dt-bindings: mmc: Correct the type of the clk phase properties
Date: Fri, 22 Nov 2019 12:45:57 +0530
Message-ID: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

The clock phase properties are having two uint32 values. The minItems
and maxItems are set to 2 for the same. So the property type should be
'uint32-array' and not 'uint32'. Modify it to correct the same.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 305b2016bc17..b130450c3b34 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -334,16 +334,17 @@ patternProperties:
       - reg
 
   "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 2
     maxItems: 2
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 359
-    description:
-      Set the clock (phase) delays which are to be configured in the
-      controller while switching to particular speed mode. These values
-      are in pair of degrees.
+    items:
+      minimum: 0
+      maximum: 359
+      description:
+        Set the clock (phase) delays which are to be configured in the
+        controller while switching to particular speed mode. These values
+        are in pair of degrees.
 
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
-- 
2.17.1
