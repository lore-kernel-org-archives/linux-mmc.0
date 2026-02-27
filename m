Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700830E0FC
	for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179305; cv=none; b=WauQSjGCp+2+C1p9t8TTLLi57V6MMJXb0+mkBKVYAW6pKCBhcfLxIKkvxkv7e6Jjik+easzmuHGOAGmZEszJ4hJw46Ubt19CFExoTQ5EmaTTr8PFIGjmsISKau1zf4JrTgJ3hQGPlAKbeBcO4h+OOskZEVwYagRD2nucd9gXlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179305; c=relaxed/simple;
	bh=L7F+r3J84syV47PIHgh5dYdBtE03Cg3oMvvoDQtZg0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHP4hcDG/qTSs1PZ47HbFzniyhiQ8Drl9kZr4pf3Mb/zWus6O9Q+bm1s0nuTvAwAtA3ypIoghwls3JV1XuPDQ9XVRU5zix7xA3BQWaS/KSJalnK6qyB3voesXCoiE0hkkklz6lxzyZ1BcKibxcXOAznXRa3PULnEnQAEqR20bac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzKVv/MF; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzKVv/MF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772179292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gwJj1+FJ2SrTq0V7rniC+F/sZrYY8oLo+nmrkZurdaU=;
	b=NzKVv/MFap2TqTkBEF6cTQrHZv4DusJdFAyqM3WkGP7K8NN0wrllvynbzy7pwDSrxSHP0t
	6oSL9MBy0hbrV57+XAoipepr+Ls23ybDk5raGA+9ZhFZqDgVpH2a1F8WI4euonRm0o+P9i
	exkeuDtH97qAOFJl61s2YwQTOFfOvYI=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Date: Thu, 26 Feb 2026 23:59:09 -0800
Message-ID: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The GL9750 SD host controller has intermittent data corruption during
DMA write operations. The GM_BURST register's R_OSRC_Lmt field
(bits 17:16), which limits outstanding DMA read requests from system
memory, is not being cleared during initialization. The Windows driver
sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.

Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
write corruption verified with f3write/f3read tests while maintaining
DMA performance.

Cc: stable@vger.kernel.org
Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Link to RFC: https://lore.kernel.org/all/20260117234800.931664-1-matthew.schwartz@linux.dev/
Changes from RFC -> v1: use the proper name for the register field 
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b0f91cc9e40e4..7a7be3f7bee6b 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -26,6 +26,9 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
+#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT	    GENMASK(17, 16)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 
 	gl9750_wt_on(host);
 
+	/* clear R_OSRC_Lmt to avoid DMA write corruption */
+	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
+	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
+	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
+
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
 	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
 	/* set ASPM L1 entry delay to 7.9us */
-- 
2.53.0

