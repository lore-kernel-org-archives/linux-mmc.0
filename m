Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202425A640
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066822; cv=none; b=e6A5CoFipkLCayC6ze1PvU0TL20UkhUst0wauBPbDKRMpcyRquq3/Cp8DUkUwUL280Dya+lL7CJylkdr5zOmfB/fq2e89JHLTqbOFKlUZUyVJ2DrfUvPEMc1WD3Ba6cCI5mGw8TrdwaDKZlJ7nbS76MthmM3Sx0b/L2RQfebrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066822; c=relaxed/simple;
	bh=y/9jSmUPWoB6Pg/lLP93spxgs3GgF0mq0hpbLP9/roY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cxTYNIpr++edt6Hw5exp5oMFWcB45S7l8XpFp74s1fLiKOiTeLhNNrDxjjqk6A5hzte5TnYNmCwr1hw4OSZ+LLvRWjKbzroqlZjfxeKSmdAjxs1o0v0A8yP/o6kIoNG47uxPxE/TiufRivbfBcbMLTZUeYBEmdsQiMWZnFV3JXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Zlq1QX1U; arc=none smtp.client-ip=45.254.49.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zlq1QX1U"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb498;
	Thu, 18 Dec 2025 22:06:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 16/18] mmc: dw_mmc-pci: Use BAR_2 and pcim_iomap_region()
Date: Thu, 18 Dec 2025 22:00:43 +0800
Message-Id: <1766066445-14144-17-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c8ed5809cckunm1f354c4b7886
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pKSFYZGkNKH0odTEseTxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Zlq1QX1Ut4Wc9ii8EhBAqWxPVCe0VpE+aj6JFE1yt//hyzvAo/V6JO7uTbEPPrEXpV1SnsfGIsYcohbDJE+pY95GGs963b2Ch6zNcSLqNb5Ntd5brGSepaQLe+P7EylUilf64i8BaqHJ5ph6Yg8RkQap0VIUOzMGdPm0QyfbXo0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xySTpWMRodOIl9kkXoWAcGfZnXCh5zVUzTcSDJbC2xw=;
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

 drivers/mmc/host/dw_mmc-pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index a0c788b..096f5b5 100644
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
@@ -50,11 +50,9 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
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

