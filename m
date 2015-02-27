From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH] mmc: mmc_oops: support mmc_oops feature
Date: Fri, 27 Feb 2015 14:33:39 +0900
Message-ID: <1425015219-19849-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15703 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbB0Fdo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 00:33:44 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NKF003950S63Y00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 27 Feb 2015 14:33:42 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

When kernel is occurred the panic or oops, then save the panic/oops log
into eMMC card.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/mmc/mmcoops.txt |   23 ++
 drivers/mmc/card/Kconfig                          |    8 +
 drivers/mmc/card/Makefile                         |    1 +
 drivers/mmc/card/block.c                          |    4 +
 drivers/mmc/card/mmc_oops.c                       |  304 +++++++++++++++++++++
 drivers/mmc/core/core.c                           |   27 ++
 include/linux/mmc/card.h                          |    3 +
 include/linux/mmc/core.h                          |    3 +
 8 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmcoops.txt
 create mode 100644 drivers/mmc/card/mmc_oops.c

diff --git a/Documentation/devicetree/bindings/mmc/mmcoops.txt b/Documentation/devicetree/bindings/mmc/mmcoops.txt
new file mode 100644
index 0000000..236f6ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmcoops.txt
@@ -0,0 +1,23 @@
+* Mmcoops oops/panic logger
+
+Mmcoops is an oops/panic logger that write its logs to MMC before the system crashes.
+Introduction and concept are similar to other oops logger.
+(Refer to Documention/ramoops.txt)
+- Disadvantage: if MMC is occurred an oops/panic, this logger can't work.
+
+After reboot, you can get the last log with below command.
+#dd if=/dev/mmcblk0 of=/tmp/dump.log skip=64 count=16
+#vi dump.log
+
+Required Properties:
+
+* compatible: should be "mmcoops"
+* start-offset: block-offset for start.
+* size: the number of block to write oopses and panics.
+
+Example:
+	mmcoops {
+		compatible = "mmcoops";
+		start-offest = <64>;	/* 64 * 512B = 32KiB offset */
+		size = <16>;		/* 16 * 512B = 8KiB */
+	};
diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 5562308..3895dc1 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -68,3 +68,11 @@ config MMC_TEST
 
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
+
+config MMC_OOPS
+	tristate "Log panic/oops to a MMC buffer"
+	depends on OF
+	help
+	  This enables panic and oops messages to be logged to a circular
+	  buffer in a MMC sectors where it can be read back at some
+	  later point.
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index c73b406..f88a085 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
+obj-$(CONFIG_MMC_OOPS)		+= mmc_oops.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..61a2135 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2447,6 +2447,10 @@ static int mmc_blk_probe(struct device *dev)
 
 	dev_set_drvdata(dev, md);
 
+#ifdef CONFIG_MMC_OOPS
+	if (mmc_card_mmc(card))
+		mmc_oops_card_set(card);
+#endif
 	if (mmc_add_disk(md))
 		goto out;
 
