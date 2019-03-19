From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH v2] mmc: dw_mmc: Fix to avoid potential NULL pointer dereference
Date: Mon, 18 Mar 2019 20:45:51 -0500
Message-ID: <20190319014551.16559-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

of_match_node can fail and return NULL in case no matching structure.
The patches checks for such a scenario and returns -ENXIO.

---
V1: Added files dw_mmc-zx.c and dw_mmc-rockchip.c

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mmc/host/dw_mmc-exynos.c   | 2 ++
 drivers/mmc/host/dw_mmc-k3.c       | 2 ++
 drivers/mmc/host/dw_mmc-pltfm.c    | 2 ++
 drivers/mmc/host/dw_mmc-rockchip.c | 2 ++
 drivers/mmc/host/dw_mmc-zx.c       | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index d46c3439b508..8a75d7314606 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	int ret;
 
 	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..cc50b7546a20 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 58c13e21bd5a..b1948989f617 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
+		if (!match)
+			return -ENXIO;
 		drv_data = match->data;
 	}
 
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c86a800a8fd..20e3471260ea 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -344,6 +344,8 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
index c06b5393312f..abea35431045 100644
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -213,6 +213,8 @@ static int dw_mci_zx_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_zx_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
-- 
2.17.1
