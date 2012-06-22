From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 9/9 v4] mmc: tmio: use generic GPIO CD and WP handlers
Date: Fri, 22 Jun 2012 15:23:22 +0200
Message-ID: <1340371402-4801-10-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52669 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762101Ab2FVNXn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 09:23:43 -0400
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

The tmio-mmc driver is already using the generic GPIO CD handler in IRQ
mode. This patch adds support for CD polling mode and also checks for
availability of a WP GPIO.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f8df021..0d8a9bb 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -875,6 +875,9 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
+	int ret = mmc_gpio_get_ro(mmc);
+	if (ret >= 0)
+		return ret;
 
 	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
 		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
@@ -884,6 +887,9 @@ static int tmio_mmc_get_cd(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
+	int ret = mmc_gpio_get_cd(mmc);
+	if (ret >= 0)
+		return ret;
 
 	if (!pdata->get_cd)
 		return -ENOSYS;
-- 
1.7.2.5

