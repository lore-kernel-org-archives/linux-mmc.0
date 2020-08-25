Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F033FC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C7A2083B
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598384222;
	bh=g3o7tt+MugsYL++tcyWf98GZHjVPsCkdOLiyqZCrTPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfyAB5jFHX/Kz453RxOnpf3DavWixKfukBdz4Or2rIZfOKhA5rbyGAWR7i+2BTujz
	 BlekUnPA93TkN4C5EW9vBQTruCfnpWz13ll/6aLRD7vOfpdmx8yVsWjNQeHazuV69A
	 XN4ANdn1UbZjUU3RUn38wksiqqZ0vLCpeUv7ECoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHYThB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYThB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 15:37:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C2052075E;
        Tue, 25 Aug 2020 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384220;
        bh=g3o7tt+MugsYL++tcyWf98GZHjVPsCkdOLiyqZCrTPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kORXmtVj56/yh+M6P8dAGqV5fA7gajUwn+2p2xSP5U6n/sdI3lXOhbqAipAeqkQ9X
         ZP2jNDj9R+dN76qNqdiWD0PCUhUzW8e8I06SDdZ+FTzXep2RrotPrUHPiIsR72/Wkc
         zQ9UC+ARBwsFd/bFEXsTR/VdqKFHyAHc2T63W3u4=
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
Subject: [PATCH v3 07/19] dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
Date:   Tue, 25 Aug 2020 21:35:24 +0200
Message-Id: <20200825193536.7332-8-krzk@kernel.org>
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

Changes since v1:
1. Fix subject prefix
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index cba3f83ccd5f..3d896173b3b0 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -36,6 +36,10 @@ properties:
             - fsl,imx6sx-uart
             - fsl,imx6ul-uart
             - fsl,imx7d-uart
+            - fsl,imx8mm-uart
+            - fsl,imx8mn-uart
+            - fsl,imx8mp-uart
+            - fsl,imx8mq-uart
           - const: fsl,imx6q-uart
 
   reg:
-- 
2.17.1

