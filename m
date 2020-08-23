Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765EC433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA202075B
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199607;
	bh=qT97af3F+6zT5YN98/ik4UyHTeDAWVRhgipmgnsunZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpk8NennAnFPGrsBC9qxfMj7ZpMGWm3T+PWdDfSFSQDl61dFUrlhgVeVTUBazUgAj
	 v7X5P9EDnageMD1PP+MNLyPMGNcKT1Vs5k+Bbel/7le1l6z/3KOFPW/nTs5jnrZPbt
	 dyqqyWk3HzEq9va9cJGksn1QLjN10J7AdLdPmHC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHWQQ0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgHWQQQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:16:16 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E282072D;
        Sun, 23 Aug 2020 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199375;
        bh=qT97af3F+6zT5YN98/ik4UyHTeDAWVRhgipmgnsunZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYTIJdnKD8ggSMwFP0uCdP7QfLgD+Q74psSfXOgJNF5q1PJXOQdH2j3H/mktYKKxk
         DnYLOalxi3KdGoGad4midcoNESDhAXpSuIJlQ+fPr/zEZ7AILWav3BrpWW3cBW04+m
         3PvCTduJ7FmVeJHkBVTHB+S1jPBqkoz9/l8chR/o=
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
Subject: [PATCH 04/22] dt-bindings: gpio: fsl-imx-gpio: Add power-domains
Date:   Sun, 23 Aug 2020 18:15:32 +0200
Message-Id: <20200823161550.3981-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Parse also optional power-domains property to fix dtbs_check warnings
like:

  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: gpio@5d080000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
    From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index 337b99343dce..a7d17a98df6b 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -54,6 +54,9 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 patternProperties:
   "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
     type: object
-- 
2.17.1

