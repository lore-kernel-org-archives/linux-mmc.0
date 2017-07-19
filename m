From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 038/102] mmc: dw_mmc: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:42 +0200
Message-ID: <20170719152646.25903-39-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9dfb26972f21..7c1e2dbc76776 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2950,7 +2950,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		return ERR_PTR(-ENOMEM);
 
 	/* find reset controller when exist */
-	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
+	pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
 	if (IS_ERR(pdata->rstc)) {
 		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
 			return ERR_PTR(-EPROBE_DEFER);
-- 
2.11.0
