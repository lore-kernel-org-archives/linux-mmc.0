Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com [220.197.31.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00803BBA0E;
	Mon, 21 Sep 2026 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977256; cv=none; b=C0p7JWFSLa1BSp9ITMhlHzI9KNHvcPauBNOkKozsUuCdH42UYZLjhgs17RebRkJH8Ygm0zoM9Sa7UddPRXP1nY0+j59o5bPv26uYtL/j/T6j01suvDRpKIRZKpVxVDm0lSaFTBVeodI8PlrdR3JJyTsvTA4WvVdIuGAuhad2Xuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977256; c=relaxed/simple;
	bh=um64cN9AuPQatfJGrRtfe+eWMczsnRIKXJR2SrRDIew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hUhIOpym1FXRjD8ywyWTCfKwqNpHblmm1ZtwG2TIvitwqnSUuRrmwJuwd/y+iU5P2GOW0MIuxla2QrfMFYCE63c9mePDUq5JYq8bq0rmnRcHSZ9SObrda3/U2qb3/1cg2iEK7KycBfzHlP9191JmFppazFAL9l5uINT5K5xjXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UIB2VaTJ; arc=none smtp.client-ip=220.197.31.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UIB2VaTJ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e89bec6b;
	Mon, 21 Sep 2026 15:18:32 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 1/3] mmc: core: Add SDIO userspace passthrough character device
Date: Mon, 21 Sep 2026 15:18:17 +0800
Message-Id: <1789975099-157594-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c2d4acaa03a4kunm73dcdfcc310941
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0hNSlYaHU9DSx1CQh
	4eGEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UIB2VaTJ5SnKJZgw+jY/L703eIWR2PNRf6h61rcmcZFjvczpsdXeL2s6BabX/9hCnOWIopwZBSAWpNiC20V2A3yYpcggWE7I/F460bTJ22QG9p8ioNekz0DozvW7kjHM4Sa/jeI+slpDukL6W47ZhfbeJ72LpCdL9A0GFsXk1sU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KhnAGT/Dfq8pZkZgWXeHzWdSd+3LTAybCNYn2XO/n8w=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Expose a character device (/dev/mmcX:YYYY:FN) for every SDIO
function, providing userspace access to the SDIO register space:

  - SDIO_IOC_RW issues CMD52: single byte read/write. Function 0
    addresses the card common area (CCCR/FBR); with the raw flag the
    register is read back after being written.
  - SDIO_IOC_RW_EXT issues CMD53 in byte mode for 1..512 bytes.

Intended for debugging and factory test tools on systems without a
function driver (the userspace counterpart is a new 'mmc sdio'
command in mmc-utils). The ioctls require CAP_SYS_ADMIN, are gated
behind CONFIG_MMC_SDIO_CDEV and take the host claim for the duration
of each command, since raw access can disturb the state a bound
function driver maintains.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/Kconfig                 |  11 +++
 drivers/mmc/core/Makefile           |   1 +
 drivers/mmc/core/sdio_bus.c         |  12 ++-
 drivers/mmc/core/sdio_cdev.c        | 189 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio_cdev.h        |  21 ++++
 include/linux/mmc/sdio_func.h       |   4 +
 include/uapi/linux/mmc/sdio_ioctl.h |  48 +++++++++
 7 files changed, 284 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/core/sdio_cdev.c
 create mode 100644 drivers/mmc/core/sdio_cdev.h
 create mode 100644 include/uapi/linux/mmc/sdio_ioctl.h

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 2436eb4..5d0ddc5 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -13,6 +13,17 @@ menuconfig MMC
 	  If you want MMC/SD/SDIO support, you should say Y here and
 	  also to your specific host controller driver.
 
+config MMC_SDIO_CDEV
+	bool "SDIO userspace passthrough character device"
+	depends on MMC
+	default y
+	help
+	  Expose a character device (/dev/mmcX:YYYY:FN) for every SDIO
+	  function, providing CMD52/CMD53 register access to userspace
+	  via ioctl. Intended for debugging and factory test tools;
+	  raw access requires CAP_SYS_ADMIN and can disturb the state
+	  a bound function driver maintains.
+
 if MMC
 
 source "drivers/mmc/core/Kconfig"
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 15b067e..485b4f5 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_MMC)		+= mmc_core.o
+obj-$(CONFIG_MMC_SDIO_CDEV)	+= sdio_cdev.o
 mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098..06fc26cb 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -23,6 +23,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "sdio_cdev.h"
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
@@ -400,9 +401,12 @@ int sdio_add_func(struct sdio_func *func)
 	sdio_acpi_set_handle(func);
 	device_enable_async_suspend(&func->dev);
 	ret = device_add(&func->dev);
-	if (ret == 0)
+	if (ret == 0) {
 		sdio_func_set_present(func);
 
+		sdio_cdev_create(func);
+	}
+
 	return ret;
 }
 
