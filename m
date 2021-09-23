Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9896126A
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhIWI7r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhIWI7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 04:59:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6EC061574;
        Thu, 23 Sep 2021 01:58:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so5155294pfm.1;
        Thu, 23 Sep 2021 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8D/BUId9p/fF4y2rgtXgkg6y0k6T1zK3JKxwNsMcAQ=;
        b=ND9VSwwLJTk0sMiDscF2wgLeYcSwPLL0lGtbgmwLG13svSlnsS4a/2rrtuEdxgv+kX
         pDH0rbV8aTJK5b9liyxHypS3OS2dIrkufksgXf1pcC8ZvTUWus7p/+bser7RDKEEIta+
         9PRE03cT7+vvW//7trSuE4fU627h5Th8nrPE6YqLR+xjbEnZqU/u2/GYZD6BMrEvR4i6
         dDze7umDkEOTfh9zC8xVKU50RbiYHxbErXWUc2maFiAljmnR5ODq9nWnSeGJg5F4Edi4
         8AY5/tMqd7DXXv24VB9T6xOHiU4nvzaq7muidAGbqY7GYJo47rE0c8f0tliNzqSKvGii
         Lzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8D/BUId9p/fF4y2rgtXgkg6y0k6T1zK3JKxwNsMcAQ=;
        b=BQFJMzxs1U4u8kRfuIZ5s6BiNhOqCa43k24RZx6mVQGKB2M6m5Ygm+n+afMTPcoY0m
         gM/q09+1ysEhJ+wuMQD+UjJapAOK5GOnYGjVZ+fLDBztnQPdyCyZEkcobqclLB5ywNmO
         PBNb/6nrhXbCI1dKLr4D+HJx1aDxVb2g62lmQIMFBdnCqgVz6I2lo+BUkT26DMlsXkpp
         USSMZZPc9VxNuIX4EhleSwDRHBV3pnoRfN4BlLgGTbSNYzgBhzhD6XMMsS2QfzSxa9yj
         BGu2oBfPAltp5eNl+yB4ZZIP6xGkOcYPqPVJKws4slGQ3YQXYiJJExki96iJ8dZYU+Sn
         O/FA==
X-Gm-Message-State: AOAM532JgO5+7SSQZJC8OnwMeLAl9VsnxrrgyE9L2q86vLcS885/SzMs
        zBcXk6Xd/EHcIE4lgeAguZc=
X-Google-Smtp-Source: ABdhPJwX3d784LlIOcQawj5hxaOIdE5BKGMUwrNRjybgDmOJYSRYvuk8pje0vn410E78XYsbyY16Eg==
X-Received: by 2002:a63:3e8b:: with SMTP id l133mr1425974pga.451.1632387495821;
        Thu, 23 Sep 2021 01:58:15 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c9sm5534530pgq.58.2021.09.23.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 01:58:15 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-sprd: Wait until DLL locked after being configured
Date:   Thu, 23 Sep 2021 16:57:50 +0800
Message-Id: <20210923085750.71968-1-zhang.lyra@gmail.com>
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
 drivers/mmc/host/sdhci-sprd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 11e375579cfb..83749c7a6db4 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -39,6 +39,9 @@
 #define  SDHCI_SPRD_BIT_POSRD_DLY_INV		BIT(21)
 #define  SDHCI_SPRD_BIT_NEGRD_DLY_INV		BIT(29)
 
+#define SDHCI_SPRD_REG_32_DLL_STS0	0x210
+#define SDHCI_SPRD_DLL_LOCKED		BIT(18)
+
 #define SDHCI_SPRD_REG_32_BUSY_POSI		0x250
 #define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN	BIT(25)
 #define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN	BIT(24)
@@ -236,7 +239,7 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 
 static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
 {
-	u32 tmp;
+	u32 tmp, timeout = 1000;
 
 	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
 	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
@@ -256,6 +259,21 @@ static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
 	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
 	/* wait 1ms */
 	usleep_range(1000, 1250);
+
+	while (--timeout) {
+		if ((sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_STS0) &
+		     SDHCI_SPRD_DLL_LOCKED))
+			break;
+		usleep_range(1000, 1250);
+	}
+
+	if (!timeout) {
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

