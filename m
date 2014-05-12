From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/5] mmc: dw_mmc: add the specified capbilities2 of controller.
Date: Mon, 12 May 2014 20:14:15 +0900
Message-ID: <1399893256-7071-5-git-send-email-jh80.chung@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43656 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbaELLOk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:40 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00INMKKFQ980@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:39 +0900 (KST)
In-reply-to: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

To use capabilities2, add the caps2 into dw_mci_drv_data.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 drivers/mmc/host/dw_mmc.h |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 75d7d4e..e0e933d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2088,6 +2088,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
+	if (drv_data && drv_data->caps2)
+		mmc->caps2 |= drv_data->caps2[ctrl_id];
+
 	mmc_of_parse(mmc);
 
 	if (host->pdata->blk_settings) {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 738fa24..5541946c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -237,6 +237,7 @@ struct dw_mci_tuning_data {
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
+ * @caps2: mmc subsystem specified capabilities2 of the controller(s).
  * @init: early implementation specific initialization.
  * @setup_clock: implementation specific clock configuration.
  * @prepare_command: handle CMD register extensions.
@@ -250,6 +251,7 @@ struct dw_mci_tuning_data {
  */
 struct dw_mci_drv_data {
 	unsigned long	*caps;
+	unsigned long	*caps2;
 	int		(*init)(struct dw_mci *host);
 	int		(*setup_clock)(struct dw_mci *host);
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
-- 
1.7.9.5

