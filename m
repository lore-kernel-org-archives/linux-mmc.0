From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/7] mmc: tmio: stop interface clock before runtime PM suspending
Date: Tue, 24 Apr 2012 18:41:41 +0200
Message-ID: <1335285707-22707-2-git-send-email-g.liakhovetski@gmx.de>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64311 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab2DXQlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:41:50 -0400
In-Reply-To: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

The call to pm_runtime_put() in tmio-mmc's .set_ios() method can switch
off the supplying clock or even power down the whole unit. Therefore,
calling tmio_mmc_clk_stop() after that can be redundant, put it before.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9a7996a..0d2643b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -809,11 +809,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	} else if (ios->power_mode != MMC_POWER_UP) {
 		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
 			host->set_pwr(host->pdev, 0);
+		tmio_mmc_clk_stop(host);
 		if (host->power) {
 			host->power = false;
 			pm_runtime_put(dev);
 		}
-		tmio_mmc_clk_stop(host);
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.5

