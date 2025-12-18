Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412828134F
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067760; cv=none; b=n/N/FTlUMiZcebSMWkO+wJAWbNen1HoL1jXBDS4qIFfSigBRCuFpCu3T/UhetwDCDylq8XqdHU25z6zPEs42tjJx+0Vlk9uYpPnmpKp0xG7/qBvVly5t/ooELHOly/N9XftCRDyBvotqVhQGL0NdJvsPgkrRQiZpHsNbkewO3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067760; c=relaxed/simple;
	bh=Pl4E8ccCPR0l1mDlkFLWVGiekcFR1yfgw4TfY5IAMAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DgpGkw8zBuCXu4VUcwXlf8fpclaChpfOzC63CKRd7Gs+YSRk6EKKD0OYBVSGGC+l7i+WtEyPmh8WhUj7+u/KyfGXDm2cfKneiulHlyaSu9t7BhZC2dA9PPBZxZ4OlWFAvJjXzzscFUZ4LSWlBjGpO0UMscESiiJGlIylDyfh9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DTIEuGLB; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DTIEuGLB"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb4ab;
	Thu, 18 Dec 2025 22:07:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 17/18] mmc: dw_mmc-pltfm: use modern PM macros
Date: Thu, 18 Dec 2025 22:00:44 +0800
Message-Id: <1766066445-14144-18-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c9317309cckunm1f354c4b78d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5MTVYYGUhDSU1IHUhKTU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DTIEuGLBWZhKmKdVgKJvZkZpP7aof6BrMZviqxekQnegI3YYy8Ii8uXc03HLDKdPOj43IYUOHdcHcBRMnYhvQGBxnZFZo2L3OLUk/iJlpOJL+6sXDEMgfHngpOmz6PZUiGL4OZpQGLodrrWLde4e5qEZIhSyRgWp7ebwLvmU47I=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=AG/bm+pIuOM6zhmpCI7CBxuZfaVdCPgC/UlV4UE+Vw4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or CONFIG_PM_SLEEP
are disabled, without having to use #ifdef guards.

When this's done, remove all variant drivers' local pm definition and
replace it with dw_mci_pltfm_pmops.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
 drivers/mmc/host/dw_mmc-k3.c        | 7 +------
 drivers/mmc/host/dw_mmc-pci.c       | 7 +------
 drivers/mmc/host/dw_mmc-pltfm.c     | 4 ++--
 drivers/mmc/host/dw_mmc-rockchip.c  | 7 +------
 drivers/mmc/host/dw_mmc.c           | 2 --
 6 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 3cf526a..ed6dea4 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -73,7 +73,7 @@ static struct platform_driver dw_mci_bluefield_pltfm_driver = {
 		.name		= "dwmmc_bluefield",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_bluefield_match,
-		.pm		= &dw_mci_pltfm_pmops,
+		.pm		= pm_ptr(&dw_mci_pltfm_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 4c313fc..6836710 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -453,11 +453,6 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-static const struct dev_pm_ops dw_mci_k3_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
-};
-
 static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.probe		= dw_mci_k3_probe,
 	.remove		= dw_mci_pltfm_remove,
@@ -465,7 +460,7 @@ static struct platform_driver dw_mci_k3_pltfm_driver = {
 		.name		= "dwmmc_k3",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_k3_match,
-		.pm		= pm_ptr(&dw_mci_k3_dev_pm_ops),
+		.pm		= pm_ptr(&dw_mci_pltfm_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 096f5b5..a81bbd0 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -72,11 +72,6 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 	dw_mci_remove(host);
 }
 
-static const struct dev_pm_ops dw_mci_pci_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
-};
-
 static const struct pci_device_id dw_mci_pci_id[] = {
 	{ PCI_DEVICE(SYNOPSYS_DW_MCI_VENDOR_ID, SYNOPSYS_DW_MCI_DEVICE_ID) },
 	{}
@@ -89,7 +84,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   pm_ptr(&dw_mci_pci_dev_pm_ops),
+		.pm =   pm_ptr(&dw_mci_pltfm_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index a927f5ba..bc76b0d 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -58,9 +58,9 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
 const struct dev_pm_ops dw_mci_pltfm_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend,
 			   dw_mci_runtime_resume,
 			   NULL)
 };
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 879188f..c75bb5d1 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -573,11 +573,6 @@ static void dw_mci_rockchip_remove(struct platform_device *pdev)
 	dw_mci_pltfm_remove(pdev);
 }
 
-static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
-};
-
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
 	.remove		= dw_mci_rockchip_remove,
@@ -585,7 +580,7 @@ static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 		.name		= "dwmmc_rockchip",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= pm_ptr(&dw_mci_rockchip_dev_pm_ops),
+		.pm		= pm_ptr(&dw_mci_pltfm_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9ba12e0..d2b895b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3435,7 +3435,6 @@ void dw_mci_remove(struct dw_mci *host)
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-#ifdef CONFIG_PM
 int dw_mci_runtime_suspend(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
@@ -3524,7 +3523,6 @@ int dw_mci_runtime_resume(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
-#endif /* CONFIG_PM */
 
 static int __init dw_mci_init(void)
 {
-- 
2.7.4

