From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: omap: fix error return code in mmc_omap_probe()
Date: Tue, 28 May 2013 13:25:23 +0800
Message-ID: <CAPgLHd9rFJf-sT85R6oiiopxoH7EYVrXVy6eYebT6yhkrSpTNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:43902 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab3E1FZZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 01:25:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jarkko.lavinen@nokia.com, cjb@laptop.org
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the workqueue alloc error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 4b3e0eb..5d0bd0c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1455,8 +1455,10 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->reg_shift = (mmc_omap7xx() ? 1 : 2);
 
 	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
-	if (!host->mmc_omap_wq)
+	if (!host->mmc_omap_wq) {
+		ret = -ENOMEM;
 		goto err_plat_cleanup;
+	}
 
 	for (i = 0; i < pdata->nr_slots; i++) {
 		ret = mmc_omap_new_slot(host, i);

