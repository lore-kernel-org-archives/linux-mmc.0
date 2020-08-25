Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B476C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0A2075F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598384299;
	bh=sGtFPuXEsVbIrliCojcp2Mbe+DlIhAJbh8Iyk2PAwVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vxu7fgTYEpBiGQ5NMqP3twHvv7HnAR/LvKm5QUgkRSVU9DNQQi8h+3o7sZTELlwES
	 dRsA2iWqR6MWGbunobVmAlkKqguRm4ybB2gQSAUkN+GwShEOdyAbY1fCPxICbCcBYc
	 lnlUJlKR+qQ4DItiqz4oUs64P6Yy6pwkcDxIlCbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHYTiN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTiL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 15:38:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852572076C;
        Tue, 25 Aug 2020 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384291;
        bh=sGtFPuXEsVbIrliCojcp2Mbe+DlIhAJbh8Iyk2PAwVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5T+9iBATjKkXGJCeBqNAkAw3SBt/m46XL/ziWg/zYkWvcZDhbpTMqDfrsbhCcbkA
         e5lvmECPc2cMpr7pnyu7aBccWffRpz2kxB1/7qcAe/gKtkV0LBLCO7wjOlrFaYgdof
         rDtf6Pk40serFot87UKcrp3zoaEx5TSm/23LJCT4=
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
Subject: [PATCH v3 16/19] dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible matching
Date:   Tue, 25 Aug 2020 21:35:33 +0200
Message-Id: <20200825193536.7332-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The i.MX 8M DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
    compatible: ['fsl,imx8m-irqsteer', 'fsl,imx-irqsteer'] is too long
    From schema: Domentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

  arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
    compatible: Additional items are not allowed ('fsl,imx-irqsteer' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/fsl,irqsteer.yaml       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 360a575ef8b0..3b11a1a15398 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -11,9 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8m-irqsteer
-      - fsl,imx-irqsteer
+    oneOf:
+      - const: fsl,imx-irqsteer
+      - items:
+          - const: fsl,imx8m-irqsteer
+          - const: fsl,imx-irqsteer
 
   reg:
     maxItems: 1
-- 
2.17.1

