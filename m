Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC9C47089
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiLBP1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiLBP07 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B13D0390;
        Fri,  2 Dec 2022 07:26:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fc4so5378237ejc.12;
        Fri, 02 Dec 2022 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yABTotUF1aHfY2MvDhzL0Nasx3orq8o9ESsBCAmUe4=;
        b=LQOtUd70pxQF/PYBI+E7Ast5RY8z/1CQLkbm0kM3GR6fjttSEg9vUcgH9JB9/fCQrF
         SMVbuN1a364G1jwA2a9nzy8MVHfY3vPAe9D9sO+xJxGNQg1lk2mBI4b0jlK8wKW+2wVe
         t/QB9Uh96vYG9zrPGwE53IG/zdhGnQfFuVvNCQiRfJ1OhahG5VUY3QoHK0Op6amzmA1T
         4o9BK0OK18W33uPmC8qw1i2z23CtdFTh8x35RwMHetjTdZxmfyneFr0kGoEk22jweqrw
         Ql8xIJlowkCw2viJBvSyYE/ofgB9wec0mcXXhGiglHBAhF3bYYawjwCh6aONR6cVD8kk
         +kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yABTotUF1aHfY2MvDhzL0Nasx3orq8o9ESsBCAmUe4=;
        b=WNbeMkN68O6LIpalJRifYwYVE9bgwNJT1r36x9S25hP6LI+cNCrG0FzIiOYTc5Zqhj
         RhAaPNh5k/c2dYi8pE9zWWX/1rNhDBnKYFcl6FpxqdnIOrXuUXMNTjbGexwk7lXX9jT5
         6T6PfATOQhzMEC4O4UKROOnYdQICKXYZH3SiJo6g7h5346VbE0opr16V9YT8rJBFPzPw
         7zp/iBpNanO37EExm2NDLPvtLvZSDqf90dk/MU1g8ECSTs7Iel48tFov/B3BQpuSOJWf
         fG2E1/zUKJ6b4lotuLirZNuyLL/DNs4Vqir74pzOaeTfCk6uXVmGceajr3q6yTnnzusH
         2/tA==
X-Gm-Message-State: ANoB5pkD6G69QJ+eQJJtrqKD1g/U9FBzJvBtFI4Q3ulznORSt86agTXp
        FuHyhavZhumxujiUAqGKr1A=
X-Google-Smtp-Source: AA0mqf7fF9YbsaKeHpA/1+LF6sgvUbDCFvfeZvxpbLCimbL4kRbRCVmTwTsIy6UffpRKqhriTPD8DA==
X-Received: by 2002:a17:907:3f8a:b0:7bf:4ae6:c36 with SMTP id hr10-20020a1709073f8a00b007bf4ae60c36mr23176828ejc.674.1669994816065;
        Fri, 02 Dec 2022 07:26:56 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b0046150ee13besm3001605edz.65.2022.12.02.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v12 6/6] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Fri,  2 Dec 2022 16:26:44 +0100
Message-Id: <20221202152644.29450-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

In case of error condition to avoid system crash Tegra SDMMC controller
requires CMD and DAT resets issued together. SDHCI controller FSM goes
into bad state due to rapid SD card hot-plug event. Issuing reset on the
CMD FSM before DATA FSM results in kernel panic, hence add support to
issue CMD and DAT resets together.

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
index c17700fa9899..49f60e292551 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1528,7 +1528,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df1c1d10a338..81f4fed11629 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,6 +270,11 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
+	if (host->quirks2 & SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		return;
+	}
+
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b6f31a7d6152..605eaee805f7 100644
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

