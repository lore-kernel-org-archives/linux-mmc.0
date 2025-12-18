Received: from mail-m32118.qiye.163.com (mail-m32118.qiye.163.com [220.197.32.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12F33AD87
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066976; cv=none; b=r4lPZVWA5OgqMrxl0Mhp0Sjzvir+AHwh227InNOz1PWBduO+8iEFdy/5psEn7FSFkwHux+JBxQCmbIOPpYaHoLPD+fHL1+j6hDepnCYN5axxwNEMdzT0RL80/Su9NcYRtCKXJ1i/5ZkLpsCAZ+yJZJfXXGcK1ZkSdEHW3e7NzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066976; c=relaxed/simple;
	bh=BnzXLYZVKqtCVqljVmdP758WYEHmUjBicd0sVw/HKqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZulgAifIi8yvU4VcMxuoirikrv9cRGijx6OZ5PB7DATVY5Djo3zV/LA2uzBoLhlUBFLEUZLu7OyHf5xRkfBHWfO6LwHNINEYIGfe9PBc3XZGbPCkXu2Hok/OUJpVsE1KCL7yPEHV+JKJ33gazoHLyy6Ei73BFDaoMYuQguSWJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Q2OvDdeI; arc=none smtp.client-ip=220.197.32.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q2OvDdeI"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb391;
	Thu, 18 Dec 2025 22:04:14 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/18] mmc: dw_mmc: Remove bus_hz from struct dw_mci_board
Date: Thu, 18 Dec 2025 22:00:36 +0800
Message-Id: <1766066445-14144-10-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c68ce909cckunm1f354c4b74e0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4fT1ZMGEpDGUJIQx8aHklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Q2OvDdeIGy2+Be/75rcfWbmE+4rMmBrf1y5N85YMCCJqiB4O/dl8jhhVf7FFzWePQWLRTmzwUw/4IwZcvhIX7GA8GGOJuV/pzysBOU09dRGLU0V7zRJsJQE/DbPuZiAaDKQYoepyhQvtl5BgohtyYzytMDArFMRq1o8LACGSkv8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=i4Rg/RVBbhrYdV1G1C3ukNcErf8CfGMBD8EH1XyeV0s=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci already keep one, reuse it. Now, as dw_mmc-pci still
provide struct dw_mci_board, so host->bus_hz will not be overwritten.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pci.c |  2 +-
 drivers/mmc/host/dw_mmc.c     | 10 ++++------
 drivers/mmc/host/dw_mmc.h     |  2 --
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index bfd1cbf..99aad54 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -26,7 +26,6 @@
 
 static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
-	.bus_hz				= 33 * 1000 * 1000,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -49,6 +48,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->pdata = &pci_board_data;
 	host->fifo_depth = 32;
 	host->detect_delay_ms = 200;
+	host->bus_hz = 33 * 1000 * 1000;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 741ad41..3c565d79 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3195,7 +3195,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		host->wm_aligned = true;
 
 	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
-		pdata->bus_hz = clock_frequency;
+		host->bus_hz = clock_frequency;
 
 	if (drv_data && drv_data->parse_dt) {
 		ret = drv_data->parse_dt(host);
@@ -3269,8 +3269,6 @@ int dw_mci_probe(struct dw_mci *host)
 		ret = PTR_ERR(host->ciu_clk);
 		if (ret == -EPROBE_DEFER)
 			goto err_clk_biu;
-
-		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
@@ -3278,12 +3276,12 @@ int dw_mci_probe(struct dw_mci *host)
 			goto err_clk_biu;
 		}
 
-		if (host->pdata->bus_hz) {
-			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
+		if (host->bus_hz) {
+			ret = clk_set_rate(host->ciu_clk, host->bus_hz);
 			if (ret)
 				dev_warn(host->dev,
 					 "Unable to set bus rate to %uHz\n",
-					 host->pdata->bus_hz);
+					 host->bus_hz);
 		}
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4263cb4..6e9d838 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -269,8 +269,6 @@ struct dw_mci_dma_ops {
 
 /* Board platform data */
 struct dw_mci_board {
-	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
-
 	u32 caps;	/* Capabilities */
 };
 
-- 
2.7.4

