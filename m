From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] MMC: omap_hsmmc: enable interface clock before calling
 mmc_host_enable()
Date: Tue, 7 Dec 2010 16:27:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43882 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab0LGX1b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 18:27:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, linux-omap@vger.kernel.org


In the OMAP HSMMC driver, the code path entered via mmc_host_enable() can 
include register accesses to the HSMMC IP block.  For this to work, both 
the device interface clock and functional clock need to be enabled before 
mmc_host_enable() is called.  However, omap_hsmmc_probe() calls 
mmc_host_enable() before enabling the device interface clock.  This can 
crash the kernel with:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09c014

Fix by calling mmc_host_enable() after the device interface clock is
enabled.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5d46021..58a2c5e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2101,14 +2101,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	/* we start off in DISABLED state */
 	host->dpm_state = DISABLED;
 
-	if (mmc_host_enable(host->mmc) != 0) {
+	if (clk_enable(host->iclk) != 0) {
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
 	}
 
-	if (clk_enable(host->iclk) != 0) {
-		mmc_host_disable(host->mmc);
+	if (mmc_host_enable(host->mmc) != 0) {
+		clk_disable(host->iclk);
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
-- 
1.7.2.3

