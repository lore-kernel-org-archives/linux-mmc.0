Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF7CECAAD8
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Sep 2022 19:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIVTGv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVTGu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2022 15:06:50 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284CEBBEB
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2022 12:06:48 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id bRWzoFS7XOizNbRWzoX4NW; Thu, 22 Sep 2022 21:06:46 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Sep 2022 21:06:46 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, cjb@laptop.org, dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
Date:   Thu, 22 Sep 2022 21:06:40 +0200
Message-Id: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A dma_free_coherent() call is missing in the error handling path of the
probe, as already done in the remove function.

Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes since v1:
  * Add and use the (ugly named) 'fail5_and_a_half' label   [Dan Carpenter <dan.carpenter@oracle.com>]

v1: https://lore.kernel.org/all/bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr/
---
 drivers/mmc/host/wmt-sdmmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 163ac9df8cca..9b5c503e3a3f 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -846,7 +846,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk_sdmmc)) {
 		dev_err(&pdev->dev, "Error getting clock\n");
 		ret = PTR_ERR(priv->clk_sdmmc);
-		goto fail5;
+		goto fail5_and_a_half;
 	}
 
 	ret = clk_prepare_enable(priv->clk_sdmmc);
@@ -863,6 +863,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	return 0;
 fail6:
 	clk_put(priv->clk_sdmmc);
+fail5_and_a_half:
+	dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
+			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
 fail5:
 	free_irq(dma_irq, priv);
 fail4:
-- 
2.34.1

