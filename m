From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 06/10] mmc: omap_hsmmc: remove access to SYSCONFIG register
Date: Sat, 18 Aug 2012 00:22:26 +0530
Message-ID: <1345229550-8672-7-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40417 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2HQSxx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:53:53 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

SYSCONFIG register of HSMMC IP is managed by the omap hwmod
abstraction layer. Resetting the IP and configuring the correct
SYSCONFIG mode is centrally managed by hwmod.

Remove code which manipulates IP reset and SYSCONFIG directly in the
driver.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index da4f5a7..4bc55ac 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -44,7 +44,6 @@
 #include <plat/cpu.h>
 
 /* OMAP HSMMC Host Controller Registers */
-#define OMAP_HSMMC_SYSCONFIG	0x0010
 #define OMAP_HSMMC_SYSSTATUS	0x0014
 #define OMAP_HSMMC_CON		0x002C
 #define OMAP_HSMMC_BLK		0x0104
@@ -576,21 +575,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	if (host->context_loss == context_loss)
 		return 1;
 
-	/* Wait for hardware reset */
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
-		&& time_before(jiffies, timeout))
-		;
-
-	/* Do software reset */
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
-		&& time_before(jiffies, timeout))
-		;
-
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
-			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
+	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
+		return 1;
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		if (host->power_mode != MMC_POWER_OFF &&
@@ -1593,10 +1579,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	value = OMAP_HSMMC_READ(host->base, CAPA);
 	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
 
-	/* Set the controller to AUTO IDLE mode */
-	value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
-
 	/* Set SD bus power bit */
 	set_sd_bus_power(host);
 }
@@ -1654,8 +1636,6 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 
 	pm_runtime_get_sync(host->dev);
 
-	seq_printf(s, "SYSCONFIG:\t0x%08x\n",
-			OMAP_HSMMC_READ(host->base, SYSCONFIG));
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
-- 
1.7.11.1.25.g0e18bef

