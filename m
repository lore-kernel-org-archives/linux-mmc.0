Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93AC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56287207CD
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286581;
	bh=CnRSnps+AJEG/CNxkZZ3JT+RUcAXLf0eIGA4Cov4d+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vA1GRRlGqfFnm9uUdzg0aDxBOQsUrsD5WJOse0M/VcTn0F5XjnS34HDfMa5rZZR82
	 ErllYZ238iwnS9MCKA5GgYL3rWDv840A0yfoQn3RQTUf8eQ6p1o7laMKQn5QP8o52u
	 YJjSm+1gyiYnKsf3duQMlil6F2oapP0vuYboVwh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHXQ3b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgHXQ3X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 12:29:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968582072D;
        Mon, 24 Aug 2020 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286562;
        bh=CnRSnps+AJEG/CNxkZZ3JT+RUcAXLf0eIGA4Cov4d+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nh6hgK7lOgmW9izb+LuDJ5SUOJo34fH/EcIpkU/0ZYG4pF1uo1o36J78/CuG+K+t4
         qgGmOJjzuiea5OHtVIhlowJCGQvlmsszKFpGttk8lcVH3x6B0kuBekleSS7+IS2r1g
         7LwXM1sLXEhWcF0hUbBodcOCqYk9umOvq2I1qbyQ=
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
Subject: [PATCH v2 19/19] arm64: dts: imx8mq-zii-ultra: Add hog suffixes to GPIO hogs
Date:   Mon, 24 Aug 2020 18:26:52 +0200
Message-Id: <20200824162652.21047-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to device tree specification, device node names should be
somewhat generic and reflecting the function of the device so add the
"hog" suffixes to all GPIO hog nodes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 0d1088dcaa02..fa7a041ffcfd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -229,28 +229,28 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	usb-emulation {
+	usb-emulation-hog {
 		gpio-hog;
 		gpios = <10 GPIO_ACTIVE_HIGH>;
 		output-low;
 		line-name = "usb-emulation";
 	};
 
-	usb-mode1 {
+	usb-mode1-hog {
 		gpio-hog;
 		gpios = <11 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "usb-mode1";
 	};
 
-	usb-pwr {
+	usb-pwr-hog {
 		gpio-hog;
 		gpios = <12 GPIO_ACTIVE_LOW>;
 		output-high;
 		line-name = "usb-pwr-ctrl-en-n";
 	};
 
-	usb-mode2 {
+	usb-mode2-hog {
 		gpio-hog;
 		gpios = <13 GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.17.1

