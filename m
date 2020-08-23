Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F47C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80282072D
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199585;
	bh=NxgEI35oyykqhboGx/XN/M8uVZEQeFJp9m/hyO8Zrz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHTy5yRQbtmjaZsqQEP6531GwRaoe8mlNkmbeO+N2ngHs9tE0SR/lVORel/FIxMWt
	 gpj3Q/hUHsU0Wy9YQ5aYXeLmiovkTj1AHESgqwZTB1JjCJOkjahJnSV2HKLyz+X2TJ
	 EVsOcpAegjIsCh3oV9UY3jLCYuTdBfHmx2m/b23M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgHWQTo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgHWQQe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:16:34 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADF62072D;
        Sun, 23 Aug 2020 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199394;
        bh=NxgEI35oyykqhboGx/XN/M8uVZEQeFJp9m/hyO8Zrz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I365IYMK2f4cJo9LIAiBZOGUP6G+PLIcviQWmOBZ7sZhR+ZnbckMqzPXPq6aLI45k
         sk6+7J4eACIstlKyV1arsBMFSwEK9+WcHr9CLbhFEDO8rs0iOINKxsvTQcDgO+dYDn
         IergBE3bX9pt5S2vmBZa9BV9SMdCFAVW7wVMPxoo=
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
Subject: [PATCH 08/22] dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
Date:   Sun, 23 Aug 2020 18:15:36 +0200
Message-Id: <20200823161550.3981-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible:0: 'fsl,imx8mm-wdt' is not one of ['fsl,imx21-wdt']
    From schema: Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible: ['fsl,imx8mm-wdt', 'fsl,imx21-wdt'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml: watchdog@30280000:
    compatible: Additional items are not allowed ('fsl,imx21-wdt' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index d96b93b11fad..991b4e33486e 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -14,8 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx21-wdt
+    oneOf:
+      - const: fsl,imx21-wdt
+      - items:
+          - enum:
+              - fsl,imx8mm-wdt
+              - fsl,imx8mn-wdt
+              - fsl,imx8mp-wdt
+              - fsl,imx8mq-wdt
+          - const: fsl,imx21-wdt
 
   reg:
     maxItems: 1
-- 
2.17.1

