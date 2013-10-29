From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH -next] mmc: MMC requires GPIOLIB to build
Date: Tue, 29 Oct 2013 16:35:20 +0300
Message-ID: <20131029133520.GB2180@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

MMC should select GPIOLIB to build:

ERROR: "devm_gpio_request_one" [drivers/mmc/core/mmc_core.ko] undefined!
linux-next/scripts/Makefile.modpost:90: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1
Makefile:955: recipe for target 'modules' failed

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

---

 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f2eeb38..bf44002 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -5,6 +5,7 @@
 menuconfig MMC
 	tristate "MMC/SD/SDIO card support"
 	depends on HAS_IOMEM
+	select GPIOLIB
 	help
 	  This selects MultiMediaCard, Secure Digital and Secure
 	  Digital I/O support.
