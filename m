From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] Convert dw_mci_pltfm_prepare_command into a library
 call
Date: Wed, 20 Jan 2016 17:26:36 +0900
Message-ID: <569F44BC.4010205@samsung.com>
References: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60637 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcATI0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 03:26:44 -0500
In-reply-to: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Shawn.

On 01/19/2016 12:39 PM, Shawn Lin wrote:
> This patchset expose dw_mci_pltfm_prepare_command towards to
> library call and remove the redundant code from dw_mmc-rockchip.
> Meanwhile we make dw_mmc-exynos to call it instead of changing cmdr
> in its variant drivers.
> 

Actually, I want to remove  *_prepare_command from entire dw-mmc driver.
Since exynos used USE_HOLD_REG bit in case of special condition, maybe you doesn't remove all, right?

I'm figuring out the using the generic solution.
Before that, how about this? I want to know your opinion.

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3a7e835..ed08e4b 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -145,6 +145,16 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 		mci_writel(host, CLKSEL64, clksel);
 	else
 		mci_writel(host, CLKSEL, clksel);
+
+	/*
+	 * Exynos4412 and Exynos5250 extends the use of CMD register with the
+	 * use of bit 29 (which is reserved on standard MSHC controllers) for
+	 * optionally bypassing the HOLD register for command and data. The
+	 * HOLD register should be bypassed in case there is no phase shift
+	 * applied on CMD/DATA that is sent to the card.
+	 */
+	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel))
+		host->no_use_hold = 1;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -202,26 +212,6 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 #define dw_mci_exynos_resume_noirq	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	struct dw_mci_exynos_priv_data *priv = host->priv;
-	/*
-	 * Exynos4412 and Exynos5250 extends the use of CMD register with the
-	 * use of bit 29 (which is reserved on standard MSHC controllers) for
-	 * optionally bypassing the HOLD register for command and data. The
-	 * HOLD register should be bypassed in case there is no phase shift
-	 * applied on CMD/DATA that is sent to the card.
-	 */
-	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
-		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
-		if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL64)))
-			*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-	 } else {
-		if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
-			*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-	}
-}
-
 static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
@@ -500,7 +490,6 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
 	.init			= dw_mci_exynos_priv_init,
 	.setup_clock		= dw_mci_exynos_setup_clock,
-	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 81bdeeb..c0bb0c7 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -26,19 +26,6 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
-static const struct dw_mci_drv_data socfpga_drv_data = {
-	.prepare_command	= dw_mci_pltfm_prepare_command,
-};
-
-static const struct dw_mci_drv_data pistachio_drv_data = {
-	.prepare_command	= dw_mci_pltfm_prepare_command,
-};
-
 int dw_mci_pltfm_register(struct platform_device *pdev,
 			  const struct dw_mci_drv_data *drv_data)
 {
@@ -94,10 +81,8 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
-	{ .compatible = "altr,socfpga-dw-mshc",
-		.data = &socfpga_drv_data },
-	{ .compatible = "img,pistachio-dw-mshc",
-		.data = &pistachio_drv_data },
+	{ .compatible = "altr,socfpga-dw-mshc", },
+	{ .compatible = "img,pistachio-dw-mshc", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d9c92f3..84e50f3 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -26,11 +26,6 @@ struct dw_mci_rockchip_priv_data {
 	int			default_sample_phase;
 };
 
-static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
 static int dw_mci_rk3288_setup_clock(struct dw_mci *host)
 {
 	host->bus_hz /= RK3288_CLKGEN_DIV;
@@ -240,12 +235,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 }
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
-	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ffef24a..844f8cf 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -234,7 +234,6 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	struct mmc_data	*data;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
-	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 cmdr;
 
 	cmd->error = -EINPROGRESS;
@@ -296,8 +295,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
 
-	if (drv_data && drv_data->prepare_command)
-		drv_data->prepare_command(slot->host, &cmdr);
+	if (!host->no_use_hold)
+		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
 }
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index a14b7fc..c0fc0e3 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -277,7 +277,6 @@ struct dw_mci_slot {
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @init: early implementation specific initialization.
  * @setup_clock: implementation specific clock configuration.
- * @prepare_command: handle CMD register extensions.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
@@ -290,7 +289,6 @@ struct dw_mci_drv_data {
 	unsigned long	*caps;
 	int		(*init)(struct dw_mci *host);
 	int		(*setup_clock)(struct dw_mci *host);
-	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
 	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 89df7ab..7b1416a 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -221,6 +221,8 @@ struct dw_mci {
 
 	struct timer_list       cmd11_timer;
 	struct timer_list       dto_timer;
+
+	int			no_use_hold;
 };
 
 /* DMA ops for Internal/External DMAC interface */
> 
> 
> Shawn Lin (3):
>   mmc: dw_mmc: expose dw_mci_pltfm_prepare_command
>   mmc: dw_mmc-rockchip: remove prepare_command hook
>   mmc: dw_mmc-exynos: wrapper prepare_command
> 
>  drivers/mmc/host/dw_mmc-exynos.c   | 4 ++--
>  drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
>  drivers/mmc/host/dw_mmc-pltfm.h    | 2 +-
>  drivers/mmc/host/dw_mmc-rockchip.c | 9 ++-------
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 

