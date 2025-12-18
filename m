Received: from mail-m19731100.qiye.163.com (mail-m19731100.qiye.163.com [220.197.31.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13E3358CD
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066706; cv=none; b=qsDVePZpQaMqGK2eC50OTjcD3DfSFlvhoEGF5WQ828lA+gK0NdRmCvI8TXZbMQ6N9tUXd1GUL9O8gJ63k67ZKmhPUN4oBSFBXhruiqy0CoDmsp2BURqG5DokUJAjT1zhMw6n0JWj5E/WYAi/J1L+CDXoV/XhVGVXJQLPDwiRlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066706; c=relaxed/simple;
	bh=6G/13Okkr/kQpTGAUDDe3gAFcmMm/AhtdCEStF7vuyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oyPjeZQr5N/k/2BHnXM3YkgYUWSoHYjCTQF9BzMA9uIiEPYhtBM9T6fpXIbV643FsTqSSGqWcFFTPBdzRJfa/u5V48Aft0fPyAiCz/AvXWDTR53SvOYnos5lGceMDsYX2XlIjisqIEDcPIzobPmj3oqqX0masDIzSGidBYULjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TV0DisRi; arc=none smtp.client-ip=220.197.31.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TV0DisRi"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb3e1;
	Thu, 18 Dec 2025 22:04:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 10/18] mmc: dw_mmc: Remove struct dw_mci_board
Date: Thu, 18 Dec 2025 22:00:37 +0800
Message-Id: <1766066445-14144-11-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c7192c09cckunm1f354c4b75f5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hDHlZPQ04YTRgeQh8eGUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TV0DisRifGHjYvJL3+v3DD2VJZxx9kqW2LXKL8RJn1Zm6r3kaW62QGgXQBv+faZIXJTUyyazND3dgwW+W+aysJ5nvRktGvmSHLVQeGPojPL8F+a3DeJOP43FkWq9NQXLLRD0KYMCWD0MUnzz1/Q4Qw/YHyUJbNjOKA0Cw51H9Qw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=OZvcoHSq3ZZSKKOEvmTRYtAx0hBQzYLjxcY1Fv44VFo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The only user of dw_mci_board is dw_pci-pci, now we can provide
the caps from dw_mci_drv_data, so we could let dw_pci-pci use
dw_mci_drv_data and remove caps from struct dw_mci_board.

With that, struct dw_mci_board is no longer needed, we can remove
it. Then we should check all settings in dw_mci_parse_dt in order
not to overwrite them if provided from variant drivers.

Also, without CONFIG_OF support, dw_mmc doesn' work as host->pdata
is always ERR_PTR(-EINVAL), we could remove it together.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pci.c |  6 +++---
 drivers/mmc/host/dw_mmc.c     | 45 ++++++++++++++-----------------------------
 drivers/mmc/host/dw_mmc.h     |  7 -------
 3 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 99aad54..a0c788b 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -24,8 +24,8 @@
 				MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA |\
 				MMC_CAP_SDIO_IRQ)
 
-static struct dw_mci_board pci_board_data = {
-	.caps				= DW_MCI_CAPABILITIES,
+static const struct dw_mci_drv_data pci_drv_data = {
+	.common_caps = DW_MCI_CAPABILITIES,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -45,10 +45,10 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->irq = pdev->irq;
 	host->irq_flags = IRQF_SHARED;
 	host->dev = &pdev->dev;
-	host->pdata = &pci_board_data;
 	host->fifo_depth = 32;
 	host->detect_delay_ms = 200;
 	host->bus_hz = 33 * 1000 * 1000;
+	host->drv_data = &pci_drv_data;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3c565d79..03aed41 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2837,9 +2837,6 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
 	struct mmc_host *mmc = host->mmc;
 	int ctrl_id;
 
-	if (host->pdata->caps)
-		mmc->caps = host->pdata->caps;
-
 	if (drv_data)
 		mmc->caps |= drv_data->common_caps;
 
@@ -3164,54 +3161,43 @@ static void dw_mci_dto_timer(struct timer_list *t)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
-#ifdef CONFIG_OF
-static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
+static int dw_mci_parse_dt(struct dw_mci *host)
 {
-	struct dw_mci_board *pdata;
 	struct device *dev = host->dev;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ret;
 	u32 clock_frequency;
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
 	/* find reset controller when exist */
 	host->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
 	if (IS_ERR(host->rstc))
-		return ERR_CAST(host->rstc);
+		return PTR_ERR(host->rstc);
 
-	if (device_property_read_u32(dev, "fifo-depth", &host->fifo_depth))
+	if (!host->fifo_depth && device_property_read_u32(dev, "fifo-depth", &host->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
-	device_property_read_u32(dev, "card-detect-delay",
-				 &host->detect_delay_ms);
+	if (!host->detect_delay_ms)
+		device_property_read_u32(dev, "card-detect-delay",
+					 &host->detect_delay_ms);
 
-	device_property_read_u32(dev, "data-addr", &host->data_addr_override);
+	if (!host->data_addr_override)
+		device_property_read_u32(dev, "data-addr", &host->data_addr_override);
 
 	if (device_property_present(dev, "fifo-watermark-aligned"))
 		host->wm_aligned = true;
 
-	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
+	if (!host->bus_hz && !device_property_read_u32(dev, "clock-frequency", &clock_frequency))
 		host->bus_hz = clock_frequency;
 
 	if (drv_data && drv_data->parse_dt) {
 		ret = drv_data->parse_dt(host);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
-	return pdata;
-}
-
-#else /* CONFIG_OF */
-static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
-{
-	return ERR_PTR(-EINVAL);
+	return 0;
 }
-#endif /* CONFIG_OF */
 
 static void dw_mci_enable_cd(struct dw_mci *host)
 {
@@ -3241,12 +3227,9 @@ int dw_mci_probe(struct dw_mci *host)
 	int width, i, ret = 0;
 	u32 fifo_size;
 
-	if (!host->pdata) {
-		host->pdata = dw_mci_parse_dt(host);
-		if (IS_ERR(host->pdata))
-			return dev_err_probe(host->dev, PTR_ERR(host->pdata),
-					     "platform data not available\n");
-	}
+	ret = dw_mci_parse_dt(host);
+	if (ret)
+		return dev_err_probe(host->dev, ret, "parse dt failed\n");
 
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6e9d838..548ff51 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -103,7 +103,6 @@ struct dw_mci_dma_slave {
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
- * @pdata: Platform data associated with the MMC controller.
  * @drv_data: Driver specific data for identified variant of the controller
  * @priv: Implementation defined private data.
  * @biu_clk: Pointer to bus interface unit clock instance.
@@ -208,7 +207,6 @@ struct dw_mci {
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
-	struct dw_mci_board	*pdata;
 	const struct dw_mci_drv_data	*drv_data;
 	void			*priv;
 	struct clk		*biu_clk;
@@ -267,11 +265,6 @@ struct dw_mci_dma_ops {
 	void (*exit)(struct dw_mci *host);
 };
 
-/* Board platform data */
-struct dw_mci_board {
-	u32 caps;	/* Capabilities */
-};
-
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
 /* Force 32-bit access to the FIFO */
-- 
2.7.4

