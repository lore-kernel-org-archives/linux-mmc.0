From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
Date: Mon, 5 Mar 2012 15:42:41 -0800
Message-ID: <20120305234240.GQ12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53091 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453Ab2CEXmp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 18:42:45 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning

Otherwise we can get following warning when re-loading the
omap_hsmmc driver module when gpio_twl4030 module is not
loaded:

omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
omap_hsmmc: probe of omap_hsmmc.0 failed with error -22

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Kevin, maybe take a look and see if this is correct and
fits into your PM branches?

Tony

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2146,6 +2146,7 @@ err_irq_cd_init:
 err_irq:
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
+	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->got_dbclk) {
 		clk_disable(host->dbclk);
