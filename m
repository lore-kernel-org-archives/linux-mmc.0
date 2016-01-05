From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 06/11] mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
Date: Tue, 5 Jan 2016 18:51:34 +0800
Message-ID: <1451991099-4946-7-git-send-email-jszhang@marvell.com>
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
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
sdhci-of-esdhc driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 90e94a0..2fb8314 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -49,7 +49,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 				     int spec_reg, u32 value)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_esdhc *esdhc = pltfm_host->priv;
+	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	u32 ret;
 
 	/*
@@ -354,7 +354,7 @@ static void esdhc_le_writeb(struct sdhci_host *host, u8 val, int reg)
 static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_esdhc *esdhc = pltfm_host->priv;
+	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	bool applicable;
 	dma_addr_t dmastart;
 	dma_addr_t dmanow;
@@ -404,7 +404,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_esdhc *esdhc = pltfm_host->priv;
+	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	int pre_div = 1;
 	int div = 1;
 	u32 temp;
@@ -569,15 +569,12 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	u16 host_ver;
 
 	pltfm_host = sdhci_priv(host);
-	esdhc = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_esdhc),
-			     GFP_KERNEL);
+	esdhc = sdhci_pltfm_priv(pltfm_host);
 
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
 	esdhc->spec_ver = host_ver & SDHCI_SPEC_VER_MASK;
-
-	pltfm_host->priv = esdhc;
 }
 
 static int sdhci_esdhc_probe(struct platform_device *pdev)
@@ -589,9 +586,11 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 
 	if (of_get_property(np, "little-endian", NULL))
-		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_le_pdata, 0);
+		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_le_pdata,
+					sizeof(struct sdhci_esdhc));
 	else
-		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_be_pdata, 0);
+		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_be_pdata,
+					sizeof(struct sdhci_esdhc));
 
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
2.6.4
