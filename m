From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] mmc: host: s3cmci: no need to check return value of
 debugfs_create functions
Date: Wed, 12 Jun 2019 10:25:31 +0200
Message-ID: <20190612082531.2652-4-gregkh@linuxfoundation.org>
References: <20190612082531.2652-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190612082531.2652-1-gregkh@linuxfoundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, because there is no need to save the file dentries, remove them
from the host-specific structure and just recursively delete the
directory that the driver created, when shutting down.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/s3cmci.c | 27 ++++++---------------------
 drivers/mmc/host/s3cmci.h |  2 --
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f31333e831a7..6a91db7ca5f1 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1452,33 +1452,18 @@ DEFINE_SHOW_ATTRIBUTE(s3cmci_regs);
 static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 {
 	struct device *dev = &host->pdev->dev;
+	struct dentry *root;
 
-	host->debug_root = debugfs_create_dir(dev_name(dev), NULL);
-	if (IS_ERR(host->debug_root)) {
-		dev_err(dev, "failed to create debugfs root\n");
-		return;
-	}
-
-	host->debug_state = debugfs_create_file("state", 0444,
-						host->debug_root, host,
-						&s3cmci_state_fops);
-
-	if (IS_ERR(host->debug_state))
-		dev_err(dev, "failed to create debug state file\n");
-
-	host->debug_regs = debugfs_create_file("regs", 0444,
-					       host->debug_root, host,
-					       &s3cmci_regs_fops);
+	root = debugfs_create_dir(dev_name(dev), NULL);
+	host->debug_root = root;
 
-	if (IS_ERR(host->debug_regs))
-		dev_err(dev, "failed to create debug regs file\n");
+	debugfs_create_file("state", 0444, root, host, &s3cmci_state_fops);
+	debugfs_create_file("regs", 0444, root, host, &s3cmci_regs_fops);
 }
 
 static void s3cmci_debugfs_remove(struct s3cmci_host *host)
 {
-	debugfs_remove(host->debug_regs);
-	debugfs_remove(host->debug_state);
-	debugfs_remove(host->debug_root);
+	debugfs_remove_recursive(host->debug_root);
 }
 
 #else
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..62cae53b4271 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -70,8 +70,6 @@ struct s3cmci_host {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*debug_root;
-	struct dentry		*debug_state;
-	struct dentry		*debug_regs;
 #endif
 
 #ifdef CONFIG_ARM_S3C24XX_CPUFREQ
-- 
2.22.0
