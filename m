Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524B13D61A;
	Mon,  1 Jul 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835637; cv=none; b=JWdKqLaktFk8IClZ2SMeFkRbD7+iKSTLapC0xNAs+aYAKwb0e5684JsyDk57fZsIW+Uds8hFUsWhv54hvF0Q2A2gFRFsJu5PrCU896a7Muan347vwMv8epNJr1JflXcYaFS7Grdg5n4HgLmLPrxXsJKx74u7kEwS6aE00R78kXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835637; c=relaxed/simple;
	bh=WEqgwiJL4AgHm9RFyD2B+/GN8B2LwoYp8qyKJWDHSMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9ipj2YHTjvMH7aRRwoVwQo3q58CtqrH+tY7fFcPUKO6qGb3iS/S2vP8r81V0p+2yzHKrW9jcPrsEAcTJTw2efuWheeZHBfiMRpUcffd10fcokCHoyzabzLVKOtCD85RRf3B11AVHkqHmC5E4lvkGSKWwA8bT1eLHWvstiLHTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbf1qXP6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbf1qXP6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ce674da85so3134811e87.2;
        Mon, 01 Jul 2024 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719835633; x=1720440433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzWJ6PJpGMeRR+vNNCKFpzuvLIUp4qYOq0s9qfzZzPM=;
        b=Bbf1qXP6LTf1pJ/MZMzSLNslO8GqXWrAF/+26DdbYQjSxq08Wd/g63IHC7GqSOnoFD
         lK5BFMwmK8LT6XxRpZz14HD09I3lBHqL1m/nXNWGiz7cji22K1QeB1t4UxHdsWMZnCtL
         YgU5M+2xUVyt3JUuPEbI0yLPpQFE2ueEOjqWrGhWDLxQ6/uKot4VLqYQF+byqxc7Awty
         VZNc4cX6PONynHgAboDLRAG9317imT9BNB0HySviKSUkAXGdVclGK6BmHPCOmqcKA9yv
         8ON0/Q+x2wWfumYAiRJWKrFtFsfJwoFTQYbV0BYAZ7hmhD+BEs26jWSUTMNOr6XhYpJI
         rdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835633; x=1720440433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzWJ6PJpGMeRR+vNNCKFpzuvLIUp4qYOq0s9qfzZzPM=;
        b=XYN59HacutDtjsjSuF/B4pL9TWQGLcw86tA6qHwSFxbbf0LWKcP+6pP2y1lWHvItuV
         6guI2izYZIx94nt+hbyMcshhsYbR+wWsRs4zWBdKf2L6VLZupzt6zV7F9CWUyZN37yX+
         G2cLBHXMkwuLkY5uSxCRnybKAm1tE7isa2Yb6bMMiH17Hh7Krk9k+h9vlOQpHGUhRbN3
         dX0iS9kig+9Xr52WCCK/Epd2EZSxBt4xuAwspo49fe3j4h39EJr7JVqRy7gz5kl9VsNb
         4DWN8JQ7SMugyM2eoS1dfwHlLPygAIkpmPpAYi4e4bbo5BDof5oztuhhl3ueWbI9Krl1
         Q0vw==
X-Forwarded-Encrypted: i=1; AJvYcCWopXwqS3Gy5q3KuH6MpjH8IVmHVnBpgzARYN+2jdLY4XjTz2RbtEybku/eQageYKSLrRAB42tiBypsMXmMrI/2InUb6QJBKp61
X-Gm-Message-State: AOJu0Yw0cxNgUVPVs+PthNMO6L2EZPtq11C3MCQ/J6e6DXwiOV4PcRVT
	ePCyWdIRtnBlqa7tikd2+aNwqOKT2LBiUlvdRvxKnpPil8f/z0dlt8klW3TJ
