From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] s3mci: mark debug_regs[] as static
Date: Wed,  3 Jan 2018 10:26:51 +0100
Message-ID: <20180103092705.1949763-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Sergio Prado <sergio.prado@e-labworks.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The global array clashes with a newly added symbol of the same name:

drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here

We should fix both, this one addresses the s3cmci driver by removing
the symbol from the global namespace.

Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 36daee1e6588..24b27e0957e7 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1421,7 +1421,7 @@ static const struct file_operations s3cmci_fops_state = {
 
 #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
 
-struct s3cmci_reg {
+static struct s3cmci_reg {
 	unsigned short	addr;
 	unsigned char	*name;
 } debug_regs[] = {
-- 
2.9.0
