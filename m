Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4299C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AA72177B
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286700;
	bh=VqDD3KFuiRD86Z7+w0i17rgKkKCPFxI1DEBp8fL8MEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXCq8LMe7VYH9z7ioCfBXZP+68uBpn/thdPALPUjwh5stRRFZ6litV02GCTLlnbVl
	 YWu7y/TE6ypo4wHVfrsyXgA8eM2Jh2x7Ju/2Hpf4M9WUiogjptvB9siGt3qfOKjjEN
	 6E0rZo9bbd24zLZrU8fJjFhC/t1sC3flw6CWuJQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHXQar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgHXQ2n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:28:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D143F2072D;
        Mon, 24 Aug 2020 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286522;
        bh=VqDD3KFuiRD86Z7+w0i17rgKkKCPFxI1DEBp8fL8MEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmBhqPsTaqTMpuCWp3N5a8nZCNSG1bp3MFzm8cE3550C8EWaKLl6jaeLKN7wcT+ZI
         wwcY6+Sq7GY0eSzM1utr8okE4/6QxbQOnXozS58RESNT6KV0pwwU0YtrF4NTDYeYAP
         HjvQJJ6Aww5qZxclKiV/B3vKIeAHyQcI/mrNFpTc=
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
Subject: [PATCH v2 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
Date:   Mon, 24 Aug 2020 18:26:46 +0200
Message-Id: <20200824162652.21047-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
    From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: Additional items are not allowed ('syscon' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 1c9d7f05f173..b5b250185afd 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -19,21 +19,30 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,imx6q-ocotp
-          - fsl,imx6sl-ocotp
-          - fsl,imx6sx-ocotp
-          - fsl,imx6ul-ocotp
-          - fsl,imx6ull-ocotp
-          - fsl,imx7d-ocotp
-          - fsl,imx6sll-ocotp
-          - fsl,imx7ulp-ocotp
-          - fsl,imx8mq-ocotp
-          - fsl,imx8mm-ocotp
-          - fsl,imx8mn-ocotp
-          - fsl,imx8mp-ocotp
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6q-ocotp
+              - fsl,imx6sl-ocotp
+              - fsl,imx6sx-ocotp
+              - fsl,imx6ul-ocotp
+              - fsl,imx6ull-ocotp
+              - fsl,imx7d-ocotp
+              - fsl,imx6sll-ocotp
+              - fsl,imx7ulp-ocotp
+              - fsl,imx8mq-ocotp
+              - fsl,imx8mm-ocotp
+              - fsl,imx8mn-ocotp
+              - fsl,imx8mp-ocotp
+          - const: syscon
+      - items:
+          # The devices are not really compatible with fsl,imx8mm-ocotp, however
+          # the code for getting SoC revision depends on fsl,imx8mm-ocotp compatible.
+          - enum:
+              - fsl,imx8mn-ocotp
+              - fsl,imx8mp-ocotp
+          - const: fsl,imx8mm-ocotp
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.17.1

