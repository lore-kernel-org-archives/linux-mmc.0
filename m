From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 2/3] mmc: dw_mmc: add switch_voltage
Date: Thu, 14 May 2015 16:45:18 +0800
Message-ID: <1431593119-31889-3-git-send-email-zhangfei.gao@linaro.org>
References: <1431593119-31889-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431593119-31889-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Jorge A. Ramirez-Ortiz" <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dan Yuan <yuandan-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

switch_voltage is required on some platform since special register accessing

Signed-off-by: Jorge A. Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Dan Yuan <yuandan-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5f5adaf..ce66565 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1236,11 +1236,15 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 uhs;
 	u32 v18 = SDMMC_UHS_18V << slot->id;
 	int min_uv, max_uv;
 	int ret;
 
+	if (drv_data && drv_data->switch_voltage)
+		return drv_data->switch_voltage(mmc, ios);
+
 	/*
 	 * Program the voltage.  Note that some instances of dw_mmc may use
 	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index f45ab91..c723617 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -287,5 +287,7 @@ struct dw_mci_drv_data {
 	int		(*execute_tuning)(struct dw_mci_slot *slot);
 	int		(*prepare_hs400_tuning)(struct dw_mci *host,
 						struct mmc_ios *ios);
+	int		(*switch_voltage)(struct mmc_host *mmc,
+					  struct mmc_ios *ios);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
