Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05FC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiKQS1k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiKQS1d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786628517E;
        Thu, 17 Nov 2022 10:27:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t25so7185464ejb.8;
        Thu, 17 Nov 2022 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gHvtmH6qGDFUgG9Xrttoa7AgeGSmg5n5XNiv/6s7gw=;
        b=Er3109dKYZA7GnJLjMn74fmBltDWu4fU7J95oOgkYHBdH9QYpjjr0BerGeMINPkfgh
         XttoomE7vlWCZ+BOq+rtelL/3nPG9qvv4dbltBuVvjwOhmkSk6V49Y3XMkz66IOL4R6Q
         qiuDF8XpiCFYo3zmIozavb7Sy1rGfLO9i9yS9Jt49sSZ40rXbks2Lwu5XQM2wNfLj7id
         fzOECDDCbw9oAGN/2ixUoL2TKRQhIPcvKe1c525ZhcH/3WqbfBs0F5q4q0m8pNuhM1Py
         aslu2SnPWWEfdSOP48UaMTfqg5sU0OWBna+mYT0Ft/Yajcyryc/DDrtFNL+ig68YsXMd
         Xf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gHvtmH6qGDFUgG9Xrttoa7AgeGSmg5n5XNiv/6s7gw=;
        b=UxQStkurdk0+Ddb0vLXjB6p5+DOvzFqD87PZvkXDE28JZuWtjWoNdaBhV1s7gw5IA6
         gkvhEuR7sYucczTxCQ4W8Z5G1Nuz91bZtYn22t5m7QOnAvoZ987qpBvDoDZHvi/LagB9
         YCTuhoTZBX67EBK2GyUbeGMerRT1IxzOZk+GteiwyuSE+gBTogS8eLL6pmExR/Kuqcw1
         aZ7xrroNNYvzWiwdK2Ok9KniOEzqhLHqzikJ5cztOZ+aD5fZpnhFIniLqAhQyCtEeogN
         nv2FWhGfwxQbDpxrFzMCCBZ4AHBgyZcv+d8uPz8Iv841+G2QzpIKQ4mVNNmMzfkjQ3mm
         Lmpw==
X-Gm-Message-State: ANoB5pmc4JZW5Q4RkNZHyY07ma4s+3bFkYEvCzCmVi9v9l5EPkG3FIVS
        4GqMyFND368vBzaIeqf1LgI=
X-Google-Smtp-Source: AA0mqf4C/XcXI5n2CuuQwC6i/qjB120KD7Gvl7BFChzq0rU9n3k2h57zDx8DzAPXCaoGo/L0TRgPrA==
X-Received: by 2002:a17:906:4d16:b0:78b:15dc:2355 with SMTP id r22-20020a1709064d1600b0078b15dc2355mr3145426eju.306.1668709650695;
        Thu, 17 Nov 2022 10:27:30 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402034b00b004587f9d3ce8sm849384edw.56.2022.11.17.10.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 6/6] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Thu, 17 Nov 2022 19:27:20 +0100
Message-Id: <20221117182720.2290761-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

In case of error condition to avoid system crash
Tegra SDMMC controller requires CMD and DAT resets
issued together. SDHCI controller FSM goes into
bad state due to rapid SD card hot-plug event.
Issuing reset on the CMD FSM before DATA FSM results
in kernel panic, hence add support to issue CMD and
DAT resets together.
This is applicable to Tegra186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 1cb7fd3afa7e..3384bfd3585c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1533,7 +1533,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fb6e9a81f198..ed59bb3247a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,6 +270,11 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
+	if (host->quirks2 &
+		SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		return;
+	}
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 908da47ac5ba..ca7ede721523 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -478,6 +478,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.38.1

