Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741F3BD25D;
	Sat, 11 Apr 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936627; cv=none; b=diIL3RLxG7iqoNymTnVo9gf6cAbJmOGr2W39g2EEV7pvDFX5sCljw8xqqcI43CeSRhzr+0gXQ64KQwwVKYKnYWvLoVQH7wBQgB4N+TLY/DXT+0Z/Rd/o66YwrecvmVdhIeXtycsPxKvqP7rAexQ2Y/g2UCeJM/a2rh8T87gj7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936627; c=relaxed/simple;
	bh=euYE7bbY9MJPZ100uUG3rFFhszj9e+Q+eCWtK51vq1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjgTG42up11HJ5kUqeW8ISw23pWQGIdGYqf1Y5ptVXKX1bv88xcsVdAMSu4493d7x+GELKbs/knml9PblGaSsVcWtdDym46RX8DaDJv7fKeoVJaBYgHQAWqsCa3ybZDSYYkIyRCLyMFA7Pa3lSGkTl42Y5NperKiTGKM5gNqV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=STHCD9Vi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="STHCD9Vi"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AB17026F47;
	Sat, 11 Apr 2026 21:43:34 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GpP43buCNK5x; Sat, 11 Apr 2026 21:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775936613; bh=euYE7bbY9MJPZ100uUG3rFFhszj9e+Q+eCWtK51vq1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=STHCD9VieTRqMDgacOHlh9hUocb7nA8NBEwO3ihMVhZwxLC6PwXK1/d+9wVEjQIYz
	 Jn2r9Bg6oypiZL/ElBAukl+LavFRCQHtBkbJEz1CCmTFrBwMWzjUhVtE3fNFXXQdmj
	 xLnoOgpgfqpzpQ4Hh824iXYU6m/id/3p07ibSHoxA6aOlQ/+yRh9IWnGFvWWHw9f/L
	 6XYwwvnTlqVI/O/6EO8p5Ms1iytQT25yE/iO1gZwKavmGDk9q/EYATnc5jGx/8Yu25
	 6fVc1k4D8qnFCsiZ2Fm/fxYbzQAaQIb/gJy5P+u6E9f7rlZYYdwT8ZLR9pgKIwVEba
	 8jXX8fCVl2L7w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 12 Apr 2026 01:13:15 +0530
Subject: [PATCH 2/2] mmc: dw_mmc: implement option for configuring DMA
 threshold
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-dwmmc-dma-thr-v1-2-75a2f658eee3@disroot.org>
References: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
In-Reply-To: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Some controllers, such as certain Exynos SDIO ones, are unable to
perform DMA transfers of small amount of bytes properly. Following the
device tree schema, implement the property to define the DMA transfer
threshold (from a hard coded value of 16 bytes) so that lesser number of
bytes can be transferred safely skipping DMA in such controllers. The
value of 16 bytes stays as the default for controllers which do not
define it.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++--
 drivers/mmc/host/dw_mmc.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 20193ee7b73eb..0c0d269b5e033 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -40,7 +40,6 @@
 				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
 #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
 				 DW_MCI_CMD_ERROR_FLAGS)
-#define DW_MCI_DMA_THRESHOLD	16
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
@@ -821,7 +820,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 	 * non-word-aligned buffers or lengths. Also, we don't bother
 	 * with all the DMA setup overhead for short transfers.
 	 */
-	if (data->blocks * data->blksz < DW_MCI_DMA_THRESHOLD)
+	if (data->blocks * data->blksz < host->dma_threshold)
 		return -EINVAL;
 
 	if (data->blksz & 3)
@@ -3137,6 +3136,9 @@ static int dw_mci_parse_dt(struct dw_mci *host)
 	if (!host->data_addr_override)
 		device_property_read_u32(dev, "data-addr", &host->data_addr_override);
 
+	if (device_property_read_u32(dev, "dma-threshold-bytes", &host->dma_threshold) < 0)
+		host->dma_threshold = 16;
+
 	if (device_property_present(dev, "fifo-watermark-aligned"))
 		host->wm_aligned = true;
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 42e58be74ce09..5cdd342d01b68 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -163,6 +163,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			data_addr_override;
+	u32			dma_threshold;
 	bool			wm_aligned;
 
 	struct scatterlist	*sg;

-- 
2.53.0

