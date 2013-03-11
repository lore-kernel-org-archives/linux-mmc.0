From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: wmt-sdmmc: remove unused variable in wmt_complete_data_request()
Date: Mon, 11 Mar 2013 22:36:09 +0800
Message-ID: <CAPgLHd-7nVD3=83wpNtw1cBmkr+xs5iD7tuxZM+PdxWPLtwZsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60965 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab3CKOgK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 10:36:10 -0400
Received: by mail-bk0-f49.google.com with SMTP id w11so1723187bku.8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 07:36:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@prisktech.co.nz, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable 'mmc' is initialized but never used
otherwise, so remove the unused variable.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 154f0e8..41d5802 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -348,13 +348,11 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
 
 static irqreturn_t wmt_mci_dma_isr(int irq_num, void *data)
 {
-	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
 
 	int status;
 
 	priv = (struct wmt_mci_priv *)data;
-	mmc = priv->mmc;
 
 	status = readl(priv->sdmmc_base + SDDMA_CCR) & 0x0F;
 