X-Google-Smtp-Source: AGHT+IEz+td6Pt75zfqjEaiKa9YSArLmgdiP1EZ/38p8OdxrOm+20jFf7JOGxpUX5KVJhxxfNqSwJg==
X-Received: by 2002:a05:6512:6ca:b0:52c:db76:1c2d with SMTP id 2adb3069b0e04-52e8274ad30mr3908154e87.63.1719835632883;
        Mon, 01 Jul 2024 05:07:12 -0700 (PDT)
Received: from localhost.localdomain ([94.25.177.16])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3c3eesm1397088e87.304.2024.07.01.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:07:12 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mikhail Krasheninnikov <krashmisha@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Matwey Kornilov <matwey.kornilov@gmail.com>
Subject: [PATCH] mmc/virtio: Add virtio MMC driver for QEMU emulation
Date: Mon,  1 Jul 2024 12:06:42 +0000
Message-Id: <20240701120642.30001-1-krashmisha@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new virtio MMC driver to enable virtio SD/MMC card
emulation with QEMU. This driver allows emulating MMC cards in
virtual environments, enhancing functionality and testing
capabilities within QEMU.

Link to the QEMU patch: https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00664.html

No changes to existing dependencies or documentation.

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
---
 drivers/mmc/core/mmc_ops.c      |   2 +
 drivers/mmc/host/Kconfig        |  14 ++
 drivers/mmc/host/Makefile       |   2 +
 drivers/mmc/host/virtio-mmc.c   | 266 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/virtio-mmc.h   |  42 +++++
 include/uapi/linux/virtio_ids.h |   1 +
 6 files changed, 327 insertions(+)
 create mode 100644 drivers/mmc/host/virtio-mmc.c
 create mode 100644 drivers/mmc/host/virtio-mmc.h

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..4e663140048a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -5,6 +5,7 @@
  *  Copyright 2006-2007 Pierre Ossman
  */
 
