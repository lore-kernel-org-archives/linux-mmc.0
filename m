Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEE1DA319
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jul 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019949; cv=none; b=cPn2GXAOqKLAswETtxPtq5vrS+PDJywoi8T+GMn2jeRKw0A5mLvTvBXZ3nTi6JmfnCs4Ggo60bh45NzV2Rj6Eqmr+uQ5AwCqEs+j75mLjEYQLAq/WC6jJjz+/fgnkq7SnZWtsiUZZD58NBMy0tk5a+QrhIF4ea+E3OXIsGNj24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019949; c=relaxed/simple;
	bh=AhEkhUjwAwCZNGM1WbRYMLuiqUmlSqwK6e/NTWOSKQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOyrfQzEE0vqpwrSK9ZV/Fxm9lT08x2D6kTiP5TzYhZKpClRHTbnsTLkxGAMGxt2mor5SSpywiRaihggNKUVDvd6bJ97gxLxCJOzKv04PR7Ljg45KCYoH4bgj+vYQo77Vk15+73Q17PY9DuKelqZTBzNAYH459l00/efhHnBtVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBeM/ssN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBeM/ssN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdbvXL65U7gamXn5Q823zN/r/LJrVkQ2GWKPVXvliZo=;
	b=KBeM/ssNhamXOi1zKoWX5Dyvct6cxZV2hEptfAFnHry7iMek+ldXexykvz22MHe1gWH9fA
	W3JB8DzagJqUFcbZS/MZB33XN8lMjU/PKhyrRTIfIyhvebYtFiN2OwjyyCITXc8ugZJeOq
	v7Fo6U1iZQKrmr+mtCoZzw4d436VeuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-TqPD6Df4MdKjsbTac_cGUQ-1; Wed, 03 Jul 2024 11:19:05 -0400
X-MC-Unique: TqPD6Df4MdKjsbTac_cGUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4258675a6easo25560235e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jul 2024 08:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019944; x=1720624744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdbvXL65U7gamXn5Q823zN/r/LJrVkQ2GWKPVXvliZo=;
        b=pdjFfYgJW5S8FTqTbONsD/VxqkWueXNVZeB0r3OEUtak91wJpIrXigpDQTTB77uHv5
         osP3d6MXMHbXjewtQrbQymwrazTgZTJP6cWzNe3NqFFwHsl9HjosPT9g6I6sl/3hoUFz
         TWuAlugmbZApsRv2/Uf5727XWuNMk1IDl2Qlx49/UNg3NLUaOuadSRqZ2VEZt81cOBsi
         kYPqD8ExcaSOXODA4LbMn76dKq0VIz3uzp/1GCFtZOSWQOrPYES1W3x7O3BlEEwEplIB
         0rKH7VhDJ/aQkHaRJDySF3IeN4gpu4DqDA7EQpV2qVK39FHpcciSkExKHh+hGlud5AhU
         oA4g==
X-Forwarded-Encrypted: i=1; AJvYcCUerdq1iUZywvzjS3SMSaovVeBjgXWzBmtpzYMc3+cHX8WShsNMQ5Y4A2aiP66rDgndleeUFSnVNdr07HsGbN+g8aF0IsIFd1s5
X-Gm-Message-State: AOJu0YzNDPR16PjkP+EjpLhCNYWnq2T18WL44ErYhffst74eD93psG9F
	ntdGNr4K+7b98uak9X49KhKxV3oGt+0+JlcdE4KZ/y/SIfe8k6jYa4KgBisXInMIwsROIBj1yUn
	07oiPBULe9hyFUMVZbmpxBDwFJFxgBHT3LP0Q0n1Sl4SMRVosfz3LAdJv9A==
X-Received: by 2002:a05:600c:19cb:b0:425:6424:6e47 with SMTP id 5b1f17b1804b1-4257a02b896mr77069045e9.2.1720019943804;
        Wed, 03 Jul 2024 08:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlxI9ojuQUPBpffMCpVF2/NXtOEHSVKe5S8Qvgkg6OFTtQC/ccbL4Q7nV8X0yPo3kZ1PZYQ==
X-Received: by 2002:a05:600c:19cb:b0:425:6424:6e47 with SMTP id 5b1f17b1804b1-4257a02b896mr77068835e9.2.1720019943037;
        Wed, 03 Jul 2024 08:19:03 -0700 (PDT)
