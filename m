From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 02/11] mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
Date: Tue, 5 Jan 2016 18:51:30 +0800
Message-ID: <1451991099-4946-3-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the sdhci
esdhc-imx driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1f1582f..594a753 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -259,7 +259,7 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
@@ -337,7 +337,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 data;
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
@@ -387,7 +387,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u16 ret = 0;
 	u32 val;
 
@@ -447,7 +447,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 new_val = 0;
 
 	switch (reg) {
@@ -553,7 +553,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 new_val;
 	u32 mask;
 
@@ -630,7 +630,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 					 unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	unsigned int host_clock = pltfm_host->clock;
 	int pre_div = 2;
 	int div = 1;
@@ -689,7 +689,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	switch (boarddata->wp_type) {
@@ -791,7 +791,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 						unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct pinctrl_state *pinctrl;
 
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
@@ -861,7 +861,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	u32 m;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	/* disable ddr mode and disable HS400 mode */
@@ -914,7 +914,7 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
 }
@@ -922,7 +922,7 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	/* use maximum timeout counter */
 	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
@@ -1097,21 +1097,17 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
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
@@ -1238,7 +1234,7 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -1261,7 +1257,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_runtime_suspend_host(host);
@@ -1279,7 +1275,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	if (!sdhci_sdio_irq_enabled(host)) {
 		clk_prepare_enable(imx_data->clk_per);
-- 
2.6.4
