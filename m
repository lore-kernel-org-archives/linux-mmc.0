Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68989C433E8
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B742072D
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199540;
	bh=QlwySSBCvmniu5l1kZrfLw5QDFpCJZGwDezndX9H7Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hzL3PKD3VJ+7E7h5AN+lGCtZiYmNRnhaxko2X7fOHdrz16gMkg/pMTlQlLJGiDWGP
	 mAQsOT02IrSqufQCHX1Nx3khPB+8C6OQLIChk/N+AY/+yZcKKMsk7SXwC6EC6522ka
	 8C1liWXULphRYaF3uGwf+cnjLnpSxjCEqH1HV9SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHWQRF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHWQRC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:02 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEB02072D;
        Sun, 23 Aug 2020 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199421;
        bh=QlwySSBCvmniu5l1kZrfLw5QDFpCJZGwDezndX9H7Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djqIqNfpDmCmAnKttL/Jn8WVYR+hrsPFeZ18Xf1X9f0kSf3uyPd+3W9sIOZ2oGCj9
         eU/976pAeoTdxJrCRFp4IOXobPGzAwtVOoEP0biGIMBSRLT15GOWf+zLhV+1fu1JBw
         oYITexJMsa1/UlJ4n4pCKbkCKIwpmRNO4zXg4YbU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 14/22] dt-bindings: arm: fsl: Fix Toradex Colibri i.MX 8 binding
Date:   Sun, 23 Aug 2020 18:15:42 +0200
Message-Id: <20200823161550.3981-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Toradex Colibri i.MX 8 Evaluation board has two Toradex compatibles
so it needs separate entry.  This fixes dtbs_check warning:

  arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /:
    compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is not valid under any of the given schemas (Possible causes of the failure):
    arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dt.yaml: /: compatible: ['toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x', 'fsl,imx8qxp'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 591fa336d6fa..93a21b10d115 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -385,7 +385,13 @@ properties:
               - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
               - toradex,colibri-imx8x         # Colibri iMX8X Module
+          - const: fsl,imx8qxp
+
+      - description: Toradex Colibri i.MX8 Evaluation Board
+        items:
+          - enum:
               - toradex,colibri-imx8x-eval-v3 # Colibri iMX8X Module on Colibri Evaluation Board V3
+          - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
       - description:
-- 
2.17.1

