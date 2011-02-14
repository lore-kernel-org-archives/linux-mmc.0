From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 5/5] sdhci: sdhci-pxa.c: Add QUIRKS for DMA/ADMA to match
 h/w
Date: Sun, 13 Feb 2011 23:01:24 -0800
Message-ID: <45293FA4-D66D-4817-AA18-6BD50264F87A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60846 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663Ab1BNHHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:07:48 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


32 Bit DMA/ADMA Access
32 Bit Size
Support ADMA End Descriptor in current chain
	(no need for dummy entry)

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index c8abf0f..215517f 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -120,6 +120,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	host->ops = &sdhci_pxa_ops;
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	host->quirks |= SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;
-- 
1.7.0.4


