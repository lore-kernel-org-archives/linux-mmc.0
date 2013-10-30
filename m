From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 2/6] mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
Date: Wed, 30 Oct 2013 22:09:49 +0800
Message-ID: <1383142193-24950-3-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:3281 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab3J3O3A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:29:00 -0400
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

Used to read out the correct value of SDHCI_TRANSFER_MODE register
for upper layer.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1ce3511..92d5782 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -385,6 +385,22 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 		return ret;
 	}
 
+	if (unlikely(reg == SDHCI_TRANSFER_MODE)) {
+		if (esdhc_is_usdhc(imx_data)) {
+			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			ret = m & ESDHC_MIX_CTRL_SDHCI_MASK;
+			/* Swap AC23 bit */
+			if (m & ESDHC_MIX_CTRL_AC23EN) {
+				ret &= ~ESDHC_MIX_CTRL_AC23EN;
+				ret |= SDHCI_TRNS_AUTO_CMD23;
+			}
+		} else {
+			ret = readw(host->ioaddr + SDHCI_TRANSFER_MODE);
+		}
+
+		return ret;
+	}
+
 	return readw(host->ioaddr + reg);
 }
 
-- 
1.7.2.rc3


