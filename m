Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE8C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16777610A0
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 10:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhHRKIw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:08:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57574 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhHRKIr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 06:08:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F7151A4E58;
        Wed, 18 Aug 2021 12:08:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBCF71A4E59;
        Wed, 18 Aug 2021 12:08:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E67D183AD26;
        Wed, 18 Aug 2021 18:08:10 +0800 (+08)
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: change the pinctrl-names rule
Date:   Wed, 18 Aug 2021 17:46:24 +0800
Message-Id: <1629279984-7397-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Change the pinctrl-names rule to cover all cases.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 17086f60f8a3..d324606a4f0a 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -116,12 +116,21 @@ properties:
       - const: per
 
   pinctrl-names:
-    minItems: 1
-    items:
-      - const: default
-      - const: state_100mhz
-      - const: state_200mhz
-      - const: sleep
+    oneOf:
+      - items:
+          - const: default
+          - const: state_100mhz
+          - const: state_200mhz
+          - const: sleep
+      - items:
+          - const: default
+          - const: state_100mhz
+          - const: state_200mhz
+      - items:
+          - const: default
+          - const: sleep
+      - items:
+          - const: default
 
 required:
   - compatible
-- 
2.17.1

