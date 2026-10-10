Received: from mail-m118102.qiye.163.com (mail-m118102.qiye.163.com [115.236.118.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3D30F819;
	Sat, 10 Oct 2026 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626853; cv=none; b=bpqstBjzB5GFjkeywu4IXAbFCCybTC7mTC4wgnflZEL6NN6VG5OYrWViDVOLzVXqsnWnoCDM7DVUkaajf9uSaboLlWpJ3/CcawekPBbcLXeORoOLXZT9BKVIsyrh/PbAuoihWsrgr5urTkugMX5wB7z1QMOg7dEhOhK4ZPk5UJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626853; c=relaxed/simple;
	bh=Wayv4Ajw2MYBb2/zludqSex+fzbEtxkQ7xSQ+/aicK4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F17thlgcfbAh4XXp7tfJwJFSGjQKUGgA8P5uh7p4Hc2yaoqYvCNSLq6Ia2hW9ubmjPT9jgw5wkhBfaeqZLYybmG0OnZb5zu8IKPBPJxwPGHrwQpa5bVlwGhHNrlu8E4TINws/p/qUP3HwaidclUIKkbcErqiZBW3dNqzX4WwRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JkVxQK8V; arc=none smtp.client-ip=115.236.118.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JkVxQK8V"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 508f9b372;
	Sat, 10 Oct 2026 18:02:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] tty: serial: move sdio_uart from mmc/core to tty/serial
Date: Sat, 10 Oct 2026 18:01:57 +0800
Message-Id: <1791626517-18161-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa12543426203a4kunm685a0dbb9700e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGktOS1YZGUpMSh5OGB
	hITB1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JkVxQK8V9+FgwbR2cLuC8PhpoC43nU2ohQwPt1nvtnklFdIpOUoIU6cvtpim2XGyfLnAg6xwZvP1gpJZbvqO5/ZhNqvnYMSiMPl/imgt1U6dNxSIJVq/HJkbFFel2ZnT0/oBeejTOxrRk6vnbYCf53WrwZ0cp3Y3KIQebISrpBE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=a2Kq4on5A/+8+LrB8kwW5NvAdeankGNyxTEEWGV8OjA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

sdio_uart is an SDIO function driver, not part of the MMC/SDIO core.
Keeping it in drivers/mmc/core/ is misplaced: it registers to the SDIO
bus (sdio_register_driver) and only uses the public SDIO API from
include/linux/mmc/, with no dependency on any mmc core internals.

Other SDIO function drivers live under their respective functional
subsystem, e.g. the SDIO WiFi drivers are under drivers/net/wireless/.
sdio_uart should likewise be placed under its functional subsystem, tty,
just like the PCIe and I2C/SPI transport drivers (men_z135_uart,
sc16is7xx, max310x) that live under drivers/tty/serial/.

Historically almost all changes to this driver were tty API changes
(e.g. tty_operations adjustments, alloc_tty_driver removal), yet
scripts/get_maintainer.pl never listed the TTY maintainers while the
file lived under drivers/mmc/core/. Moving it under drivers/tty/serial/
makes get_maintainer.pl report the proper TTY/serial maintainers and
reviewers, which benefits future maintenance of this driver.

No functional change. The CONFIG_SDIO_UART symbol is intentionally kept
unchanged to avoid breaking existing configs; the dependency is updated
to 'TTY && MMC' accordingly.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/Kconfig                     |  7 -------
 drivers/mmc/core/Makefile                    |  1 -
 drivers/tty/serial/Kconfig                   | 10 ++++++++++
 drivers/tty/serial/Makefile                  |  1 +
 drivers/{mmc/core => tty/serial}/sdio_uart.c |  0
 5 files changed, 11 insertions(+), 8 deletions(-)
 rename drivers/{mmc/core => tty/serial}/sdio_uart.c (100%)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 14d2ecb..03061b1 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -64,13 +64,6 @@ config MMC_BLOCK_MINORS
 
 	  If unsure, say 8 here.
 
-config SDIO_UART
-	tristate "SDIO UART/GPS class support"
-	depends on TTY
-	help
-	  SDIO function driver for SDIO cards that implements the UART
-	  class, as well as the GPS class which appears like a UART.
-
 config MMC_TEST
 	tristate "MMC host test driver"
 	help
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 485b4f5..7d909f3 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -18,5 +18,4 @@ mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
-obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 mmc_core-$(CONFIG_MMC_CRYPTO)	+= crypto.o
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bf680d2..3864cef 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1387,6 +1387,16 @@ config SERIAL_MEN_Z135
 	  This driver can also be build as a module. If so, the module will be called
 	  men_z135_uart.ko
 
+config SDIO_UART
+	tristate "SDIO UART/GPS class support"
+	depends on TTY && MMC
+	help
+	  SDIO function driver for SDIO cards that implements the UART
+	  class, as well as the GPS class which appears like a UART.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sdio_uart.
+
 config SERIAL_SPRD
 	tristate "Support for Spreadtrum serial"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index bba7b21..d63b126 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_SERIAL_SCCNXP)		+= sccnxp.o
 obj-$(CONFIG_SERIAL_SC16IS7XX)		+= sc16is7xx.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_SPI)	+= sc16is7xx_spi.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_I2C)	+= sc16is7xx_i2c.o
+obj-$(CONFIG_SDIO_UART)			+= sdio_uart.o
 obj-$(CONFIG_SERIAL_SH_SCI)		+= sh-sci.o
 obj-$(CONFIG_SERIAL_SIFIVE)		+= sifive.o
 obj-$(CONFIG_SERIAL_SPRD)		+= sprd_serial.o
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/tty/serial/sdio_uart.c
similarity index 100%
rename from drivers/mmc/core/sdio_uart.c
rename to drivers/tty/serial/sdio_uart.c
-- 
2.7.4

