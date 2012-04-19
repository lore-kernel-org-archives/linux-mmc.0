From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] mmc: sh_mmcif: re-read the clock frequency upon re-enabling
Date: Fri, 20 Apr 2012 00:09:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204192357250.2110@axis700.grange>
References: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
 <Pine.LNX.4.64.1202022256580.13860@axis700.grange>
 <CANqRtoQ7o=_9uRa3F=4pkNvDWS2g2wZU6oBipttfGuFv4irpzA@mail.gmail.com>
 <Pine.LNX.4.64.1202031156020.6211@axis700.grange>
 <Pine.LNX.4.64.1204191215430.2110@axis700.grange>
 <CANqRtoTq1e7_g82FGZS3S8yb0j7MgCYNhiH7E=a+nHkTWiOgLQ@mail.gmail.com>
 <Pine.LNX.4.64.1204192351190.2110@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204192351190.2110@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Once the clock is disabled by a driver, nothing prevents it from being 
reconfigured by another user. Drivers, that save power by disabling the 
clock when not in use must re-read its frequency every time they re-enable 
it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0441140..ed59392 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -916,6 +916,13 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sh_mmcif_start_cmd(host, mrq);
 }
 
+static void sh_mmcif_clk_update(struct sh_mmcif_host *host)
+{
+	host->clk = clk_get_rate(host->hclk);
+	host->mmc->f_max = host->clk / 2;
+	host->mmc->f_min = host->clk / 512;
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
@@ -962,6 +969,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			if (p->set_pwr)
 				p->set_pwr(host->pd, ios->power_mode);
 			clk_enable(host->hclk);
+			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
@@ -1313,9 +1321,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 	clk_enable(host->hclk);
-	host->clk = clk_get_rate(host->hclk);
-	mmc->f_max = host->clk / 2;
-	mmc->f_min = host->clk / 512;
+	sh_mmcif_clk_update(host);
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-- 
1.7.2.5

