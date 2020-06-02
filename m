Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB9C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 03:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88F12086A
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 03:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFBDsQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:48:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40082 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFBDsQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Jun 2020 23:48:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AA762005FD;
        Tue,  2 Jun 2020 05:48:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C7502005FE;
        Tue,  2 Jun 2020 05:48:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 065BF40285;
        Tue,  2 Jun 2020 11:48:01 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] dt-bindings: mmc: Convert imx esdhc to json-schema
Date:   Tue,  2 Jun 2020 11:37:44 +0800
Message-Id: <1591069066-12727-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591069066-12727-1-git-send-email-Anson.Huang@nxp.com>
References: <1591069066-12727-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the i.MX ESDHC binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 122 +++++++++++++++++++++
 2 files changed, 122 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
deleted file mode 100644
index de1b8bd..0000000
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
-
-The Enhanced Secure Digital Host Controller on Freescale i.MX family
-provides an interface for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
-
-Required properties:
-- compatible : Should be "fsl,<chip>-esdhc", the supported chips include
-	       "fsl,imx25-esdhc"
-	       "fsl,imx35-esdhc"
-	       "fsl,imx51-esdhc"
-	       "fsl,imx53-esdhc"
-	       "fsl,imx6q-usdhc"
-	       "fsl,imx6sl-usdhc"
-	       "fsl,imx6sx-usdhc"
-	       "fsl,imx6ull-usdhc"
-	       "fsl,imx7d-usdhc"
-	       "fsl,imx7ulp-usdhc"
-	       "fsl,imx8mq-usdhc"
-	       "fsl,imx8mm-usdhc"
-	       "fsl,imx8mn-usdhc"
-	       "fsl,imx8mp-usdhc"
-	       "fsl,imx8qm-usdhc"
-	       "fsl,imx8qxp-usdhc"
-
-Optional properties:
-- fsl,wp-controller : Indicate to use controller internal write protection
-- fsl,delay-line : Specify the number of delay cells for override mode.
-  This is used to set the clock delay for DLL(Delay Line) on override mode
-  to select a proper data sampling window in case the clock quality is not good
-  due to signal path is too long on the board. Please refer to eSDHC/uSDHC
-  chapter, DLL (Delay Line) section in RM for details.
-- voltage-ranges : Specify the voltage range in case there are software
-  transparent level shifters on the outputs of the controller. Two cells are
-  required, first cell specifies minimum slot voltage (mV), second cell
-  specifies maximum slot voltage (mV). Several ranges could be specified.
-- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
-  in tuning procedure.
-- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
-  The uSDHC use one delay cell as default increasing step to do tuning process.
-  This property allows user to change the tuning step to more than one delay
-  cells which is useful for some special boards or cards when the default
-  tuning step can't find the proper delay window within limited tuning retries.
-- fsl,strobe-dll-delay-target: Specify the strobe dll control slave delay target.
-  This delay target programming host controller loopback read clock, and this
-  property allows user to change the delay target for the strobe input read clock.
-  If not use this property, driver default set the delay target to value 7.
-  Only eMMC HS400 mode need to take care of this property.
-
-Examples:
-
-esdhc@70004000 {
-	compatible = "fsl,imx51-esdhc";
-	reg = <0x70004000 0x4000>;
-	interrupts = <1>;
-	fsl,wp-controller;
-};
-
-esdhc@70008000 {
-	compatible = "fsl,imx51-esdhc";
-	reg = <0x70008000 0x4000>;
-	interrupts = <2>;
-	cd-gpios = <&gpio1 6 0>; /* GPIO1_6 */
-	wp-gpios = <&gpio1 5 0>; /* GPIO1_5 */
-};
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
new file mode 100644
index 0000000..7d0ea27
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+description: |
+  The Enhanced Secure Digital Host Controller on Freescale i.MX family
+  provides an interface for MMC, SD, and SDIO types of memory cards.
+
+  This file documents differences between the core properties described
+  by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx25-esdhc
+      - fsl,imx35-esdhc
+      - fsl,imx51-esdhc
+      - fsl,imx53-esdhc
+      - fsl,imx6q-usdhc
+      - fsl,imx6sl-usdhc
+      - fsl,imx6sx-usdhc
+      - fsl,imx6ull-usdhc
+      - fsl,imx7d-usdhc
+      - fsl,imx7ulp-usdhc
+      - fsl,imx8mq-usdhc
+      - fsl,imx8mm-usdhc
+      - fsl,imx8mn-usdhc
+      - fsl,imx8mp-usdhc
+      - fsl,imx8qm-usdhc
+      - fsl,imx8qxp-usdhc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  fsl,wp-controller:
+    description: |
+      boolean, if present, indicate to use controller internal write protection.
+    type: boolean
+
+  fsl,delay-line:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify the number of delay cells for override mode.
+      This is used to set the clock delay for DLL(Delay Line) on override mode
+      to select a proper data sampling window in case the clock quality is not good
+      due to signal path is too long on the board. Please refer to eSDHC/uSDHC
+      chapter, DLL (Delay Line) section in RM for details.
+    default: 0
+
+  voltage-ranges:
+    $ref: '/schemas/types.yaml#/definitions/uint32-matrix'
+    description: |
+      Specify the voltage range in case there are software
+      transparent level shifters on the outputs of the controller. Two cells are
+      required, first cell specifies minimum slot voltage (mV), second cell
+      specifies maximum slot voltage (mV). Several ranges could be specified.
+    items:
+      items:
+        - description: value for minimum slot voltage
+        - description: value for maximum slot voltage
+    maxItems: 1
+
+  fsl,tuning-start-tap:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify the start dealy cell point when send first CMD19 in tuning procedure.
+    default: 0
+
+  fsl,tuning-step:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify the increasing delay cell steps in tuning procedure.
+      The uSDHC use one delay cell as default increasing step to do tuning process.
+      This property allows user to change the tuning step to more than one delay
+      cells which is useful for some special boards or cards when the default
+      tuning step can't find the proper delay window within limited tuning retries.
+    default: 0
+
+  fsl,strobe-dll-delay-target:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify the strobe dll control slave delay target.
+      This delay target programming host controller loopback read clock, and this
+      property allows user to change the delay target for the strobe input read clock.
+      If not use this property, driver default set the delay target to value 7.
+      Only eMMC HS400 mode need to take care of this property.
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    mmc@70004000 {
+        compatible = "fsl,imx51-esdhc";
+        reg = <0x70004000 0x4000>;
+        interrupts = <1>;
+        fsl,wp-controller;
+    };
+
+    mmc@70008000 {
+        compatible = "fsl,imx51-esdhc";
+        reg = <0x70008000 0x4000>;
+        interrupts = <2>;
+        cd-gpios = <&gpio1 6 0>; /* GPIO1_6 */
+        wp-gpios = <&gpio1 5 0>; /* GPIO1_5 */
+    };
-- 
2.7.4

