Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5CC2BD09
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C3220706
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9+uU+AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFRIl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:08:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLFRIl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 12:08:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so8414782ljh.5
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2019 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bena7hxM6Q5CJen1XKF9/qXFjbtAx0rdagpDLN6ovkc=;
        b=X9+uU+AYohCgYCEkPNcJ5fhTjP243QbHdbgFzdpvm7JZMjhzz7TPWGnPWgcRm69nGz
         jsvzcimEHNE5dwSluVSH6tk2OnrsVGfoHOaIlFpN3nlEGAXx3qTfRKj7q7knpSMLJ0pJ
         qky1f5fry4paJxZLbulff8VP3rb/8yDaceyR9hRoc5+10MW0CW+ezcawH2lomDLs94GD
         rSBR3tfVGbgCRFvFlC0osU4As2yBRTqMsHz49weRtD7FanceXxm3VI2QLzr5iPOYZf/G
         twvactJN9GSLPbml17ZFHwSMwybk0VDyJYaEpjlY3iJa6sVXuNBePPSKzMsvgp/j+hkZ
         kcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bena7hxM6Q5CJen1XKF9/qXFjbtAx0rdagpDLN6ovkc=;
        b=kemNxdpu5varPlMfZECsz/BsU+0FsVeFExb/a7LNYfDqZzSm7/c/ub4pFlxWlOHncE
         4YU/RWmGfq6xHXQWyq44ndWMWPmHZCPZ0iYx4qtL7GJVzaIP6XN9WJY5UJxs5xOrlIsV
         dbWPPIsEQqDKUgkGRdCSe55nGVfqG0RVPGqkoMbDqO3EWLHqMCefz/naTZBaBXMgIkp9
         Rq9iKboCQdTgzakki9bOSIlUCRm5p1QObY4jdu7kybnLfBinUsmnVC9Nm9/aZdduEDmt
         HDlLn4z19evuJpzRUQSSdNsE7lDxzgYU/hTqhJgo9riYroiHyoqRsXxA5+xHXfE4mMJ4
         /apA==
X-Gm-Message-State: APjAAAWHW0B686+OXyfroCO7LvwZ9XwgOZ+v8eIuCNsO46a8LuN3VmJF
        5X1hZ//orIk6R44gSbiBXuC0fg==
X-Google-Smtp-Source: APXvYqyzRis2mN3JfJuOhE7couVt+BvfwzvIsTBrVXasuhhX9uFysTzSF44YDY3ZqVA+ggR5Nir32Q==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr7778784ljj.147.1575652118999;
        Fri, 06 Dec 2019 09:08:38 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z9sm6905283ljm.40.2019.12.06.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:08:38 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 9/9] mmc: uniphier-sd: Convert to pinctrl_select_default_state()
Date:   Fri,  6 Dec 2019 18:08:21 +0100
Message-Id: <20191206170821.29711-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206170821.29711-1-ulf.hansson@linaro.org>
References: <20191206170821.29711-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Let's drop the boilerplate code for managing the default pinctrl state and
convert into using the new pinctrl_select_default_state().

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/uniphier-sd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 0c72ec5546c3..a1683c49cb90 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -59,7 +59,6 @@
 struct uniphier_sd_priv {
 	struct tmio_mmc_data tmio_data;
 	struct pinctrl *pinctrl;
-	struct pinctrl_state *pinstate_default;
 	struct pinctrl_state *pinstate_uhs;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -500,13 +499,12 @@ static int uniphier_sd_start_signal_voltage_switch(struct mmc_host *mmc,
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
-	struct pinctrl_state *pinstate;
+	struct pinctrl_state *pinstate = NULL;
 	u32 val, tmp;
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
 		val = UNIPHIER_SD_VOLT_330;
-		pinstate = priv->pinstate_default;
 		break;
 	case MMC_SIGNAL_VOLTAGE_180:
 		val = UNIPHIER_SD_VOLT_180;
@@ -521,7 +519,10 @@ static int uniphier_sd_start_signal_voltage_switch(struct mmc_host *mmc,
 	tmp |= FIELD_PREP(UNIPHIER_SD_VOLT_MASK, val);
 	writel(tmp, host->ctl + UNIPHIER_SD_VOLT);
 
-	pinctrl_select_state(priv->pinctrl, pinstate);
+	if (pinstate)
+		pinctrl_select_state(priv->pinctrl, pinstate);
+	else
+		pinctrl_select_default_state(mmc_dev(mmc));
 
 	return 0;
 }
@@ -533,11 +534,6 @@ static int uniphier_sd_uhs_init(struct tmio_mmc_host *host,
 	if (IS_ERR(priv->pinctrl))
 		return PTR_ERR(priv->pinctrl);
 
-	priv->pinstate_default = pinctrl_lookup_state(priv->pinctrl,
-						      PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(priv->pinstate_default))
-		return PTR_ERR(priv->pinstate_default);
-
 	priv->pinstate_uhs = pinctrl_lookup_state(priv->pinctrl, "uhs");
 	if (IS_ERR(priv->pinstate_uhs))
 		return PTR_ERR(priv->pinstate_uhs);
-- 
2.17.1

