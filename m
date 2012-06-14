From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 4/5 v2] mmc: bfin_sdh: Remove redundent suspend and resume setting.
Date: Thu, 14 Jun 2012 17:22:22 +0800
Message-ID: <1339665743-7947-4-git-send-email-sonic.adi@gmail.com>
References: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339665743-7947-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Bob Liu <lliubbo@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

mmc core suspend and resume functions had already called sdh_set_ios with proper flags.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 drivers/mmc/host/bfin_sdh.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index f47526f..7776614 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -643,11 +643,6 @@ static int sdh_suspend(struct platform_device *dev, pm_message_t state)
 	if (mmc)
 		ret = mmc_suspend_host(mmc);
 
-#ifndef RSI_BLKSZ
-	bfin_write_SDH_PWR_CTL(bfin_read_SDH_PWR_CTL() & ~PWR_ON);
-#else
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() & ~PWR_ON);
-#endif
 	peripheral_free_list(drv_data->pin_req);
 
 	return ret;
@@ -669,16 +664,6 @@ static int sdh_resume(struct platform_device *dev)
 	/* Secure Digital Host shares DMA with Nand controller */
 	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
 #endif
-#ifndef RSI_BLKSZ
-	bfin_write_SDH_PWR_CTL(bfin_read_SDH_PWR_CTL() | PWR_ON);
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN);
-#else
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN | PWR_ON);
-#endif
-	SSYNC();
-
-	bfin_write_SDH_CFG((bfin_read_SDH_CFG() & 0x1F) | (PUP_SDDAT | PUP_SDDAT3));
-	SSYNC();
 
 	if (mmc)
 		ret = mmc_resume_host(mmc);
-- 
1.7.0.4
