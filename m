From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 2/2] mmc: tmio: reset the controller after power-up
Date: Thu, 6 Jun 2013 16:35:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306061626200.32566@axis700.grange>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
 <871u8f8nxb.fsf@octavius.laptop.org> <Pine.LNX.4.64.1306061625290.32566@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1306061625290.32566@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This fixes two reported problems:
1. after a system resume the controller isn't functioning until a command
   runs on a timeout and a controller reset is performed.
2. if a card is ejected during a running write operation, its re-insertion
   isn't detected.

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Reported-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Tested-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
---

v3: rebased on top of current mmc-next / 3.10-rc

 drivers/mmc/host/tmio_mmc_pio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 67d9642..f294708 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -867,6 +867,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->resuming = false;
 			}
 		}
+		if (host->power == TMIO_MMC_OFF_STOP)
+			tmio_mmc_reset(host);
 		tmio_mmc_set_clock(host, ios->clock);
 		if (host->power == TMIO_MMC_OFF_STOP)
 			/* power up SD card and the bus */
@@ -1186,7 +1188,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	tmio_mmc_reset(host);
 	tmio_mmc_enable_dma(host, true);
 
 	return 0;
-- 
1.7.2.5

