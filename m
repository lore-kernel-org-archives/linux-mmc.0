From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 01/11] mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
Date: Wed, 23 Jan 2013 16:32:28 +0100
Message-ID: <1358955158-1510-2-git-send-email-g.liakhovetski@gmx.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55358 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3AWPkT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 10:40:19 -0500
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

tmio-mmc platform flags can be set by various means, including caller
drivers and device-tree bindings, therefore it is better to only check
them in the tmio-mmc driver proper, not in caller drivers themselves.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: .write16_hook should also be assigned in the absence of platform data, 
e.g. with DT.

 drivers/mmc/host/sh_mobile_sdhi.c |    3 +--
 drivers/mmc/host/tmio_mmc_pio.c   |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 524a7f7..e0ca0ab 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -153,10 +153,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+	mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
-		if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
-			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0f992e9..b25adb4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -928,6 +928,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
+	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
+		pdata->write16_hook = NULL;
+
 	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_ctl)
 		return -EINVAL;
-- 
1.7.2.5

