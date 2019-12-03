Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4BBC432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23C20848
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 20:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLCUdJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:33:09 -0500
Received: from sauhun.de ([88.99.104.3]:34624 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfLCUdJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 15:33:09 -0500
Received: from localhost (p54B33759.dip0.t-ipconnect.de [84.179.55.89])
        by pokefinder.org (Postfix) with ESMTPSA id 604BC2C0678;
        Tue,  3 Dec 2019 21:33:07 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/2] mmc: renesas_sdhi: remove double clear of automatic correction
Date:   Tue,  3 Dec 2019 21:33:01 +0100
Message-Id: <20191203203301.2202-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203203301.2202-1-wsa+renesas@sang-engineering.com>
References: <20191203203301.2202-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hw_reset() clears the automatic correction bit twice. I couldn't find
anything in the docs recommending that. Removing one of them didn't
cause any regressions here, so keep it simple.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Last minute patch, sorry for the confusing numbering...

 drivers/mmc/host/renesas_sdhi_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a29290ee2051..10ccd90e5c64 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -578,10 +578,6 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
 		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
-		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
-		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
-
 	if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 		sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
 					     TMIO_MASK_INIT_RCAR2);
-- 
2.20.1

