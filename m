Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D904FC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Dec 2020 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ADD23BC6
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Dec 2020 19:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbgLITn4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:56 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:20165 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387938AbgLITnv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Dec 2020 14:43:51 -0500
Received: from localhost.localdomain ([93.23.14.30])
        by mwinf5d59 with ME
        id 2Ki3240020euSfR03Ki3UJ; Wed, 09 Dec 2020 20:42:06 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Dec 2020 20:42:06 +0100
X-ME-IP: 93.23.14.30
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: owl-mmc: Fix a resource leak in an error handling path and in the remove function
Date:   Wed,  9 Dec 2020 20:42:02 +0100
Message-Id: <20201209194202.54099-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'dma_request_chan()' calls should be balanced by a corresponding
'dma_release_channel()' call.

Add the missing call both in the error handling path of the probe function
and in the remove function.

Fixes: ff65ffe46d28 ("mmc: Add Actions Semi Owl SoCs SD/MMC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/owl-mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 53b81582f1af..5490962dc8e5 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -640,7 +640,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	owl_host->irq = platform_get_irq(pdev, 0);
 	if (owl_host->irq < 0) {
 		ret = -EINVAL;
-		goto err_free_host;
+		goto err_release_channel;
 	}
 
 	ret = devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handler,
@@ -648,19 +648,21 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq %d\n",
 			owl_host->irq);
-		goto err_free_host;
+		goto err_release_channel;
 	}
 
 	ret = mmc_add_host(mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add host\n");
-		goto err_free_host;
+		goto err_release_channel;
 	}
 
 	dev_dbg(&pdev->dev, "Owl MMC Controller Initialized\n");
 
 	return 0;
 
+err_release_channel:
+	dma_release_channel(owl_host->dma);
 err_free_host:
 	mmc_free_host(mmc);
 
@@ -674,6 +676,7 @@ static int owl_mmc_remove(struct platform_device *pdev)
 
 	mmc_remove_host(mmc);
 	disable_irq(owl_host->irq);
+	dma_release_channel(owl_host->dma);
 	mmc_free_host(mmc);
 
 	return 0;
-- 
2.27.0

