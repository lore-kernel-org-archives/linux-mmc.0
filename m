Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75FC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BA420866
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286460;
	bh=lnBHoUXioLOrOWNKvWtcrwmt13u6QaY0trxOTodHtew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uB8Tm2jRi6varLZR5ZEZYNLAMxUpTm31Nt24HIlj62Xm4TObLelhSuErUUdfV0NLH
	 2Gt4fl6QSKcyA445WXWrf1g9Ck5IEU8NsGGEGP59kw//Hlkd1uGUKb8p+8Ts83svUS
	 1riDpVyO+NO7by5w/SFa0GKDmjA3+p51FBoSH2lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHXQ1S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXQ1R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:27:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E5F2072D;
        Mon, 24 Aug 2020 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286437;
        bh=lnBHoUXioLOrOWNKvWtcrwmt13u6QaY0trxOTodHtew=;
        h=From:To:Cc:Subject:Date:From;
        b=Znz4cKVrnSCgYw35MMVSPppJ5hjlovEHC0R/6Thnt26/cwLk2AL+Vy0L/Q8VJDg2z
         0YaNbOuluJaThIJ/UdVJU13Pvd1GJutNSYP8bKDyNdneetH6PEX0IKFOEeU0GmtueK
         tTgVmwEG0W5wMKi6KelLbGhNcQGJlRHl+mt+/mRA=
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 01/19] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
Date:   Mon, 24 Aug 2020 18:26:34 +0200
Message-Id: <20200824162652.21047-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8 SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible:0: 'fsl,imx8mm-gpio' is not one of ['fsl,imx1-gpio', 'fsl,imx21-gpio', 'fsl,imx31-gpio', 'fsl,imx35-gpio', 'fsl,imx7d-gpio']
    From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible: ['fsl,imx8mm-gpio', 'fsl,imx35-gpio'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
    compatible: Additional items are not allowed ('fsl,imx35-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/gpio/fsl-imx-gpio.yaml           | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index 0b223abe8cfb..454db20c2d1a 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -11,12 +11,21 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx1-gpio
-      - fsl,imx21-gpio
-      - fsl,imx31-gpio
-      - fsl,imx35-gpio
-      - fsl,imx7d-gpio
+    oneOf:
+      - enum:
+          - fsl,imx1-gpio
+          - fsl,imx21-gpio
+          - fsl,imx31-gpio
+          - fsl,imx35-gpio
+          - fsl,imx7d-gpio
+      - items:
+          - enum:
+              - fsl,imx8mm-gpio
+              - fsl,imx8mn-gpio
+              - fsl,imx8mp-gpio
+              - fsl,imx8mq-gpio
+              - fsl,imx8qxp-gpio
+          - const: fsl,imx35-gpio
 
   reg:
     maxItems: 1
-- 
2.17.1

