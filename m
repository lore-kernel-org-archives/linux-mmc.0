From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] mmc: tmio: reset the controller after power-up
Date: Wed, 24 Apr 2013 11:59:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1304241143460.11670@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, hechtb@gmail.com, Horman Simon <simon@horms.net>, Damm Magnus <magnus.damm@gmail.com>, "^[$B0p5H$5$s^[(B" <jinso.inayoshi@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nguyen Hong Ky <nh-ky@jinso.co.jp>
List-Id: linux-mmc@vger.kernel.org

This fixes two reported problems:
1. after a system resume the controller isn't functioning until a command
   runs on a timeout and a controller reset is performed.
2. if a card is ejected during a running write operation, its re-insertion
   isn't detected.

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Reported-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: this patch supersedes the earlier "mmc: tmio: postpone controller 
reset during resume" in that it extends the number of cases, in which the 
reset is applied. It turned out, it is needed not only after a resume, but 
also for recovery after an interrupted write. It also now applies on top 
of "[PATCH v2] MMC: tmio: fix unbalanced power-on calls with clock-gating 
enabled" http://article.gmane.org/gmane.linux.kernel.mmc/20233. Reporters 
are cordially invited to add their "Tested-by" tags ;-)

Chris, both these patches are fixes. Not sure whether it's still a good 
idea to push them for 3.9, maybe better get them into 3.10 and then to 
stable?

 drivers/mmc/host/tmio_mmc_pio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1d5ef64..fcb9503 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -863,6 +863,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			tmio_mmc_clk_update(mmc);
 			pm_runtime_get_sync(dev);
 		}
+		if (host->power == TMIO_MMC_OFF_STOP)
+			tmio_mmc_reset(host);
 		tmio_mmc_set_clock(host, ios->clock);
 		if (host->power == TMIO_MMC_OFF_STOP)
 			/* power up SD card and the bus */
@@ -1161,7 +1163,6 @@ int tmio_mmc_host_resume(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	tmio_mmc_reset(host);
 	tmio_mmc_enable_dma(host, true);
 
 	/* The MMC core will perform the complete set up */
-- 
1.7.2.5

