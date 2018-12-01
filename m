From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mmc: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 10:24:57 -0500
Message-ID: <20181201152457.8252-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ben-linux@fluff.org, adrian.hunter@intel.com, linus.walleij@linaro.org, arnd@arndb.de, tony@atomide.com, andreas@kemnade.info, kishon@ti.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mmc/core/mmc_test.c   | 14 ++------------
 drivers/mmc/host/atmel-mci.c  | 31 +++++--------------------------
 drivers/mmc/host/omap_hsmmc.c | 14 ++------------
 drivers/mmc/host/s3cmci.c     | 30 ++++--------------------------
 4 files changed, 13 insertions(+), 76 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ef18daeaa4cc..eabb1cab1765 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3145,17 +3145,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
 	return 0;
 }
 
-static int mtf_testlist_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mtf_testlist_show, inode->i_private);
-}
-
-static const struct file_operations mmc_test_fops_testlist = {
-	.open		= mtf_testlist_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mtf_testlist);
 
 static void mmc_test_free_dbgfs_file(struct mmc_card *card)
 {
@@ -3216,7 +3206,7 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
 		goto err;
 
 	ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
-		&mmc_test_fops_testlist);
+		&mtf_testlist_fops);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index be53044086c7..7469a7e369c0 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -446,18 +446,7 @@ static int atmci_req_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int atmci_req_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, atmci_req_show, inode->i_private);
-}
-
-static const struct file_operations atmci_req_fops = {
-	.owner		= THIS_MODULE,
-	.open		= atmci_req_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(atmci_req);
 
 static void atmci_show_status_reg(struct seq_file *s,
 		const char *regname, u32 value)
@@ -583,18 +572,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	return ret;
 }
 
-static int atmci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, atmci_regs_show, inode->i_private);
-}
-
-static const struct file_operations atmci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= atmci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(atmci_regs);
 
 static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 {
@@ -608,13 +586,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 		return;
 
 	node = debugfs_create_file("regs", S_IRUSR, root, host,
-			&atmci_regs_fops);
+				   &atmci_regs_fops);
 	if (IS_ERR(node))
 		return;
 	if (!node)
 		goto err;
 
-	node = debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
+	node = debugfs_create_file("req", S_IRUSR, root, slot,
+				   &atmci_req_fops);
 	if (!node)
 		goto err;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 467d889a1638..6094e9e687b1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1652,7 +1652,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
+static int mmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1691,17 +1691,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int omap_hsmmc_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, omap_hsmmc_regs_show, inode->i_private);
-}
-
-static const struct file_operations mmc_regs_fops = {
-	.open           = omap_hsmmc_regs_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mmc_regs);
 
 static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f77493604312..51069a43d609 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1406,18 +1406,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int s3cmci_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, s3cmci_state_show, inode->i_private);
-}
-
-static const struct file_operations s3cmci_fops_state = {
-	.owner		= THIS_MODULE,
-	.open		= s3cmci_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(s3cmci_state);
 
 #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
 
@@ -1459,18 +1448,7 @@ static int s3cmci_regs_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int s3cmci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, s3cmci_regs_show, inode->i_private);
-}
-
-static const struct file_operations s3cmci_fops_regs = {
-	.owner		= THIS_MODULE,
-	.open		= s3cmci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(s3cmci_regs);
 
 static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 {
@@ -1484,14 +1462,14 @@ static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 
 	host->debug_state = debugfs_create_file("state", 0444,
 						host->debug_root, host,
-						&s3cmci_fops_state);
+						&s3cmci_state_fops);
 
 	if (IS_ERR(host->debug_state))
 		dev_err(dev, "failed to create debug state file\n");
 
 	host->debug_regs = debugfs_create_file("regs", 0444,
 					       host->debug_root, host,
-					       &s3cmci_fops_regs);
+					       &s3cmci_regs_fops);
 
 	if (IS_ERR(host->debug_regs))
 		dev_err(dev, "failed to create debug regs file\n");
-- 
2.17.0
