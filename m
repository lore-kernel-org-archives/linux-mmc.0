From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] MMC: omap_hsmmc: enable interface clock before calling
 mmc_host_enable()
Date: Fri, 25 Feb 2011 18:26:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251823540.6198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com> <AANLkTikMerO+FFsCJkiX7xa5m51zmKhQbikHDxT8GPK8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1BZB0q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 20:26:46 -0500
In-Reply-To: <AANLkTikMerO+FFsCJkiX7xa5m51zmKhQbikHDxT8GPK8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, linux-omap@vger.kernel.org


Hi Chris,

would you like to take this one, or should we merge it through the OMAP 
tree?


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 25 Feb 2011 18:22:08 -0700
Subject: [PATCH] MMC: omap_hsmmc: enable interface clock before calling mmc_host_enable()

The code path entered via mmc_host_enable() can include register
accesses to the HSMMC IP block.  For this to work, both the device
interface clock and functional clock need to be enabled before
mmc_host_enable() is called.  However, omap_hsmmc_probe() calls
mmc_host_enable() before enabling the device interface clock.

Fix by calling mmc_host_enable() after the device interface clock is
enabled.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Acked-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 078fdf1..0cf0d89 100644
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

