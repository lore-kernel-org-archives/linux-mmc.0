Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73818242D98
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666065; cv=none; b=j7NjZdU18jgKaoDnOBlTNr1b28lm/ERhygpdVLKsbajlpO/JJDkB4qGSipjdq/nB+BEgBUJBqBxuW9DySPSrrHwiilqWTAiL0QMwxQnYPldh3Mr4mrxEWsyEARQkrfb+0cGeVVM+mSIUwRO6Bx8T8fAMHD7SBS9zA1KFTlPBbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666065; c=relaxed/simple;
	bh=Cw7PEWcrC5XoAZG7lX77os/hC1JJEL1BxVj7DS6fx80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DthpjfGOjGOcba3mBBwHjL3suu77lJH9tEkICcgm3fAskl7ESRrVCW/5D3olkw4tH5Hkim2k+px8ZGYdChw6C2xXKzBA26aNgmyUtQPSaoz2UpGRVYTUB6fDYYMGmhQ2naJj7aK4i4Idz6k15XGR7Gb3mbbrYKg9EoBaaU9xeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Rm1gX1O5; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Rm1gX1O5"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c31df2;
	Tue, 6 Jan 2026 10:20:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 09/18] mmc: dw_mmc: Remove bus_hz from struct dw_mci_board
Date: Tue,  6 Jan 2026 10:17:00 +0800
Message-Id: <1767665829-183001-10-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911b6a3509cckunmc69ba49b79c349
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkseQ1ZISh4eHh9DSR4eGRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Rm1gX1O51bxWC3hRIvOLMoQgG3YHmkiR3ALV3/nMDlz77MXdGMMOom4JE6YkSShi5llL5CJgs8/xh6df9oubcLkP0EuZ9O8xKAIYMc+ZT2j+nGNW/B6qRhXVohjVvUtFwikrjC5CHMFbzRd4UG8921qun4yvnWccVzKdMwlt6BQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=p7B6PEFc64y+/fOGwOeMjB9C0eiyibX/1tMsCSgo+3g=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci already keeps one, reuse it. Now, as dw_mmc-pci still
provide struct dw_mci_board, so host->bus_hz will not be overwritten.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-pci.c |  2 +-
 drivers/mmc/host/dw_mmc.c     | 10 ++++------
 drivers/mmc/host/dw_mmc.h     |  2 --
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 616804a..95e91f8 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -26,7 +26,6 @@
 
 static struct dw_mci_board pci_board_data = {
 	.caps				= DW_MCI_CAPABILITIES,
-	.bus_hz				= 33 * 1000 * 1000,
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
@@ -48,6 +47,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	host->pdata = &pci_board_data;
 	host->fifo_depth = 32;
 	host->detect_delay_ms = 200;
+	host->bus_hz = 33 * 1000 * 1000;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
 	if (ret)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4947c62..a7b9f03 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3183,7 +3183,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		host->wm_aligned = true;
 
 	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
-		pdata->bus_hz = clock_frequency;
+		host->bus_hz = clock_frequency;
 
 	if (drv_data && drv_data->parse_dt) {
 		ret = drv_data->parse_dt(host);
@@ -3273,8 +3273,6 @@ int dw_mci_probe(struct dw_mci *host)
 		ret = PTR_ERR(host->ciu_clk);
 		if (ret == -EPROBE_DEFER)
 			goto err_clk_biu;
-
-		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
@@ -3282,12 +3280,12 @@ int dw_mci_probe(struct dw_mci *host)
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
index e364b16..cb0e06b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -270,8 +270,6 @@ struct dw_mci_dma_ops {
 
 /* Board platform data */
 struct dw_mci_board {
-	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
-
 	u32 caps;	/* Capabilities */
 };
 
-- 
2.7.4

