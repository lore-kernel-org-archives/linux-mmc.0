From: "George G. Davis" <gdavis@mvista.com>
Subject: [PATCH] mmc: sdhci: Fix SDHCI_INT_ADMA_ERROR typo in SDHCI_INT_DATA_MASK
Date: Thu, 18 Feb 2010 11:50:29 -0500
Message-ID: <1266511829-18464-1-git-send-email-gdavis@mvista.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:39485 "EHLO
	qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757886Ab0BRQvX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2010 11:51:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Pierre Ossman <pierre@ossman.eu>, "George G. Davis" <gdavis@mvista.com>

The "4accfe2 sdhci: catch ADMA errors" commit added SDHCI_ADMA_ERROR to
the definition of SDHCI_INT_DATA_MASK but obviously intended to use
SDHCI_INT_ADMA_ERROR.

Signed-off-by: George G. Davis <gdavis@mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
---
 drivers/mmc/host/sdhci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..9ba4268 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -127,7 +127,7 @@
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
-		SDHCI_INT_DATA_END_BIT | SDHCI_ADMA_ERROR)
+		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
-- 
1.6.3.3.311.g43dd

