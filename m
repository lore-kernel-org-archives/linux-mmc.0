From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc-pltfm: fix the potential NULL pointer dereference
Date: Fri, 21 Oct 2016 19:57:57 +0900
Message-ID: <20161021105757.22712-1-jh80.chung@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, stable@vger.kernel.org, gregkh@linuxfoundation.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

platform_get_resource can be returned the NULL pointer.
Then regs->start should be referred to NULL Pointer.
devm_ioremap_resource() checks whether res is NULL or not.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index b486fef..1236d49b 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -47,12 +47,13 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->pdata = pdev->dev.platform_data;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	/* Get registers' physical base address */
-	host->phy_regs = regs->start;
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
 
+	/* Get registers' physical base address */
+	host->phy_regs = regs->start;
+
 	platform_set_drvdata(pdev, host);
 	return dw_mci_probe(host);
 }
-- 
2.10.1
