Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25092C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 03:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJRD5v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJRD5r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 23:57:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493687FB5
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12815060pjl.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bYbVaurNHZoKZuiVprhZUwyKptjwry92NaACiNGGbI=;
        b=biCG5g3PRhSpx+svQLWgmgvOwtH++XWGKTkyE9UWOj6vpD7L1xDgNgA2bS7D6s5lzt
         6VCdakl25O4uQtiTkhYdpW2bJKszFrfsV48BRcAimQ2GDDRoq2nZg6E61fEGNtTw7cer
         IxKQK4PEAs9gKnrrzgPwkjW4YE6M2eNLHRR+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bYbVaurNHZoKZuiVprhZUwyKptjwry92NaACiNGGbI=;
        b=Y6CivxmsP7QzJBU+FJvyY8jMphOwb7YSYgHFxRmSoIhSEAoESehHhJeTvcyTvXlHrJ
         70sGTjaXT4+fM/1KP6Slu4LZnSEsPWam/y5WzdhUOJOozL8VA0um/l8UBaNYXw5Q27DM
         DdEc2/Ng9Y2PxeKQjiJ+xL5Jp+PI3rxAYwhVNB0v+4yeXX59KW/6iZvjjiLkwVPOSivT
         83feR2WIk8w0b1QpnAqoIcG9Dbqh7C23rWnStGQvsBJLwdeXCEBFpkOjlrVpraXzHC+H
         MHiA1Z6fOPeF/ZFPw53Yh/1fquIJDqfQGcBs0Tcx4dlWxnbMKR+sgkQd8oGFTXhQ40Mn
         O+FQ==
X-Gm-Message-State: ACrzQf0/DoiJ50UPbXLLV3sFEN68iIz4bWfk6J9Z4yvEmZE4uTKCbCJt
        FNZHe3o1pHInzkuNXo0PPSUA6A==
X-Google-Smtp-Source: AMsMyM4uYSizE6bAIrsyINpuEBbUqcSLImXqDRTQmFW3Z8JeyX3c+3AaBMWv5jKZI6sxwoXEXsVJdg==
X-Received: by 2002:a17:90b:3892:b0:20d:4bb5:91fe with SMTP id mu18-20020a17090b389200b0020d4bb591femr1296941pjb.31.1666065464699;
        Mon, 17 Oct 2022 20:57:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id k6-20020aa79986000000b0056186e8b29esm8229358pfh.96.2022.10.17.20.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:44 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/5] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:22 -0700
Message-Id: <20221017205610.3.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018035724.2061127-1-briannorris@chromium.org>
References: <20221018035724.2061127-1-briannorris@chromium.org>
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

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..222c83929e20 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1288,6 +1288,13 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    imx_data->socdata->flags & ESDHC_FLAG_CQHCI)
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.38.0.413.g74048e4d9e-goog

