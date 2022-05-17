Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D7DC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 18:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351449AbiEQSWD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiEQSVz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 14:21:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477619F8B;
        Tue, 17 May 2022 11:21:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ev18so7512459pjb.4;
        Tue, 17 May 2022 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfNE+jsBlh9BNefkHevdeU8gbP6/3y3vCQYKDZXj4Ys=;
        b=ismjAffrM0Q6B2lFKAcU5kHfnWHsoQtY0jH6z+mcWDjAQBM04jte2fmNn38AGxc6mw
         nOPlhtlueQajG9TQyq6Fo3GI3WMxmGFqrhBCT6lLCNylv4Xje9f3lfeRvpNHALNsdfzH
         ttYt/pqcrw4UNRpn51SDjvkrvCBiUyveVKMz6i3+8F5IR3GoZGAsJUOyQ/p/nAM4NrMf
         Klb/MQzk2rQhhXDHmpcxt2GKmOXurgyefNnF++bcoaPvFpv3DKTGUS6GIqUeUrFnuNK5
         EcZHas7W/q53C8KngQkdnqeG+z0WYwdvkQnwFpcGJGxnLg0+LEb0ALTda+zw/fhdxpbr
         9Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gfNE+jsBlh9BNefkHevdeU8gbP6/3y3vCQYKDZXj4Ys=;
        b=1OYJU7XpOFRDTF5DnTlWWjS/qq01F8zg9yd1CNYRUhJ9Nj4DYO6M+uPuFWgeVorzF+
         3qK0bq//0NHagHcEUQwE6H63mFGLLYlQiJsIFyVF+HJKDnCDdSIYbhI/9tnmeqeae1Fe
         u6XmPaKxhLv/Qa4JyBg0JJOObWPjwQ9phvr9oFZPWtp7w5xxl8zQCcGLUPZyCHk6kZXi
         vtske6Wsl/bF7NTheat5JqaiGjqmffKHb5Nf7r1deVSaPmvMEzFXVqxVIzeR5VnKqxW0
         sJ6caCbT+/qi+bXiUfMmacUeTH6QMCcJJFFR5JsgC2E5IYamQqwpn8Xzz/ezW6dICmkD
         r9qQ==
X-Gm-Message-State: AOAM532ogYuuN6AxjTFFEdiZhzF/H5fx85DwfcxoaXDgniRv4HX3WqOC
        Z/zg8zAxPyG3YD9Xm/ntIRo=
X-Google-Smtp-Source: ABdhPJwjAHkl3HBNbIqOh9aVEZVP0xLlvh1xSgh6JYuLlEEj7Kfs8DybX8TEuqKINe7y+BHall6l/Q==
X-Received: by 2002:a17:903:240a:b0:14e:dad4:5ce4 with SMTP id e10-20020a170903240a00b0014edad45ce4mr24157104plo.125.1652811699765;
        Tue, 17 May 2022 11:21:39 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id 125-20020a630383000000b003f5e0c264bcsm837641pgd.66.2022.05.17.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:21:39 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date:   Tue, 17 May 2022 14:04:35 -0400
Message-Id: <20220517180435.29940-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517180435.29940-1-kdasu.kdev@gmail.com>
References: <20220517180435.29940-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz. The
driver will need to get the clock and increase it's default rate
and override the caps register, that still indicates a max of 100MHz.
The new clock will be named "sdio_freq" in the DT node's "clock-names"
list. The driver will use a DT property, "max-frequency", to
enable this functionality and will get the actual rate in MHz
from the property to allow various speeds to be requested.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 8eb57de48e0c..bb614a5e1ea4 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -250,6 +250,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	struct clk *master_clk;
+	u32 actual_clock_mhz;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
@@ -330,6 +332,32 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (!(host->mmc->f_max))
+		goto add_host;
+
+	master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
+	if (IS_ERR(master_clk)) {
+		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+		goto add_host;
+	} else {
+		res = clk_prepare_enable(master_clk);
+		if (res)
+			goto err;
+	}
+
+	/* set improved clock rate */
+	clk_set_rate(master_clk, host->mmc->f_max);
+	actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
+
+	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
+	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
+	/* Disable presets because they are now incorrect */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
+		actual_clock_mhz);
+
+add_host:
 	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
-- 
2.17.1

