Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC987C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B2320825
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598384215;
	bh=hL/fcCPcN2C/m5il4PArkR2+637T0WAxztArDirM7/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fj7V7hbx6cqUCbXD3YfYaFc8VqBE/1zYrrGUM9POH+P5aXQ74q/4i8Bq6dDqaY4TW
	 H550qKo2H6e52zPtl9xtgVeIWU7hfhjiZdPuSpp0/8XRRQYLlE9qXktgsQCLvWmp5H
	 /sLADDEgZYkoS5VUWICIWg+QmmsHmJUbzDn/4jF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHYTgw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYTgv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 15:36:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9977B20782;
        Tue, 25 Aug 2020 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384210;
        bh=hL/fcCPcN2C/m5il4PArkR2+637T0WAxztArDirM7/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHPnAXBiZPoBs6b+udD/Uugeim4hNbPPkyepzNn7M3IOrHPCfbZ9wFfUhzL2ySqgS
         6+fEqJc3UFsNMh2av2oYIbMQ/w1UgK3w6kC+suCq+ANdhhDDXYhUAE39spbaC5a80S
         a/WVxOD8L8BiIP7z7zg7bM7ATnvtIKLKzDYX/WlU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
Date:   Tue, 25 Aug 2020 21:35:23 +0200
Message-Id: <20200825193536.7332-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,imx27-pwm']
    From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: Additional items are not allowed ('fsl,imx27-pwm' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 01df06777cba..473863eb67e5 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -19,9 +19,17 @@ properties:
       - 3
 
   compatible:
-    enum:
-      - fsl,imx1-pwm
-      - fsl,imx27-pwm
+    oneOf:
+      - enum:
+          - fsl,imx1-pwm
+          - fsl,imx27-pwm
+      - items:
+          - enum:
+              - fsl,imx8mm-pwm
+              - fsl,imx8mn-pwm
+              - fsl,imx8mp-pwm
+              - fsl,imx8mq-pwm
+          - const: fsl,imx27-pwm
 
   reg:
     maxItems: 1
-- 
2.17.1

