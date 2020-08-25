Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0CEC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E32075F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598384289;
	bh=1VUD/MGPO0EoM+Nm4VoPQz9kp6MovSZ6Aft2L3Sknoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6fE6iU28QgzhurjtdXXf043P8pmug5/2xnTLp2Z74CxXb82dfAF73UtkDWRgt1IQ
	 4xBQtnbGU5b6t1WzYLi9h60sJfXZMxamFnjtqXlN+z9zORhZPZZ9rPYkoxbs2fUefv
	 BdEx+hQrqHS763o0PLmw/6ovHrrIqOWLkSbnsqCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHYTiF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTiE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 15:38:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4452075F;
        Tue, 25 Aug 2020 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384284;
        bh=1VUD/MGPO0EoM+Nm4VoPQz9kp6MovSZ6Aft2L3Sknoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMEckcrNLH9r4ordRZV8YCVpcA5MOwo56whP7MDYWvOZycDDcYk17RIN3HQEwn8LS
         /ZYK2MwBDXH1E0JSH+RK4EcrtmC4oT+ahu9bj6jBOPSoqt76miuBMv5WzaNxMbixGg
         0lpqZz9i7aqzjldGtWQeQGxtNBzjbrCNaBWqN2d8=
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
Subject: [PATCH v3 15/19] dt-bindings: arm: fsl: Add ZII Ultra boards binding
Date:   Tue, 25 Aug 2020 21:35:32 +0200
Message-Id: <20200825193536.7332-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the binding for Zodiac Inflight Innovations Ultra Boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 377fc2a4c159..b48dbf924cfe 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -373,6 +373,14 @@ properties:
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
 
+      - description: Zodiac Inflight Innovations Ultra Boards
+        items:
+          - enum:
+              - zii,imx8mq-ultra-rmb3
+              - zii,imx8mq-ultra-zest
+          - const: zii,imx8mq-ultra
+          - const: fsl,imx8mq
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
-- 
2.17.1

