From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 8/30] omap_hsmmc: add debugfs entry (host registers)
Date: Wed, 09 Sep 2009 14:57:34 +0300
Message-ID: <20090909115734.12833.4891.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42792 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbZIIL5W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:57:22 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

>From 9ef69fd17bbd1d598a7f262d5940f88dbfff526c Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Wed, 22 Apr 2009 14:21:34 +0200
Subject: [PATCH] omap_hsmmc: add debugfs entry (host registers)

Adds <debugfs_root>/kernel/debug/mmc<N>/regs entry,
contents show registers' state and some driver internal
state variables.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   57 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1cf9cfb..cbd8376 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -17,6 +17,8 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -967,6 +969,59 @@ static struct mmc_host_ops mmc_omap_ops = {
 	/* NYET -- enable_sdio_irq */
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static int mmc_regs_show(struct seq_file *s, void *data)
+{
+	struct mmc_host *mmc = s->private;
+	struct mmc_omap_host *host = mmc_priv(mmc);
+
+	seq_printf(s, "mmc%d regs:\n", mmc->index);
+
+	seq_printf(s, "SYSCONFIG:\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, SYSCONFIG));
+	seq_printf(s, "CON:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "HCTL:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, HCTL));
+	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, SYSCTL));
+	seq_printf(s, "IE:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, IE));
+	seq_printf(s, "ISE:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, ISE));
+	seq_printf(s, "CAPA:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, CAPA));
+	return 0;
+}
+
+static int mmc_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mmc_regs_show, inode->i_private);
+}
+
+static const struct file_operations mmc_regs_fops = {
+	.open           = mmc_regs_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static void omap_mmc_debugfs(struct mmc_host *mmc)
+{
+	if (mmc->debugfs_root)
+		debugfs_create_file("regs", S_IRUSR, mmc->debugfs_root,
+			mmc, &mmc_regs_fops);
+}
+
+#else
+
+static void omap_mmc_debugfs(struct mmc_host *mmc)
+{
+}
+
+#endif
+
 static int __init omap_mmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -1150,6 +1205,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 			goto err_cover_switch;
 	}
 
+	omap_mmc_debugfs(mmc);
+
 	return 0;
 
 err_cover_switch:
-- 
1.5.6.3

