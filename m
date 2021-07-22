Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C60C63798
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E3961222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGVDWL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhGVDVy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267DC061757;
        Wed, 21 Jul 2021 21:02:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu14so4386527pjb.0;
        Wed, 21 Jul 2021 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jPg7TYNoaxg7wBJUp7wcIlMPDK4HteHjTAZGWqphXY=;
        b=FDj+DeD8gEaBAZ38MeLLodcrNxM5NgsjsZAi6E6TtDquYuulPz/p9oHVrukvU7TGlL
         Or+cPt9EngcCx+79gqFIZ0v7fUYUFladM42rlHIRgQpk4HAqzwCSCXi+n0h7bLxGhuT3
         mMuLAGA53Ur063GUckOLtHMZrPMoS0CEZqJuraflH3QRy/KFX3VcXY2lbTx07a525WA2
         NSdToL9AM2DrbWtlfoEQYC6AWxVdIJ+YSXelqc9pSeOf6rq/93P+jBuyQ+1xxKaizj0T
         2VD6vgfE4GC/8/G9yKJxTtn5XVeaAHWFrqtjiMj3xlLiLdYapTmaP0/WHaSK6r6AJ+/b
         oQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jPg7TYNoaxg7wBJUp7wcIlMPDK4HteHjTAZGWqphXY=;
        b=G4UDGUfXzMsz+7ccjGzAP2Ks39gqacKaIYtvygvgQcQi25uCUxi25BY9e10wL/JWK3
         WtbbXuXxIwSdwpORoqH0cRfmv/T1TlJ4SO8NhBXW6xboGyjCGi6zBgGQq95GKW77OuMh
         0D3UskgwUJSgfuHxGZPG/1yqiEgaBvXk6QqCeSGN4WCTgKgQ7u0/8AupcahHFxTy1deg
         8DGZd8nmzwb1wXw9K9zGfb5MGTTxzYMJtonbExz8qWAYHV/WQHWiubGKbvgeEYyhYO7O
         r2YsZ+GQGxd04N6GP2EJX/Bt0PU7xOdahtpNwF8Y+poh+5u/3N4f9s6JFFk84OQ9dHrw
         RjTg==
X-Gm-Message-State: AOAM530wqGwDQMoE5pTjI+FvysGsNmnt+BK4jiGcN38qHXchJJtLqTEt
        tt6CSAHNQ/HsOzB0cVSbivM=
X-Google-Smtp-Source: ABdhPJwv7m+5cLa9LtYY+t1c3fuFSOPt1YwAGNN811V6eCbizTnO1HgYHw3VgvXdqRkZG6/Xqpdf4Q==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr7240104pjo.177.1626926548401;
        Wed, 21 Jul 2021 21:02:28 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:28 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 19/29] mmc: sdhci-uhs2: add set_reg() to initialise the interface
Date:   Thu, 22 Jul 2021 12:01:14 +0800
Message-Id: <20210722040124.7573-19-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
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
2.32.0

