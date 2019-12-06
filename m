Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059CC2BBE2
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3608F21835
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzqIxUO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFRIh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:08:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37076 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFRIh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 12:08:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so8433661lja.4
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2019 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTEyh8XCr6qWiWO+Sm26auA9jej3JxBZE/rL5aBzRVY=;
        b=dzqIxUO7WxQk+plB0N+sxpgJHd9B7Gqjohrdy/hCB+cGg3rfhemNz+2LL8EssKd0MV
         upCGcYGQYMVNMExbGvN7Qreozlys4r8Q/t+j3QoLCQiSB1xykzvEJ9SOmOISwrA1jlvp
         4YqHPRHa85RcGLnuhvUzfCGVkvNFoPHGWUjCMMR7Bjm70zmoMVHvm9rSqeqBhF5pJYET
         uu3CXmcUMAhftU9pWR0U+AkR1SxsikEKY2Lc1bWHLNgIODEP1QqxizVF1LdyzMUtxcHJ
         gV5lyhhxeEnapF91t37e5JauaL/D9OqEQjGP+GtxsJTJJaE5TXiESw07H2QqV8NtezBg
         RuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTEyh8XCr6qWiWO+Sm26auA9jej3JxBZE/rL5aBzRVY=;
        b=IvDy/yr3Sk49/OjVtqTvirOAyhP9yGFUJcTdslkXNCQpKNKkppmCPLfVcnL/6JU/Wj
         dxUtukz1c8k6QdHXxG7QmJ7cQZv+rBbkq+0H/LzxS/ABU9uEp4goZSo2mKFAAziAo2eo
         kPrO9p0r7oRUVDx8rsQ4EXDSZekOtlASxnhVq5VyMhE7MSXLTKZAlQnnf6D0FMj84yF0
         mpQgUpEJ3FndCCX+tCfli/eIqJfn6N3hSOkaWwNfhnrBw1iDs0KmeSGwQDuihJwfQdLe
         sf7ne7q8dWPjC5CmExWMkFveno5LaNj29xJ7OVu5bC48otjgMCIY3EA20Yyyw362xCmA
         Oylg==
X-Gm-Message-State: APjAAAWBjLX7hNyA+0kfbrh3f//x1Y8kf3FfbIB35IVHbKFcz4Gy+/PZ
        8zYeBOtzO05Bpsk8u7t6A6Mi6g==
X-Google-Smtp-Source: APXvYqx2YUEFT3CYqRkqrCF50CxYbiVYSIL4MAtnnjeQmuc33zVtu9572g9p4vEVQvm8MMy9E6jTOQ==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr9527832ljo.86.1575652115109;
        Fri, 06 Dec 2019 09:08:35 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z9sm6905283ljm.40.2019.12.06.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:08:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 6/9] mmc: sdhci-esdhc-imx: Convert to pinctrl_select_default_state()
Date:   Fri,  6 Dec 2019 18:08:18 +0100
Message-Id: <20191206170821.29711-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206170821.29711-1-ulf.hansson@linaro.org>
References: <20191206170821.29711-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Let's drop the boilerplate code for managing the default pinctrl state and
convert into using the new pinctrl_select_default_state().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1c988d6a2433..43628c9c05ac 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -224,7 +224,6 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
-	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_100mhz;
 	struct pinctrl_state *pins_200mhz;
 	const struct esdhc_soc_data *socdata;
@@ -951,7 +950,6 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
 
 	if (IS_ERR(imx_data->pinctrl) ||
-		IS_ERR(imx_data->pins_default) ||
 		IS_ERR(imx_data->pins_100mhz) ||
 		IS_ERR(imx_data->pins_200mhz))
 		return -EINVAL;
@@ -968,7 +966,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 		break;
 	default:
 		/* back to default state for other legacy timing */
-		pinctrl = imx_data->pins_default;
+		return pinctrl_select_default_state(mmc_dev(host->mmc));
 	}
 
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
@@ -1338,7 +1336,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
-	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default)) {
+	if (esdhc_is_usdhc(imx_data)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
@@ -1492,11 +1490,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto disable_ahb_clk;
 	}
 
-	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
-						PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(imx_data->pins_default))
-		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
-
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
-- 
2.17.1

