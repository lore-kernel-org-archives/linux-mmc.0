From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/11] mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
Date: Tue, 5 Jan 2016 18:51:37 +0800
Message-ID: <1451991099-4946-10-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-tegra
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ad28b49..25d0c08 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -54,7 +54,7 @@ struct sdhci_tegra {
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 
 	if (unlikely((soc_data->nvquirks & NVQUIRK_FORCE_SDHCI_SPEC_200) &&
@@ -90,7 +90,7 @@ static void tegra_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 
 	/* Seems like we're getting spurious timeout and crc errors, so
@@ -122,7 +122,7 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	u32 misc_ctrl;
 
@@ -260,19 +260,13 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	soc_data = match->data;
 
-	host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
+	host = sdhci_pltfm_init(pdev, soc_data->pdata,
+				sizeof(*tegra_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 	pltfm_host = sdhci_priv(host);
-
-	tegra_host = devm_kzalloc(&pdev->dev, sizeof(*tegra_host), GFP_KERNEL);
-	if (!tegra_host) {
-		dev_err(mmc_dev(host->mmc), "failed to allocate tegra_host\n");
-		rc = -ENOMEM;
-		goto err_alloc_tegra_host;
-	}
+	tegra_host = sdhci_pltfm_priv(pltfm_host);
 	tegra_host->soc_data = soc_data;
-	pltfm_host->priv = tegra_host;
 
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
@@ -305,7 +299,6 @@ err_add_host:
 err_clk_get:
 err_power_req:
 err_parse_dt:
-err_alloc_tegra_host:
 	sdhci_pltfm_free(pdev);
 	return rc;
 }
-- 
2.6.4
