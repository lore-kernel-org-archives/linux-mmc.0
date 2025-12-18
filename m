Received: from mail-m1973195.qiye.163.com (mail-m1973195.qiye.163.com [220.197.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CE33A6EE
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066933; cv=none; b=cFAX5esS3CvwZSYQJG+26Y3945Zwk4M3dTVMIcs+c0runFGRh74iSBD4nyoQdy/SnmZZAJTnx1BF0NoloVAhNw71jMJGqcUSUf+IA0TUWjRPDjglIQ5WwjUpA7iQyZyt0YzRpLhJ6viMkhN1MdocW7kOTg1xq50opcCiCOasAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066933; c=relaxed/simple;
	bh=S37bgVkLfiwnFb5MPN29VqbHFJoAKTnO/0I3AJpES4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hf/0OWTQeRwlpSfugpakkyjqFHRMIJkSwQ/iZiZiRJcXstyU+GS1aW1AJe98ZczPxDK7xgz3KGoDqe3n/usOUYKllzsUygzDAv7B7qShJydDk6kbHWGPxihr7Q+hHs2upJnz8m9xV48dvNsXSJ6VZptG17PnwIUX6Q1CCEPQgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Y97ML2on; arc=none smtp.client-ip=220.197.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y97ML2on"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb35a;
	Thu, 18 Dec 2025 22:03:36 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 07/18] mmc: dw_mmc: Remove fifo_depth from struct dw_mci_board
Date: Thu, 18 Dec 2025 22:00:34 +0800
Message-Id: <1766066445-14144-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c5f90f09cckunm1f354c4b742e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1OGFYaHUgYT0MZHUhLSRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y97ML2onyblg2AWQbKt00q/4uhwH7BvpuOJhmt/+MA+asHGK8CzSAWtNq3CdKDQrHfypywWV3ps3aInUx0dnFDjSJlztNiU95iww9K6DZjRyuZOjUPB2kuu9lB9u8p7fkMdyNgMpAxzLypc9elHf9P1KjYtR7di/eeWGL2wVLU4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=d6osbAhulOriDsYpLmc6wI9YH/C7vL555dH4dhmyAcM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci already keep one, so remove it from struct dw_mci_board.
Now, as dw_mmc-pci still provide struct dw_mci_board, so host->fifo_depth
will not be overwritten.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pci.c | 2 +-
 drivers/mmc/host/dw_mmc.c     | 6 +++---
 drivers/mmc/host/dw_mmc.h     | 6 ------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 092cc99..f5ef872 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -28,7 +28,6 @@ static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
 	.detect_delay_ms		= 200,
-	.fifo_depth			= 32,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -49,6 +48,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->irq_flags = IRQF_SHARED;
 	host->dev = &pdev->dev;
 	host->pdata = &pci_board_data;
+	host->fifo_depth = 32;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 133da87..84e1b07 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3182,7 +3182,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (IS_ERR(host->rstc))
 		return ERR_CAST(host->rstc);
 
-	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
+	if (device_property_read_u32(dev, "fifo-depth", &host->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
@@ -3369,7 +3369,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
 	 *                          Tx Mark = fifo_size / 2 DMA Size = 8
 	 */
-	if (!host->pdata->fifo_depth) {
+	if (!host->fifo_depth) {
 		/*
 		 * Power-on value of RX_WMark is FIFO_DEPTH-1, but this may
 		 * have been overwritten by the bootloader, just like we're
@@ -3379,7 +3379,7 @@ int dw_mci_probe(struct dw_mci *host)
 		fifo_size = mci_readl(host, FIFOTH);
 		fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
 	} else {
-		fifo_size = host->pdata->fifo_depth;
+		fifo_size = host->fifo_depth;
 	}
 	host->fifo_depth = fifo_size;
 	host->fifoth_val =
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 96fe923..dd4a8b0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -270,12 +270,6 @@ struct dw_mci_board {
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

