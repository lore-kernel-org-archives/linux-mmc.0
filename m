From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 2/8] mmc: omap: add DDR support to omap_hsmmc
Date: Thu, 15 Mar 2012 20:03:36 +0530
Message-ID: <1331822022-26714-3-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53098 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761123Ab2COOej (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 10:34:39 -0400
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com

From: Balaji T K <balajitk@ti.com>

Add Dual data rate support for omap_hsmmc

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b1e9be7..db8af43 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -92,6 +92,7 @@
 #define MSBS			(1 << 5)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
+#define DDR			(1 << 19)
 #define DW8			(1 << 5)
 #define CC			0x1
 #define TC			0x02
@@ -523,6 +524,10 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
 	u32 con;
 
 	con = OMAP_HSMMC_READ(host->base, CON);
+	if (ios->timing == MMC_TIMING_UHS_DDR50)
+		con |= DDR;	/* configure in DDR mode */
+	else
+		con &= ~DDR;
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_8:
 		OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
-- 
1.7.10.rc0.41.gfa678

