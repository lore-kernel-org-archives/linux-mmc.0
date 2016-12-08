From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: block: Move files to core
Date: Fri,  9 Dec 2016 00:48:12 +0100
Message-ID: <1481240892-2431-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37582 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbcLHXsV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2016 18:48:21 -0500
Received: by mail-wm0-f46.google.com with SMTP id t79so2650654wmt.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2016 15:48:20 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Once upon a time it made sense to keep the mmc block device driver and its
related code, in its own directory called card. Over time, more an more
functions/structures have become shared through generic mmc header files,
between the core and the card directory. In other words, the relationship
between them has become closer.

By sharing functions/structures via generic header files, it becomes easy
for outside users to abuse them. In a way to avoid that from happen, let's
move the files from card directory into the core directory, as it enables
us to move definitions of functions/structures into mmc core specific
header files.

Note, this is only the first step in providing a cleaner mmc interface for
outside users. Following changes will do the actual cleanup, as that is not
part of this change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes in v2:
	- Updated changelog to better reflect why I think this is good idea.
	- Add reviewed tag from Linus (off-list).
	- Used "git format-patch -M", per advise from Linus (thanks!!) to get a
	nice patch-diff when renaming files.


Another note; If people agree that this seems like a good idea, I intend to
queue this up for 4.10 and then work on the following clean-ups step-by-step.

---
 drivers/mmc/Kconfig                    |  2 -
 drivers/mmc/Makefile                   |  1 -
 drivers/mmc/card/Kconfig               | 70 ----------------------------------
 drivers/mmc/card/Makefile              | 10 -----
 drivers/mmc/core/Kconfig               | 66 ++++++++++++++++++++++++++++++++
 drivers/mmc/core/Makefile              |  4 ++
 drivers/mmc/{card => core}/block.c     |  0
 drivers/mmc/{card => core}/block.h     |  0
 drivers/mmc/{card => core}/mmc_test.c  |  0
 drivers/mmc/{card => core}/queue.c     |  0
 drivers/mmc/{card => core}/queue.h     |  0
 drivers/mmc/{card => core}/sdio_uart.c |  0
 12 files changed, 70 insertions(+), 83 deletions(-)
 delete mode 100644 drivers/mmc/card/Kconfig
 delete mode 100644 drivers/mmc/card/Makefile
 rename drivers/mmc/{card => core}/block.c (100%)
 rename drivers/mmc/{card => core}/block.h (100%)
 rename drivers/mmc/{card => core}/mmc_test.c (100%)
 rename drivers/mmc/{card => core}/queue.c (100%)
 rename drivers/mmc/{card => core}/queue.h (100%)
 rename drivers/mmc/{card => core}/sdio_uart.c (100%)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f2eeb38..7e803fc4 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -23,8 +23,6 @@ if MMC
 
 source "drivers/mmc/core/Kconfig"
 
-source "drivers/mmc/card/Kconfig"
-
 source "drivers/mmc/host/Kconfig"
 
 endif # MMC
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 400756e..416b6d1 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -5,5 +5,4 @@
 subdir-ccflags-$(CONFIG_MMC_DEBUG) := -DDEBUG
 
 obj-$(CONFIG_MMC)		+= core/
-obj-$(CONFIG_MMC)		+= card/
 obj-$(subst m,y,$(CONFIG_MMC))	+= host/
diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
deleted file mode 100644
index 5562308..0000000
--- a/drivers/mmc/card/Kconfig
+++ /dev/null
@@ -1,70 +0,0 @@
-#
-# MMC/SD card drivers
-#
-
-comment "MMC/SD/SDIO Card Drivers"
-
-config MMC_BLOCK
-	tristate "MMC block device driver"
-	depends on BLOCK
-	default y
-	help
-	  Say Y here to enable the MMC block device driver support.
-	  This provides a block device driver, which you can use to
-	  mount the filesystem. Almost everyone wishing MMC support
-	  should say Y or M here.
-
-config MMC_BLOCK_MINORS
-	int "Number of minors per block device"
-	depends on MMC_BLOCK
-	range 4 256
-	default 8
-	help
-	  Number of minors per block device. One is needed for every
-	  partition on the disk (plus one for the whole disk).
-
-	  Number of total MMC minors available is 256, so your number
-	  of supported block devices will be limited to 256 divided
-	  by this number.
-
-	  Default is 8 to be backwards compatible with previous
-	  hardwired device numbering.
-
-	  If unsure, say 8 here.
-
-config MMC_BLOCK_BOUNCE
-	bool "Use bounce buffer for simple hosts"
-	depends on MMC_BLOCK
-	default y
-	help
-	  SD/MMC is a high latency protocol where it is crucial to
-	  send large requests in order to get high performance. Many
-	  controllers, however, are restricted to continuous memory
-	  (i.e. they can't do scatter-gather), something the kernel
-	  rarely can provide.
-
-	  Say Y here to help these restricted hosts by bouncing
-	  requests back and forth from a large buffer. You will get
-	  a big performance gain at the cost of up to 64 KiB of
-	  physical memory.
-
-	  If unsure, say Y here.
-
-config SDIO_UART
-	tristate "SDIO UART/GPS class support"
-	depends on TTY
-	help
-	  SDIO function driver for SDIO cards that implements the UART
-	  class, as well as the GPS class which appears like a UART.
-
-config MMC_TEST
-	tristate "MMC host test driver"
-	help
-	  Development driver that performs a series of reads and writes
-	  to a memory card in order to expose certain well known bugs
-	  in host controllers. The tests are executed by writing to the
-	  "test" file in debugfs under each card. Note that whatever is
-	  on your card will be overwritten by these tests.
-
-	  This driver is only of interest to those developing or
-	  testing a host driver. Most people should say N here.
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
deleted file mode 100644
index c73b406..0000000
--- a/drivers/mmc/card/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for MMC/SD card drivers
-#
-
-obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
-mmc_block-objs			:= block.o queue.o
-obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
-
-obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
-
diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 250f223..cdfa852 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -22,3 +22,69 @@ config PWRSEQ_SIMPLE
 
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
+
+config MMC_BLOCK
+	tristate "MMC block device driver"
+	depends on BLOCK
+	default y
+	help
+	  Say Y here to enable the MMC block device driver support.
+	  This provides a block device driver, which you can use to
+	  mount the filesystem. Almost everyone wishing MMC support
+	  should say Y or M here.
+
+config MMC_BLOCK_MINORS
+	int "Number of minors per block device"
+	depends on MMC_BLOCK
+	range 4 256
+	default 8
+	help
+	  Number of minors per block device. One is needed for every
+	  partition on the disk (plus one for the whole disk).
+
+	  Number of total MMC minors available is 256, so your number
+	  of supported block devices will be limited to 256 divided
+	  by this number.
+
+	  Default is 8 to be backwards compatible with previous
+	  hardwired device numbering.
+
+	  If unsure, say 8 here.
+
+config MMC_BLOCK_BOUNCE
+	bool "Use bounce buffer for simple hosts"
+	depends on MMC_BLOCK
+	default y
+	help
+	  SD/MMC is a high latency protocol where it is crucial to
+	  send large requests in order to get high performance. Many
+	  controllers, however, are restricted to continuous memory
+	  (i.e. they can't do scatter-gather), something the kernel
+	  rarely can provide.
+
+	  Say Y here to help these restricted hosts by bouncing
+	  requests back and forth from a large buffer. You will get
+	  a big performance gain at the cost of up to 64 KiB of
+	  physical memory.
+
+	  If unsure, say Y here.
+
+config SDIO_UART
+	tristate "SDIO UART/GPS class support"
+	depends on TTY
+	help
+	  SDIO function driver for SDIO cards that implements the UART
+	  class, as well as the GPS class which appears like a UART.
+
+config MMC_TEST
+	tristate "MMC host test driver"
+	help
+	  Development driver that performs a series of reads and writes
+	  to a memory card in order to expose certain well known bugs
+	  in host controllers. The tests are executed by writing to the
+	  "test" file in debugfs under each card. Note that whatever is
+	  on your card will be overwritten by these tests.
+
+	  This driver is only of interest to those developing or
+	  testing a host driver. Most people should say N here.
+
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index f007151..b2a257d 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -12,3 +12,7 @@ mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
+obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
+mmc_block-objs			:= block.o queue.o
+obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
+obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/core/block.c
similarity index 100%
rename from drivers/mmc/card/block.c
rename to drivers/mmc/core/block.c
diff --git a/drivers/mmc/card/block.h b/drivers/mmc/core/block.h
similarity index 100%
rename from drivers/mmc/card/block.h
rename to drivers/mmc/core/block.h
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/core/mmc_test.c
similarity index 100%
rename from drivers/mmc/card/mmc_test.c
rename to drivers/mmc/core/mmc_test.c
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/core/queue.c
similarity index 100%
rename from drivers/mmc/card/queue.c
rename to drivers/mmc/core/queue.c
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/core/queue.h
similarity index 100%
rename from drivers/mmc/card/queue.h
rename to drivers/mmc/core/queue.h
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
similarity index 100%
rename from drivers/mmc/card/sdio_uart.c
rename to drivers/mmc/core/sdio_uart.c
-- 
1.9.1

