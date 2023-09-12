Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0ECA0ECE
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 04:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjILE4Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjILEze (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:55:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E132707
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13480255a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494394; x=1695099194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOt8MObi3EwEd8MaojWICeVg9Wc3NR34oiCfGNrign4=;
        b=EEmXfhVLWIBOmRS67+zlhPLXu9K+BH7pdL5wWZoBTHEu256lJQt/22C5vb0xfgLcx7
         BvP49C/8icz0iZzOIcL+f1e1iNlIaHCCt48+K9mHf1nnuac49qieAU8YAzwrIM44+F7K
         Cr0c324763W8HDgogG1AYhIfBclnF/BwmEMKRnKJsfubeuuUpAqX7CAd+cbKlYT0RrlQ
         ajQ/nkQvtY4BMmhWgTyv3+b2CfGW8g/Apkop7/y4ck3hT3c0VIOOjnJUe+QEWvaBYrpX
         BSXjAPs7foYb4V/P1CaVVhuTVoISg2atWnKUaz71FoOxXXBPsN4697+hHG01dUkJTG5c
         WXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494394; x=1695099194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOt8MObi3EwEd8MaojWICeVg9Wc3NR34oiCfGNrign4=;
        b=oanNoGLnUIslr0gep05Ir/YIXUgP4ueSTE/eEPscQDW4MkvMovpv8ur6X3MTqaht43
         8QzW5IT4jtH4Z/bN3MMqCTFfkYmIqvXNkotvI9itwzHY+SDU7WPfwjVmhK6W4jVOsg7N
         gYUX6qSGWeqhk1MDvxV42ZjfBQUlHJspzzCDsYpWfQxWQKf7Yy7JsNA0Jt3U5JR4cl+u
         Nv5wkCpMLuLqnjxCaoEXSeQZCiQvZAncENub9eAIstbcMbqzquDdf7c0EPuAkVaofCMe
         SDoE8BFr4TVPlF0vLUlYDhGgU6YMn9+PPiozv838WK4bf6++dmBQ6DZaHSRWwFUkm55Y
         eE/A==
X-Gm-Message-State: AOJu0Yw2hjQwH9bkhLftBO8xVyIll1JqdFvfjBnfYJcFIgprF6N+Y03h
        zdyexcyBiU/AGhKNxAvg99Hn0A==
X-Google-Smtp-Source: AGHT+IGioaNZKByYaWoJquYAY/wrS8yDc8WG3m1FB5QI2yVls9/T86vMdDqrUMMLswER2NynSKXSJQ==
X-Received: by 2002:a05:6402:f83:b0:52f:a763:aab4 with SMTP id eh3-20020a0564020f8300b0052fa763aab4mr621610edb.5.1694494393949;
        Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 28/37] pinctrl: renesas: rzg2l: make struct rzg2l_pinctrl_data::dedicated_pins constant
Date:   Tue, 12 Sep 2023 07:51:48 +0300
Message-Id: <20230912045157.177966-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

struct rzg2l_pinctrl_data::dedicated_pins is constant thus mark it so.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index d90ff5ea356d..cf2092d9229d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -181,7 +181,7 @@ struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
 	unsigned int n_ports;
-	struct rzg2l_dedicated_configs *dedicated_pins;
+	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 	const struct rzg2l_hwcfg *hwcfg;
@@ -1330,7 +1330,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static struct {
+static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins = {
-- 
2.39.2

