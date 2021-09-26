Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF3C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Sep 2021 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6D860FC1
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Sep 2021 09:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhIZJaW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Sep 2021 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhIZJaW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2021 05:30:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886FC061570;
        Sun, 26 Sep 2021 02:28:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c1so12903890pfp.10;
        Sun, 26 Sep 2021 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sogTVPrg0xxbas/RQ1KzZKqbAN+Sr35NAFihXcVk5gA=;
        b=VPqJpdtV+f8dyVaN244AnekcAr7Fv8zFZfj8x4RPR7Z8K18flc2bMjY8eTUPZ8b7Zj
         MpOwjGCcGfBctJvOBj2ICI+2GJbjGWma2anQcI95UC/blFQDNdRznFHvzIxey/IBgPBV
         4+Y6+hiBhTDsSfSqOCD4eoSTCDLV5JW5Omf2KOykOyRUvYuW8SG1JQjIRayD8PkLAT3U
         8+YByakhzJvs1xH1QcrEUTOQQZA5C50ty5P50r9cZoIFDOgoO23HJj+KY0WG2+mnRSzX
         gQPlyaPSmcxbzu0R2s3i/pr4KoAfGdzHkZj9reW4pt1XmpM0NVD0PT8aa8HxJRJDCaRD
         1dUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sogTVPrg0xxbas/RQ1KzZKqbAN+Sr35NAFihXcVk5gA=;
        b=u7FWfvc7Gd7JYSRH2YIyIFwq3IikaLXzRnMBrsfwvNKJX0q6GACutTCckZKg3Pq56C
         CqQ+72gkHlx9c0KEBefS8liOv+3tRXxpdwab2kMIqatNHqbBz4q3ma9rgQM4iZuL4aeR
         T59zCHDQEhD14yGcwxse5eIvP29WRDOSsD+KE91ODaScVOojNejX80JTfHms6j0MnSqY
         Czk9IVUDAduDw2uaxa6nTy/zadPLWvd0DWWfrdNWSh2kbPIoWRxpqCLhRozbHK1YXGqd
         921dzHCdVNC7nZfpe7eVKXvOzJbBMpzxUfhskliOlm1b0LVjUqXO6L7AsCeiLcdxJTrV
         6G+A==
X-Gm-Message-State: AOAM532YjKyPID2YNXmTvuKXOTfH6CYkCHskoJJNtvduzHM7jQpmnMF+
        2tIv/z6ydEnOdENDLm0yqvD9CWTotsg=
X-Google-Smtp-Source: ABdhPJxeO+z/buaSfnel8difWKijnp2RI2B8rwhFFBPaMKn5x7arAZobLS6aVnrCSwIrj8D+oHjnag==
X-Received: by 2002:a62:641:0:b0:44b:74bb:294c with SMTP id 62-20020a620641000000b0044b74bb294cmr5499951pfg.12.1632648525886;
        Sun, 26 Sep 2021 02:28:45 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q11sm14372509pfn.91.2021.09.26.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 02:28:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-sprd: Wait until DLL locked after being configured
Date:   Sun, 26 Sep 2021 17:28:35 +0800
Message-Id: <20210926092835.146449-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>

According to the specification, DLL status has to be locked before using it.

Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes since v1:
* Use read_poll_timeout() instead of while loop.
---
 drivers/mmc/host/sdhci-sprd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 11e375579cfb..f33e9349e4e6 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -39,6 +40,9 @@
 #define  SDHCI_SPRD_BIT_POSRD_DLY_INV		BIT(21)
 #define  SDHCI_SPRD_BIT_NEGRD_DLY_INV		BIT(29)
 
+#define SDHCI_SPRD_REG_32_DLL_STS0	0x210
+#define SDHCI_SPRD_DLL_LOCKED		BIT(18)
+
 #define SDHCI_SPRD_REG_32_BUSY_POSI		0x250
 #define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN	BIT(25)
 #define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN	BIT(24)
@@ -256,6 +260,15 @@ static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
 	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
 	/* wait 1ms */
 	usleep_range(1000, 1250);
+
+	if (read_poll_timeout(sdhci_readl, tmp, (tmp & SDHCI_SPRD_DLL_LOCKED),
+		2000, USEC_PER_SEC, false, host, SDHCI_SPRD_REG_32_DLL_STS0)) {
+		pr_err("%s: DLL locked fail!\n", mmc_hostname(host->mmc));
+		pr_info("%s: DLL_STS0 : 0x%x, DLL_CFG : 0x%x\n",
+			 mmc_hostname(host->mmc),
+			 sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_STS0),
+			 sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG));
+	}
 }
 
 static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
-- 
2.25.1

