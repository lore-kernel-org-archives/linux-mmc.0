From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/4] mmc: omap: add DDR support to omap_hsmmc
Date: Fri, 24 Feb 2012 21:14:32 +0530
Message-ID: <1330098274-12048-3-git-send-email-balajitk@ti.com>
References: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add Dual data rate support for omap_hsmmc

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f4c7f89..c39fb8f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -89,6 +89,7 @@
 #define MSBS			(1 << 5)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
+#define DDR			(1 << 19)
 #define DW8			(1 << 5)
 #define CC			0x1
 #define TC			0x02
@@ -643,6 +644,10 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
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
1.7.0.4

