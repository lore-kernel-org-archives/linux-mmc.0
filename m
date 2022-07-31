Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06167C00140
	for <linux-mmc@archiver.kernel.org>; Sun, 31 Jul 2022 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGaRfX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 31 Jul 2022 13:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGaRfV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Jul 2022 13:35:21 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37E5589
        for <linux-mmc@vger.kernel.org>; Sun, 31 Jul 2022 10:35:20 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ICqPojIknQUcTICqPoEmYh; Sun, 31 Jul 2022 19:35:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 19:35:18 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] mmc: dw_mmc-rockchip: Fix the dw_mci_rockchip_remove() function
Date:   Sun, 31 Jul 2022 19:35:12 +0200
Message-Id: <bd442556c0094be2c240f070d15ce2061b376c09.1659288898.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Having a something_get() function call in a remove function is unusual.
A something_put() is more likely.

More over the remove() function does not match the error handling of the
probe().

Fix the remove() function to match the error handling path of the probe.

Fixes: f90142683f04 ("mmc: dw_mmc-rockchip: add runtime PM support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\   SPECULATIVE   /!\

I have a limited knowledge of the pm_ API.
However, as said, the error handling path of the probe looks more logical
to me.

Moreover, some more or less similar code can be found in
drivers/mmc/host/dw_mmc-exynos.c. This patch also align this rockchip
driver to the exynos's one.

So review with care.
---
 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 2a99f15f527f..b5893c738b4a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -373,8 +373,8 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 
 static int dw_mci_rockchip_remove(struct platform_device *pdev)
 {
-	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	dw_mci_pltfm_remove(pdev);
-- 
2.34.1

