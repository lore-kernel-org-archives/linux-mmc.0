Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1360C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 21:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiJSVzZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiJSVzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 17:55:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA2147D2A
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f9-20020a17090a654900b00210928389f8so1465094pjs.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYKDq3nQvcWGiMSg+hxeuum9J23X3dmFHWVwl7YaDYc=;
        b=CfYbZ+nJXXk7KoFnE1sVg2XDbJnWj3hQVyrHcC6PGar9i+6OAIY/BwhB1o8E++95Wq
         lxcU180XOgaqUAVgRDa9NNPFTsOvZ+KK189p0I1A1jg1II+X4whI4JV1qME/yqC+qRqb
         x4ksvICFtNq8gEHVfGwf9KMw/70IcLQL2C1ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYKDq3nQvcWGiMSg+hxeuum9J23X3dmFHWVwl7YaDYc=;
        b=iZ9F6cpjXwh3OVsWKwm3HlnDyD+wVs7ZLC7YaxAITMaKKuW4mX2lee6anNSojFBoGK
         zW8TqaGCqJhBxCulLYtCdHo+Oh9VrHMyDi0rcrYoCvYLiuBF8bCqWii23+TWLkYndpM3
         vDS0IM7SUdbyO9Z+XxweVzdX7udzH6WyVtYW1njyvWvhvWIezb0EPoLAHhPVu1XZAWBW
         o0dG59tqjIc1DZFxHwZ7grUX/Pq6h3tnninbLJXoClxdTgXflNkLoSuZ18cG3JeBcX0q
         NfHCEThbW7KoijM/ygm4hspMK2iZh3H1b1NXvb/CfwSdZYB1OVebIbomie4Ex6Q7phKM
         r7Tw==
X-Gm-Message-State: ACrzQf27lTkLtdIyD2gfc/ug3VIyLtQA8YACqLYoqb8flo0HNbuKlMP3
        ++R1e8aB3FU2DgGd7JTGEK9knQ==
X-Google-Smtp-Source: AMsMyM57I9WXTwCoqZq8IJIrWVZbrfmNmvZU+g7bdf0d/ugyHIFaaJuyFfnLqZW5AS8dO+IXT+trXA==
X-Received: by 2002:a17:902:82ca:b0:185:75d:ee2c with SMTP id u10-20020a17090282ca00b00185075dee2cmr10547061plz.145.1666216512060;
        Wed, 19 Oct 2022 14:55:12 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id w14-20020a17090a5e0e00b0020ad53b5883sm422006pjf.14.2022.10.19.14.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:11 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/7] mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:38 -0700
Message-Id: <20221019145246.v2.5.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

 [[ NOTE: this is completely untested by the author, but included solely
    because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
    SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
    drivers using CQHCI might benefit from a similar change, if they
    also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
    bug on at least MSM, Arasan, and Intel hardware. ]]

SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
tracking that properly in software. When out of sync, we may trigger
various timeouts.

It's not typical to perform resets while CQE is enabled, but this may
occur in some suspend or error recovery scenarios.

Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Drop unnecessary 'enable_hwcq' check

 drivers/mmc/host/sdhci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 413925bce0ca..0a80335a42ec 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -367,6 +367,9 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	if (!(mask & SDHCI_RESET_ALL))
-- 
2.38.0.413.g74048e4d9e-goog

