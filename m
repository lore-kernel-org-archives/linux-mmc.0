Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B93A1E92
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666632; cv=none; b=WdtBBviMCxIBxAPbLnH4LwgEu+NNwg421azX401aBQDXUu0ah/0A2YZCxbhGhrn+BG4qAuq9C4fqxUmdnJ2TSqv49WTEFlf+DYTnNCK35jirbEsAtWDCFKow/Fh8mWqc1L+qTJ7GHeNtvud3hY3hhADAUO6aR5u4K7UjE4blFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666632; c=relaxed/simple;
	bh=5zm0j4E4hIV9WfQU0gWZmO1BZ9P9HrxF1vCHtRKLmm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U+RoKff7KHqFUouFrpwNHUitrZA0n+2DgjWQylHYZ5b6hQX0QdtmoQo1u84gw+8o7XzLeQhPHuORqhgLmZyK1i2TkJWU2ukO8r30EtMbNPgNwfUcBW+N8nmR5UR3a2w/h6f5GKovRsfx3Sdl+jJTpKZabmB4iHncVHZQQ5oNdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Pp8Qn2G5; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pp8Qn2G5"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c6515b;
	Tue, 6 Jan 2026 10:25:15 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 17/18] mmc: dw_mmc-pltfm: use modern PM macros
Date: Tue,  6 Jan 2026 10:17:08 +0800
Message-Id: <1767665829-183001-18-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911f70af09cckunmc69ba49b79d367
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpJQ1YYT0sYQ0gYHUJDSB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Pp8Qn2G5meW78WI5tJIA5UHZnFFGvn3ERtrdJ1sSlUhUotkMFQ87qzYC5glFaDbyK945AAYMgcOCSSZfQtGbBnqN9YtKkINhig0gQdyX/Yuo3KfYNX5GK7IP7BA47WTL608snohlGwvQT7cXMTgkMBr4JB/C9nqVv0ras5Bkw3c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=koJLL3SeI/hZJaWSPUXWm9Dj6xly/0VhtTVXZnIiLJ0=;
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

Changes in v2:
- fix compile error

 drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
 drivers/mmc/host/dw_mmc-k3.c        | 7 +------
 drivers/mmc/host/dw_mmc-pci.c       | 8 ++------
 drivers/mmc/host/dw_mmc-pltfm.c     | 4 ++--
 drivers/mmc/host/dw_mmc-rockchip.c  | 7 +------
 drivers/mmc/host/dw_mmc.c           | 2 --
 drivers/mmc/host/dw_mmc.h           | 5 -----
 7 files changed, 7 insertions(+), 28 deletions(-)

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
index 66d2edc..e046674 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
 
 #define SYNOPSYS_DW_MCI_VENDOR_ID 0x700
 #define SYNOPSYS_DW_MCI_DEVICE_ID 0x1107
@@ -71,11 +72,6 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
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
@@ -88,7 +84,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   pm_ptr(&dw_mci_pci_dev_pm_ops),
+		.pm =   pm_ptr(&dw_mci_pltfm_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index c7d7273..fde465a 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -57,9 +57,9 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
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
index fdc9dd7..f599205 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3438,7 +3438,6 @@ void dw_mci_remove(struct dw_mci *host)
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
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index a4d5f4f..9a27d77 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -497,13 +497,8 @@ static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
 extern struct dw_mci *dw_mci_alloc_host(struct device *device);
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
-#ifdef CONFIG_PM
 extern int dw_mci_runtime_suspend(struct device *device);
 extern int dw_mci_runtime_resume(struct device *device);
-#else
-static inline int dw_mci_runtime_suspend(struct device *device) { return -EOPNOTSUPP; }
-static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTSUPP; }
-#endif
 
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
-- 
2.7.4

