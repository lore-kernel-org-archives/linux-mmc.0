From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: [PATCH] mmc: Convert s3cmci driver to gpiolib API
Date: Sat, 30 Jun 2012 14:24:22 +0200
Message-ID: <1341059062-16530-1-git-send-email-sylvester.nawrocki@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

The s3c2410_gpio* calls are obsolete and have been scheduled for
removal since several kernel releases. Remove them and use common
gpiolib API.

This patch is a prerequisite for removal of the S3C24XX SoC specific
arch/arm/plat-samsung/include/gpio-fns.h header.

Tested on Micro2440-SDK.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 drivers/mmc/host/s3cmci.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index c3622a6..bd5a5cc 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -26,7 +26,6 @@
 #include <mach/dma.h>

 #include <mach/regs-sdi.h>
-#include <mach/regs-gpio.h>

 #include <plat/mci.h>

@@ -1237,12 +1236,9 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_ON:
 	case MMC_POWER_UP:
-		s3c2410_gpio_cfgpin(S3C2410_GPE(5), S3C2410_GPE5_SDCLK);
-		s3c2410_gpio_cfgpin(S3C2410_GPE(6), S3C2410_GPE6_SDCMD);
-		s3c2410_gpio_cfgpin(S3C2410_GPE(7), S3C2410_GPE7_SDDAT0);
-		s3c2410_gpio_cfgpin(S3C2410_GPE(8), S3C2410_GPE8_SDDAT1);
-		s3c2410_gpio_cfgpin(S3C2410_GPE(9), S3C2410_GPE9_SDDAT2);
-		s3c2410_gpio_cfgpin(S3C2410_GPE(10), S3C2410_GPE10_SDDAT3);
+		/* Configure GPE5...GPE10 pins in SD mode */
+		s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
+				      S3C_GPIO_PULL_NONE);

 		if (host->pdata->set_power)
 			host->pdata->set_power(ios->power_mode, ios->vdd);
--
1.7.4.1
