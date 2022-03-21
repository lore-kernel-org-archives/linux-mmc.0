Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A9C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Mar 2022 11:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbiCULxP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiCULwv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2022 07:52:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72A15B060
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2022 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=yNuiRrYSmsAtp9
        N39Y/ajnCG1ZPP72tGEy39+XJpozQ=; b=J/fmceZcw+8diprk/fGBq+ncKvorZH
        +q7HdxM1ulcDHWnQSXEuSEi4iXY6gNfYz1L/yg2qbEAcRpfJT8gzZI3ghVYP4/54
        iU9zKrbDLednesjmdkDlgsZAGrpIhN5NKQQLccwM7NapMVbFgJ0fdzNFcQVUO1pa
        3hWNw5f8AbxD8=
Received: (qmail 860482 invoked from network); 21 Mar 2022 12:51:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 12:51:12 +0100
X-UD-Smtp-Session: l3s3148p1@BDvjHLnaEqcgAQnoAFxnAN8BywfgXJ9V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 09/10] mmc: core: improve API to make clear sw_reset from bus_ops is for cards
Date:   Mon, 21 Mar 2022 12:50:55 +0100
Message-Id: <20220321115059.21803-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make it unambiguous that bus_ops->sw_reset() is for cards and not for
controllers, we a) add 'card' to the function name and b) make the
function argument mmc_card instead of mmc_host. All users are converted,
too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 4 ++--
 drivers/mmc/core/core.h | 2 +-
 drivers/mmc/core/sdio.c | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1d874b064202..7e48570007f9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2023,10 +2023,10 @@ int mmc_card_sw_reset(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	int ret;
 
-	if (!host->bus_ops->sw_reset)
+	if (!host->bus_ops->card_sw_reset)
 		return -EOPNOTSUPP;
 
-	ret = host->bus_ops->sw_reset(host);
+	ret = host->bus_ops->card_sw_reset(card);
 	if (ret)
 		pr_warn("%s: tried to SW reset card, got error %d\n",
 			mmc_hostname(host), ret);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index c54270a6d457..27e8435ae779 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -28,7 +28,7 @@ struct mmc_bus_ops {
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
 	int (*card_hw_reset)(struct mmc_card *);
-	int (*sw_reset)(struct mmc_host *);
+	int (*card_sw_reset)(struct mmc_card *);
 	bool (*cache_enabled)(struct mmc_host *);
 	int (*flush_cache)(struct mmc_host *);
 };
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 30242faf703e..e6460285b46b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1154,8 +1154,10 @@ static int mmc_sdio_card_hw_reset(struct mmc_card *card)
 	return mmc_sdio_reinit_card(host);
 }
 
-static int mmc_sdio_sw_reset(struct mmc_host *host)
+static int mmc_sdio_card_sw_reset(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
+
 	mmc_set_clock(host, host->f_init);
 	sdio_reset(host);
 	mmc_go_idle(host);
@@ -1176,7 +1178,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.runtime_resume = mmc_sdio_runtime_resume,
 	.alive = mmc_sdio_alive,
 	.card_hw_reset = mmc_sdio_card_hw_reset,
-	.sw_reset = mmc_sdio_sw_reset,
+	.card_sw_reset = mmc_sdio_card_sw_reset,
 };
 
 
-- 
2.30.2

