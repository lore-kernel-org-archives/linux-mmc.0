Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8220EC433E5
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3522072D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286606;
	bh=Nf0OvcvrRDy7hmzkr0pvBomF5COodtTwW57kov6fTeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlLIilEoo1qpIJcLKJrWoAq6U6HPRgl2M3uA2pp4Ossr1Rqak6Aurb9ny/vREYpqV
	 HKvDPScoXllVag8RFqLEXnGCCB4s8GWnjkm1PFSnMgGHFcIbMAVV97ImrcOsJDD1ts
	 YbxB52t0HJl+9A6AmJ6ZEtFlx7W1DeRNpAbMypE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgHXQ3N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXQ3J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:29:09 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BFCD207CD;
        Mon, 24 Aug 2020 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286548;
        bh=Nf0OvcvrRDy7hmzkr0pvBomF5COodtTwW57kov6fTeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjBsPtlwd3lyNplTLQWLqE4mmSOTqYpF39QWDc+pZpaEXACNoZ/W2J8VAc4iWbisp
         QCbcIZSs9nMfanlynSx2HiZwFlSIj09dreAppvZpuvr7LF8cIw11q0G9Puf36CWdmI
         8GZnbXcwv1ODKcYtr+lolOZYNLL67tDltw6nkAWs=
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
Subject: [PATCH v2 17/19] dt-bindings: serial: fsl-lpuart: Fix compatible matching
Date:   Mon, 24 Aug 2020 18:26:50 +0200
Message-Id: <20200824162652.21047-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The i.MX 8QXP DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
    From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
    compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch.
---
 .../devicetree/bindings/serial/fsl-lpuart.yaml | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index e82c2cf9fef7..8ee651f2ef0b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -14,13 +14,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-lpuart
-      - fsl,ls1021a-lpuart
-      - fsl,ls1028a-lpuart
-      - fsl,imx7ulp-lpuart
-      - fsl,imx8qxp-lpuart
-      - fsl,imx8qm-lpuart
+    oneOf:
+      - enum:
+          - fsl,vf610-lpuart
+          - fsl,ls1021a-lpuart
+          - fsl,ls1028a-lpuart
+          - fsl,imx7ulp-lpuart
+          - fsl,imx8qxp-lpuart
+          - fsl,imx8qm-lpuart
+      - items:
+          - const: fsl,imx8qxp-lpuart
+          - const: fsl,imx7ulp-lpuart
 
   reg:
     maxItems: 1
-- 
2.17.1

