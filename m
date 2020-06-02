Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCDC433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 03:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462DB2073B
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 03:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBDsR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:48:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36826 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBDsR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Jun 2020 23:48:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 599DE1A0AA9;
        Tue,  2 Jun 2020 05:48:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 727471A0A48;
        Tue,  2 Jun 2020 05:48:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2AEB4402B1;
        Tue,  2 Jun 2020 11:48:03 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] dt-bindings: mmc: Convert imx mmc to json-schema
Date:   Tue,  2 Jun 2020 11:37:45 +0800
Message-Id: <1591069066-12727-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591069066-12727-1-git-send-email-Anson.Huang@nxp.com>
References: <1591069066-12727-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the i.MX MMC binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        | 23 ----------
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
deleted file mode 100644
index 184ccff..0000000
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Freescale Secure Digital Host Controller for i.MX2/3 series
-
-This file documents differences to the properties defined in mmc.txt.
-
-Required properties:
-- compatible : Should be "fsl,<chip>-mmc", chip can be imx21 or imx31
-
-Optional properties:
-- dmas: One DMA phandle with arguments as defined by the devicetree bindings
-	of the used DMA controller.
-- dma-names: Has to be "rx-tx".
-
-Example:
-
-sdhci1: sdhci@10014000 {
-	compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
-	reg = <0x10014000 0x1000>;
-	interrupts = <11>;
-	dmas = <&dma 7>;
-	dma-names = "rx-tx";
-	bus-width = <4>;
-	cd-gpios = <&gpio3 29>;
-};
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
new file mode 100644
index 0000000..777a732
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl-imx-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Secure Digital Host Controller for i.MX2/3 series
+
+maintainers:
+  - Markus Pargmann <mpa@pengutronix.de>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx21-mmc
+      - const: fsl,imx31-mmc
+      - items:
+          - const: fsl,imx27-mmc
+          - const: fsl,imx21-mmc
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
+
+examples:
+  - |
+    mmc@10014000 {
+        compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+        reg = <0x10014000 0x1000>;
+        interrupts = <11>;
+        dmas = <&dma 7>;
+        dma-names = "rx-tx";
+        bus-width = <4>;
+        cd-gpios = <&gpio3 29>;
+    };
-- 
2.7.4

