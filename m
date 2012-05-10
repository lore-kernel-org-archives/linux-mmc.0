From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: Workaround for TC irq coming ealier than DMA irq
Date: Thu, 10 May 2012 11:33:18 +0200
Message-ID: <1336642399-4543-4-git-send-email-dirk.behme@de.bosch.com>
References: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:51592 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab2EJJkX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:40:23 -0400
Received: from smtp2-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 7E09E2805C0
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:56 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 553E9B0021D
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:10 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id 13F421AC07B0
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:33:46 +0200 (CEST)
In-Reply-To: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: RichardZhu <richard.zhu@linaro.org>, Tony Lin <tony.lin@freescale.com>, Philipp Ahmann <pahmann@de.adit-jv.com>

From: RichardZhu <richard.zhu@linaro.org>

On i.MX6, if the TC interrupt bit is set but the DMA interrupt bit is cleared,
read the status register again in case the DMA interrupt will come in next
time cycle.

Note: This is a workaround for i.MX6 version 1.0 silicon. It's fixed in hardware in
      version 1.1 silicon.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
Signed-off-by: RichardZhu <richard.zhu@linaro.org>
Signed-off-by: Philipp Ahmann <pahmann@de.adit-jv.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index af2f581..a13e75b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -180,6 +180,19 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	}
 
 	if (unlikely(reg == SDHCI_INT_STATUS)) {
+		if (is_imx6q_usdhc(imx_data)) {
+			/*
+			 * on mx6q, there is low possibility that
+			 * DATA END interrupt comes ealier than DMA
+			 * END interrupt which is conflict with standard
+			 * host controller spec. In this case, read the
+			 * status register again will workaround this issue.
+			 */
+			if ((val & SDHCI_INT_DATA_END) && \
+				!(val & SDHCI_INT_DMA_END))
+				val = readl(host->ioaddr + reg);
+		}
+
 		if (val & SDHCI_INT_VENDOR_SPEC_DMA_ERR) {
 			val &= ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
 			val |= SDHCI_INT_ADMA_ERROR;
-- 
1.7.0.4

