Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4DC433E4
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5C0206F0
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598290617;
	bh=xV9upgJFUdWJViQpTgljw0h9O9Oy/nU6sRG9fJrRqIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6vJI9N9o3W+pMDP6q+B6jZ9ixWv9QTHHHk5K+V4teEB+UmP465X7r9xxAmcf/57+
	 HqmNBZ9WuAF2wZskBRLInMD+dt229Q8f7si0tD99tHmO7mcaGYBiDUlqevQUflgq7g
	 S+xkXHJ9YYd2/pp1s6bNyQDioNqhHX7mueNkkXUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHXRd1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgHXQ1p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:27:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EEC207CD;
        Mon, 24 Aug 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286454;
        bh=xV9upgJFUdWJViQpTgljw0h9O9Oy/nU6sRG9fJrRqIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rbb5Xsxg/cfMuBlbOhmadtnzMEI+gV19eqcQz5I6FbgH9EE9d9S8KhzNKQoMQL/KP
         UnqVKL7CBXxTmSlJC5S4xiX7r8RilT3hhfyDXF6IB/0wiSM/RJhVZB0jeyLvmP4DFa
         8I3AJahzpeTvWZTFk/XhSw6z8DAu5DHFfokfQOiM=
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
Subject: [PATCH v2 03/19] dt-bindings: gpio: fsl-imx-gpio: Add parsing of hogs
Date:   Mon, 24 Aug 2020 18:26:36 +0200
Message-Id: <20200824162652.21047-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Allow parsing GPIO controller children nodes with GPIO hogs to fix
warning:

  arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpio@30240000: 'wl-reg-on' does not match any of the regexes: 'pinctrl-[0-9]+'
    From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index dffd9171ea66..620a52f944e8 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -53,6 +53,23 @@ properties:
 
   gpio-ranges: true
 
+patternProperties:
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
+    type: object
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.17.1

