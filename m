Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65107C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AAC223E0
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 07:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLWHbP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 02:31:15 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37558 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726923AbgLWHbP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 02:31:15 -0500
X-IronPort-AV: E=Sophos;i="5.78,441,1599490800"; 
   d="scan'208";a="66908319"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2020 16:30:43 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D5AFE40104CF;
        Wed, 23 Dec 2020 16:30:43 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] mmc: tmio: Add data timeout error detection
Date:   Wed, 23 Dec 2020 16:30:21 +0900
Message-Id: <1608708622-29668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608708622-29668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1608708622-29668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

Currently, busy timeout is not checked for data transfer command. But,
if the temperature condition changes, the data cannot be acquired
correctly and timeout may occur. Also, we could reproduce an issue by
using mmc_test driver (e.g. "Correct xfer_size at write (start
failure)"). Therefore, this adds timeout error check.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[saito: rework commit message.]
Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[shimoda: rebase, add commit description]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 942b8375..21492b5 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -477,8 +477,10 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 	if (!data)
 		goto out;
 
-	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
-	    stat & TMIO_STAT_TXUNDERRUN)
+	if (stat & TMIO_STAT_DATATIMEOUT)
+		data->error = -ETIMEDOUT;
+	else if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
+		 stat & TMIO_STAT_TXUNDERRUN)
 		data->error = -EILSEQ;
 	if (host->dma_on && (data->flags & MMC_DATA_WRITE)) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
-- 
2.7.4

