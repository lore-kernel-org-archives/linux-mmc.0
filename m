Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF8C433E1
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350C620738
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgFDBwK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:52:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35608 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgFDBwC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Jun 2020 21:52:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D64420012A;
        Thu,  4 Jun 2020 03:52:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58A9C200EDD;
        Thu,  4 Jun 2020 03:51:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0FCDD402B0;
        Thu,  4 Jun 2020 09:51:48 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/3] dt-bindings: mmc: Convert mxs mmc to json-schema
Date:   Thu,  4 Jun 2020 09:41:26 +0800
Message-Id: <1591234886-15351-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
References: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the MXS MMC binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- add "unevaluatedProperties: false".
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  | 27 ----------
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 58 ++++++++++++++++++++++
 2 files changed, 58 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
deleted file mode 100644
index 515addc..0000000
--- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Freescale MXS MMC controller
-
-The Freescale MXS Synchronous Serial Ports (SSP) can act as a MMC controller
-to support MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the mxsmmc driver.
-
-Required properties:
-- compatible: Should be "fsl,<chip>-mmc".  The supported chips include
-  imx23 and imx28.
-- interrupts: Should contain ERROR interrupt number
-- dmas: DMA specifier, consisting of a phandle to DMA controller node
-  and SSP DMA channel ID.
-  Refer to dma.txt and fsl-mxs-dma.txt for details.
-- dma-names: Must be "rx-tx".
-
-Examples:
-
-ssp0: ssp@80010000 {
-	compatible = "fsl,imx28-mmc";
-	reg = <0x80010000 2000>;
-	interrupts = <96>;
-	dmas = <&dma_apbh 0>;
-	dma-names = "rx-tx";
-	bus-width = <8>;
-};
diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
new file mode 100644
index 0000000..1cccc04
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS MMC controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The Freescale MXS Synchronous Serial Ports (SSP) can act as a MMC controller
+  to support MMC, SD, and SDIO types of memory cards.
+
+  This file documents differences between the core properties in mmc.txt
+  and the properties used by the mxsmmc driver.
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-mmc
+      - fsl,imx28-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@80010000 {
+        compatible = "fsl,imx28-mmc";
+        reg = <0x80010000 2000>;
+        interrupts = <96>;
+        dmas = <&dma_apbh 0>;
+        dma-names = "rx-tx";
+        bus-width = <8>;
+    };
-- 
2.7.4

