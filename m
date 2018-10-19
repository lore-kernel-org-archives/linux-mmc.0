From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v1 1/1] mmc: dw_mmc-bluefield: simplify the probe() function
Date: Fri, 19 Oct 2018 10:26:14 -0400
Message-ID: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, David Woods <dwoods@mellanox.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This commit removes the unnecessary of-node check since the
dw_mci_bluefield_match[] structure has only one entry.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 54c3fbb..ed8f225 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -52,16 +52,7 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 static int dw_mci_bluefield_probe(struct platform_device *pdev)
 {
-	const struct dw_mci_drv_data *drv_data = NULL;
-	const struct of_device_id *match;
-
-	if (pdev->dev.of_node) {
-		match = of_match_node(dw_mci_bluefield_match,
-				      pdev->dev.of_node);
-		drv_data = match->data;
-	}
-
-	return dw_mci_pltfm_register(pdev, drv_data);
+	return dw_mci_pltfm_register(pdev, &bluefield_drv_data);
 }
 
 static struct platform_driver dw_mci_bluefield_pltfm_driver = {
-- 
1.8.3.1
