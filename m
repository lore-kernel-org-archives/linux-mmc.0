Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E44C2BA2B
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B196C20A8B
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 14:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgDHOW7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:22:59 -0400
Received: from sauhun.de ([88.99.104.3]:44020 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgDHOW7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Apr 2020 10:22:59 -0400
Received: from localhost (p54B334FE.dip0.t-ipconnect.de [84.179.52.254])
        by pokefinder.org (Postfix) with ESMTPSA id D978A2C1FD6;
        Wed,  8 Apr 2020 16:22:56 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: simplify summary output
Date:   Wed,  8 Apr 2020 16:22:52 +0200
Message-Id: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

No need to call platform_get_resource twice when we still have the
pointer from before. Also, use '%pa' for a resource_size_t pointer.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c002e9fb67fb..de7f4fc9bc21 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -933,10 +933,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			goto eirq;
 	}
 
-	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
-		 mmc_hostname(host->mmc), (unsigned long)
-		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-		 host->mmc->f_max / 1000000);
+	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
+		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
 
 	return ret;
 
-- 
2.20.1

