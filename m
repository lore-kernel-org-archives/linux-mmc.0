From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Fri, 22 Jun 2012 08:49:32 +0900
Message-ID: <1340322572-16024-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53205 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760623Ab2FUXty (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 19:49:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Chris Brandt <Chris.Brandt@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

In 930f152cc9998388031af577843baae572ac8ab6 ("mmc: sh_mmcif: mmc->f_max
should be half of the bus clock") I changed the setting of mmc->f_max from
the bus clock to half the bus clock based on the manual for the sh7372 SoC.

Inspection of sh_mmcif_clock_control() reveals that it relies on
mmc->f_max being set to the bus speed in order to enable the supplementary
clock, a feature that is only known to exist on the sh7757 SoC.

Armed with this information implement the following heuristic for setting
mmc->f_max:

* Use bus clock if the supplementary clock feature is present
  - Confirmed in the documentation of the sh7757 SoC.
* Use half the bus clock otherwise
  - As per the documentation for the sh7372, sh7724 and R8A7740 SoCs.

Reported-by: Magnus Damm <damm@opensource.se>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Brandt <Chris.Brandt@renesas.com>
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
 drivers/mmc/host/sh_mmcif.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 204bced..04b14d0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -450,7 +450,11 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 
 	if (!clk)
 		return;
-	if (p->sup_pclk && clk == host->clk)
+	/* clk == host->clk implies that p->sup_pclk is non-zero
+	 * as otherwise the maximum value of clk is host->clk / 2
+	 * as per the value of host->mmc->f_max
+	 */
+	if (clk == host->clk)
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
 	else
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
@@ -913,10 +917,11 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
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

