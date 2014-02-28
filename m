From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] mmc: omap_hsmmc: remove redundant reset done
Date: Fri, 28 Feb 2014 19:52:32 +0530
Message-ID: <1393597352-13282-3-git-send-email-balajitk@ti.com>
References: <1393597352-13282-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaB1OWn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 09:22:43 -0500
In-Reply-To: <1393597352-13282-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Remove redundant reset done check since omap hwmod layer ensures IP reset.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7d03d36..f9595b9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -97,7 +97,6 @@
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
-#define RESETDONE		(1 << 0)
 
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
@@ -627,9 +626,6 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	u32 hctl, capa;
 	unsigned long timeout;
 
-	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
-		return 1;
-
 	if (host->con == OMAP_HSMMC_READ(host->base, CON) &&
 	    host->hctl == OMAP_HSMMC_READ(host->base, HCTL) &&
 	    host->sysctl == OMAP_HSMMC_READ(host->base, SYSCTL) &&
-- 
1.7.5.4

