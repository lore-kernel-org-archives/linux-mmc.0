Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB52C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 03:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJRD5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJRD5n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 23:57:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B188D87095
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q9so12223372pgq.8
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij4KWz/xfjwjagiNwbsSS9W+22RRneq0xL/Tg7OEAHQ=;
        b=IMZnm0AtLYkB5SOiYzwzKdVoh765CWB45APSqYyjXFUWB0VArkwtlA4V2j6wR8MSaC
         FIJ1wTsDtiZ2ZfLdjdfv9K7mFoBFeDwQ9LxETzRM2vgBqtc1oOif8WxtzeiyfT7lSIRL
         vujMRT8CAcW5c3MDzJubCEejTmZKjl719zp9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij4KWz/xfjwjagiNwbsSS9W+22RRneq0xL/Tg7OEAHQ=;
        b=7eEf5tUEgH71KLCkWSjwoFYAinJ2u1pX2tTWeMnV2rm3le7Y7JmEx+Ja4Sause3zLe
         EXbN5C3+vhSubnqdF9+4TJGJSZx7EdnhuDOU6GluMHgxdK+4fA7/RlTgY4JGvFf7mgwp
         DP9VAAx3GRM17UDPnyrz/6Wj20dragRazL1Iz3wcEy2XZmTOyIRDapE22mOWp6FWBKSz
         M1Hjzr20oxz1lRAzeI7k8Bc0NyaML2nwfaLXUJO2CbnY2DLt8U5BcN5KHgnvyjQkCUwl
         ZUvZ0GWnzJertFWNqShEx+cEffnQkIasyNnRPmLOalwtIKfyF2moOHzO8Z8haR8Jfv3X
         yb/w==
X-Gm-Message-State: ACrzQf3r38u5LF9EeIn2KmorxSI2hWD2slUw62BrRDNJjbcc+7SbxkxL
        SmItdGtNJnpSXQJM4XMiUl7V2qXNvna5vw==
X-Google-Smtp-Source: AMsMyM6NUgDZWVCAPG/YKy52pDfvfuxHZwNTWvLNoBE3utASdxI5Qb1NC0KFBHjH4K0coFUzbkNyLA==
X-Received: by 2002:a63:6a09:0:b0:43a:20d4:85fe with SMTP id f9-20020a636a09000000b0043a20d485femr929157pgc.625.1666065462001;
        Mon, 17 Oct 2022 20:57:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id r8-20020aa79628000000b0056699fcdf6bsm7127084pfg.84.2022.10.17.20.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:41 -0700 (PDT)
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
Subject: [PATCH 2/5] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:21 -0700
Message-Id: <20221017205610.2.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
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

Move around the CQE caps handling, because sdhci_setup_host() performs
resets before we've initialized CQHCI. This is the pattern followed in
other SDHCI/CQHCI drivers.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-brcmstb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index aff36a933ebe..7f4bb362b923 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -55,6 +55,10 @@ static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    (priv->flags & BRCMSTB_PRIV_FLAGS_HAS_CQE))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
@@ -209,7 +213,6 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
 		return sdhci_add_host(host);
 
 	dev_dbg(mmc_dev(host->mmc), "CQE is enabled\n");
-	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;
@@ -230,6 +233,8 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
 		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 	}
 
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+
 	ret = cqhci_init(cq_host, host->mmc, dma64);
 	if (ret)
 		goto cleanup;
-- 
2.38.0.413.g74048e4d9e-goog

