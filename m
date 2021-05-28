Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104DC47087
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 11:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1167E610A5
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 11:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhE1LWz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 May 2021 07:22:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:10564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhE1LWy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 28 May 2021 07:22:54 -0400
IronPort-SDR: oEpJFh/xL2ynRSulXTbMkh/8omfRfEZiC02XrKvJjPrlu4SMm3D/iVP0+1xkeAoeupN4VLGEn/
 7e3P3slQ2Gqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="190309419"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="190309419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 04:21:12 -0700
IronPort-SDR: GwBp7j8AA09JggSbtLsNAJ8msgeQLY/f7WuKXrA5lHaWsoGmWbdkAOVREhA+mgjX35mdWolj8m
 DyJ+K5w+csyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="547955919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2021 04:21:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E6D33B6; Fri, 28 May 2021 14:21:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mmc: mmc_spi: Drop duplicate 'mmc_spi' in the debug messages
Date:   Fri, 28 May 2021 14:21:26 +0300
Message-Id: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dev_dbg() in any case prints the device and driver name, no need
to repeat this in (some) messages. Drop duplicates for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 9776a03a10f5..65c65bb5737f 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -504,7 +504,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
 		/* else:  R1 (most commands) */
 	}
 
-	dev_dbg(&host->spi->dev, "  mmc_spi: CMD%d, resp %s\n",
+	dev_dbg(&host->spi->dev, "  CMD%d, resp %s\n",
 		cmd->opcode, maptype(cmd));
 
 	/* send command, leaving chipselect active */
@@ -928,8 +928,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		while (length) {
 			t->len = min(length, blk_size);
 
-			dev_dbg(&host->spi->dev,
-				"    mmc_spi: %s block, %d bytes\n",
+			dev_dbg(&host->spi->dev, "    %s block, %d bytes\n",
 				(direction == DMA_TO_DEVICE) ? "write" : "read",
 				t->len);
 
@@ -974,7 +973,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		int		tmp;
 		const unsigned	statlen = sizeof(scratch->status);
 
-		dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
+		dev_dbg(&spi->dev, "    STOP_TRAN\n");
 
 		/* Tweak the per-block message we set up earlier by morphing
 		 * it to hold single buffer with the token followed by some
@@ -1175,7 +1174,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		canpower = host->pdata && host->pdata->setpower;
 
-		dev_dbg(&host->spi->dev, "mmc_spi: power %s (%d)%s\n",
+		dev_dbg(&host->spi->dev, "power %s (%d)%s\n",
 				mmc_powerstring(ios->power_mode),
 				ios->vdd,
 				canpower ? ", can switch" : "");
@@ -1248,8 +1247,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		host->spi->max_speed_hz = ios->clock;
 		status = spi_setup(host->spi);
-		dev_dbg(&host->spi->dev,
-			"mmc_spi:  clock to %d Hz, %d\n",
+		dev_dbg(&host->spi->dev, "  clock to %d Hz, %d\n",
 			host->spi->max_speed_hz, status);
 	}
 }
-- 
2.30.2

