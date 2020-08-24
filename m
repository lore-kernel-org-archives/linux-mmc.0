Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DFC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA952067C
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286717;
	bh=D0lGql3068l0qoya1++oR3DiMvBwPOUE4frjDG+x5vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9wvozgb/f06zyT7qMiAwSa31GRMOB/Xf2GF7juLY6N/Xbi++Coo8q4RZCNExaOTm
	 baphn8aJ0yQgh4oCcU9elBrCpVy3RtQFtzzk7CLVy6UBtcSjYxWxs8XE4g/hb00+BU
	 WvJcIbv05dFMxGdfgkQ9UuO6j730sZN9Adl4QgZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHXQbp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgHXQ2Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:28:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3037A2074D;
        Mon, 24 Aug 2020 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286495;
        bh=D0lGql3068l0qoya1++oR3DiMvBwPOUE4frjDG+x5vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFNO5DdkEiEzZ/CI+2ciB/9994joymxRDDFV80yw9eyP9da5eItooQLa42+hABTXX
         rvJ1Z4+jH5dpazhjihHiJN+0JgvVCBxCNPMqi8bYa6CXdeoz741ZrpAkZUnrkAzU+W
         7jG1Ex7uw8jDCBFUndsBneeOxMmYKI9I9sOMWInE=
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
Subject: [PATCH v2 09/19] dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
Date:   Mon, 24 Aug 2020 18:26:42 +0200
Message-Id: <20200824162652.21047-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible:0: 'fsl,imx8mm-gpmi-nand' is not one of ['fsl,imx23-gpmi-nand', 'fsl,imx28-gpmi-nand', 'fsl,imx6q-gpmi-nand', 'fsl,imx6sx-gpmi-nand', 'fsl,imx7d-gpmi-nand']
    From schema: Documentation/devicetree/bindings/mtd/gpmi-nand.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: ['fsl,imx8mm-gpmi-nand', 'fsl,imx7d-gpmi-nand'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: Additional items are not allowed ('fsl,imx7d-gpmi-nand' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml     | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 3201372b7f85..28ff8c581837 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -20,12 +20,18 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-gpmi-nand
-      - fsl,imx28-gpmi-nand
-      - fsl,imx6q-gpmi-nand
-      - fsl,imx6sx-gpmi-nand
-      - fsl,imx7d-gpmi-nand
+    oneOf:
+      - enum:
+          - fsl,imx23-gpmi-nand
+          - fsl,imx28-gpmi-nand
+          - fsl,imx6q-gpmi-nand
+          - fsl,imx6sx-gpmi-nand
+          - fsl,imx7d-gpmi-nand
+      - items:
+          - enum:
+              - fsl,imx8mm-gpmi-nand
+              - fsl,imx8mn-gpmi-nand
+          - const: fsl,imx7d-gpmi-nand
 
   reg:
     items:
-- 
2.17.1

