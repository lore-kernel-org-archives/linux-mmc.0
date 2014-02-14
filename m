From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: fix sparse/smatch warning for paranthesis
Date: Thu, 13 Feb 2014 23:28:02 -0600
Message-ID: <1392355682-30802-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37392 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbaBNF2N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Feb 2014 00:28:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>

commit 6c31b21 (mmc: omap_hsmmc: remove access to SYSCONFIG register)

introduced an smatch(http://smatch.sf.net) warning for the following:

drivers/mmc/host/omap_hsmmc.c:608 omap_hsmmc_context_restore() warn: add
some parenthesis here?
drivers/mmc/host/omap_hsmmc.c:608 omap_hsmmc_context_restore() warn:
maybe use && instead of &

sparse reports:
drivers/mmc/host/omap_hsmmc.c: warning: dubious: !x & y

Fix the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dbd32ad..575f9cc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -605,7 +605,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	u32 hctl, capa;
 	unsigned long timeout;
 
-	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
+	if (!(OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE))
 		return 1;
 
 	if (host->con == OMAP_HSMMC_READ(host->base, CON) &&
-- 
1.7.9.5

