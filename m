Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624DC4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC9A20756
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZftMHcQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKFC25 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKFC24 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:56 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C4C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so2927813pfr.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AJ3XfVjmJenPF25E68SJna40yNR+zW1Gz7zFWMxzx4=;
        b=ZftMHcQAczmBR0kkhRn2JkIlUz7l43eESAu87iP8nd/QzunngYgvuY5mI+fCpvKB+u
         NM5StKdbqyeBdSv83mvPKgiwXC5QnP46h/CaUripR4wkJpQ/7HJFqbCeY9RQWs23RQIe
         5iIdJv/cSwWnemw/RauC3vMsrHVZW2CzRNbS5SeHBwM1cyHw7trQeVKylT3txYMeZu93
         73LpOwozqQzYPyZilipg/ze7GJtY6UKbqnAmLNW+jb6+y8i7z+EnP7DVeYtER4o51/TP
         UfduIjhz5epTI4NNFW/+rG2mjN3gXLbbCMnsSJHhnPmTFxhZxuMPWvQbxsX4BDfklJY4
         sTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AJ3XfVjmJenPF25E68SJna40yNR+zW1Gz7zFWMxzx4=;
        b=JIQBa6esb3A66yq//Aq8h3L3RUUQ4BJacMH7vSXsfN3lKDlnvocfp/sQGol6ko6JeC
         bqsun1sdy+g3PBUgURc8jrQJSebuy0swUqwfI3NeuG1XJwwpDz06zLME6P2OObHM0vXN
         2/rYXA8sURHuSX3bVngGupSB4GPj4h0tSCRv0ftJnVsx6aVJ66HOKd2XbBn5QbMMh4Uq
         AhanNxiqH+AIYqjk/fu/FhKc+Nrwhaet7vScTunRYDurpq+2ItrfwQARK0KOk2sPioVQ
         UM9wzuKFhDhFMLaTOIxbGamDRof3ow8AchpQ78dz/8KJK/Y2OWPo0L5H00MnQ/MJnK6L
         DSNA==
X-Gm-Message-State: AOAM532Jd7sLUaUU3abQ5Hufzju96GJM07OgrQsphfCJc4mEU16cYaa6
        3FVAwX3lDKX0mctqJo8WDNcarQ==
X-Google-Smtp-Source: ABdhPJyPbJwTC3HHbKJUiPVe0J4QTU+uhgIwqd5wxWYiZETQo15cyR9gX3AQgXO1r6mzb7m8Wq8p9Q==
X-Received: by 2002:a17:90a:ba8d:: with SMTP id t13mr25709pjr.38.1604629735240;
        Thu, 05 Nov 2020 18:28:55 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:54 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 19/27] mmc: sdhci-uhs2: add set_reg() to initialise the interface
Date:   Fri,  6 Nov 2020 11:27:18 +0900
Message-Id: <20201106022726.19831-20-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a sdhci version of mmc's uhs2_set_reg operation.
UHS-II interface (related registers) will be initialised here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 55362ace1857..d8afb99a9918 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -332,6 +332,68 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/* TODO: move this function to sdhci.c */
+static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
+	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
+
+	/* Set Gen Settings */
+	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
+		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
+		(host->mmc->uhs2_caps.n_lss_sync_set <<
+			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
+	if (host->mmc->flags & MMC_UHS2_SPEED_B)
+		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = (host->mmc->uhs2_caps.max_retry_set <<
+			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
+		(host->mmc->uhs2_caps.n_fcu_set <<
+			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
+		     sdhci_uhs2_tran_set_1_reg);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	int timeout = 100;
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IN_DORMANT_STATE)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -422,6 +484,45 @@ static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 	}
 }
 
+static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
+{
+        struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int err = 0;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
+	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
+
+	DBG("Begin sdhci_uhs2_set_reg, act %d.\n", act);
+	spin_lock_irqsave(&host->lock, flags);
+
+	switch (act) {
+	case SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case ENABLE_INT:
+		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case DISABLE_INT:
+		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case SET_SPEED_B:
+		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
+			     sdhci_uhs2_phy_set_reg);
+		break;
+	case CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	default:
+		pr_err("%s: input action %d is wrong!\n",
+		       mmc_hostname(host->mmc), act);
+		err = -EIO;
+		break;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return err;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -597,6 +698,8 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
 	if (!host->mmc_host_ops.uhs2_enable_clk)
 		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
+	if (!host->mmc_host_ops.uhs2_set_reg)
+		host->mmc_host_ops.uhs2_set_reg = sdhci_uhs2_set_reg;
 
 	return 0;
 }
-- 
2.28.0

