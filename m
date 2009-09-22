From: akpm@linux-foundation.org
Subject: [patch 052/232] omap_hsmmc: make use of new enable/disable interface
Date: Tue, 22 Sep 2009 16:44:39 -0700
Message-ID: <200909222344.n8MNid3I012581@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55655 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067AbZIWATY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:19:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Adrian Hunter <adrian.hunter@nokia.com>

For the moment enable / disable just turns the fclk on and off.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |   68 +++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-make-use-of-new-enable-disable-interface drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-make-use-of-new-enable-disable-interface
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -605,7 +605,9 @@ static void mmc_omap_detect(struct work_
 	if (host->carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	} else {
+		mmc_host_enable(host->mmc);
 		mmc_omap_reset_controller_fsm(host, SRD);
+		mmc_host_lazy_disable(host->mmc);
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
 	}
 }
@@ -818,6 +820,27 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 	return 0;
 }
 
+static int omap_mmc_enable(struct mmc_host *mmc)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	int err;
+
+	err = clk_enable(host->fclk);
+	if (err)
+		return err;
+	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
+	return 0;
+}
+
+static int omap_mmc_disable(struct mmc_host *mmc, int lazy)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+
+	clk_disable(host->fclk);
+	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
+	return 0;
+}
+
 /*
  * Request function. for read/write operation
  */
@@ -841,6 +864,8 @@ static void omap_mmc_set_ios(struct mmc_
 	unsigned long timeout;
 	u32 con;
 
+	mmc_host_enable(host->mmc);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -919,6 +944,8 @@ static void omap_mmc_set_ios(struct mmc_
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
 		OMAP_HSMMC_WRITE(host->base, CON,
 				OMAP_HSMMC_READ(host->base, CON) | OD);
+
+	mmc_host_lazy_disable(host->mmc);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -969,6 +996,8 @@ static void omap_hsmmc_init(struct mmc_o
 }
 
 static struct mmc_host_ops mmc_omap_ops = {
+	.enable = omap_mmc_enable,
+	.disable = omap_mmc_disable,
 	.request = omap_mmc_request,
 	.set_ios = omap_mmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
@@ -983,7 +1012,16 @@ static int mmc_regs_show(struct seq_file
 	struct mmc_host *mmc = s->private;
 	struct mmc_omap_host *host = mmc_priv(mmc);
 
-	seq_printf(s, "mmc%d regs:\n", mmc->index);
+	seq_printf(s, "mmc%d:\n"
+			" enabled:\t%d\n"
+			" nesting_cnt:\t%d\n"
+			"\nregs:\n",
+			mmc->index, mmc->enabled ? 1 : 0, mmc->nesting_cnt);
+
+	if (clk_enable(host->fclk) != 0) {
+		seq_printf(s, "can't read the regs\n");
+		goto err;
+	}
 
 	seq_printf(s, "SYSCONFIG:\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, SYSCONFIG));
@@ -999,6 +1037,9 @@ static int mmc_regs_show(struct seq_file
 			OMAP_HSMMC_READ(host->base, ISE));
 	seq_printf(s, "CAPA:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CAPA));
+
+	clk_disable(host->fclk);
+err:
 	return 0;
 }
 
@@ -1099,14 +1140,16 @@ static int __init omap_mmc_probe(struct 
 		goto err1;
 	}
 
-	if (clk_enable(host->fclk) != 0) {
+	mmc->caps |= MMC_CAP_DISABLE;
+	mmc_set_disable_delay(mmc, 100);
+	if (mmc_host_enable(host->mmc) != 0) {
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
 	}
 
 	if (clk_enable(host->iclk) != 0) {
-		clk_disable(host->fclk);
+		mmc_host_disable(host->mmc);
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
@@ -1197,6 +1240,8 @@ static int __init omap_mmc_probe(struct 
 	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
 	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
 
+	mmc_host_lazy_disable(host->mmc);
+
 	mmc_add_host(mmc);
 
 	if (host->pdata->slots[host->slot_id].name != NULL) {
@@ -1225,7 +1270,7 @@ err_irq_cd:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
-	clk_disable(host->fclk);
+	mmc_host_disable(host->mmc);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
@@ -1250,6 +1295,7 @@ static int omap_mmc_remove(struct platfo
 	struct resource *res;
 
 	if (host) {
+		mmc_host_enable(host->mmc);
 		mmc_remove_host(host->mmc);
 		if (host->pdata->cleanup)
 			host->pdata->cleanup(&pdev->dev);
@@ -1258,7 +1304,7 @@ static int omap_mmc_remove(struct platfo
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_scheduled_work();
 
-		clk_disable(host->fclk);
+		mmc_host_disable(host->mmc);
 		clk_disable(host->iclk);
 		clk_put(host->fclk);
 		clk_put(host->iclk);
@@ -1289,6 +1335,7 @@ static int omap_mmc_suspend(struct platf
 		return 0;
 
 	if (host) {
+		mmc_host_enable(host->mmc);
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
 			host->suspended = 1;
@@ -1307,10 +1354,11 @@ static int omap_mmc_suspend(struct platf
 
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
-			clk_disable(host->fclk);
+			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
-		}
+		} else
+			mmc_host_disable(host->mmc);
 
 	}
 	return ret;
@@ -1327,13 +1375,12 @@ static int omap_mmc_resume(struct platfo
 
 	if (host) {
 
-		ret = clk_enable(host->fclk);
-		if (ret)
+		if (mmc_host_enable(host->mmc) != 0)
 			goto clk_en_err;
 
 		ret = clk_enable(host->iclk);
 		if (ret) {
-			clk_disable(host->fclk);
+			mmc_host_disable(host->mmc);
 			clk_put(host->fclk);
 			goto clk_en_err;
 		}
@@ -1355,6 +1402,7 @@ static int omap_mmc_resume(struct platfo
 		ret = mmc_resume_host(host->mmc);
 		if (ret == 0)
 			host->suspended = 0;
+		mmc_host_lazy_disable(host->mmc);
 	}
 
 	return ret;
_
