From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: dw_mmc: fix error return code in dw_mci_probe()
Date: Fri, 19 Apr 2013 09:25:45 +0800
Message-ID: <CAPgLHd9RGHwoitQ0EusPepKK+AApKJ=ryRbm4S32o_vOonUgeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64297 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967266Ab3DSBZr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Apr 2013 21:25:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id je9so1539941bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 18 Apr 2013 18:25:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in alloc workqueue error case instead
of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/dw_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc3a1bc..0652690 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2321,8 +2321,10 @@ int dw_mci_probe(struct dw_mci *host)
 	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
 	host->card_workqueue = alloc_workqueue("dw-mci-card",
 			WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
-	if (!host->card_workqueue)
+	if (!host->card_workqueue) {
+		ret = -ENOMEM;
 		goto err_dmaunmap;
+	}
 	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
 	ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
 			       host->irq_flags, "dw-mci", host);

