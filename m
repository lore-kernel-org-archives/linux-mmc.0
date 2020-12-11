Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16019C4167B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FB423EF4
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbgLKLdW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgLKLdD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 06:33:03 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EBFC0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 03:32:23 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id t19so2750229uaq.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wwm6zOPoi4PewnHX/M0FVc7OW+eK52gkrmZ20s+gfBE=;
        b=P6OPuNxuh7Y9Adq5IAJX/xZdCKd6WMCawiODgutJhjY0gqq7e3tIbqTu/85cUYDUBE
         2e/CCdqZKdfhT68lKLcB6JJXwqe6a/wxeuZE8YO0RJlCANT1n63VE1XCvC21hB8FNQS6
         S2crh8TI2FJqfk+LVzCFRp59t3gEqDKbxtOADDdaJ6S0rsDsxCRDEQEEB98wsdVtVtb1
         gy+PbB0ugNor4McB4Ct+dw1gzJPaCyYLlNpggPRojBI6EJOl7+U0JWm0i02PphR6/jOm
         sZQKH9QH5RU8kdb3FJVcUECdEILkS+K+dAKxjGD6pYieoXG+A4XlQBsgG/kAMjHrWYfu
         hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwm6zOPoi4PewnHX/M0FVc7OW+eK52gkrmZ20s+gfBE=;
        b=h9ZRnwp7n2vr1tKK+JWIL0jPHnJKST981HuX5TmFSUxxLs0XGu6tzr0XBkCCcte8b2
         gCvmfyd28jbdK4Qvj8EzaZUCQ40kZt6ctMhSYvgsDmef/ILBvH9+Y6fluRFNYf+rjFQl
         35RNk/rlYmBuxRuJMRbgJ/EivLsTw+7a2NH/T+aPQWkadOM2wAmegxebIOAVj/o4K08w
         nsoZVIculo8xJocL8KHOYoKAWT9dEQyzd/mPM9LcY2NQhpOgcVHpG8w0YXtLN7pIDWZq
         ZBIyT3JpjyBp+oGf+Aw4OnCHoTIInqplQBnIOKOgcJSTIPySUpbTr/24w7Xm2kzxLlEw
         u8tQ==
X-Gm-Message-State: AOAM533xeO2MG44Q2jON1q49BIRq7aJKYseW5bdLtV6ntXbuTAZ1/OeG
        RlK3/mJehH4T2M4kCiVm/YvlacMHxbU9IWrzk5CIsg==
X-Google-Smtp-Source: ABdhPJwnLi9jMx8j/Wk3Mof4cYvt7HL/nrsmliwVtsTjliJ24hlkf4pGj4x7nGo+BEHDV0xG7GZ88oLhscUiIr8D4Bg=
X-Received: by 2002:ab0:4597:: with SMTP id u23mr12513632uau.100.1607686342736;
 Fri, 11 Dec 2020 03:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com> <20201207115753.21728-2-bbudiredla@marvell.com>
In-Reply-To: <20201207115753.21728-2-bbudiredla@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Dec 2020 12:31:46 +0100
Message-ID: <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Christoph

On Mon, 7 Dec 2020 at 12:58, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
> This patch introduces to mmcpstore. The functioning of mmcpstore
> is similar to mtdpstore. mmcpstore works on FTL based flash devices
> whereas mtdpstore works on raw flash devices. When the system crashes,
> mmcpstore stores the kmsg panic and oops logs to a user specified
> MMC device.
>
> It collects the details about the host MMC device through pstore/blk
> "blkdev" parameter. The user can specify the MMC device in many ways
> by checking in Documentation/admin-guide/pstore-blk.rst.
>
> The individual mmc host drivers have to define suitable polling and
> cleanup subroutines to write kmsg panic/oops logs through mmcpstore.
> These new host operations are needed as pstore panic write runs with
> interrupts disabled.

Apologies for the delay. I have tried to give this some more thinking,
more comments below.

