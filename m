From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: mxs-mmc: Add MODULE_ALIAS()
Date: Mon,  7 Jan 2013 20:41:52 -0200
Message-ID: <1357598512-24189-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:62641 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab3AGWsY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 17:48:24 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so13471174qcp.12
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jan 2013 14:48:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: marex@denx.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Add an entry for MODULE_ALIAS().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..b9a9ca0 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -804,3 +804,4 @@ module_platform_driver(mxs_mmc_driver);
 MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
 MODULE_AUTHOR("Freescale Semiconductor");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.9.5

