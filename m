From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] mmcoops with panic/oops
Date: Tue, 30 Nov 2010 17:42:13 +0900
Message-ID: <4CF4B8E5.9070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44432 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab0K3IpT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 03:45:19 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCO00EJJW6DTT00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 17:42:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCO00169W6D7N@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 17:42:13 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>

This patch is mmcoops.

When Kernel panic or oops, write panic log to circular buffer in eMMC.
then after reset, we can see the log in MMC.

So we need change mmc_wait_for_req().
because if we used schedule(), we can find atomic schedule warning.
That is not our needs log. so i used delay.
i want to know how about __mmc_wait_for_req()

If any question, let me know.

Thanks,
Jaehoon Chung

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
 drivers/mmc/card/Kconfig    |    6 +
 drivers/mmc/card/Makefile   |    1 +
 drivers/mmc/card/mmc_oops.c |  270 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.c     |   47 +++++++-
 include/linux/mmc/core.h    |    1 +
 include/linux/mmcoops.h     |   12 ++
 6 files changed, 330 insertions(+), 7 deletions(-)
 create mode 100644 drivers/mmc/card/mmc_oops.c
 create mode 100644 include/linux/mmcoops.h

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 57e4416..02c9256 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -54,6 +54,12 @@ config SDIO_UART
 	help
 	  SDIO function driver for SDIO cards that implements the UART
 	  class, as well as the GPS class which appears like a UART.