[...]

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d42037f0f10d..7682b267f1d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_cqe_recovery);
>
> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> +/**
> + *     mmc_wait_for_pstore_req - initiate a blocking mmc request
> + *     @host: MMC host to start command
> + *     @mrq: MMC request to start
> + *
> + *     Start a blocking MMC request for a host and wait for the request
> + *     to complete that is based on polling and timeout.
> + */
> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       unsigned int timeout;
> +
> +       host->ops->req_cleanup_pending(host);

So, the host driver should through this callback, be able to terminate
any ongoing requests/commands - and also try to make sure that the
(e)MMC/SD card remains in the data transfer state. Moreover, no locks
and no IRQs must be used to manage this, right?

Have you really tried if this works for real?

> +       mmc_start_request(host, mrq);

This looks like the wrong approach to me, as it will try to re-use the
regular request based path, where the host driver is allowed to use
locks, IRQs, DMAs, etc, etc.

I would suggest inventing a new separate request path and a new host
ops, to deal with these kinds of requests.

In this way, the below part with host->ops->req_completion_poll, can
probably be removed. Instead we may just wait for the request to
return from the new request path.

> +
> +       if (mrq->data) {
> +               timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
> +               host->ops->req_completion_poll(host, timeout);
> +       }
> +}
> +EXPORT_SYMBOL(mmc_wait_for_pstore_req);
> +#endif
> +
>  /**
>   *     mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
>   *     @host: MMC host
> diff --git a/drivers/mmc/core/mmcpstore.c b/drivers/mmc/core/mmcpstore.c
> new file mode 100644
> index 000000000000..1113eae0756c
> --- /dev/null
> +++ b/drivers/mmc/core/mmcpstore.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MMC pstore support based on pstore/blk
> + *
> + * Copyright (c) 2020 Marvell.
> + * Author: Bhaskara Budiredla <bbudiredla@marvell.com>
> + */
> +
> +#define pr_fmt(fmt) "mmcpstore: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pstore_blk.h>
> +#include <linux/blkdev.h>
> +#include <linux/mount.h>
> +#include <linux/slab.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +#include <linux/scatterlist.h>
> +#include "block.h"
> +#include "card.h"
> +#include "core.h"
> +
> +static struct mmcpstore_context {
> +       char dev_name[BDEVNAME_SIZE];
> +       int partno;
> +       sector_t start_sect;
> +       sector_t size;
> +       struct pstore_device_info dev;
> +       struct pstore_blk_config conf;
> +       struct pstore_blk_info info;
> +
> +       char *sub;
> +       struct mmc_card *card;
> +       struct mmc_request *mrq;
> +} oops_cxt;
> +
> +static void mmc_prep_req(struct mmc_request *mrq,
> +               unsigned int sect_offset, unsigned int nsects,
> +               struct scatterlist *sg, u32 opcode, unsigned int flags)
> +{
> +       mrq->cmd->opcode = opcode;
> +       mrq->cmd->arg = sect_offset;
> +       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       if (nsects == 1) {
> +               mrq->stop = NULL;
> +       } else {
> +               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
> +               mrq->stop->arg = 0;
> +               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> +       }
> +
> +       mrq->data->blksz = SECTOR_SIZE;
> +       mrq->data->blocks = nsects;
> +       mrq->data->flags = flags;
> +       mrq->data->sg = sg;
> +       mrq->data->sg_len = 1;
> +}
> +
> +static int mmcpstore_rdwr_req(const char *buf, unsigned int nsects,
> +                       unsigned int sect_offset, unsigned int flags)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       struct mmc_request *mrq = cxt->mrq;
> +       struct mmc_card *card = cxt->card;
> +       struct mmc_host *host = card->host;
> +       struct scatterlist sg;
> +       u32 opcode;
> +
> +       if (flags == MMC_DATA_READ)
> +               opcode  = (nsects > 1) ?
> +                       MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
> +       else
> +               opcode = (nsects > 1) ?
> +                       MMC_WRITE_MULTIPLE_BLOCK : MMC_WRITE_BLOCK;
> +
> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, flags);
> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> +       mmc_set_data_timeout(mrq->data, cxt->card);
> +
> +       mmc_claim_host(host);
> +       mmc_wait_for_req(host, mrq);
> +       mdelay(mrq->data->timeout_ns / NSEC_PER_MSEC);
> +       mmc_release_host(host);
> +
> +       if (mrq->cmd->error) {
> +               pr_err("Cmd error: %d\n", mrq->cmd->error);
> +               return mrq->cmd->error;
> +       }
> +       if (mrq->data->error) {
> +               pr_err("Data error: %d\n", mrq->data->error);
> +               return mrq->data->error;
> +       }
> +
> +       return 0;
> +}
> +
> +static ssize_t mmcpstore_write(const char *buf, size_t size, loff_t off)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       int ret;
> +
> +       ret = mmcpstore_rdwr_req(buf, (size >> SECTOR_SHIFT),
> +               cxt->start_sect + (off >> SECTOR_SHIFT), MMC_DATA_WRITE);
> +       if (ret)
> +               return ret;
> +
> +       return size;
> +}
> +
> +static ssize_t mmcpstore_read(char *buf, size_t size, loff_t off)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       unsigned int sect_off = cxt->start_sect  + (off >> SECTOR_SHIFT);
> +       unsigned long sects = (cxt->conf.kmsg_size >> SECTOR_SHIFT);
> +       int ret;
> +
> +       if (unlikely(!buf || !size))
> +               return -EINVAL;
> +
> +       ret = mmcpstore_rdwr_req(cxt->sub, sects, sect_off, MMC_DATA_READ);
> +       if (ret)
> +               return ret;
> +       memcpy(buf, cxt->sub, size);
> +
> +       return size;
> +}

