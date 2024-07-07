Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08DEDC;
	Sun,  7 Jul 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368398; cv=none; b=bJynVETBnk+TAXuEFGL/JdIbdi9zq0UDUmsbz5FyY+PD7SB2RwRn2noeaRfiRhZ/R+Yap+L3SHQcciTRGJufe35k0Y7ncEcPiOzMOl/8Zg7YWIrT9zQv/Q0yZne6CYBDwcW+pxurnRXq4Xar25hxlldyk1eSpXc2UY742xIKvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368398; c=relaxed/simple;
	bh=qmGFeqIVRtl5jDHfaj0Y735c93t8wRQZkdRzBL0WRt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVjiTZo8cz1XESw+UF5MdWW5S1c3e14dZCKxkLm2KoFds3pocuBOtXdIXdOHGkB4Filx8PRDCqaeEF9XdXXcTHpLNPnnNdJDjchxRbM9YiYn9stqyvC3EV/tM5c10zM4d3EciJkB+1Gqcy8zxAxBLQUdgockCnOkixSPm5sFt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOeIyuB3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOeIyuB3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso34791721fa.1;
        Sun, 07 Jul 2024 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720368394; x=1720973194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/HhqMkLGKu3CQaSHjV4RBU6xYguRPqmHbickJ7CSiE=;
        b=MOeIyuB3txOu1ZREUYaOqI8tiWvMNpa+H5TVJUdxheC8aFUSWawHq5AkEmvwTIX4Sc
         x0f9g0+8LtGCSeo/heJVzX1ey7nEiFdZcHbISL4+iYy3xzxFYLJ0Olni8GJUmKIp27TA
         FF5RWWUaUM4LMKy+9b9H5bubJFwZvfehRwqYrHJrPC4wKK6GkBSrKbMCTnvSiHhj9E2u
         1h1QNM3TpSZX1nAo4psCDVrfpGzezCGDgj5yIo14YYxTVxP1SLFFl+nz7qLxpmwnMvbq
         47JSI1i3WO3tMhgTCeytnnmd/1zlv+LTRc5VLDByDkDv0rgoTowhlAbFXovVNsVcT759
         4HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720368394; x=1720973194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/HhqMkLGKu3CQaSHjV4RBU6xYguRPqmHbickJ7CSiE=;
        b=Z5gUPALHe4sRioKK2TWigAmBepWzRbNI0c/hffT1RvyqVfp9I/0Kkr7YLr+KrPv9O5
         UTxet/l5/Hl/B+4dR8stJTfgBBwLmKcEvKzEmk8TpNXLh4hjhrSa+QpXsSQUfBDIAsMh
         zvsIXuaMYMru1qA+wHU8YTrCPwgBHKs8JRa9Ge+qN1jClA6b2xcvq1MIAe8L+OWPgep3
         FI6VyM2k0XgmCSfeP0DbUHvoEYGNXMf/DM3lLY3mh9RtRVLdZb8GNPJzNBh2L2umKhk8
         rfv+yjhiR1SgaF9AUjGcqKedgT5CIjwmMvgAauc7bhDWDto/IlYm/1OqwAbMcBlVRPgb
         2r+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZnzu8qhJV/tFrE8a6liOUW1+plGDoqjykqAKlZ08DAFFrJwodDRbrV5LWThcTqrLQ7iAKU3UQDJ2jOhHosKRJCq5wqzGzOSQB
X-Gm-Message-State: AOJu0YwCi2fSw+IoIgkcrJwT92O2dk3q+EEHdI1nwfSg5/U+7t3Fpha0
	bby3utz61lC5VCoZZBFcczH8hPRUvqGLvF8IGiVBVoKLb5EX5Y3tPs7KDjOs4x0=
X-Google-Smtp-Source: AGHT+IFJSW37MHNz7AelfnqDiXzYq5LprGNfj8wWYP+ZRjdVn9Y3BBHMdVaW4fab9GjZ4VU1VDOlUw==
X-Received: by 2002:a2e:a316:0:b0:2ee:7c37:a5d5 with SMTP id 38308e7fff4ca-2ee8ed879fbmr64520731fa.25.1720368393993;
        Sun, 07 Jul 2024 09:06:33 -0700 (PDT)
