Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA399C41537
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9927A6109E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhHRLjW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:39:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45710 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhHRLjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 07:39:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 803B31A50E2;
        Wed, 18 Aug 2021 13:38:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 487AE1A50DE;
        Wed, 18 Aug 2021 13:38:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA07C183ACDE;
        Wed, 18 Aug 2021 19:38:44 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] dt-bindings: mmc: fsl-imx-esdhc: add fsl,broken-auto-tuning binding
Date:   Wed, 18 Aug 2021 19:16:52 +0800
Message-Id: <1629285415-7495-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add a new fsl,broken-auto-tuning binding for sdio devices. When sdio
device support sdio interrupt, need to use this property to disable
auto-tuning. Auto-tuning circuit is conflict with sdio interrupt.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index b5baf439fbac..d7c8e5880473 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -93,6 +93,15 @@ properties:
       tuning step can't find the proper delay window within limited tuning retries.
     default: 0
 
+  fsl,broken-auto-tuning:
+    description: |
+      Recommend for SDIO cards that enables SDIO interrupt for SDR104 and SDR50 mode.
+      SDIO interrupt uses DAT[1] to signal the card's interrupt. Auto-tuning circuit
+      will detect this interrupt on DAT[1] when in 4Bit bus mode, and take it just
+      as normal data, wrongly adjust the delay cell. This property is used to disable
+      the auto-tuning function.
+    type: boolean
+
   fsl,strobe-dll-delay-target:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-- 
2.17.1

