Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com [220.197.31.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBE29D273
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666005; cv=none; b=PQUje/PJ6bij/Nr2IlZfEqqzpzrOZjCTfHsdYuIZ1hbHMdhOs4TS5Y2eNcVDCAsHaLyN1ryjvkgwLIxQBNAri8yw4VZkqQsg8LDq2iX77rN8D5TGyLaCpndujuuEhUA3rz7IRPCBHa8ry+Mbi4VeFkQT5AM+kdae6y00JpXogXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666005; c=relaxed/simple;
	bh=JsF2PlrgnDOO9B2E0NvfrFnmVkYw4BDZySza3jG+X6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DP7BstTgiC/GetKdJycje9RHAKqa17biUpIgcy2HYXV5+jH+sp6Q9B7bPgbhn7B+JnAOaY4zKi7/33VdktRy3b8UmaL/ZwLqRX7xsXOczHUH5zlR3x9KBlp/EVgDtlC3hB7bso2GmG3nhc6h/1tDwH1EeG/W3yWgNUaKOvhvlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M0jMLpd/; arc=none smtp.client-ip=220.197.31.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M0jMLpd/"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c31c53;
	Tue, 6 Jan 2026 10:19:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 07/18] mmc: dw_mmc: Remove fifo_depth from struct dw_mci_board
Date: Tue,  6 Jan 2026 10:16:58 +0800
Message-Id: <1767665829-183001-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911a79d509cckunmc69ba49b79bf3e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxOQlZLQkhISR9PGU0fQhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M0jMLpd/Hsm+aDRXMBCcCx/2USFr8G5bwuMJ/plcljg94+AQTGROWMX3rBCzkf0cqpbU8ib3VdFUUDKhNFrB8xlvEunZItUDEi1gtQ/JlDbp9IHk60Foj774K78cjWKOUrYdbzlyJsg/n6bTHd2bdfp+Bfppv1M8uMnM7pnkmw8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=CDb9AoUvS8DJVwkxn+xlzSPJ9lV+0CWvtHJL7Uoo850=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci already keeps one, so remove it from struct dw_mci_board.
Now, as dw_mmc-pci still provide struct dw_mci_board, so host->fifo_depth
will not be overwritten.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-pci.c | 2 +-
 drivers/mmc/host/dw_mmc.c     | 6 +++---
 drivers/mmc/host/dw_mmc.h     | 6 ------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 24f4036..89ad499 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -28,7 +28,6 @@ static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
 	.detect_delay_ms		= 200,
-	.fifo_depth			= 32,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -48,6 +47,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->irq = pdev->irq;
 	host->irq_flags = IRQF_SHARED;
 	host->pdata = &pci_board_data;
+	host->fifo_depth = 32;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c9e8165..b48d76f9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3170,7 +3170,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (IS_ERR(host->rstc))
 		return ERR_CAST(host->rstc);
 
-	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
+	if (device_property_read_u32(dev, "fifo-depth", &host->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
@@ -3373,7 +3373,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
 	 *                          Tx Mark = fifo_size / 2 DMA Size = 8
 	 */
-	if (!host->pdata->fifo_depth) {
+	if (!host->fifo_depth) {
 		/*
 		 * Power-on value of RX_WMark is FIFO_DEPTH-1, but this may
 		 * have been overwritten by the bootloader, just like we're
@@ -3383,7 +3383,7 @@ int dw_mci_probe(struct dw_mci *host)
 		fifo_size = mci_readl(host, FIFOTH);
 		fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
 	} else {
-		fifo_size = host->pdata->fifo_depth;
+		fifo_size = host->fifo_depth;
 	}
 	host->fifo_depth = fifo_size;
 	host->fifoth_val =
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 3cac7ce..bc82d1d 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -271,12 +271,6 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-	/*
-	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
-	 * but note that this may not be reliable after a bootloader has used
-	 * it.
-	 */
-	unsigned int fifo_depth;
 
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
-- 
2.7.4