It looks like the above I/O read/write interface for pstore is
intended to be used when the platform is up and running and not during
a panic, correct?

If so, I don't get why it can't use the regular block interface, as
any other file system does, for example?

> +
> +static void mmcpstore_panic_write_req(const char *buf,
> +               unsigned int nsects, unsigned int sect_offset)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       struct mmc_request *mrq = cxt->mrq;
> +       struct mmc_card *card = cxt->card;
> +       struct mmc_host *host = card->host;
> +       struct scatterlist sg;
> +       u32 opcode;
> +
> +       opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK : MMC_WRITE_BLOCK;
> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, MMC_DATA_WRITE);
> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> +       mmc_set_data_timeout(mrq->data, cxt->card);
> +
> +       mmc_claim_host(host);

So, this will use several locks, which may be a problem, right?

Moreover, if there is an ongoing I/O request (or any other active
command/request for that matter), then the host is already claimed by
the mmc core. Normally, we would then wait for that request to be
completed, to trigger the release of the host and then allow us to
claim it here.

However, because of the kernel panic, I assume it's quite likely that
any ongoing request will not be completed at all, as IRQs may not
work, for example.

In other words, we may be hanging here forever waiting to claim the
host. Unless we are lucky, because of no ongoing request, although we
would still have to succeed walking through all the locking, etc, in
mmc_claim_host().

Do note, as part of the mmc_claim_host() we may also runtime resume
the host, if it was runtime suspended (which is quite likely). To
runtime resume a host via runtime PM, we may end up ungating device
clocks, power on corresponding PM domains, run a so called re-tuning
sequence to restore communication with the card, etc, etc. The point
is, all these things must also be possible to do, without locks and by
using a polling based "mode"...

> +       mmc_wait_for_pstore_req(host, mrq);

Okay, so let's assume that we are lucky and succeed to claim and
runtime resume the host above.

Then we also need to runtime resume the card, as it may be runtime
suspended. In the "worst case", runtime resuming the card means a
complete re-initialization of it, covering a series of commands and
turning on regulators, for example.

> +       mmc_release_host(card->host);
> +}
> +
> +static ssize_t mmcpstore_panic_write(const char *buf, size_t size, loff_t off)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +
> +       mmcpstore_panic_write_req(buf, (size >> SECTOR_SHIFT),
> +                       cxt->start_sect + (off >> SECTOR_SHIFT));
> +       return size;
> +}

[...]

Having said the above, I am not entirely convinced that it makes sense
to support this, at all.

Not only, will the support be highly fragile from the mmc core point
of view, but there is also a significant complexity for an mmc host
driver to support this (at least in general).

Kind regards
Uffe
