Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80B1D8E10
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767678595; cv=none; b=KkmJrq2pLa5GhXh9I6dryi4/RuN3+QdNmGVcFf1SR59sFTppR70mIkLVUvePQeMsejyFWDvf5njfL8H+Xy6o/JmNR5PV5B6a/hikIKKWm2MzqjNaSW7opTUuRlq0qLKJ8SfS9OVDsXQPBKA40lxGlGY/6tCexZXwLylb3SyWJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767678595; c=relaxed/simple;
	bh=CjfSQFo6aMEOMcmmK5Y8rdSDmZ8rnbDBd69ucfkigIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LX4oKrpPbB/XIs91/zwKtoMJ9jGsewHCWaIFnzvcTT4vPLUnLhJZLlVXEa7untlOmrgfsQN9IPCdmJ0RAu+Zy3m5N1u+6lbXCp/uV1wJmuSFTR8WLqGLumN49JmF0TQUjPBHhiwGd8JRHLElG+QQ7SXt7njwQiQXgbtS7+7fsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JyiUzY9F; arc=none smtp.client-ip=45.254.49.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JyiUzY9F"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c31d50;
	Tue, 6 Jan 2026 10:20:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 08/18] mmc: dw_mmc: Move detect_delay_ms from struct dw_mci_board to struct dw_mci
Date: Tue,  6 Jan 2026 10:16:59 +0800
Message-Id: <1767665829-183001-9-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911b079909cckunmc69ba49b79c1aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9DT1ZMTRgeGhhDHkkaGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JyiUzY9FAw4Mp8FYrwsFK22R/q62BFuEmSV6fXSXlSqeLOTk2Qpbv2J8DO4Op2fFOdV27Y25Uzyqkr7EkL/pTwLGGUDWkXn/jkx8URWDcJDbI188deU5/9ThK9N4IG3xM4rJABeVLc1rOSZTp+dAJP04llKGe8E4G8nnHnwvf8s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uGsosxlaARcj6yK/WTbAFFmmjeeM6p4nnZjv8+VmKL0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Now, as dw_mmc-pci still provide struct dw_mci_board, so host->detect_delay_ms
will not be overwritten. So it's fine to move it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-pci.c | 2 +-
 drivers/mmc/host/dw_mmc.c     | 4 ++--
 drivers/mmc/host/dw_mmc.h     | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 89ad499..616804a 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -27,7 +27,6 @@
 static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
-	.detect_delay_ms		= 200,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -48,6 +47,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->irq_flags = IRQF_SHARED;
 	host->pdata = &pci_board_data;
 	host->fifo_depth = 32;
+	host->detect_delay_ms = 200;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b48d76f9..4947c62 100644
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
@@ -3175,7 +3175,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
 	device_property_read_u32(dev, "card-detect-delay",
-				 &pdata->detect_delay_ms);
+				 &host->detect_delay_ms);
 
 	device_property_read_u32(dev, "data-addr", &host->data_addr_override);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index bc82d1d..e364b16 100644
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
@@ -253,6 +254,7 @@ struct dw_mci {
 	unsigned int		clk_old;
 	struct platform_device	*pdev;
 	struct reset_control *rstc;
+	u32 detect_delay_ms;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -271,9 +273,6 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-
-	/* delay in mS before detecting cards after interrupt */
-	u32 detect_delay_ms;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

