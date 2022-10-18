Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4756C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 03:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJRD60 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJRD5y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 23:57:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB988DCB
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 10so12705748pli.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p3m7T6e0mIj8rcCXtywVHD8sGWIzKCyjF4TP7KLyZQ=;
        b=F4EZTL9tVgb/GVZL3Pq3dG+YSUlqemGjgd1HKl8uW7Zv3ivDiffA8tbC7/7dWruKax
         2LCuvRHAppGUX8X6oBUrN2c9Rq3xqt9/4nqMIWNlL+g8QUFp5AYvLHJji2VTBRoAUEDs
         1E5N2J25qZgWy/Rxdk6krea1cWV1M/bcTxVsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p3m7T6e0mIj8rcCXtywVHD8sGWIzKCyjF4TP7KLyZQ=;
        b=E2LaSLzUZWNvxnjOMB/dT3PK+yrayqXQ918qzwRGvYUrri8nH4ZIis/EZYN9x6O+DX
         1q30NMaaIjBNtWvsAr0LSawhNid9jnP5nB5j2b+xc7IQdMtiwG23trFj0YV8QwDQAtQ4
         DasMTtp8e9AeopfzygagnsLsdMRNKf9eBpZpRhQeR+D0hBboLip+AUxPNQZIG+Ldj6bj
         ByYWdLlF5GsW/q3j7CgpCr/l8TLzPx6ic6ZDXu2b/A9MD0TzGK0rNt1t2xb2fYNQK/aa
         LD6vT0hnUaGgMt9X2vj2hlH4HGkXq3VAdjW2ye/JD68HGwbnxyPniBgTgAy94h1KuT3Y
         T6Dw==
X-Gm-Message-State: ACrzQf3YPYawH1ES7JUkX5ONYIcalg13zOL6PQwt3uAH6qKnbZWAxFA/
        593N0W8l4wOXJwE/mfhc9cwXKQ==
X-Google-Smtp-Source: AMsMyM4Oi5SI4xxHrO4wJahkDYqAgw2comRgFo0posUVaiivWN51Whl+zPIHJrd+P7q1UiVjJiRzBg==
X-Received: by 2002:a17:90b:384f:b0:20d:4761:3394 with SMTP id nl15-20020a17090b384f00b0020d47613394mr1319039pjb.144.1666065470226;
        Mon, 17 Oct 2022 20:57:50 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id q23-20020a635c17000000b0043a0de69c94sm6805583pgb.14.2022.10.17.20.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:49 -0700 (PDT)
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
Subject: [PATCH 5/5] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:24 -0700
Message-Id: <20221017205610.5.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
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

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci_am654.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8f1023480e12..187a21086791 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -378,6 +378,9 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
-- 
2.38.0.413.g74048e4d9e-goog

