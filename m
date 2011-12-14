From: <r66093@freescale.com>
Subject: [PATCH 3/6] ESDHC: set the timeout to the max value
Date: Wed, 14 Dec 2011 10:19:39 +0800
Message-ID: <1323829182-1551-4-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <1323829182-1551-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:38821 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab1LNDFs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:05:48 -0500
Received: from mail178-tx2 (localhost [127.0.0.1])	by
 mail178-tx2-R.bigfish.com (Postfix) with ESMTP id D9325360271	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:49 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.239])	by
 mail178-tx2.bigfish.com (Postfix) with ESMTP id A998B140044	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:49 +0000 (UTC)
In-Reply-To: <1323829182-1551-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>, Xie Xiaobo <X.Xie@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When access the card on some FSL platform board (e.g p2020, p1010, mpc8536),
the following error is reported with the timeout value calculated:

mmc0: Got data interrupt 0x00000020 even though no data operation was
in progress.
mmc0: Got data interrupt 0x00000020 even though no data operation was
in progress.

So we skip the calculation of timeout and use the max value to fix it.

Signed-off-by: Gao Guanhua <B22826@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 5417d84..c4ec8bd 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -74,6 +74,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "sdhci,dma-broken", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_get_property(np, "sdhci,adjust-timeout", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 		if (of_get_property(np, "sdhci,ahb2mag-irq-bypass", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS;
 
-- 
1.7.5.4


