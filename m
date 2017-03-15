From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 06/14] mmc: dw_mmc: simplify optional reset handling
Date: Wed, 15 Mar 2017 12:31:39 +0100
Message-ID: <20170315113139.17989-1-p.zabel@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47403 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753752AbdCOLbn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 07:31:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9ac0b4573131..3d62b0a1f81cb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2968,10 +2968,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	/* find reset controller when exist */
 	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
-	if (IS_ERR(pdata->rstc)) {
-		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
-			return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (IS_ERR(pdata->rstc))
+		return ERR_CAST(pdata->rstc);
 
 	/* find out number of slots supported */
 	of_property_read_u32(np, "num-slots", &pdata->num_slots);
@@ -3100,7 +3098,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!IS_ERR(host->pdata->rstc)) {
+	if (host->pdata->rstc) {
 		reset_control_assert(host->pdata->rstc);
 		usleep_range(10, 50);
 		reset_control_deassert(host->pdata->rstc);
@@ -3257,8 +3255,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
@@ -3290,8 +3287,7 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
-- 
2.11.0

