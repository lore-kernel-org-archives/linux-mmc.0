From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] mmc: dw_mmc: remove setup_clock callback
Date: Thu, 28 Jan 2016 09:31:19 +0800
Message-ID: <1453944679-16981-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Now, no dw_mmc variant drivers use this callback, let's
remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 9 ---------
 drivers/mmc/host/dw_mmc.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1d27a2b..ee13374 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3003,15 +3003,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (drv_data && drv_data->setup_clock) {
-		ret = drv_data->setup_clock(host);
-		if (ret) {
-			dev_err(host->dev,
-				"implementation specific clock setup failed\n");
-			goto err_clk_ciu;
-		}
-	}
-
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 1a9492e..bfc2a4d 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -286,7 +286,6 @@ struct dw_mci_slot {
 struct dw_mci_drv_data {
 	unsigned long	*caps;
 	int		(*init)(struct dw_mci *host, bool setup_clk);
-	int		(*setup_clock)(struct dw_mci *host);
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-- 
2.3.7