diff --git a/drivers/mmc/card/mmc_oops.c b/drivers/mmc/card/mmc_oops.c
new file mode 100644
index 0000000..db09b47
--- /dev/null
+++ b/drivers/mmc/card/mmc_oops.c
@@ -0,0 +1,304 @@
+/*
+ *  MMC Oops/Panic logger
+ *
+ *  Copyright (C) 2010-2015 Samsung Electronics
+ *  Jaehoon Chung <jh80.chung@samsung.com>
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kmsg_dump.h>
+#include <linux/slab.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/scatterlist.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+/* TODO Unify the oops header, mmtoops, ramoops, mmcoops */
+#define MMCOOPS_KERNMSG_HDR	"===="
+#define MMCOOPS_HEADER_SIZE	(5 + sizeof(struct timeval))
+
+#define RECORD_SIZE		4096
+
+static int dump_oops = 1;
+module_param(dump_oops, int, 0600);
+MODULE_PARM_DESC(dump_oops,
+		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
+
+#define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
+
+static struct mmcoops_context {
+	struct kmsg_dumper	dump;
+	struct mmc_card		*card;
+	unsigned long		start;
+	unsigned long		size;
+	struct device		*dev;
+	struct platform_device	*pdev;
+	int			count;
+	int			max_count;
+	void			*virt_addr;
+} oops_cxt;
+
+static void mmc_panic_write(struct mmcoops_context *cxt,
+	char *buf, unsigned long start, unsigned int size)
+{
+	struct mmc_card *card = cxt->card;
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+	struct scatterlist sg;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	memset(&stop, 0, sizeof(struct mmc_command));
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	sg_init_one(&sg, buf, (size << 9));
+
+	if (size > 1)
+		cmd.opcode = MMC_WRITE_MULTIPLE_BLOCK;
+	else
+		cmd.opcode = MMC_WRITE_BLOCK;
+	cmd.arg = start;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	if (size == 1)
+		mrq.stop = NULL;
+	else {
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.arg = 0;
+		stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
+	data.blksz = 512;
+	data.blocks = size;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	mmc_wait_for_oops_req(host, &mrq);
+
+	if (cmd.error)
+		pr_info("%s: cmd error %d\n", __func__, cmd.error);
+	if (data.error)
+		pr_info("%s: data error %d\n", __func__, data.error);
+	/* wait busy */
+
+	cxt->count = (cxt->count + 1) % cxt->max_count;
+}
+
+static void mmcoops_do_dump(struct kmsg_dumper *dumper,
+		enum kmsg_dump_reason reason)
+{
+	struct mmcoops_context *cxt = container_of(dumper,
+			struct mmcoops_context, dump);
+	struct mmc_card *card = cxt->card;
+	unsigned int count = 0;
+	char *buf;
+
+	if (!card)
+		return;
+
+	mmc_claim_host(card->host);
+
+	/* Only dump oopses if dump_oops is set */
+	if (reason == KMSG_DUMP_OOPS && !dump_oops)
+		return;
+
+	buf = (char *)(cxt->virt_addr + (cxt->count * RECORD_SIZE));
+	memset(buf, '\0', RECORD_SIZE);
+	count = sprintf(buf + count, "%s", MMCOOPS_KERNMSG_HDR);
+
+	kmsg_dump_get_buffer(dumper, true, buf + MMCOOPS_HEADER_SIZE,
+			RECORD_SIZE - MMCOOPS_HEADER_SIZE, NULL);
+
+	mmc_panic_write(cxt, buf, cxt->start + (cxt->count * 8), cxt->size);
+}
+
+int  mmc_oops_card_set(struct mmc_card *card)
+{
+	struct mmcoops_context *cxt = &oops_cxt;
+
+	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
+		return -ENODEV;
+
+	cxt->card = card;
+	pr_info("%s: %s\n", mmc_hostname(card->host), __func__);
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_oops_card_set);
+
+static int mmc_oops_probe(struct device *dev)
+{
+	int ret = 0;
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	ret = mmc_oops_card_set(card);
+	if (ret)
+		return ret;
+
+	mmc_claim_host(card->host);
+
+	return 0;
+}
+
+static int mmc_oops_remove(struct device *dev)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	mmc_release_host(card->host);
+
+	return 0;
+}
+
+/*
+ * You can always switch between mmc_test and mmc_block by
+ * unbinding / binding e.g.
+ *
+ *
+ * # ls -al /sys/bus/mmc/drivers/mmcblk
+ * drwxr-xr-x    2 root     0               0 Jan  1 00:00 .
+ * drwxr-xr-x    4 root     0               0 Jan  1 00:00 ..
+ * --w-------    1 root     0            4096 Jan  1 00:01 bind
+ *  lrwxrwxrwx    1 root     0               0 Jan  1 00:01
+ *			mmc0:0001 -> ../../../../class/mmc_host/mmc0/mmc0:0001
+ *  --w-------    1 root     0            4096 Jan  1 00:01 uevent
+ *  --w-------    1 root     0            4096 Jan  1 00:01 unbind
+ *
+ *  # echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
+ *
+ *  # echo mmc0:0001 > /sys/bus/mmc/drivers/mmc_oops/bind
+ *  [   48.490814] mmc0: mmc_oops_card_set
+ */
+static struct device_driver mmc_driver = {
+	.name		= "mmc_oops",
+	.probe		= mmc_oops_probe,
+	.remove		= mmc_oops_remove,
+};
+
+/* Parsing dt node */
+static int mmcoops_parse_dt(struct mmcoops_context *cxt)
+{
+	struct device_node *np = cxt->dev->of_node;
+	u32 start_offset = 0;
+	u32 size = 0;
+	int ret = 0;
+
+	ret = of_property_read_u32(np, "start-offset", &start_offset);
+	if (ret) {
+		pr_err("%s: Start offset can't set..\n", __func__);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "size", &size);
+	if (ret) {
+		pr_err("%s: Size can't set..\n", __func__);
+		return ret;
+	}
+
+	cxt->start = start_offset;
+	cxt->size = size;
+
+	return 0;
+}
+
+static int __init mmcoops_probe(struct platform_device *pdev)
+{
+	struct mmcoops_context *cxt = &oops_cxt;
+	int err = -EINVAL;
+
+	err = mmc_register_driver(&mmc_driver);
+	if (err)
+		return err;
+
+	cxt->card = NULL;
+	cxt->count = 0;
+	cxt->dev = &pdev->dev;
+
+	err = mmcoops_parse_dt(cxt);
+	if (err) {
+		pr_err("mmcoops: parsing mmcoops property failed");
+		return err;
+	}
+
+
+	cxt->max_count = (cxt->size << 9) / RECORD_SIZE;
+
+	cxt->virt_addr = kmalloc((cxt->size << 9), GFP_KERNEL);
+	if (!cxt->virt_addr)
+		goto kmalloc_failed;
+
+	cxt->dump.dump = mmcoops_do_dump;
+
+	err = kmsg_dump_register(&cxt->dump);
+	if (err) {
+		pr_err("mmcoops: registering kmsg dumper failed");
+		goto kmsg_dump_register_failed;
+	}
+
+	pr_info("mmcoops is probed\n");
+	return err;
+
+kmsg_dump_register_failed:
+	kfree(cxt->virt_addr);
+kmalloc_failed:
+	mmc_unregister_driver(&mmc_driver);
+
+	return err;
+}
+
+static int mmcoops_remove(struct platform_device *pdev)
+{
+	struct mmcoops_context *cxt = &oops_cxt;
+
+	if (kmsg_dump_unregister(&cxt->dump) < 0)
+		pr_warn("mmcoops: colud not unregister kmsg dumper");
+	kfree(cxt->virt_addr);
+	mmc_unregister_driver(&mmc_driver);
+
+	return 0;
+}
+
+static const struct of_device_id mmcoops_match[] = {
+	{ .compatible = "mmcoops", },
+};
+
+static struct platform_driver mmcoops_driver = {
+	.remove			= mmcoops_remove,
+	.driver			= {
+		.name		= "mmcoops",
+		.of_match_table	= mmcoops_match,
+	},
+};
+
+static int __init mmcoops_init(void)
+{
+	return platform_driver_probe(&mmcoops_driver, mmcoops_probe);
+}
+
+static void __exit mmcoops_exit(void)
+{
+	platform_driver_unregister(&mmcoops_driver);
+}
+
+module_init(mmcoops_init);
+module_exit(mmcoops_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jaehoon Chung <jh80.chung@samsung.com>");
+MODULE_DESCRIPTION("MMC Oops/Panic Looger");
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 23f10f7..c91a67a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -610,6 +610,33 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
 
+#ifdef CONFIG_MMC_OOPS
+/**
+ *	mmc_wait_for_oops_req - start a oops request and wait for completion
+ *	@host: MMC host to start command
+ *	@mrq: MMC request to start
+ *
+ *	Start a new MMC custom command request for a host, and wait
+ *	for the command to complete. Does not attempt to parse the
+ *	response.
+ */
+void mmc_wait_for_oops_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	mmc_start_request(host, mrq);
+
+	spin_lock_irq(&host->wq.lock);
+	init_waitqueue_head(&host->wq);
+
+	add_wait_queue_exclusive(&host->wq, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+
+	mdelay(10);
+	spin_unlock_irq(&host->wq.lock);
+}
+#endif
+
 /**
  *	mmc_interrupt_hpi - Issue for High priority Interrupt
  *	@card: the MMC card associated with the HPI transfer
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index a6cf4c0..4a1ee03 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -517,5 +517,8 @@ extern void mmc_unregister_driver(struct device_driver *);
 
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
+#ifdef CONFIG_MMC_OOPS
+int mmc_oops_card_set(struct mmc_card *card);
+#endif /* CONFIG_MMC_OOPS */
 
 #endif /* LINUX_MMC_CARD_H */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 160448f..85533e2 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -146,6 +146,9 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *, int *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
+#ifdef CONFIG_MMC_OOPS
+extern void mmc_wait_for_oops_req(struct mmc_host *, struct mmc_request *);
+#endif /* CONFIG_MMC_OOPS */
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
-- 
1.7.9.5

