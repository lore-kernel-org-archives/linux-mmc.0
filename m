Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC3C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217672072D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286610;
	bh=IcWdUIpZPLrTFhfMFn5K5VkjUKVluLTxZ3P2v5TWsEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nysYlA8dTRGhm1UOPKs0DaieawdsfjZqFk9tXkMN9OCDHWIPsLWTITUF/EMi80KrI
	 cmeoE3+2b0f2cVbpUcHuwACixwkOI2eD+8AzN0DDMA77oFNnKEtWgCWOYPQXdSHkpi
	 SoGxdGjjVg61URHSFERzdZN2TBP2V9FjGr5MDSRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHXQaG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgHXQ3Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:29:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215E920866;
        Mon, 24 Aug 2020 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286556;
        bh=IcWdUIpZPLrTFhfMFn5K5VkjUKVluLTxZ3P2v5TWsEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyGTA3pl2iZ6iwRTHRYvbqGpkvnk43nFCR8d3W1X2RJu/hO3ZgALLiUgPt8e58Ibx
         kfvaz4xYS3ZNqva0peuSxSgYny+/X7lvFzweEhN8BcH8LaKhgC47hEq4bwVGeK3yLC
         5BKfBbu4I0HwGbZ+9otThfJkwOjs9tiFPmxyxcvE=
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
Subject: [PATCH v2 18/19] arm64: dts: imx8mq-evk: Add hog suffix to wl-reg-on
Date:   Mon, 24 Aug 2020 18:26:51 +0200
Message-Id: <20200824162652.21047-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to device tree specification, device node names should be
somewhat generic and reflecting the function of the device so add the
"hog" suffix to wl-reg-on GPIO hog.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 8aa9cd8e495a..a088831d2e24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -157,7 +157,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wifi_reset>;
 
-	wl-reg-on {
+	wl-reg-on-hog {
 		gpio-hog;
 		gpios = <29 GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.17.1