Received: from localhost.localdomain ([176.194.243.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee962b0f11sm6429581fa.34.2024.07.07.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 09:06:33 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mikhail Krasheninnikov <krashmisha@gmail.com>,
	Matwey Kornilov <matwey.kornilov@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2] mmc/virtio: Add virtio MMC driver for QEMU emulation
Date: Sun,  7 Jul 2024 16:05:55 +0000
Message-Id: <20240707160555.78062-1-krashmisha@gmail.com>
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

Link to the QEMU patch:
https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00221.html

No changes to existing dependencies or documentation.

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: virtualization@lists.linux-foundation.org

---
Changes from v1:
 - Add MAINTAINERS entry
 - Refactor includes
 - Change CPU endian format to little endian for device communication
 - Move structs that belonged to uapi
 - Validate multiple fields
 - Introduce mutexes for safe request handling
 - Call virtio_device_ready before adding host
 - Fix removal of the device

 MAINTAINERS                       |  15 ++
 drivers/mmc/host/Kconfig          |  14 ++
 drivers/mmc/host/Makefile         |   2 +
 drivers/mmc/host/virtio-sdhci.c   | 258 ++++++++++++++++++++++++++++++
 drivers/mmc/host/virtio-sdhci.h   |  40 +++++
 include/uapi/linux/virtio-sdhci.h |  39 +++++
 include/uapi/linux/virtio_ids.h   |   1 +
 7 files changed, 369 insertions(+)
 create mode 100644 drivers/mmc/host/virtio-sdhci.c
 create mode 100644 drivers/mmc/host/virtio-sdhci.h
 create mode 100644 include/uapi/linux/virtio-sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..be86156cd66c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22907,6 +22907,21 @@ S:	Maintained
 F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
+VIRTIO SDHCI DRIVER
+M:	Mikhail Krasheninnikov <krashmisha@gmail.com>
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+M:	Paolo Bonzini <pbonzini@redhat.com>
+M:	Stefan Hajnoczi <stefanha@redhat.com>
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	virtualization@lists.linux-foundation.org
+L:	linux-mmc@vger.kernel.org
+L:	OASIS-virtio@ConnectedCommunity.org
+S:	Maintained
+F:	drivers/mmc/host/virtio-sdhci.c
+F:	drivers/mmc/host/virtio-sdhci.h
+F:	include/uapi/linux/virtio-sdhci.h
+
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..d62d669ee117 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1069,3 +1069,17 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config SDHCI_VIRTIO
+	tristate "VirtIO SDHCI Host Controller support"
+	depends on VIRTIO
+	help
+	  This enables support for the Virtio SDHCI driver, which allows the
+	  kernel to interact with SD/MMC devices over Virtio. Virtio is a
+	  virtualization standard for network and disk device drivers,
+	  providing a common API for virtualized environments.
+
+	  Enable this option if you are running the kernel in a virtualized
+	  environment and need SD/MMC support via Virtio.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1c..f9b05a07c6db 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -108,3 +108,5 @@ endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
+
+obj-$(CONFIG_SDHCI_VIRTIO)	+= virtio-sdhci.o
\ No newline at end of file
diff --git a/drivers/mmc/host/virtio-sdhci.c b/drivers/mmc/host/virtio-sdhci.c
new file mode 100644
index 000000000000..1a637ab5e010
--- /dev/null
+++ b/drivers/mmc/host/virtio-sdhci.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+
+#include "virtio-sdhci.h"
+#include "linux/mmc/host.h"
+#include "linux/virtio.h"
+#include "linux/virtio_config.h"
+#include "linux/completion.h"
+#include "uapi/linux/virtio-sdhci.h"
+
+struct virtio_sdhci_host {
+	struct virtio_device *vdev;
+	struct mmc_host *mmc;
+	struct virtqueue *vq;
+	struct mmc_request *current_request;
+
+	struct virtio_mmc_request virtio_request;
+	struct virtio_mmc_response virtio_response;
+
+	struct completion request_handled;
+	spinlock_t handling_request;
+};
+
+static void virtio_sdhci_vq_callback(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct mmc_host *mmc;
+	struct virtio_sdhci_host *host;
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
+	if (!virtio_response)
+		return;
+
+	memcpy(mrq->cmd->resp, virtio_response->cmd_resp,
+	       min(4 * (int)sizeof(u32), virtio_response->cmd_resp_len));
+
+	if (virtio_request->flags & VIRTIO_MMC_REQUEST_DATA) {
+		mrq->data->bytes_xfered =
+			min((unsigned int)virtio_request->buf_len,
+			    mmc->max_blk_size);
+
+		if (!(virtio_request->flags & VIRTIO_MMC_REQUEST_WRITE)) {
+			sg_copy_from_buffer(mrq->data->sg, mrq->data->sg_len,
+					    virtio_response->buf,
+					    mrq->data->bytes_xfered);
+		}
+	}
+
+	complete(&host->request_handled);
+}
+
+static void virtio_sdhci_send_and_recv_request_from_qemu(struct virtio_sdhci_host *data)
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
+		dev_crit(&data->vdev->dev, "Failed to add sg\n");
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
+static void virtio_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct virtio_sdhci_host *host;
+	struct virtio_mmc_request *virtio_req;
+	struct mmc_data *mrq_data;
+
+	host = mmc_priv(mmc);
+
+	spin_lock(&host->handling_request);
+
+	WARN_ON(host->current_request != NULL);
+
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
+	virtio_sdhci_send_and_recv_request_from_qemu(host);
+
+	host->current_request = NULL;
+	spin_unlock(&host->handling_request);
+	mmc_request_done(mmc, mrq);
+}
+
+static void virtio_sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+}
+
+static int virtio_sdhci_get_ro(struct mmc_host *mmc)
+{
+	return 0;
+}
+
+static int virtio_sdhci_get_cd(struct mmc_host *mmc)
+{
+	return 1;
+}
+
+static const struct mmc_host_ops virtio_sdhci_host_ops = {
+	.request = virtio_sdhci_request,
+	.set_ios = virtio_sdhci_set_ios,
+	.get_ro = virtio_sdhci_get_ro,
+	.get_cd = virtio_sdhci_get_cd,
+};
+
+static inline void __fill_host_attr(struct mmc_host *host)
+{
+	host->ops = &virtio_sdhci_host_ops;
+	host->f_min = 300000;
+	host->f_max = 500000;
+	host->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	host->caps = MMC_CAP_SD_HIGHSPEED;
+	host->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_MMC | MMC_CAP2_HS400;
+	host->max_blk_size = 4096;
+}
+
+static int create_host(struct virtio_device *vdev)
+{
+	int err;
+	struct mmc_host *mmc;
+	struct virtio_sdhci_host *host;
+
+	mmc = mmc_alloc_host(sizeof(struct virtio_sdhci_host), &vdev->dev);
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
+	host->vdev = vdev;
+
+	spin_lock_init(&host->handling_request);
+	init_completion(&host->request_handled);
+
+	host->vq =
+		virtio_find_single_vq(vdev, virtio_sdhci_vq_callback, "vq_name");
+	if (!host->vq) {
+		pr_err("virtio_mmc: Failed to find virtqueue\n");
+		mmc_free_host(mmc);
+		return -ENODEV;
+	}
+
+	virtio_device_ready(vdev);
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
+static int virtio_sdhci_probe(struct virtio_device *vdev)
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
+static void remove_mmc_host(struct mmc_host *host)
+{
+	/*
+	 * Host is claimed while removing, so all ongoing
+	 * requests would be handled before removal and no
+	 * additional control is required
+	 */
+	mmc_remove_host(host);
+	mmc_free_host(host);
+}
+
+static void virtio_sdhci_remove(struct virtio_device *vdev)
+{
+	struct mmc_host *mmc = vdev->priv;
+	struct virtio_sdhci_host *host = mmc_priv(mmc);
+
+	complete(&host->request_handled);
+	remove_mmc_host(mmc);
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
diff --git a/drivers/mmc/host/virtio-sdhci.h b/drivers/mmc/host/virtio-sdhci.h
new file mode 100644
index 000000000000..db35268e7b64
--- /dev/null
+++ b/drivers/mmc/host/virtio-sdhci.h
@@ -0,0 +1,40 @@
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
+static int virtio_sdhci_probe(struct virtio_device *vdev);
+
+static void virtio_sdhci_remove(struct virtio_device *vdev);
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_SDHCI, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_sdhci_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= id_table,
+	.probe		= virtio_sdhci_probe,
+	.remove		= virtio_sdhci_remove,
+};
+
+module_virtio_driver(virtio_sdhci_driver);
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+MODULE_AUTHOR("Mikhail Krasheninnikov");
+MODULE_DESCRIPTION("VirtIO SD/MMC driver");
+MODULE_LICENSE("GPL");
+
+#endif
diff --git a/include/uapi/linux/virtio-sdhci.h b/include/uapi/linux/virtio-sdhci.h
new file mode 100644
index 000000000000..751ed215bc61
--- /dev/null
+++ b/include/uapi/linux/virtio-sdhci.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+#ifndef _LINUX_VIRTIO_MMC_H
+#define _LINUX_VIRTIO_MMC_H
+#include <linux/types.h>
+
+struct mmc_req {
+	__le32 opcode;
+	__le32 arg;
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
+	__le32 buf_len;
+
+	struct mmc_req stop_req;
+	struct mmc_req sbc_req;
+};
+
+struct virtio_mmc_response {
+	__le32 cmd_resp[4];
+	int cmd_resp_len;
+	u8 buf[4096];
+};
+
+#endif /* _LINUX_VIRTIO_MMC_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6de8d432db7f 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SDHCI         42 /* virtio mmc */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1