+config MMC_OOPS
+	tristate "Log panic/oops to a MMC buffer"
+	help
+	  This enables panic and oops messages to be logged to a circular
+	  buffer in a MMC sectors where it can be read back at some
+	  later point.
 
 config MMC_TEST
 	tristate "MMC host test driver"
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index c73b406..09ecd82 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
+obj-$(CONFIG_MMC_OOPS)		+= mmc_oops.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
diff --git a/drivers/mmc/card/mmc_oops.c b/drivers/mmc/card/mmc_oops.c
new file mode 100644
index 0000000..79b98f2
--- /dev/null
+++ b/drivers/mmc/card/mmc_oops.c
@@ -0,0 +1,270 @@
+/*
+ *  MMC Oops/Panic logger
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
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
+#include <linux/mmcoops.h>
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
+	__mmc_wait_for_req(host, &mrq, 1);
+
+	if (cmd.error)
+		printk("%s[%d] cmd error %d\n", __func__, __LINE__, cmd.error);
+	if (data.error)
+		printk("%s[%d] data error %d\n", __func__, __LINE__, data.error);
+	/* wait busy */
+
+	cxt->count = (cxt->count + 1) % cxt->max_count;
+}
+
+static void mmcoops_do_dump(struct kmsg_dumper *dumper,
+		enum kmsg_dump_reason reason, const char *s1, unsigned long l1,
+		const char *s2, unsigned long l2)
+{
+	struct mmcoops_context *cxt = container_of(dumper,
+			struct mmcoops_context, dump);
+	struct mmc_card *card = cxt->card;
+	unsigned long s1_start, s2_start;
+	unsigned long l1_cpy, l2_cpy;
+	unsigned int count = 0;
+	char *buf;
+
+	if (!card)
+		return;
+
+	/* Only dump oopses if dump_oops is set */
+	if (reason == KMSG_DUMP_OOPS && !dump_oops)
+		return;
+
+	buf = (char *)(cxt->virt_addr + (cxt->count * RECORD_SIZE));
+	memset(buf, '\0', RECORD_SIZE);
+	count = sprintf(buf + count, "%s", MMCOOPS_KERNMSG_HDR);
+
+	l2_cpy = min(l2, (unsigned long)(RECORD_SIZE - MMCOOPS_HEADER_SIZE));
+	l1_cpy = min(l1, (unsigned long)(RECORD_SIZE - MMCOOPS_HEADER_SIZE) - l2_cpy);
+
+	s2_start = l2 - l2_cpy;
+	s1_start = l1 - l1_cpy;
+
+	memcpy(buf + count, s1 + s1_start, l1_cpy);
+	memcpy(buf + count + l1_cpy, s2 + s2_start, l2_cpy);
+
+	mmc_panic_write(cxt, buf, cxt->start + (cxt->count * 8), cxt->size);
+}
+
+static int mmc_oops_probe(struct mmc_card *card)
+{
+	struct mmcoops_context *cxt = &oops_cxt;
+
+	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
+		return -ENODEV;
+
+	cxt->card = card;
+	mmc_claim_host(card->host);
+
+	printk("%s[%d] %s\n", __func__, __LINE__, mmc_hostname(card->host));
+
+	return 0;
+}
+
+static void mmc_oops_remove(struct mmc_card *card)
+{
+	mmc_release_host(card->host);
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
+ *  lrwxrwxrwx    1 root     0               0 Jan  1 00:01 mmc0:0001 -> ../../../../class/mmc_host/mmc0/mmc0:0001
+ *  --w-------    1 root     0            4096 Jan  1 00:01 uevent
+ *  --w-------    1 root     0            4096 Jan  1 00:01 unbind
+ *
+ *  # echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
+ *
+ *  # echo mmc0:0001 > /sys/bus/mmc/drivers/mmc_oops/bind
+ *  [   48.490814] mmc_oops_probe[97] mmc0
+ */
+static struct mmc_driver mmc_driver = {
+	.drv		= {
+		.name	= "mmc_oops",
+	},
+	.probe		= mmc_oops_probe,
+	.remove		= mmc_oops_remove,
+};
+
+static int __init mmcoops_probe(struct platform_device *pdev)
+{
+	struct mmcoops_platform_data *pdata = pdev->dev.platform_data;
+	struct mmcoops_context *cxt = &oops_cxt;
+	int err = -EINVAL;
+
+	if (!pdata) {
+		dev_warn(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	cxt->start = pdata->start;
+	cxt->size = pdata->size;
+
+	/* FIXME how to get the given mmc deivce instead of bind/unbind */
+	err = mmc_register_driver(&mmc_driver);
+	if (err)
+		return err;
+
+	cxt->card = NULL;
+	cxt->count = 0;
+	cxt->max_count = (cxt->size << 9) / RECORD_SIZE;
+
+	cxt->virt_addr = kmalloc((cxt->size << 9), GFP_KERNEL);
+	if (!cxt->virt_addr)
+		goto kmalloc_failed;
+
+	cxt->dump.dump = mmcoops_do_dump;
+	err = kmsg_dump_register(&cxt->dump);
+	if (err) {
+		printk(KERN_ERR "mmcoops: registering kmsg dumper failed");
+		goto kmsg_dump_register_failed;
+	}
+
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
+static int __exit mmcoops_remove(struct platform_device *pdev)
+{
+	struct mmcoops_context *cxt = &oops_cxt;
+
+	if (kmsg_dump_unregister(&cxt->dump) < 0)
+		printk(KERN_WARNING "mmcoops: colud not unregister kmsg dumper");
+	kfree(cxt->virt_addr);
+	mmc_unregister_driver(&mmc_driver);
+
+	return 0;
+}
+
+static struct platform_driver mmcoops_driver = {
+	.remove			= __exit_p(mmcoops_remove),
+	.driver			= {
+		.name		= "mmcoops",
+		.owner		= THIS_MODULE,
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
+MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
+MODULE_DESCRIPTION("MMC Oops/Panic Looger");
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..aa32e4f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -199,24 +199,57 @@ static void mmc_wait_done(struct mmc_request *mrq)
 }
 
 /**
- *	mmc_wait_for_req - start a request and wait for completion
+ *	__mmc_wait_for_req - start a request and wait for completion
  *	@host: MMC host to start command
  *	@mrq: MMC request to start
+ *	@panic: kernel panic/oops or not
  *
  *	Start a new MMC custom command request for a host, and wait
  *	for the command to complete. Does not attempt to parse the
  *	response.
  */
-void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
+void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
+		int panic)
 {
-	DECLARE_COMPLETION_ONSTACK(complete);
+	if (panic) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		mmc_start_request(host, mrq);
+
+		spin_lock_irq(&host->wq.lock);
+		init_waitqueue_head(&host->wq);
+
+		add_wait_queue_exclusive(&host->wq, &wait);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 
-	mrq->done_data = &complete;
-	mrq->done = mmc_wait_done;
+		mdelay(10);
+		spin_unlock_irq(&host->wq.lock);
+	} else {
+		DECLARE_COMPLETION_ONSTACK(complete);
+
+		mrq->done_data = &complete;
+		mrq->done = mmc_wait_done;
+
+		mmc_start_request(host, mrq);
+
+		wait_for_completion(&complete);
+	}
+}
 
-	mmc_start_request(host, mrq);
+EXPORT_SYMBOL(__mmc_wait_for_req);
 
-	wait_for_completion(&complete);
+/**
+ *	mmc_wait_for_req - start a request and wait for completion
+ *	@host: MMC host to start command
+ *	@mrq: MMC request to start
+ *
+ *	Start a new MMC custom command request for a host, and wait
+ *	for the command to complete. Does not attempt to parse the
+ *	response.
+ */
+void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	__mmc_wait_for_req(host, mrq, 0);
 }
 
 EXPORT_SYMBOL(mmc_wait_for_req);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e013f..7107344 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -131,6 +131,7 @@ struct mmc_request {
 struct mmc_host;
 struct mmc_card;
 
+extern void __mmc_wait_for_req(struct mmc_host *, struct mmc_request *, int);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
diff --git a/include/linux/mmcoops.h b/include/linux/mmcoops.h
new file mode 100644
index 0000000..fa356eb
--- /dev/null
+++ b/include/linux/mmcoops.h
@@ -0,0 +1,12 @@
+#ifndef __MMCOOPS_H
+#define __MMCOOPS_H
+
+#include <linux/platform_device.h>
+
+struct mmcoops_platform_data {
+	struct platform_device	*pdev;
+	unsigned long		start;
+	unsigned long		size;
+};
+
+#endif
