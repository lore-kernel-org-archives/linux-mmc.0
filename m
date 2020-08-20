Return-Path: <SRS0=808J=B6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DEBC433E3
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6F208DB
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Wp+p3WQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHTN01 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:26:27 -0400
Received: from www.zeus03.de ([194.117.254.33]:47876 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbgHTNZv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Aug 2020 09:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=WhXAXRUq4DETlX
        nFhV5uKolrccK0ifGGhZxjJ7QTZ70=; b=Wp+p3WQ9iyWAbqQ6Fp4J2CN7hbnR/9
        vveGOI88m08+4tAHscMcD/GKM3Tt3gdl8In1c/rmBbZe/lbgKvSguR40sgvm9aNk
        Wifo4dhNhC5bjbHk8gWSOmSwqtepw/6nL5tD3QVTOWYiRnDDFJ5oF2nSPfAj/Ecm
        kEAaLnqVkk9OY=
Received: (qmail 560113 invoked from network); 20 Aug 2020 15:25:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Aug 2020 15:25:47 +0200
X-UD-Smtp-Session: l3s3148p1@1InsDk+tLpggAwDPXwuPAFbD76CDVWXO
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT 3/6] mmc: tmio: remove indirection of 'hw_reset' callback
Date:   Thu, 20 Aug 2020 15:25:35 +0200
Message-Id: <20200820132538.24758-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200820132538.24758-1-wsa+renesas@sang-engineering.com>
References: <20200820132538.24758-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After Yamada-san's refactorization introducing 'tmio_mmc_host_alloc', we
can populate mmc_ops directly and don't need a layer inbetween.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 -
 drivers/mmc/host/tmio_mmc_core.c | 9 ---------
 drivers/mmc/host/uniphier-sd.c   | 5 +++--
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0a4f36500add..dac717041c2d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -178,7 +178,6 @@ struct tmio_mmc_host {
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*reset)(struct tmio_mmc_host *host);
-	void (*hw_reset)(struct tmio_mmc_host *host);
 	bool (*check_retune)(struct tmio_mmc_host *host);
 
 	/*
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 125530e7bd17..a4bd0a0a305c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -709,14 +709,6 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
-static void tmio_mmc_hw_reset(struct mmc_host *mmc)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-
-	if (host->hw_reset)
-		host->hw_reset(host);
-}
-
 static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -1008,7 +1000,6 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.get_cd		= tmio_mmc_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
-	.hw_reset	= tmio_mmc_hw_reset,
 	.execute_tuning = tmio_mmc_execute_tuning,
 };
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index f82baf99fd69..55efd5c53249 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -409,8 +409,9 @@ static void uniphier_sd_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void uniphier_sd_hw_reset(struct tmio_mmc_host *host)
+static void uniphier_sd_hw_reset(struct mmc_host *mmc)
 {
+	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
 
 	reset_control_assert(priv->rst_hw);
@@ -597,7 +598,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 			ret = PTR_ERR(priv->rst_hw);
 			goto free_host;
 		}
-		host->hw_reset = uniphier_sd_hw_reset;
+		host->ops.hw_reset = uniphier_sd_hw_reset;
 	}
 
 	if (host->mmc->caps & MMC_CAP_UHS) {
-- 
2.20.1

