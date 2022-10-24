Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E641ECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiJXTWs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJXTVv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 15:21:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CB1FCFA
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:57:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso9448616pjn.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWp3gLeR18gDUBWllj7p7A295JT2g0xhsqKP4jhnM/M=;
        b=A/JR5Rj+tGKKJmsT6QxHlUP2Ul2+BXbXtagTpnwvYnwmKxL5N2i2722xv3L4gmoVxL
         enNvMIwKR66QuY/eIput2Ma8qJZNhgvTyyEjn1HJFLvoIFpN3488+3tfqob8hEH8ryhu
         aV+VtyqiHt+tNyB8m0QKqS8JkPsGe2ZQsAOq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWp3gLeR18gDUBWllj7p7A295JT2g0xhsqKP4jhnM/M=;
        b=DIuwyoG0kD/BciMpVcdYU6HYK7wu3Yvu4SeS0NytVz319yUJsxx4w3Ur8CC6s5r8P4
         91bgQhrLvyrE7G03865v5Ir4jhUEjeiR11eXtAK55+Fq+wEyAD9eh+At+D90v7b5Zu15
         A7J+/Zp/qwKOCrXSS6d3wEspLuL43A0snxIBSaZAQJg078g9esGCHSfjZtR9SDUxSXjA
         FaP1NwUVQPreOtPjImRLXccKU+HyGoRGaz8MuzZcncixv2gJ220w0THh5YZqJ1hvxTwn
         LI4wtFYx7jgvc1N/NVia1b6Omxw1tuOgLxALSGl7B+XOjB1lvR5L6vNkgcck+AXcoCGO
         NuLA==
X-Gm-Message-State: ACrzQf1fmTHrlCN8i78hd+vdR4BEi5pEW2q9YpawYX4Hq6qKNHUcIPij
        YLOqxJipeZUb0cISC1wk4bsUTA==
X-Google-Smtp-Source: AMsMyM6xehe4fg+ZHFo4TFClgOHOiWTRdft7HPelDaGN1nci+/HaPTuEVoT43nSFrBu3QLvD9IqL+A==
X-Received: by 2002:a17:90b:954:b0:213:c01:b8ce with SMTP id dw20-20020a17090b095400b002130c01b8cemr7841306pjb.168.1666634186333;
        Mon, 24 Oct 2022 10:56:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id g29-20020aa79ddd000000b0056bdb5197f4sm103804pfq.35.2022.10.24.10.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 5/7] mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:54:59 -0700
Message-Id: <20221024105229.v3.5.I418c9eaaf754880fcd2698113e8c3ef821a944d7@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024175501.2265400-1-briannorris@chromium.org>
References: <20221024175501.2265400-1-briannorris@chromium.org>
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

Include this fix by way of the new sdhci_and_cqhci_reset() helper.

Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - Use new SDHCI+CQHCI helper

Changes in v2:
 - Drop unnecessary 'enable_hwcq' check

 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 413925bce0ca..c71000a07656 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -28,6 +28,7 @@
 
 #include <soc/tegra/common.h>
 
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -367,7 +368,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	if (!(mask & SDHCI_RESET_ALL))
 		return;
-- 
2.38.0.135.g90850a2211-goog

