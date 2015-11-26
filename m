From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 5/7] mmc: sdhc: Fix DMA descriptor with zero data length
Date: Thu, 26 Nov 2015 14:00:48 +0200
Message-ID: <1448539250-18769-6-git-send-email-adrian.hunter@intel.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbKZMEN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:13 -0500
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

SDHCI has built-in DMA called ADMA2.  ADMA2 uses a descriptor
table to define DMA scatter-gather.  Each desciptor can specify
a data length up to 65536 bytes, however the length field is
only 16-bits so zero means 65536.  Consequently, putting zero
when the size is zero must not be allowed.  This patch fixes
one case where zero data length could be set inadvertently.

The problem happens because unaligned data gets split and the
code did not consider that the remaining aligned portion might
be zero length.  That case really only happens for SDIO because
SD and eMMC cards transfer blocks that are invariably sector-
aligned.  For SDIO, access to function registers is done by
data transfer (CMD53) when the register is bigger than 1 byte.
Generally registers are 4 bytes but 2-byte registers are possible.
So DMA of 4 bytes or less can happen.  When 32-bit DMA is used,
the data alignment must be 4, so 4-byte transfers won't casue a
problem, but a 2-byte transfer could.  However with the introduction
of 64-bit DMA, the data alignment for 64-bit DMA was made 8 bytes,
so all 4-byte transfers not on 8-byte boundaries get "split" into
a 4-byte chunk and a 0-byte chunk, thereby hitting the bug.

In fact, a closer look at the SDHCI specs indicates that only the
descriptor table requires 8-byte alignment for 64-bit DMA.  That
will be dealt with in a separate patch, but the potential for a
2-byte access remains, so this fix is needed anyway.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v3.19+
---
 drivers/mmc/host/sdhci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f8b0766428c..6ac5db8e86ab 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -540,9 +540,12 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 
 		BUG_ON(len > 65536);
 
-		/* tran, valid */
-		sdhci_adma_write_desc(host, desc, addr, len, ADMA2_TRAN_VALID);
-		desc += host->desc_sz;
+		if (len) {
+			/* tran, valid */
+			sdhci_adma_write_desc(host, desc, addr, len,
+					      ADMA2_TRAN_VALID);
+			desc += host->desc_sz;
+		}
 
 		/*
 		 * If this triggers then we have a calculation bug
-- 
1.9.1

