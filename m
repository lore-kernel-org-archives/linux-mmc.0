Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE6BC3B18C
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB902467C
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBMQhW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:37:22 -0500
Received: from sauhun.de ([88.99.104.3]:48946 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgBMQhV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Feb 2020 11:37:21 -0500
Received: from localhost (p54B33627.dip0.t-ipconnect.de [84.179.54.39])
        by pokefinder.org (Postfix) with ESMTPSA id 989782C07AD;
        Thu, 13 Feb 2020 17:37:19 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: simplify execute_tuning
Date:   Thu, 13 Feb 2020 17:37:15 +0100
Message-Id: <20200213163715.8212-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After refactoring, 'ret' variable is superfluous. Remove it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a Salvator-XS (R-Car M3-N). Tuning to HS400 works,
checksumming a large file works with no performance regression.

 drivers/mmc/host/renesas_sdhi_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 0f07cc1aee34..df826661366f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -497,7 +497,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
-	int i, ret;
+	int i;
 
 	priv->tap_num = renesas_sdhi_init_tuning(host);
 	if (!priv->tap_num)
@@ -517,8 +517,7 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
 		/* Set sampling clock position */
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
 
-		ret = mmc_send_tuning(host->mmc, opcode, NULL);
-		if (ret == 0)
+		if (mmc_send_tuning(host->mmc, opcode, NULL) == 0)
 			set_bit(i, priv->taps);
 	}
 
-- 
2.20.1