+#include "linux/printk.h"
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/types.h>
@@ -459,6 +460,7 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 
 static int mmc_busy_cb(void *cb_data, bool *busy)
 {
+	pr_info("mmc_busy_cb\n");
 	struct mmc_busy_data *data = cb_data;
 	struct mmc_host *host = data->card->host;
 	u32 status = 0;
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..eb0b0e80250d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1069,3 +1069,17 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config MMC_VIRTIO
+	tristate "VirtIO MMC Host Controller support"
+	depends on VIRTIO
+	help
+	  This enables support for the Virtio MMC driver, which allows the
+	  kernel to interact with MMC devices over Virtio. Virtio is a
+	  virtualization standard for network and disk device drivers,
+	  providing a common API for virtualized environments.
+
+	  Enable this option if you are running the kernel in a virtualized
+	  environment and need MMC support via Virtio.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1c..d53493d0a692 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -108,3 +108,5 @@ endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
+
+obj-$(CONFIG_MMC_VIRTIO)	+= virtio-mmc.o
\ No newline at end of file
diff --git a/drivers/mmc/host/virtio-mmc.c b/drivers/mmc/host/virtio-mmc.c
new file mode 100644
index 000000000000..b192bd0b9ffd
--- /dev/null
+++ b/drivers/mmc/host/virtio-mmc.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+
+#include "virtio-mmc.h"
+#include "asm-generic/int-ll64.h"
+#include "linux/completion.h"
+#include "linux/kern_levels.h"
+#include "linux/mmc/core.h"
+#include "linux/mmc/host.h"
+#include "linux/printk.h"
+#include "linux/scatterlist.h"
+#include "linux/types.h"
+#include "linux/virtio_config.h"
+#include <linux/virtio.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+
+struct mmc_req {
+	u32 opcode;
+	u32 arg;
+};
+
+struct virtio_mmc_request {
+	u8 flags;
+
+#define VIRTIO_MMC_REQUEST_DATA BIT(1)
+#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
+#define VIRTIO_MMC_REQUEST_STOP BIT(3)
+#define VIRTIO_MMC_REQUEST_SBC BIT(4)
+
+	struct mmc_req request;
+
+	u8 buf[4096];
+	size_t buf_len;
+
+	struct mmc_req stop_req;
+	struct mmc_req sbc_req;
+};
+
+struct virtio_mmc_response {
+	u32 cmd_resp[4];
+	int cmd_resp_len;
+	u8 buf[4096];
+};
+
+struct virtio_mmc_host {
+	struct virtio_device *vdev;
+	struct mmc_host *mmc;
+	struct virtqueue *vq;
+	struct mmc_request *current_request;
+
+	struct virtio_mmc_request virtio_request;
+	struct virtio_mmc_response virtio_response;
+
+	struct completion request_handled;
+};
+
+static void virtio_mmc_vq_callback(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct mmc_host *mmc;
+	struct virtio_mmc_host *host;
+	struct virtio_mmc_request *virtio_request;
+	struct virtio_mmc_response *virtio_response;
+	struct mmc_request *mrq;
+
+	mmc = vq->vdev->priv;
+	host = mmc_priv(mmc);
+	mrq = host->current_request;
+	virtio_request = &host->virtio_request;
+
+	virtio_response = virtqueue_get_buf(vq, &len);
+
+	memcpy(mrq->cmd->resp, virtio_response->cmd_resp,
+	       virtio_response->cmd_resp_len);
+
+	if (virtio_request->flags & VIRTIO_MMC_REQUEST_DATA) {
+		if (!(virtio_request->flags & VIRTIO_MMC_REQUEST_WRITE)) {
+			sg_copy_from_buffer(mrq->data->sg, mrq->data->sg_len,
+					    virtio_response->buf,
+					    virtio_request->buf_len);
+		}
+		mrq->data->bytes_xfered = virtio_request->buf_len;
+	}
+
+	host->current_request = NULL;
+	mmc_request_done(mmc, mrq);
+	complete(&host->request_handled);
+}
+
+static void virtio_mmc_send_request_to_qemu(struct virtio_mmc_host *data)
+{
+	struct scatterlist sg_out_linux, sg_in_linux;
+
+	sg_init_one(&sg_out_linux, &data->virtio_request,
+		    sizeof(struct virtio_mmc_request));
+	sg_init_one(&sg_in_linux, &data->virtio_response,
+		    sizeof(struct virtio_mmc_response));
+
+	struct scatterlist *request[] = { &sg_out_linux, &sg_in_linux };
+
+	if (virtqueue_add_sgs(data->vq, request, 1, 1, &data->virtio_response,
+			      GFP_KERNEL) < 0) {
+		dev_crit(&data->vdev->dev, "virtio_mmc: Failed to add sg\n");
+		return;
+	}
+
+	virtqueue_kick(data->vq);
+	wait_for_completion(&data->request_handled);
+}
+
+static inline size_t __calculate_len(struct mmc_data *data)
+{
+	size_t len = 0;
+
+	for (int i = 0; i < data->sg_len; i++)
+		len += data->sg[i].length;
+	return len;
+}
+
+/* MMC layer callbacks */
+
+static void virtio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct virtio_mmc_host *host;
+	struct virtio_mmc_request *virtio_req;
+	struct mmc_data *mrq_data;
+
+	host = mmc_priv(mmc);
+	host->current_request = mrq; // Saving the request for the callback
+
+	virtio_req = &host->virtio_request;
+	memset(virtio_req, 0, sizeof(struct virtio_mmc_request));
+
+	virtio_req->request.opcode = mrq->cmd->opcode;
+	virtio_req->request.arg = mrq->cmd->arg;
+
+	mrq_data = mrq->data;
+	if (mrq_data) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_DATA;
+
+		virtio_req->buf_len = __calculate_len(mrq->data);
+
+		virtio_req->flags |= ((mrq_data->flags & MMC_DATA_WRITE) ?
+					      VIRTIO_MMC_REQUEST_WRITE :
+					      0);
+		if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
+			sg_copy_to_buffer(mrq_data->sg, mrq_data->sg_len,
+					  virtio_req->buf, virtio_req->buf_len);
+		}
+	}
+
+	if (mrq->stop) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_STOP;
+
+		virtio_req->stop_req.opcode = mrq->stop->opcode;
+		virtio_req->stop_req.arg = mrq->stop->arg;
+	}
+
+	if (mrq->sbc) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_SBC;
+
+		virtio_req->sbc_req.opcode = mrq->sbc->opcode;
+		virtio_req->sbc_req.arg = mrq->sbc->arg;
+	}
+
+	virtio_mmc_send_request_to_qemu(host);
+}
+
+static void virtio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+}
+
+static int virtio_mmc_get_ro(struct mmc_host *mmc)
+{
+	return 0;
+}
+
+static int virtio_mmc_get_cd(struct mmc_host *mmc)
+{
+	return 1;
+}
+
+static const struct mmc_host_ops virtio_mmc_host_ops = {
+	.request = virtio_mmc_request,
+	.set_ios = virtio_mmc_set_ios,
+	.get_ro = virtio_mmc_get_ro,
+	.get_cd = virtio_mmc_get_cd,
+};
+
+static inline void __fill_host_attr(struct mmc_host *host)
+{
+	host->ops = &virtio_mmc_host_ops;
+	host->f_min = 300000;
+	host->f_max = 500000;
+	host->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	host->caps = MMC_CAP_SD_HIGHSPEED;
+	host->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_MMC | MMC_CAP2_HS400;
+}
+
+static int create_host(struct virtio_device *vdev)
+{
+	int err;
+	struct mmc_host *mmc;
+	struct virtio_mmc_host *host;
+
+	mmc = mmc_alloc_host(sizeof(struct virtio_mmc_host), &vdev->dev);
+	if (!mmc) {
+		pr_err("virtio_mmc: Failed to allocate host\n");
+		return -ENOMEM;
+	}
+
+	__fill_host_attr(mmc);
+
+	vdev->priv = mmc;
+
+	host = mmc_priv(mmc);
+
+	init_completion(&host->request_handled);
+
+	host->vq =
+		virtio_find_single_vq(vdev, virtio_mmc_vq_callback, "vq_name");
+	if (!host->vq) {
+		pr_err("virtio_mmc: Failed to find virtqueue\n");
+		mmc_free_host(mmc);
+		return -ENODEV;
+	}
+
+	err = mmc_add_host(mmc);
+	if (err) {
+		pr_err("virtio_mmc: Failed to add host\n");
+		mmc_free_host(mmc);
+		return err;
+	}
+
+	return 0;
+}
+
+static int virtio_mmc_probe(struct virtio_device *vdev)
+{
+	int err;
+
+	err = create_host(vdev);
+	if (err)
+		pr_err("virtio_mmc: Failed to make host\n");
+
+	return 0;
+}
+
+static void remove_host(struct mmc_host *host)
+{
+	mmc_remove_host(host);
+	mmc_free_host(host);
+}
+
+static void virtio_mmc_remove(struct virtio_device *vdev)
+{
+	struct mmc_host *host = vdev->priv;
+
+	remove_host(host);
+}
diff --git a/drivers/mmc/host/virtio-mmc.h b/drivers/mmc/host/virtio-mmc.h
new file mode 100644
index 000000000000..086f33307f84
--- /dev/null
+++ b/drivers/mmc/host/virtio-mmc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+
+#ifndef _VIRTIO_MMC_H
+#define _VIRTIO_MMC_H
+
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+
+#define VIRTIO_MMC_DEV_ID 42
+
+static int virtio_mmc_probe(struct virtio_device *vdev);
+
+static void virtio_mmc_remove(struct virtio_device *vdev);
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_MMC_DEV_ID, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_mmc_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= id_table,
+	.probe		= virtio_mmc_probe,
+	.remove		= virtio_mmc_remove,
+};
+
+module_virtio_driver(virtio_mmc_driver);
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+MODULE_AUTHOR("Mikhail Krasheninnikov");
+MODULE_DESCRIPTION("VirtIO SD/MMC driver");
+MODULE_LICENSE("GPL");
+
+#endif
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..9c8a09b0f004 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_MMC           42 /* virtio mmc */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1

