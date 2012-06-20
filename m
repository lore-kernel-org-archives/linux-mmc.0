From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Wed, 20 Jun 2012 14:58:25 +0900
Message-ID: <1340171905-12534-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

In 930f152cc9998388031af577843baae572ac8ab6 ("mmc: sh_mmcif: mmc->f_max
should be half of the bus clock") I changed the setting of mmc->f_max from
the bus clock to half the bus clock based on the manual for the sh7372 SoC.

Inspection of sh_mmcif_clock_control() reveals that it relies on
mmc->f_max being set to the bus speed in order to enable the supplementary
clock, a feature that does not exist on the sh7372.

Armed with this information implement the following heuristic for setting
mmc->f_max:

* Use bus clock if the supplementary clock feature is present
  - Assumed to work on the sh7757lcr board, the only board present
    in the tree which has the feature.
* Use half the bus clock otherwise
  - As per the documentation for the sh7372 SoC.

Reported-by: Magnus Damm <damm@opensource.se>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Regression information:

It seems likely that this resolves a regression for the sh7757lcr which was
introduced by 930f152cc9998388031af577843baae572ac8ab6 ("mmc: sh_mmcif:
mmc->f_max should be half of the bus clock"). However, although I have the
hardware in question I am unsure how to exercise the code to test if there
is a problem or not.

930f152cc9998388031af577843baae572ac8ab6 was added between the 3.3 and 3.4.

Dependency information:

This patch is based on Guennadi Liakhovetski's recent series
"[PATCH 0/5 v4] mmc: sh_mmcif: clock and power updates". It should
be trivial to rebase it on 3.5-rc3.
---
 drivers/mmc/host/sh_mmcif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index f0f518b..dfcfe83 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -919,10 +919,11 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 {
 	int ret = clk_enable(host->hclk);
+	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 
 	if (!ret) {
 		host->clk = clk_get_rate(host->hclk);
-		host->mmc->f_max = host->clk / 2;
+		host->mmc->f_max = p->sup_pclk ? host->clk : host->clk / 2;
 		host->mmc->f_min = host->clk / 512;
 	}
 
-- 
1.7.10.2.484.gcd07cc5

