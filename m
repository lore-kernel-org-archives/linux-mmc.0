Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82B34B187
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066652; cv=none; b=qIZ3kSc7fGAqEwMCTHBYqwfwHsN7+ApWgBV3qARjUj1fucjKUwcQM6eL5gHZITY6WgL5HB4dDi+LHLZpHM3XBPMbdO1Z+2VIww6DsEBrrYLC9WHlZCnQW9JuM7PbepiHFQ0sL3evYgRe5/xK2L9WV+JmKSGO1JtXTDRpeum9uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066652; c=relaxed/simple;
	bh=CLinNiA64N061iFa27so9nAxejotz8hBJXQJnrABJDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GOyXfY+uwaYqtI7lFRycJOQCpFGnQP7+m67/zhtTnqo4qzYiEzK39VSW2pKMQGzoNDQQCP9dpzDqCUvuUzieC/TMPoNuDqrYHCqv7qC5sdikXThHyPzpzhhFK3CH1Ytzar0hmGAoz5ecGpIBCmlFErzV1iHLSYM7pcR4TKpYv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Y8XXSct3; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y8XXSct3"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb37d;
	Thu, 18 Dec 2025 22:04:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 08/18] mmc: dw_mmc: Move detect_delay_ms from struct dw_mci_board to struct dw_mci
Date: Thu, 18 Dec 2025 22:00:35 +0800
Message-Id: <1766066445-14144-9-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c6551509cckunm1f354c4b7496
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlMS1ZKSk1ISE9NTBlKQh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y8XXSct3OlY5SH3BbrBXiaXkxATxGgdYTvAuSxVy2dBCwKoV2mxnBcO5Nds5LbTcefmWqeGkOlRFYfZd1cMwzMw5vkxzrvsX8fDUKA+hllFhR4CmS3hKeJeBLoc2cpn6rVlJ2yncjBBO0KAnRP8FMwhztTEhlwvgtF/XkmYc4xE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=sn2UTdSUgp+mYXdugCKoIDomAtZHoqHVcB1RgQRTQjo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Now, as dw_mmc-pci still provide struct dw_mci_board, so host->detect_delay_ms
will not be overwritten.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pci.c | 2 +-
 drivers/mmc/host/dw_mmc.c     | 4 ++--
 drivers/mmc/host/dw_mmc.h     | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index f5ef872..bfd1cbf 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -27,7 +27,6 @@
 static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
-	.detect_delay_ms		= 200,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -49,6 +48,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->dev = &pdev->dev;
 	host->pdata = &pci_board_data;
 	host->fifo_depth = 32;
+	host->detect_delay_ms = 200;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 84e1b07..741ad41 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2688,7 +2688,7 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
 	mmc_detect_change(host->mmc,
-		msecs_to_jiffies(host->pdata->detect_delay_ms));
+		msecs_to_jiffies(host->detect_delay_ms));
 }
 
 static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
@@ -3187,7 +3187,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
 	device_property_read_u32(dev, "card-detect-delay",
-				 &pdata->detect_delay_ms);
+				 &host->detect_delay_ms);
 
 	device_property_read_u32(dev, "data-addr", &host->data_addr_override);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index dd4a8b0..4263cb4 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -132,6 +132,7 @@ struct dw_mci_dma_slave {
  * @clk_old: The last clock value that was requested from core.
  * @pdev: platform_device registered
  * @rstc: Reset controller for this host.
+ * @detect_delay_ms: Delay in mS before detecting cards after interrupt.
  *
  * Locking
  * =======
@@ -252,6 +253,7 @@ struct dw_mci {
 	unsigned int		clk_old;
 	struct platform_device	*pdev;
 	struct reset_control *rstc;
+	u32 detect_delay_ms;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -270,9 +272,6 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-
-	/* delay in mS before detecting cards after interrupt */
-	u32 detect_delay_ms;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

