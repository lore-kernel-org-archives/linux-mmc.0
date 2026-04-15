Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA53FCC;
	Wed, 15 Apr 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265389; cv=none; b=sg3Ml3RPqXcI75CXcgkjoJbUJ0d14YwhPB6x21/AhdPGeOP775lecTcpUq7UH2WwWz87O27gpHnjzEBhhEfD5hD9OZGJSMHLB7fyKF0fNCPiAC0N4QKjTuJkfHGtW7G0Cnxo8xTlEdZQJRcYSCnkgRjHTVEiQxV2SP/2aJIHu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265389; c=relaxed/simple;
	bh=0D1hlKCJtN9XoByE8IGBqcG2ueuIOxSDK/Q798cCv70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSHHCh3fAhVQknEZZQb/aylqc4S1evIPPioR691zY9OMYTz+vcUIwmrCBmOIFgzyPTiO4BDxYMoAsPMECdEBmIwnY21juVSlgIkJlEICuiIkTI3Xa2xfrDUFLPKdcSbNnvcMx+W0OYEQ+BsJdL9fIunk6tXlMawvv4zYfk3BqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=K6VYZeSw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="K6VYZeSw"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 074FD26F45;
	Wed, 15 Apr 2026 17:03:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IY1vHmCK0xuZ; Wed, 15 Apr 2026 17:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776265386; bh=0D1hlKCJtN9XoByE8IGBqcG2ueuIOxSDK/Q798cCv70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K6VYZeSwGmyytHCkWb5E1S3ytfQY+f6HDN04pmYXN0Yh8F7qSrZ4WYz35jvknYDkc
	 ib0Xyzj5uYbICSaKBFsNT1HRNQSlY7hCG2mK+sdfzbH1SccmnFOUgMp5hKCbm7kLJX
	 gH5gbUd1mhEELE+WeUnP0hwyzhHbDQ9Nqoz+AUJPMS5Cvqe82Hus/sq2Gltm3EITpS
	 HfhpdBV6iK+S3UMmJOzrEps34eewSF19IADvAdZqO0tuotnnafRL1Wwvm0p+TlwSUJ
	 aDYDWSmfQoA8BbV0ffFTWzyop6mgfRcPwJYE3bHQAkY8pbJd/jhMeJ/bEHZAR6SpOE
	 53/ctq97jQaQg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 15 Apr 2026 20:32:08 +0530
Subject: [PATCH v3 1/2] mmc: dw_mmc: implement option for configuring DMA
 threshold
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-dwmmc-dma-thr-v3-1-31014d36b6ee@disroot.org>
References: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
In-Reply-To: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Some controllers, such as certain Exynos SDIO ones, are unable to
perform DMA transfers of small amount of bytes properly. Following the
device tree schema, implement the property to define the DMA transfer
threshold (from a hard coded value of 16 bytes) so that lesser number of
bytes can be transferred safely skipping DMA in such controllers. The
value of 16 bytes stays as the default for controllers which do not
define it. This value can be overridden by implementation-specific init
sequences.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 20193ee7b73eb..3b4157f34d11f 100644
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
@@ -3185,6 +3184,7 @@ struct dw_mci *dw_mci_alloc_host(struct device *dev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = dev;
+	host->dma_threshold = 16;
 
 	return host;
 }
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 42e58be74ce09..f29d40158dc59 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -107,6 +107,7 @@ struct dw_mci_dma_slave {
  * @ciu_clk: Pointer to card interface unit clock instance.
  * @fifo_depth: depth of FIFO.
  * @data_addr_override: override fifo reg offset with this value.
+ * @dma_threshold: data threshold value in bytes to carry out a DMA transfer.
  * @wm_aligned: force fifo watermark equal with data length in PIO mode.
  *	Set as true if alignment is needed.
  * @data_shift: log2 of FIFO item size.
@@ -163,6 +164,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			data_addr_override;
+	u32			dma_threshold;
 	bool			wm_aligned;
 
 	struct scatterlist	*sg;

-- 
2.53.0

