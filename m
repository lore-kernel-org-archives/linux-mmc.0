Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692AEECDFA1
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiJZTnc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiJZTm4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 15:42:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27151057F6
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so15182929pls.9
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y45Z9F5+/R9uqywDzN7icoG5SzFxInaah2IApmdYfxw=;
        b=Iy9rHMtN9Rv2jganlhmWgo4QVH8Z7RUUGpg2ylFrGCK3WZN2XS7hhrGR9N3EkAipMB
         Iwx6g7aDxY2T1V1+Jm761uVArvrg2ri/fPYwbk0fiE4ko/o4cdje9BwYuxpIrfgvmK72
         KB/rlobuS5mS4s+bNIjyb46By3UIsEOQ4qZwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y45Z9F5+/R9uqywDzN7icoG5SzFxInaah2IApmdYfxw=;
        b=beiVqif9nrETbqcsOEI8R7MLZ6TDjlsdzHM22GhTkiEES8uNT8o9pk+r7fTAcfWMEl
         ILKYIFECYEdzMRa7BIrx7xEUGmL2++ZyXu3k04til6VsDNOT5QZ0sKlUzI6x7yRaUKZF
         pGqTOJOmIargTxr/NBojFElE9p9rB0nmKYK22je+9Siv9qfoQ9hLG5j26rNyn3Jtn1yh
         f5iI301bc8oEl2kvuYckufidtDu6l8/rShWpignS2DDvVJ7hWb0p1Qjg1LMLhbhnVKVR
         x32qlBg3oS4PkjUKD8sR3LAH51HQbx/uHwbYxpeNw678PGm9K9Clh0EODsVXrt0LLbZf
         Wudw==
X-Gm-Message-State: ACrzQf2dgYdQT5oBdA8dZeyfEV6NR7h6TyjqkjyiIaiRgz1c65WdMnTm
        yxeBTl8wgcRohbDbHiUHfjtQCA==
X-Google-Smtp-Source: AMsMyM6bJdMa7N5QxnACd3Ttb0ThzapeCiUxb/MbTJVAXotHLUcV2tMCdTodRYT9wH43R9ASc1A4qg==
X-Received: by 2002:a17:90b:1e49:b0:20b:36a3:aba6 with SMTP id pi9-20020a17090b1e4900b0020b36a3aba6mr6128720pjb.2.1666813357227;
        Wed, 26 Oct 2022 12:42:37 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id s27-20020aa78bdb000000b0056bc30e618dsm3341776pfd.38.2022.10.26.12.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:36 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:06 -0700
Message-Id: <20221026124150.v4.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
References: <20221026194209.3758834-1-briannorris@chromium.org>
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

This patch depends on (and should not compile without) the patch
entitled "mmc: cqhci: Provide helper for resetting both SDHCI and
CQHCI".

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Add dependency notes
 - Add Adrian's Ack

Changes in v3:
 - Use new SDHCI+CQHCI helper
 - Add Reviewed-by

Changes in v2:
 - Drop unnecessary ESDHC_FLAG_CQHCI check

 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..b297c3c360eb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 #include "cqhci.h"
@@ -1288,7 +1289,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
2.38.0.135.g90850a2211-goog

