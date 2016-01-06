From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 02/12] mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
Date: Wed, 6 Jan 2016 18:31:33 +0800
Message-ID: <1452076303-1960-3-git-send-email-jszhang@marvell.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452076303-1960-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the sdhci
esdhc-imx driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f25f292..2d300d8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -260,7 +260,7 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
@@ -338,7 +338,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 data;
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
@@ -388,7 +388,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u16 ret = 0;
 	u32 val;
 
@@ -448,7 +448,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 new_val = 0;
 
 	switch (reg) {
@@ -556,7 +556,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 new_val;
 	u32 mask;
 
@@ -633,7 +633,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 					 unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	unsigned int host_clock = pltfm_host->clock;
 	int pre_div = 2;
 	int div = 1;
@@ -692,7 +692,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	switch (boarddata->wp_type) {
@@ -794,7 +794,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 						unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct pinctrl_state *pinctrl;
 
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
@@ -864,7 +864,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	u32 m;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	/* disable ddr mode and disable HS400 mode */
@@ -917,7 +917,7 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
 }
@@ -925,7 +925,7 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	/* use maximum timeout counter */
 	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
@@ -1100,21 +1100,17 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	int err;
 	struct pltfm_imx_data *imx_data;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata,
+				sizeof(*imx_data));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
 
-	imx_data = devm_kzalloc(&pdev->dev, sizeof(*imx_data), GFP_KERNEL);
-	if (!imx_data) {
-		err = -ENOMEM;
-		goto free_sdhci;
-	}
+	imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	imx_data->socdata = of_id ? of_id->data : (struct esdhc_soc_data *)
 						  pdev->id_entry->driver_data;
-	pltfm_host->priv = imx_data;
 
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
@@ -1241,7 +1237,7 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -1264,7 +1260,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_runtime_suspend_host(host);
@@ -1282,7 +1278,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	if (!sdhci_sdio_irq_enabled(host)) {
 		clk_prepare_enable(imx_data->clk_per);
-- 
2.7.0.rc3