Received: from redhat.com ([31.187.78.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257f44c730sm149183695e9.39.2024.07.03.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:19:02 -0700 (PDT)
Date: Wed, 3 Jul 2024 11:18:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Matwey Kornilov <matwey.kornilov@gmail.com>
Subject: Re: [PATCH] mmc/virtio: Add virtio MMC driver for QEMU emulation
Message-ID: <20240703110812-mutt-send-email-mst@kernel.org>
References: <20240701120642.30001-1-krashmisha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701120642.30001-1-krashmisha@gmail.com>

On Mon, Jul 01, 2024 at 12:06:42PM +0000, Mikhail Krasheninnikov wrote:
> Introduce a new virtio MMC driver to enable virtio SD/MMC card
> emulation with QEMU. This driver allows emulating MMC cards in
> virtual environments, enhancing functionality and testing
> capabilities within QEMU.
> 
> Link to the QEMU patch: https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00664.html
> 
> No changes to existing dependencies or documentation.
> 
> Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> CC: Matwey Kornilov <matwey.kornilov@gmail.com>


you should likely add a MAINTAINERS entry so people
know to copy virtio ML and core maintainers when they are
making changes.

> ---
>  drivers/mmc/core/mmc_ops.c      |   2 +
>  drivers/mmc/host/Kconfig        |  14 ++
>  drivers/mmc/host/Makefile       |   2 +
>  drivers/mmc/host/virtio-mmc.c   | 266 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/virtio-mmc.h   |  42 +++++
>  include/uapi/linux/virtio_ids.h |   1 +
>  6 files changed, 327 insertions(+)
>  create mode 100644 drivers/mmc/host/virtio-mmc.c
>  create mode 100644 drivers/mmc/host/virtio-mmc.h
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..4e663140048a 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -5,6 +5,7 @@
>   *  Copyright 2006-2007 Pierre Ossman
>   */
>  
> +#include "linux/printk.h"
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/types.h>
> @@ -459,6 +460,7 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
>  
>  static int mmc_busy_cb(void *cb_data, bool *busy)
>  {
> +	pr_info("mmc_busy_cb\n");
>  	struct mmc_busy_data *data = cb_data;
>  	struct mmc_host *host = data->card->host;
>  	u32 status = 0;


Debugging leftovers? Does not inspire confidence...


> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 554e67103c1a..eb0b0e80250d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1069,3 +1069,17 @@ config MMC_LITEX
>  	  module will be called litex_mmc.
>  
>  	  If unsure, say N.
> +
> +config MMC_VIRTIO
> +	tristate "VirtIO MMC Host Controller support"
> +	depends on VIRTIO
> +	help
> +	  This enables support for the Virtio MMC driver, which allows the
> +	  kernel to interact with MMC devices over Virtio. Virtio is a
> +	  virtualization standard for network and disk device drivers,
> +	  providing a common API for virtualized environments.
> +
> +	  Enable this option if you are running the kernel in a virtualized
> +	  environment and need MMC support via Virtio.
> +
> +	  If unsure, say N.
> \ No newline at end of file
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index a693fa3d3f1c..d53493d0a692 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -108,3 +108,5 @@ endif
>  
>  obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
>  sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
> +
> +obj-$(CONFIG_MMC_VIRTIO)	+= virtio-mmc.o
> \ No newline at end of file
> diff --git a/drivers/mmc/host/virtio-mmc.c b/drivers/mmc/host/virtio-mmc.c
> new file mode 100644
> index 000000000000..b192bd0b9ffd
> --- /dev/null
> +++ b/drivers/mmc/host/virtio-mmc.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +
> +#include "virtio-mmc.h"
> +#include "asm-generic/int-ll64.h"
> +#include "linux/completion.h"
> +#include "linux/kern_levels.h"
> +#include "linux/mmc/core.h"
> +#include "linux/mmc/host.h"
> +#include "linux/printk.h"
> +#include "linux/scatterlist.h"
> +#include "linux/types.h"
> +#include "linux/virtio_config.h"
> +#include <linux/virtio.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>

why this weird order and way to do includes?
and it looks like you are including way too much stuff.

> +
> +struct mmc_req {
> +	u32 opcode;
> +	u32 arg;

Using CPU endian format for driver to device communication
is not a good idea.

> +};
> +
> +struct virtio_mmc_request {
> +	u8 flags;
> +
> +#define VIRTIO_MMC_REQUEST_DATA BIT(1)
> +#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
> +#define VIRTIO_MMC_REQUEST_STOP BIT(3)
> +#define VIRTIO_MMC_REQUEST_SBC BIT(4)
> +
> +	struct mmc_req request;
> +
> +	u8 buf[4096];
> +	size_t buf_len;

size_t is definitely not a good idea in a driver to device
communication.

> +
> +	struct mmc_req stop_req;
> +	struct mmc_req sbc_req;
> +};
> +
> +struct virtio_mmc_response {
> +	u32 cmd_resp[4];

> +	int cmd_resp_len;

int is also not a good idea in a driver to device communication.


> +	u8 buf[4096];
> +};


looks like there's a bunch of stuff here that belongs in
uapi/linux/virtio-mmc.h (or whatever you decide to name this).

> +
> +struct virtio_mmc_host {
> +	struct virtio_device *vdev;
> +	struct mmc_host *mmc;
> +	struct virtqueue *vq;
> +	struct mmc_request *current_request;
> +
> +	struct virtio_mmc_request virtio_request;
> +	struct virtio_mmc_response virtio_response;
> +
> +	struct completion request_handled;
> +};
> +
> +static void virtio_mmc_vq_callback(struct virtqueue *vq)
> +{
> +	unsigned int len;
> +	struct mmc_host *mmc;
> +	struct virtio_mmc_host *host;
> +	struct virtio_mmc_request *virtio_request;
> +	struct virtio_mmc_response *virtio_response;
> +	struct mmc_request *mrq;
> +
> +	mmc = vq->vdev->priv;
> +	host = mmc_priv(mmc);
> +	mrq = host->current_request;
> +	virtio_request = &host->virtio_request;
> +
> +	virtio_response = virtqueue_get_buf(vq, &len);
> +
> +	memcpy(mrq->cmd->resp, virtio_response->cmd_resp,
> +	       virtio_response->cmd_resp_len);

blindly trusting device that cmd_resp_len will not overflow
the buffer is not a good idea.


> +
> +	if (virtio_request->flags & VIRTIO_MMC_REQUEST_DATA) {
> +		if (!(virtio_request->flags & VIRTIO_MMC_REQUEST_WRITE)) {
> +			sg_copy_from_buffer(mrq->data->sg, mrq->data->sg_len,
> +					    virtio_response->buf,
> +					    virtio_request->buf_len);
> +		}
> +		mrq->data->bytes_xfered = virtio_request->buf_len;

same here - validate it's reasonable


> +	}
> +
> +	host->current_request = NULL;
> +	mmc_request_done(mmc, mrq);
> +	complete(&host->request_handled);
> +}
> +
> +static void virtio_mmc_send_request_to_qemu(struct virtio_mmc_host *data)
> +{
> +	struct scatterlist sg_out_linux, sg_in_linux;
> +
> +	sg_init_one(&sg_out_linux, &data->virtio_request,
> +		    sizeof(struct virtio_mmc_request));
> +	sg_init_one(&sg_in_linux, &data->virtio_response,
> +		    sizeof(struct virtio_mmc_response));
> +
> +	struct scatterlist *request[] = { &sg_out_linux, &sg_in_linux };
> +
> +	if (virtqueue_add_sgs(data->vq, request, 1, 1, &data->virtio_response,
> +			      GFP_KERNEL) < 0) {
> +		dev_crit(&data->vdev->dev, "virtio_mmc: Failed to add sg\n");
> +		return;
> +	}
> +
> +	virtqueue_kick(data->vq);
> +	wait_for_completion(&data->request_handled);
> +}
> +
> +static inline size_t __calculate_len(struct mmc_data *data)
> +{
> +	size_t len = 0;
> +
> +	for (int i = 0; i < data->sg_len; i++)
> +		len += data->sg[i].length;
> +	return len;
> +}
> +
> +/* MMC layer callbacks */
> +
> +static void virtio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct virtio_mmc_host *host;
> +	struct virtio_mmc_request *virtio_req;
> +	struct mmc_data *mrq_data;
> +
> +	host = mmc_priv(mmc);
> +	host->current_request = mrq; // Saving the request for the callback

no locking anywhere ...
does something else guarantee there's always just one request
outstanding?


> +
> +	virtio_req = &host->virtio_request;
> +	memset(virtio_req, 0, sizeof(struct virtio_mmc_request));
> +
> +	virtio_req->request.opcode = mrq->cmd->opcode;
> +	virtio_req->request.arg = mrq->cmd->arg;
> +
> +	mrq_data = mrq->data;
> +	if (mrq_data) {
> +		virtio_req->flags |= VIRTIO_MMC_REQUEST_DATA;
> +
> +		virtio_req->buf_len = __calculate_len(mrq->data);
> +
> +		virtio_req->flags |= ((mrq_data->flags & MMC_DATA_WRITE) ?
> +					      VIRTIO_MMC_REQUEST_WRITE :
> +					      0);
> +		if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
> +			sg_copy_to_buffer(mrq_data->sg, mrq_data->sg_len,
> +					  virtio_req->buf, virtio_req->buf_len);
> +		}
> +	}
> +
> +	if (mrq->stop) {
> +		virtio_req->flags |= VIRTIO_MMC_REQUEST_STOP;
> +
> +		virtio_req->stop_req.opcode = mrq->stop->opcode;
> +		virtio_req->stop_req.arg = mrq->stop->arg;
> +	}
> +
> +	if (mrq->sbc) {
> +		virtio_req->flags |= VIRTIO_MMC_REQUEST_SBC;
> +
> +		virtio_req->sbc_req.opcode = mrq->sbc->opcode;
> +		virtio_req->sbc_req.arg = mrq->sbc->arg;
> +	}
> +
> +	virtio_mmc_send_request_to_qemu(host);
> +}
> +
> +static void virtio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +}
> +
> +static int virtio_mmc_get_ro(struct mmc_host *mmc)
> +{
> +	return 0;
> +}
> +
> +static int virtio_mmc_get_cd(struct mmc_host *mmc)
> +{
> +	return 1;
> +}
> +
> +static const struct mmc_host_ops virtio_mmc_host_ops = {
> +	.request = virtio_mmc_request,
> +	.set_ios = virtio_mmc_set_ios,
> +	.get_ro = virtio_mmc_get_ro,
> +	.get_cd = virtio_mmc_get_cd,
> +};
> +
> +static inline void __fill_host_attr(struct mmc_host *host)
> +{
> +	host->ops = &virtio_mmc_host_ops;
> +	host->f_min = 300000;
> +	host->f_max = 500000;
> +	host->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +	host->caps = MMC_CAP_SD_HIGHSPEED;
> +	host->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_MMC | MMC_CAP2_HS400;
> +}
> +
> +static int create_host(struct virtio_device *vdev)
> +{
> +	int err;
> +	struct mmc_host *mmc;
> +	struct virtio_mmc_host *host;
> +
> +	mmc = mmc_alloc_host(sizeof(struct virtio_mmc_host), &vdev->dev);
> +	if (!mmc) {
> +		pr_err("virtio_mmc: Failed to allocate host\n");
> +		return -ENOMEM;
> +	}
> +
> +	__fill_host_attr(mmc);
> +
> +	vdev->priv = mmc;
> +
> +	host = mmc_priv(mmc);
> +
> +	init_completion(&host->request_handled);
> +
> +	host->vq =
> +		virtio_find_single_vq(vdev, virtio_mmc_vq_callback, "vq_name");
> +	if (!host->vq) {
> +		pr_err("virtio_mmc: Failed to find virtqueue\n");
> +		mmc_free_host(mmc);
> +		return -ENODEV;
> +	}
> +
> +	err = mmc_add_host(mmc);


can you get requests immediately at this point?
if yes you need to call virtio_device_ready before
you add buffers.

> +	if (err) {
> +		pr_err("virtio_mmc: Failed to add host\n");
> +		mmc_free_host(mmc);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtio_mmc_probe(struct virtio_device *vdev)
> +{
> +	int err;
> +
> +	err = create_host(vdev);
> +	if (err)
> +		pr_err("virtio_mmc: Failed to make host\n");
> +
> +	return 0;
> +}
> +
> +static void remove_host(struct mmc_host *host)
> +{

does not look like you are doing anything to quiesce the
device.


> +	mmc_remove_host(host);
> +	mmc_free_host(host);
> +}
> +
> +static void virtio_mmc_remove(struct virtio_device *vdev)
> +{
> +	struct mmc_host *host = vdev->priv;
> +
> +	remove_host(host);
> +}
> diff --git a/drivers/mmc/host/virtio-mmc.h b/drivers/mmc/host/virtio-mmc.h
> new file mode 100644
> index 000000000000..086f33307f84
> --- /dev/null
> +++ b/drivers/mmc/host/virtio-mmc.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +
> +#ifndef _VIRTIO_MMC_H
> +#define _VIRTIO_MMC_H
> +
> +#include <linux/virtio.h>
> +#include <linux/virtio_ids.h>
> +
> +#define VIRTIO_MMC_DEV_ID 42
> +
> +static int virtio_mmc_probe(struct virtio_device *vdev);
> +
> +static void virtio_mmc_remove(struct virtio_device *vdev);
> +
> +static const struct virtio_device_id id_table[] = {
> +	{ VIRTIO_MMC_DEV_ID, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_mmc_driver = {
> +	.driver = {
> +		.name	= KBUILD_MODNAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.id_table	= id_table,
> +	.probe		= virtio_mmc_probe,
> +	.remove		= virtio_mmc_remove,
> +};
> +
> +module_virtio_driver(virtio_mmc_driver);
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +
> +MODULE_AUTHOR("Mikhail Krasheninnikov");
> +MODULE_DESCRIPTION("VirtIO SD/MMC driver");
> +MODULE_LICENSE("GPL");
> +
> +#endif
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..9c8a09b0f004 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_MMC           42 /* virtio mmc */
>  
>  /*
>   * Virtio Transitional IDs
> -- 
> 2.34.1
> 

