From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap: Fix a section warning regression
Date: Sun, 27 May 2012 23:53:47 -0700
Message-ID: <20120528065347.GR17852@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab2E1Gxu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 02:53:50 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit b6e0703b (mmc: omap: make it behave well as a module) made some
__devinit changes but missed one function causing a section warning:

WARNING: vmlinux.o(.devinit.text+0x8604): Section mismatch in reference
from the function mmc_omap_probe)
The function __devinit mmc_omap_probe() references a function
__init mmc_omap_new_slot()

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1300,7 +1300,7 @@ static const struct mmc_host_ops mmc_omap_ops = {
 	.set_ios	= mmc_omap_set_ios,
 };
 
-static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
+static int __devinit mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 {
 	struct mmc_omap_slot *slot = NULL;
 	struct mmc_host *mmc;
