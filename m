From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
Date: Tue, 5 Nov 2019 06:50:13 +0100
Message-ID: <20191105055015.23656-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

A certain eMMC manufacturer provided below requirement:
 ---snip---
 Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
 ---snip---

The existing "fixed-emmc-driver-type" property [1] is the closest one
to implement the above, but it falls short due to being unable to define
two values to differentiate between HS200 and HS400 (both modes may be
supported by the same non-removable MMC device).

To allow users to set a preferred HS200/HS400 "drive strength", provide
two more bindings inspired from [1]:
 - fixed-emmc-driver-type-hs200
 - fixed-emmc-driver-type-hs400

For more details about eMMC I/O driver strength types, see Jedec spec.
Keep "fixed-emmc-driver-type" in place for backward compatibility.

[1] commit 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 .../bindings/mmc/mmc-controller.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..1c64b14f91a3 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -248,6 +248,24 @@ properties:
       the driver type as specified in the eMMC specification (table
       206 in spec version 5.1)
 
+  fixed-emmc-driver-type-hs200:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      Same as "fixed-emmc-driver-type", but specific to HS200 mode.
+      If defined, overrides "fixed-emmc-driver-type" in HS200 mode.
+
+  fixed-emmc-driver-type-hs400:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      Same as "fixed-emmc-driver-type", but specific to HS400 mode.
+      If defined, overrides "fixed-emmc-driver-type" in HS400 mode.
+
   post-power-on-delay-ms:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
@@ -336,6 +354,8 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  fixed-emmc-driver-type-hs200: [ non-removable ]
+  fixed-emmc-driver-type-hs400: [ non-removable ]
 
 examples:
   - |
-- 
2.23.0