@@ -414,8 +418,12 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	if (sdio_func_present(func))
+	if (sdio_func_present(func)) {
+		sdio_cdev_destroy(func);
+
 		device_del(&func->dev);
+	}
+
 
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
diff --git a/drivers/mmc/core/sdio_cdev.c b/drivers/mmc/core/sdio_cdev.c
new file mode 100644
index 0000000..aa2f4cf
--- /dev/null
+++ b/drivers/mmc/core/sdio_cdev.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDIO userspace passthrough character device.
+ *
+ * Copyright (C) 2026 Shawn Lin <shawn.lin@linux.dev>
+ *
+ * Every SDIO function gets a /dev/<function name> node (e.g.
+ * /dev/mmc1:0001:1); ioctls on the node issue CMD52 (single register
+ * access, function 0 included for the CCCR/FBR) and CMD53 (extended
+ * multi-byte access) to the card.
+ *
+ * Raw access can disturb the state a bound function driver maintains,
+ * so the ioctls require CAP_SYS_ADMIN and take the host claim for the
+ * duration of each command.
+ */
+#include <linux/capability.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/mmc/sdio_ioctl.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "sdio_cdev.h"
+#include "sdio_ops.h"
+
+static int sdio_cdev_rw(struct sdio_func *func,
+			struct sdio_ioc_rw __user *uarg)
+{
+	struct sdio_ioc_rw rw;
+	u8 data = 0;
+	int err, ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&rw, uarg, sizeof(rw)))
+		return -EFAULT;
+
+	if (rw.fn > 7)
+		return -EINVAL;
+
+	pm_runtime_get_sync(&func->dev);
+	sdio_claim_host(func);
+	if (rw.write && !rw.raw) {
+		/*
+		 * Plain write: pass a NULL out so the kernel does not set
+		 * the CMD52 RAW bit - out doubles as the RAW flag there.
+		 */
+		err = mmc_io_rw_direct(func->card, 1, rw.fn, rw.addr,
+				       rw.data, NULL);
+	} else {
+		err = mmc_io_rw_direct(func->card, rw.write, rw.fn, rw.addr,
+				       rw.write ? rw.data : 0, &data);
+	}
+	sdio_release_host(func);
+	pm_runtime_put_autosuspend(&func->dev);
+
+	if (err) {
+		dev_err(&func->dev, "CMD52 fn %u addr 0x%05x failed: %d\n",
+			rw.fn, rw.addr, err);
+		return err;
+	}
+
+	if (!rw.write || rw.raw)
+		rw.data = data;
+	ret = copy_to_user(uarg, &rw, sizeof(rw));
+
+	return ret ? -EFAULT : 0;
+}
+
+static int sdio_cdev_rw_ext(struct sdio_func *func,
+			    struct sdio_ioc_rw_ext __user *uarg)
+{
+	struct sdio_ioc_rw_ext rw;
+	u8 *buf;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&rw, uarg, sizeof(rw)))
+		return -EFAULT;
+
+	if (rw.fn == 0 || rw.fn > 7)
+		return -EINVAL;
+	if (!rw.count || rw.count > 512)
+		return -EINVAL;
+
+	pm_runtime_get_sync(&func->dev);
+
+	/*
+	 * Stage through a kmalloc'd buffer: rw.data lives on the ioctl
+	 * handler's stack, which is vmalloc'd with CONFIG_VMAP_STACK -
+	 * virt_to_page() on a vmalloc address is invalid, and the PIO
+	 * and DMA paths of the host drivers both derive struct pages
+	 * from the data buffer.
+	 */
+	buf = kmalloc(rw.count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (rw.write)
+		memcpy(buf, rw.data, rw.count);
+
+	sdio_claim_host(func);
+	err = mmc_io_rw_extended(func->card, rw.write, rw.fn, rw.addr,
+				 rw.incr_addr, buf, 0, rw.count);
+	sdio_release_host(func);
+	pm_runtime_put_autosuspend(&func->dev);
+
+	if (!err && !rw.write)
+		memcpy(rw.data, buf, rw.count);
+
+	kfree(buf);
+
+	if (err) {
+		dev_err(&func->dev, "CMD53 fn %u addr 0x%05x failed: %d\n",
+			rw.fn, rw.addr, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static long sdio_cdev_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct miscdevice *misc = file->private_data;
+	struct sdio_func *func = container_of(misc->parent,
+					      struct sdio_func, dev);
+
+	switch (cmd) {
+	case SDIO_IOC_RW:
+		return sdio_cdev_rw(func, (struct sdio_ioc_rw __user *)arg);
+	case SDIO_IOC_RW_EXT:
+		return sdio_cdev_rw_ext(func,
+					(struct sdio_ioc_rw_ext __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations sdio_cdev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= sdio_cdev_ioctl,
+};
+
+int sdio_cdev_create(struct sdio_func *func)
+{
+	struct miscdevice *misc;
+	int ret;
+
+	misc = kzalloc_obj(*misc);
+	if (!misc)
+		return -ENOMEM;
+
+	misc->minor = MISC_DYNAMIC_MINOR;
+	misc->name = dev_name(&func->dev);
+	misc->fops = &sdio_cdev_fops;
+	misc->parent = &func->dev;
+	func->miscdev = misc;
+
+	ret = misc_register(func->miscdev);
+	if (ret) {
+		dev_err(&func->dev, "failed to register /dev/%s: %d\n",
+			dev_name(&func->dev), ret);
+		kfree(misc);
+		func->miscdev = NULL;
+	}
+
+	return ret;
+}
+
+void sdio_cdev_destroy(struct sdio_func *func)
+{
+	if (!func->miscdev)
+		return;
+
+	misc_deregister(func->miscdev);
+	kfree(func->miscdev);
+	func->miscdev = NULL;
+}
diff --git a/drivers/mmc/core/sdio_cdev.h b/drivers/mmc/core/sdio_cdev.h
new file mode 100644
index 0000000..93bac8c
--- /dev/null
+++ b/drivers/mmc/core/sdio_cdev.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _MMC_CORE_SDIO_CDEV_H
+#define _MMC_CORE_SDIO_CDEV_H
+
+#include <linux/mmc/sdio_func.h>
+
+#ifdef CONFIG_MMC_SDIO_CDEV
+int sdio_cdev_create(struct sdio_func *func);
+void sdio_cdev_destroy(struct sdio_func *func);
+#else
+static inline int sdio_cdev_create(struct sdio_func *func)
+{
+	return 0;
+}
+
+static inline void sdio_cdev_destroy(struct sdio_func *func)
+{
+}
+#endif
+
+#endif /* _MMC_CORE_SDIO_CDEV_H */
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 5d63a64..6d01579 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -57,6 +57,10 @@ struct sdio_func {
 	const char		**info;		/* info strings */
 
 	struct sdio_func_tuple *tuples;
+
+#ifdef CONFIG_MMC_SDIO_CDEV
+	struct miscdevice	*miscdev;	/* userspace passthrough node */
+#endif
 };
 
 #define sdio_func_present(f)	((f)->state & SDIO_STATE_PRESENT)
diff --git a/include/uapi/linux/mmc/sdio_ioctl.h b/include/uapi/linux/mmc/sdio_ioctl.h
new file mode 100644
index 0000000..d099bec8
--- /dev/null
+++ b/include/uapi/linux/mmc/sdio_ioctl.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_MMC_SDIO_IOCTL_H
+#define _UAPI_LINUX_MMC_SDIO_IOCTL_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * SDIO userspace passthrough interface, issued on the character device
+ * exposed by each SDIO function (/dev/mmcX:YYYY:FN). Requires
+ * CAP_SYS_ADMIN. Raw access while a function driver is bound can
+ * disturb the state the driver maintains.
+ */
+
+/*
+ * CMD52: single byte read/write. fn 0 addresses the card common area
+ * (CCCR/FBR), functions 1-7 address the per-function registers. With
+ * raw set, the register is read back after being written and data
+ * carries the value actually read.
+ */
+struct sdio_ioc_rw {
+	__u8 write;		/* 1 = write, 0 = read */
+	__u8 fn;		/* function number, 0..7 */
+	__u8 raw;		/* read back after write */
+	__u8 data;		/* byte to write / value read */
+	__u32 addr;		/* SDIO register address */
+};
+
+/*
+ * CMD53: extended (multiple byte) read/write in byte mode, 1..512
+ * bytes. Function 0 is not valid for CMD53.
+ */
+struct sdio_ioc_rw_ext {
+	__u8 write;		/* 1 = write, 0 = read */
+	__u8 fn;		/* function number, 1..7 */
+	__u8 incr_addr;		/* 1 = incrementing address, 0 = fixed */
+	__u8 reserved1;
+	__u32 addr;		/* SDIO register address */
+	__u16 count;		/* number of bytes, 1..512 */
+	__u16 reserved2;
+	__u8 data[512];		/* data to write / buffer for read */
+};
+
+#define SDIO_IOC_MAGIC		'S'
+#define SDIO_IOC_RW		_IOWR(SDIO_IOC_MAGIC, 0x52, struct sdio_ioc_rw)
+#define SDIO_IOC_RW_EXT		_IOWR(SDIO_IOC_MAGIC, 0x53, struct sdio_ioc_rw_ext)
+
+#endif /* _UAPI_LINUX_MMC_SDIO_IOCTL_H */
-- 
2.7.4

