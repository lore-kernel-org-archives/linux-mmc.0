From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 08/10 v3] mmc: sh_mobile_sdhi: support caps2 flags
Date: Fri, 25 May 2012 17:16:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251651250.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49585 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2EYPQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:16:32 -0400
In-Reply-To: <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

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

