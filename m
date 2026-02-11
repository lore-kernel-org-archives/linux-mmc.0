Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com [220.197.31.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6A1427A;
	Wed, 11 Feb 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818457; cv=none; b=WRz7Hfifn2irSKuV2CrgjoWahWQwn9Hfn+eUoFs/EADnkGWm+XSr90S+8oQ0DBgsqc9id1rF6Y2qTRz7MWtzvkS+5bpey3E58JmzZShAV+Jbxm3MmvdiJn0GVIBVMRkDLCl3MVbS0eYopOSiwlEkdE7iivvnfWFDvmE9ka4dEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818457; c=relaxed/simple;
	bh=1ekG5mr2l6gHFIqX7DKaPi86FQuEJTMgWOOwYF/1hgk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eXUhtqQ597ZBacNlk97YDZN43JDf7cbD1X4n4pjf9mEcfgWOPWRrD1nohVmtMql/BYdyH9NzK5pe99rqDVyNZtKvdD4vkd9/1IOmlUC72oaXzcZB1Otz7tkHb8zLCWVGGftetfC/raWiGIKOqti5DwcqgxcQObqr3AiJ93U2/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UAH4YydS; arc=none smtp.client-ip=220.197.31.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UAH4YydS"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33e086569;
	Wed, 11 Feb 2026 22:00:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: Rename dw_mci_pltfm_pmops to dw_mci_pmops
Date: Wed, 11 Feb 2026 22:00:34 +0800
Message-Id: <1770818434-31096-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9c4d01184809cckunm8546a91b110f11
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0odT1YaSUgYQx4fSUMZTE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UAH4YydS0MO5cTJkm9JHkOfVYGbVus2gPdeFbyDqkAdZvAT7lHl96iexeHPy7Ys+UEedtVd5ixXLMJcwmqcbv04xJRxgka/QHtBgGxIq5NC1OXtMwVCdalhwZBxk2kqQa/BG4p6E4T7GrruFoszvIJ4qF8chKqzfTuDRXI/zglU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=eU9dLHG9KP47iVCYkNA5soQbPeIcSPZz7SLO8+PmEQc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Since it's moved to dw_mmc core and resued by others variant host
drivers, so drop the pltfm notation.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org> 
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
 drivers/mmc/host/dw_mmc-k3.c        | 2 +-
 drivers/mmc/host/dw_mmc-pci.c       | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c     | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.h     | 2 +-
 drivers/mmc/host/dw_mmc.c           | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index ed6dea4..81dc072 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -73,7 +73,7 @@ static struct platform_driver dw_mci_bluefield_pltfm_driver = {
 		.name		= "dwmmc_bluefield",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_bluefield_match,
-		.pm		= pm_ptr(&dw_mci_pltfm_pmops),
+		.pm		= pm_ptr(&dw_mci_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 8b1b4cf..59b802c 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -455,7 +455,7 @@ static struct platform_driver dw_mci_k3_pltfm_driver = {
 		.name		= "dwmmc_k3",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_k3_match,
-		.pm		= pm_ptr(&dw_mci_pltfm_pmops),
+		.pm		= pm_ptr(&dw_mci_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index e046674..a2e1b4d 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -84,7 +84,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   pm_ptr(&dw_mci_pltfm_pmops),
+		.pm =   pm_ptr(&dw_mci_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 079d0cc..68770aa 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -125,7 +125,7 @@ static struct platform_driver dw_mci_pltfm_driver = {
 		.name		= "dw_mmc",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_pltfm_match,
-		.pm		= &dw_mci_pltfm_pmops,
+		.pm		= pm_ptr(&dw_mci_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index 64cf752..ef1b05d 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -11,6 +11,6 @@
 extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
 extern void dw_mci_pltfm_remove(struct platform_device *pdev);
-extern const struct dev_pm_ops dw_mci_pltfm_pmops;
+extern const struct dev_pm_ops dw_mci_pmops;
 
 #endif /* _DW_MMC_PLTFM_H_ */
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 97e8800..b2a6538 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3523,11 +3523,11 @@ int dw_mci_runtime_resume(struct device *dev)
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 
-const struct dev_pm_ops dw_mci_pltfm_pmops = {
+const struct dev_pm_ops dw_mci_pmops = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
+EXPORT_SYMBOL_GPL(dw_mci_pmops);
 
 static int __init dw_mci_init(void)
 {
-- 
2.7.4

