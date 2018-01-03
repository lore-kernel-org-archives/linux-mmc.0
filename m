From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [v2] s3mci: mark debug_regs[] as static
Date: Wed,  3 Jan 2018 23:49:18 +0100
Message-ID: <20180103224939.4104207-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The global array clashes with a newly added symbol of the same name:

drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here

We should fix both, this one addresses the s3cmci driver by removing
the symbol from the global namespace. While at it, this separates
the declaration from the type definition and makes the variable const.

Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/s3cmci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 36daee1e6588..f77493604312 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1424,7 +1424,9 @@ static const struct file_operations s3cmci_fops_state = {
 struct s3cmci_reg {
 	unsigned short	addr;
 	unsigned char	*name;
-} debug_regs[] = {
+};
+
+static const struct s3cmci_reg debug_regs[] = {
 	DBG_REG(CON),
 	DBG_REG(PRE),
 	DBG_REG(CMDARG),
@@ -1446,7 +1448,7 @@ struct s3cmci_reg {
 static int s3cmci_regs_show(struct seq_file *seq, void *v)
 {
 	struct s3cmci_host *host = seq->private;
-	struct s3cmci_reg *rptr = debug_regs;
+	const struct s3cmci_reg *rptr = debug_regs;
 
 	for (; rptr->name; rptr++)
 		seq_printf(seq, "SDI%s\t=0x%08x\n", rptr->name,
-- 
2.9.0
