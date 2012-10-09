From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] mmc: mxcmmc: Fix MODULE_ALIAS
Date: Tue, 9 Oct 2012 16:26:05 -0300
Message-ID: <1349810765-12351-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:3719
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754876Ab2JIT0j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Oct 2012 15:26:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

The correct name for the driver is "mxc-mmc".

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxcmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 565c2e4..6290b7f 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1134,4 +1134,4 @@ module_platform_driver(mxcmci_driver);
 MODULE_DESCRIPTION("i.MX Multimedia Card Interface Driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:imx-mmc");
+MODULE_ALIAS("platform:mxc-mmc");
-- 
1.7.9.5


