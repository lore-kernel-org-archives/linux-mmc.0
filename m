Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B41197A7D
	for <linux-mmc@vger.kernel.org>; Sat, 17 Jan 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693694; cv=none; b=uZB/M54pSlVAYw0avbFsaKi3un7uzblFUUwmTetS1mNGofW/zp6rTwfsBvJIwarCBBZswT/Uncy3rD3XpduIoZgq+aYSoBS1wh3mew/lNcKkklmstlvFPtzyPQapPqyX6zBiWF+TFuo9TCAeFzMVDJoD+xOX0nm9qcWqWp+vPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693694; c=relaxed/simple;
	bh=u2RW7j3wp4dVjPImpC/IXWdc6WnGy6Q2lSvJkCeYBPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7/t8E7EBOrjL9Ba6npfbIF7wyTbz3xci0JVOJ8rKqzqBP2xEav41/yqtUeLII3T1+CwxFMgjV2hF7YEdk5DstKolWErfiYH8EHHIAwTMFGUlY8ZJUXaN0fQualSadIxpr9VwSz4L8teRszJphYvAYwcyQ+OH/iP+1MXOVuoC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xa0kXggA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xa0kXggA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768693690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+5niUaeixLKbgx0rFYLIxVy+7xWVWWGUdpqZii7CbFo=;
	b=xa0kXggAJPXhDTj9WesIFXjoF/bD3lbsmfmf/5jYUUGS5cm7b29NWLXgpfh+qV9UJsHRyR
	yzI5bV46YZz8y/Ps8RtgpVWhFeDsTzBplJo/eppjuEYPvsNPVKJgH5DXK5k35T4Qp9DK3M
	+xdAmVB1SHkylL7dLwbz0mOoAR9yp7w=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Date: Sat, 17 Jan 2026 15:48:00 -0800
Message-ID: <20260117234800.931664-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The GL9750 SD host controller has intermittent data corruption during
DMA write operations, which has been traced to an incorrect burst
configuration. This was discovered by comparing initialization sequences
between the working GL9767 controller and GL9750 and seeing that the
GM_BURST register was handled differently.

Clearing bits 16-17 eliminates the corruption with f3write/f3read tests
while maintaining full DMA write/read performance.

Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---

Hi all,

I arrived at this after a whole bunch of guesswork based on the other
Genesys card readers in the kernel that do work, like GL9767. I landed on
register 0x510 which appears to be "GM_BURST_SIZE" and ended up going
through each bit and either setting it or masking it. Eventually, I
arrived at masking bits 16-17 which seemed to stabilize writes completely.

Could someone at Genesys confirm what this register is for on GL9750, and
what those bits are? At least locally, I have been able to run 50GB of
f3write/f3read without any corruption while before even 1GB would corrupt.
This also maintains the same read/write speed as before this change. I
tried searching online but was unable to find any relevant docs, and I'd
like to confirm the purpose of those bits before sending this out as v1.

Thanks,
Matt

---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b0f91cc9e40e4..a06b0cf11f12d 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -26,6 +26,9 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
+#define   SDHCI_GLI_9750_GM_BURST_SIZE_MASK	    GENMASK(17, 16)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 
 	gl9750_wt_on(host);
 
+	/* clear GM_BURST bits to avoid corruption with DMA writes */
+	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
+	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_MASK;
+	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
+
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
 	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
 	/* set ASPM L1 entry delay to 7.9us */
-- 
2.52.0

