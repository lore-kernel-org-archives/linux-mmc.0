Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341D13A3ED
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668401; cv=none; b=QyH6pK9WmkRNJRuArohUhEzhrbQ1QSN1StbrajzB7jlJxtwovieYYwxD9IIbYMEndJ1G+d57lCaHL4Yvoo+k9hxshqO99abh1lxpT4tkyBbaKtwNyXq5aS2NURVPlilFmUkRrmU0q9McRgNYGpwgKcoCx6HNEPA4IpNEQl+PgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668401; c=relaxed/simple;
	bh=5Osr5IubXjUDIidkGbSTooRvnXXBvzxhqOyEqjWA46U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fnWMUnk9hGX5bIUBXatr5sUIGc93aoNaxTPi4j3GFEG3eH+tSryqHg5QxIadF4GgNsK1Fhkzg1MnJICz/n8jHXIAzlCsrx9pzcoo57AZE7BsVHfmCt6sEsev42M6EDaa30ornAi6Kg7IxFR1AFxM5d+NM4AwTaq+cNY1iIkjdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DWi+Xvp6; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DWi+Xvp6"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c65017;
	Tue, 6 Jan 2026 10:24:25 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 16/18] mmc: dw_mmc-pci: Use BAR_2 and pcim_iomap_region()
Date: Tue,  6 Jan 2026 10:17:07 +0800
Message-Id: <1767665829-183001-17-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911eae6709cckunmc69ba49b79d076
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1IHlZCSU8YSUMZGEkdGB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DWi+Xvp6kgioR/GKnQXvf6D2X5W5wSdw63kAAXX9xtFuubNQn4zS1vNl5Jh/GNQc8etXwlnLVAzQeiM/TgUaFOAyoJIexRPALsTcQI7/rFd9PojJhrFU+9/Z7IFVuud8hg2LK3Q+ocomvpmqMc2xG38SBHufMmJ1STS6Ph8hV6A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=pIBWDrMZwwYoWs7PFAYL4VJbwPVBfOf/m9xCBvcKdao=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

PCIe endpoint framework defines standard BAR enum for EP drivers
to use, so remove PCI_BAR_NO here.

Then, pcim_iomap_regions has been deprecated for a long time, replace
it with pcim_iomap_region();

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index c82c23e..66d2edc 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -10,13 +10,13 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/pci-epf.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include "dw_mmc.h"
 
-#define PCI_BAR_NO 2
 #define SYNOPSYS_DW_MCI_VENDOR_ID 0x700
 #define SYNOPSYS_DW_MCI_DEVICE_ID 0x1107
 /* Defining the Capabilities */
@@ -49,11 +49,9 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->bus_hz = 33 * 1000 * 1000;
 	host->drv_data = &pci_drv_data;
 
-	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
-	if (ret)
-		return ret;
-
-	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
+	host->regs = pcim_iomap_region(pdev, BAR_2, pci_name(pdev));
+	if (IS_ERR(host->regs))
+		return PTR_ERR(host->regs);
 
 	pci_set_master(pdev);
 
-- 
2.7.4

