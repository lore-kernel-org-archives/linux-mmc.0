Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90009C2BBCF
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 20:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567F623A22
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgLQUoV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:44:21 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:34422 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQUoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 15:44:20 -0500
Received: from localhost.localdomain ([93.22.133.164])
        by mwinf5d84 with ME
        id 5Yia2400B3YyeAd03Yiaxi; Thu, 17 Dec 2020 21:42:36 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 17 Dec 2020 21:42:36 +0100
X-ME-IP: 93.22.133.164
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: sdhci-sprd: Fix some resource leaks in the remove function
Date:   Thu, 17 Dec 2020 21:42:36 +0100
Message-Id: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'sdhci_remove_host()' and 'sdhci_pltfm_free()' should be used in place of
'mmc_remove_host()' and 'mmc_free_host()'.

This avoids some resource leaks, is more in line with the error handling
path of the probe function, and is more consistent with other drivers.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Other adjustment may be needed.
I'm not sure at all of the 0 passed to 'sdhci_remove_host()'. Some drivers
pass 0, some have some more complicated computation.
---
 drivers/mmc/host/sdhci-sprd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index f85171edabeb..5dc36efff47f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -708,14 +708,14 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
-	struct mmc_host *mmc = host->mmc;
 
-	mmc_remove_host(mmc);
+	sdhci_remove_host(host, 0);
+
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
-	mmc_free_host(mmc);
+	sdhci_pltfm_free(pdev);
 
 	return 0;
 }
-- 
2.27.0

