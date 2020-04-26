Return-Path: <SRS0=cyGH=6K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE7AC54FCB
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Apr 2020 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C293320700
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Apr 2020 20:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZUYC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:24:02 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:47810 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgDZUYB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Apr 2020 16:24:01 -0400
Received: from localhost.localdomain ([93.23.12.11])
        by mwinf5d64 with ME
        id XYPx2200C0EJ3pp03YPyzM; Sun, 26 Apr 2020 22:23:59 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Apr 2020 22:23:59 +0200
X-ME-IP: 93.23.12.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, drake@endlessm.com,
        kamlesh.gurudasani@gmail.com, colin.king@canonical.com,
        linux@rempel-privat.de
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: alcor: Fix a resource leak in an error handling path in 'alcor_pci_sdmmc_drv_probe()'
Date:   Sun, 26 Apr 2020 22:23:55 +0200
Message-Id: <20200426202355.43055-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If 'devm_request_threaded_irq()' fails, resources allocated by
'mmc_alloc_host()' must be freed.

Fixes: c5413ad815a6 ("mmc: add new Alcor Micro Cardreader SD/MMC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/alcor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 1aee485d56d4..026ca9194ce5 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1104,7 +1104,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get irq for data line\n");
-		return ret;
+		goto free_host;
 	}
 
 	mutex_init(&host->cmd_mutex);
@@ -1116,6 +1116,10 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, host);
 	mmc_add_host(mmc);
 	return 0;
+
+free_host:
+	mmc_free_host(mmc);
+	return ret;
 }
 
 static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
-- 
2.25.1

