From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V2 3/4] mmc: dw_mmc: move the platform specific init call
Date: Fri, 23 Aug 2013 16:45:08 +0530
Message-ID: <1377256509-18922-4-git-send-email-yuvaraj.cd@samsung.com>
References: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, alim.akhtar@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Current platform specific private data initialisation call
dw_mci_exynos_priv_init can be used to do platform specific
initialisation of SMU and others in future.So the drv_data->init
call has moved to dw_mci_probe.

changes since V1: none

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    7 -------
 drivers/mmc/host/dw_mmc.c       |    9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ee52556..a570da4 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -38,7 +38,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 {
 	struct dw_mci *host;
 	struct resource	*regs;
-	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
 	if (!host)
@@ -58,12 +57,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
 
-	if (drv_data && drv_data->init) {
-		ret = drv_data->init(host);
-		if (ret)
-			return ret;
-	}
-
 	platform_set_drvdata(pdev, host);
 	return dw_mci_probe(host);
 }
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..0c0cada 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2222,6 +2222,15 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	if (drv_data && drv_data->init) {
+		ret = drv_data->init(host);
+		if (ret) {
+			dev_err(host->dev,
+				"implementation specific init failed\n");
+			goto err_clk_ciu;
+		}
+	}
+
 	if (drv_data && drv_data->setup_clock) {
 		ret = drv_data->setup_clock(host);
 		if (ret) {
-- 
1.7.9.5
