From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci: Conditionalize regulator_get() on CONFIG_REGULATOR
Date: Sat, 30 Apr 2011 00:35:59 -0400
Message-ID: <m3r58k1hlc.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57274 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122Ab1D3Ech (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Apr 2011 00:32:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>

The regulator subsystem provides stubbed out versions of its calls that
are always present (so that they can be used without needing #ifdefs).
But the regulator_get() stub always returns an error value according
to IS_ERR(), which leads sdhci to print messages like "mmc0: no vmmc
regulator found" on every boot, even if CONFIG_REGULATOR is not set.

This patch fixes that (and removes the unwanted message) by having
the regulator_get() call occur inside an #ifdef CONFIG_REGULATOR.

Reported-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e5cfe70..e29e77a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2059,15 +2059,17 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_hostname(mmc), host);
 	if (ret)
 		goto untasklet;
 
+#ifdef CONFIG_REGULATOR
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
 		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else {
 		regulator_enable(host->vmmc);
 	}
+#endif /* CONFIG_REGULATOR */
 
 	sdhci_init(host, 0);
 
 #ifdef CONFIG_MMC_DEBUG
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
