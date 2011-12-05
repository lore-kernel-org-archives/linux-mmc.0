From: Xie Xiaobo <X.Xie@freescale.com>
Subject: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
Date: Mon, 5 Dec 2011 16:55:20 +0800
Message-ID: <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:49394 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab1LEKMg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:12:36 -0500
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mmc@vger.kernel.org, avorontsov@ru.mvista.com, Xie Xiaobo <X.Xie@freescale.com>

Some controller provides an incorrect timeout value for transfers,
So it need the quirk to adjust timeout value to 0xE.
E.g. eSDHC of MPC8536, P1010, and P2020.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a9e12ea..b5d6b3f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -2,7 +2,7 @@
  * sdhci-pltfm.c Support for SDHCI platform devices
  * Copyright (c) 2009 Intel Corporation
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -68,6 +68,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "sdhci,1-bit-only", NULL))
 			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
+		if (of_get_property(np, "sdhci,sdhci-adjust-timeout", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 		if (sdhci_of_wp_inverted(np))
 			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-- 
1.6.4


