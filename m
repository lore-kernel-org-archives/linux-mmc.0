From: akpm@linux-foundation.org
Subject: [patch 051/232] omap_hsmmc: add debugfs entry (host registers)
Date: Tue, 22 Sep 2009 16:44:38 -0700
Message-ID: <200909222344.n8MNicFF012555@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37556 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753373AbZIWASX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:18:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ext-denis.2.karpov@nokia.com, adrian.hunter@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Denis Karpov <ext-denis.2.karpov@nokia.com>

Adds <debugfs_root>/kernel/debug/mmc<N>/regs entry, contents show
registers' state and some driver internal state variables.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
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

 drivers/mmc/host/omap_hsmmc.c |   57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-add-debugfs-entry-host-registers drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-add-debugfs-entry-host-registers
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -17,6 +17,8 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -974,6 +976,59 @@ static struct mmc_host_ops mmc_omap_ops 
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
@@ -1157,6 +1212,8 @@ static int __init omap_mmc_probe(struct 
 			goto err_cover_switch;
 	}
 
+	omap_mmc_debugfs(mmc);
+
 	return 0;
 
 err_cover_switch:
_
