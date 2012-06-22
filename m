From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 8/9 v4] mmc: sh_mobile_sdhi: support caps2 flags
Date: Fri, 22 Jun 2012 15:23:21 +0200
Message-ID: <1340371402-4801-9-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762085Ab2FVNX1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 09:23:27 -0400
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

Let SDHI platforms specify mmc_host::caps2 flags in their platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |    1 +
 include/linux/mmc/sh_mobile_sdhi.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 42f07fa..1e7c5c4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -162,6 +162,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
+		mmc_data->capabilities2 |= p->tmio_caps2;
 		mmc_data->cd_gpio = p->cd_gpio;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index e94e620..b65679f 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -23,6 +23,7 @@ struct sh_mobile_sdhi_info {
 	int dma_slave_rx;
 	unsigned long tmio_flags;
 	unsigned long tmio_caps;
+	unsigned long tmio_caps2;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
 	struct tmio_mmc_data *pdata;
-- 
1.7.2.5

