Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892EC4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 11:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B519B22285
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 11:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgLOLo0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 06:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgLOLoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 06:44:17 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF69C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 03:43:36 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id h6so10788351vsr.6
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+lesXEsKnL/xary5x7l0PUuenJwrHm/9MaXt8QXqxg=;
        b=dIgBUr4xY2AgyQmfoaB/j+SROeZJSXmaAwA5393uB/IHiWKp3/9NDUj4yfykUavb+T
         n/M0xSENw9pLvuGmloIcSYCo4Oh+Ig8glke7/5D6aWb/4HWIMW5UH5OVJoY/t7mXbS6/
         UHIz7NXmu7UupCaPy8uO/UvCfMzfFOI3QbQtx8RYEC6zIGl9ypldG3dxcGcHKjPl6GP6
         bmRrbEAqSHZ7kOfFZlJ7IxbZMF2xjOMgbCy7Pl5gLKZc2RTj6/gw4NX3vOofJJ/lpqDZ
         W9J1pTNsZ/6fLaPQOyinOoJ75JrVP8bI2i94OXsfebLwe+pjETjnggHn0whMKw8iCdJg
         5l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+lesXEsKnL/xary5x7l0PUuenJwrHm/9MaXt8QXqxg=;
        b=jRDxpNgGtRIGMH/TeisFWgCBHwIcE/Jehkq8tnj1EMqqaBPMAy6H5nPyRfknMu2DqK
         mWF+2Dmt8AlmgrpLjdQJNXbq7mAq0wwMiaHrpM9vI/552Qkml9r92Lo1vQagyDxSwcyz
         jkiKQePjP3gYzoxx+t5IlfXiEV4jEZBKci609hZqCupH20FoH4+f4HjH0v7DmrcSl/Tq
         etye9UIvmyIlVqcfdUFf3AWzhYAJ6zkHGeqkErgT42j7jOW08vh8EpVUUdW4NPx3Uk6h
         XkEfkNgs6b/GBley+AD7rGCPIcWaNF6/LtEU/+y43/gSl5AdigBIkHvwET4GOE4RGyzZ
         5Slg==
X-Gm-Message-State: AOAM533bcNCYEuFNLuC+EIwN5SoN4N3VvpFbdpDrULRLnnk3QoqQfKVS
        W/5xcwOVQXtcLbq9A5jo46rNLXQr9VagsrkUkF8ToA==
X-Google-Smtp-Source: ABdhPJwkh31u995oKKYNv2mpJWbEL2YvaEcfDAM/xL/xWqn6gqitCOD/h962ZKUAiOprZVECjkqjAO2zb7b8NkNqhq4=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr25888435vsr.19.1608032615785;
 Tue, 15 Dec 2020 03:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Dec 2020 12:42:58 +0100
Message-ID: <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
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

On Tue, 15 Dec 2020 at 07:52, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Friday, December 11, 2020 5:02 PM
> >To: Bhaskara Budiredla <bbudiredla@marvell.com>
> >Cc: Kees Cook <keescook@chromium.org>; Colin Cross
> ><ccross@android.com>; Tony Luck <tony.luck@intel.com>; Sunil Kovvuri
> >Goutham <sgoutham@marvell.com>; linux-mmc@vger.kernel.org; Linux
> >Kernel Mailing List <linux-kernel@vger.kernel.org>; Christoph Hellwig
> ><hch@lst.de>
> >Subject: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
> >pstore/blk
> >
> >External Email
> >
> >----------------------------------------------------------------------
> >+ Christoph
> >
> >On Mon, 7 Dec 2020 at 12:58, Bhaskara Budiredla <bbudiredla@marvell.com>
> >wrote:
> >>
> >> This patch introduces to mmcpstore. The functioning of mmcpstore is
> >> similar to mtdpstore. mmcpstore works on FTL based flash devices
> >> whereas mtdpstore works on raw flash devices. When the system crashes,
> >> mmcpstore stores the kmsg panic and oops logs to a user specified MMC
> >> device.
> >>
> >> It collects the details about the host MMC device through pstore/blk
> >> "blkdev" parameter. The user can specify the MMC device in many ways
> >> by checking in Documentation/admin-guide/pstore-blk.rst.
> >>
> >> The individual mmc host drivers have to define suitable polling and
> >> cleanup subroutines to write kmsg panic/oops logs through mmcpstore.
> >> These new host operations are needed as pstore panic write runs with
> >> interrupts disabled.
> >
> >Apologies for the delay. I have tried to give this some more thinking, more
> >comments below.
> >
> >[...]
> >
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> >> d42037f0f10d..7682b267f1d5 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)  }
> >> EXPORT_SYMBOL(mmc_cqe_recovery);
> >>
> >> +#if IS_ENABLED(CONFIG_MMC_PSTORE)
> >> +/**
> >> + *     mmc_wait_for_pstore_req - initiate a blocking mmc request
> >> + *     @host: MMC host to start command
> >> + *     @mrq: MMC request to start
> >> + *
> >> + *     Start a blocking MMC request for a host and wait for the request
> >> + *     to complete that is based on polling and timeout.
> >> + */
> >> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct
> >> +mmc_request *mrq) {
> >> +       unsigned int timeout;
> >> +
> >> +       host->ops->req_cleanup_pending(host);
> >
> >So, the host driver should through this callback, be able to terminate any
> >ongoing requests/commands - and also try to make sure that the (e)MMC/SD
> >card remains in the data transfer state. Moreover, no locks and no IRQs must
> >be used to manage this, right?
> >
>
> Yes, that's correct.
>
> >Have you really tried if this works for real?
> >
>
> Yes, it's a working solution. Patch were submitted after testing.
>
> >> +       mmc_start_request(host, mrq);
> >
> >This looks like the wrong approach to me, as it will try to re-use the regular
> >request based path, where the host driver is allowed to use locks, IRQs,
> >DMAs, etc, etc.
> >
>
> No. The locks on host driver will be dropped in CONFIG_MMC_PSTORE path.
> Similarly, the IRQs will be replaced with polling subroutines during panic
> write. Please take a look at patch 2/2 which does this for cavium host driver.

Yes, but why is removing the locks okay for the other regular request case?

I assume the locks are there for a reason, right?

>
> >I would suggest inventing a new separate request path and a new host ops, to
> >deal with these kinds of requests.
> >
>
> The polling and cleanup host operations are the ones invented for this purpose.
> Polling to replace IRQs and cleanup to terminate ongoing requests/commands.

I understand the approach you have taken, but what I am saying is that
I don't think it is the best one to choose.

Then I think it's better to invent an entirely new path, rather than
trying to tweak the existing one. For example, in your case you could
leave the lock to be used (in patch2) for the existing regular request
path, but bypass the locks and use polling in the new one.

>
> >In this way, the below part with host->ops->req_completion_poll, can
> >probably be removed. Instead we may just wait for the request to return
> >from the new request path.
> >
>
> This is not possible unless CPU itself does the mmc write (through some block interface?).
> If the answer is block interface, sleeping cannot be avoided as part of it.

I wasn't thinking of the block interface, but rather of the internal
behavior of an mmc host driver.

For data transfers, it's common to use DMA when that is supported. If
DMA doesn't work, it's probably a FIFO being read/written to based
upon some IRQs telling when read/write should be done. Of course,
there are other cases as well.

For commands, I expect those to be managed through IRQs.

That said, all these things are preferably managed through a polling
based method instead, when doing the panic writes, correct?

> Do you really think DMA can be avoided for MMC panic writes?

That depends on the HW.

Certainly there are lots of cases where DMA isn't the only way, but
instead it's perfectly possible to fall back to polling based mode.

>
> >> +
> >> +       if (mrq->data) {
> >> +               timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
> >> +               host->ops->req_completion_poll(host, timeout);
> >> +       }
> >> +}
> >> +EXPORT_SYMBOL(mmc_wait_for_pstore_req);
> >> +#endif
> >> +
> >>  /**
> >>   *     mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is
> >done
> >>   *     @host: MMC host
> >> diff --git a/drivers/mmc/core/mmcpstore.c
> >> b/drivers/mmc/core/mmcpstore.c new file mode 100644 index
> >> 000000000000..1113eae0756c
> >> --- /dev/null
> >> +++ b/drivers/mmc/core/mmcpstore.c
> >> @@ -0,0 +1,302 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * MMC pstore support based on pstore/blk
> >> + *
> >> + * Copyright (c) 2020 Marvell.
> >> + * Author: Bhaskara Budiredla <bbudiredla@marvell.com>  */
> >> +
> >> +#define pr_fmt(fmt) "mmcpstore: " fmt
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pstore_blk.h>
> >> +#include <linux/blkdev.h>
> >> +#include <linux/mount.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/mmc/mmc.h>
> >> +#include <linux/mmc/host.h>
> >> +#include <linux/mmc/card.h>
> >> +#include <linux/scatterlist.h>
> >> +#include "block.h"
> >> +#include "card.h"
> >> +#include "core.h"
> >> +
> >> +static struct mmcpstore_context {
> >> +       char dev_name[BDEVNAME_SIZE];
> >> +       int partno;
> >> +       sector_t start_sect;
> >> +       sector_t size;
> >> +       struct pstore_device_info dev;
> >> +       struct pstore_blk_config conf;
> >> +       struct pstore_blk_info info;
> >> +
> >> +       char *sub;
> >> +       struct mmc_card *card;
> >> +       struct mmc_request *mrq;
> >> +} oops_cxt;
> >> +
> >> +static void mmc_prep_req(struct mmc_request *mrq,
> >> +               unsigned int sect_offset, unsigned int nsects,
> >> +               struct scatterlist *sg, u32 opcode, unsigned int
> >> +flags) {
> >> +       mrq->cmd->opcode = opcode;
> >> +       mrq->cmd->arg = sect_offset;
> >> +       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> >> +
> >> +       if (nsects == 1) {
> >> +               mrq->stop = NULL;
> >> +       } else {
> >> +               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
> >> +               mrq->stop->arg = 0;
> >> +               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> >> +       }
> >> +
> >> +       mrq->data->blksz = SECTOR_SIZE;
> >> +       mrq->data->blocks = nsects;
> >> +       mrq->data->flags = flags;
> >> +       mrq->data->sg = sg;
> >> +       mrq->data->sg_len = 1;
> >> +}
> >> +
> >> +static int mmcpstore_rdwr_req(const char *buf, unsigned int nsects,
> >> +                       unsigned int sect_offset, unsigned int flags)
> >> +{
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       struct mmc_request *mrq = cxt->mrq;
> >> +       struct mmc_card *card = cxt->card;
> >> +       struct mmc_host *host = card->host;
> >> +       struct scatterlist sg;
> >> +       u32 opcode;
> >> +
> >> +       if (flags == MMC_DATA_READ)
> >> +               opcode  = (nsects > 1) ?
> >> +                       MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
> >> +       else
> >> +               opcode = (nsects > 1) ?
> >> +                       MMC_WRITE_MULTIPLE_BLOCK : MMC_WRITE_BLOCK;
> >> +
> >> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, flags);
> >> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> >> +       mmc_set_data_timeout(mrq->data, cxt->card);
> >> +
> >> +       mmc_claim_host(host);
> >> +       mmc_wait_for_req(host, mrq);
> >> +       mdelay(mrq->data->timeout_ns / NSEC_PER_MSEC);
> >> +       mmc_release_host(host);
> >> +
> >> +       if (mrq->cmd->error) {
> >> +               pr_err("Cmd error: %d\n", mrq->cmd->error);
> >> +               return mrq->cmd->error;
> >> +       }
> >> +       if (mrq->data->error) {
> >> +               pr_err("Data error: %d\n", mrq->data->error);
> >> +               return mrq->data->error;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static ssize_t mmcpstore_write(const char *buf, size_t size, loff_t
> >> +off) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       int ret;
> >> +
> >> +       ret = mmcpstore_rdwr_req(buf, (size >> SECTOR_SHIFT),
> >> +               cxt->start_sect + (off >> SECTOR_SHIFT), MMC_DATA_WRITE);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       return size;
> >> +}
> >> +
> >> +static ssize_t mmcpstore_read(char *buf, size_t size, loff_t off) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       unsigned int sect_off = cxt->start_sect  + (off >> SECTOR_SHIFT);
> >> +       unsigned long sects = (cxt->conf.kmsg_size >> SECTOR_SHIFT);
> >> +       int ret;
> >> +
> >> +       if (unlikely(!buf || !size))
> >> +               return -EINVAL;
> >> +
> >> +       ret = mmcpstore_rdwr_req(cxt->sub, sects, sect_off,
> >MMC_DATA_READ);
> >> +       if (ret)
> >> +               return ret;
> >> +       memcpy(buf, cxt->sub, size);
> >> +
> >> +       return size;
> >> +}
> >
> >It looks like the above I/O read/write interface for pstore is intended to be
> >used when the platform is up and running and not during a panic, correct?
> >
> >If so, I don't get why it can't use the regular block interface, as any other file
> >system does, for example?
> >
>
> The pstore read and write operations are used as part of pstore file system mounting
> to retrieve the stored logs from MMC platform backend and to manage pstore read/write
> counters. Sleeping would be allowed during this time. Whereas, pstore PANIC write will be
> called if there happens a crash in the system. Sleeping is NOT allowed at this time.
>
> It seems you are mixing the sleeping paths of the mmcpstore with that of atomic path.

No, I am not mixing them, but questioning them.

For the non atomic path, I don't understand why the pstore file system
mounting, etc, deserves to be managed through its own specific ops?
Are there any specific reasons for this that I am missing?

In principle, for non atomic path, I would rather see that the pstore
file system should be able to be mounted on top of any generic block
device partition - without requiring the block device driver to
implement specific pstore ops.

>
>
> >> +
> >> +static void mmcpstore_panic_write_req(const char *buf,
> >> +               unsigned int nsects, unsigned int sect_offset) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +       struct mmc_request *mrq = cxt->mrq;
> >> +       struct mmc_card *card = cxt->card;
> >> +       struct mmc_host *host = card->host;
> >> +       struct scatterlist sg;
> >> +       u32 opcode;
> >> +
> >> +       opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
> >MMC_WRITE_BLOCK;
> >> +       mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode,
> >MMC_DATA_WRITE);
> >> +       sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
> >> +       mmc_set_data_timeout(mrq->data, cxt->card);
> >> +
> >> +       mmc_claim_host(host);
> >
> >So, this will use several locks, which may be a problem, right?
> >
>
> No, as said above locks are present on host driver will be dropped
> in CONFIG_MMC_PSTORE path.

Please have a look at the code implementing mmc_claim_host(). It's not
just a simple spin_lock, but there is also a wait_queue and runtime PM
being managed from there.

>
> >Moreover, if there is an ongoing I/O request (or any other active
> >command/request for that matter), then the host is already claimed by the
> >mmc core. Normally, we would then wait for that request to be completed, to
> >trigger the release of the host and then allow us to claim it here.
> >
> >However, because of the kernel panic, I assume it's quite likely that any
> >ongoing request will not be completed at all, as IRQs may not work, for
> >example.
> >
> >In other words, we may be hanging here forever waiting to claim the host.
> >Unless we are lucky, because of no ongoing request, although we would still
> >have to succeed walking through all the locking, etc, in mmc_claim_host().
> >
>
> host->ops->req_cleanup_pending(host) was introduced to clean up the queued
> and ongoing requests/commands. Terminating ongoing requests is not a complicated
> thing for the host drivers.

Well, I don't agree. Resetting the host controller should not be a big
problem, but I am more worried about what state this will bring the
eMMC/SD card in.

It sounds to me that the only option is to try to rely on the
mmc_claim_host() to actually succeed. This makes it certain that there
is no ongoing request that needs to be terminated. Otherwise, things
will just fall apart.

The question is, can/should we rely on mmc_claim_host() to succeed in
this path? Maybe it will work, in cases when there is no ongoing
request, as it means the host should be available to be immediately
claimed. Although, then the problem ends up with runtime PM, as if the
host is available for claiming, it's likely that the host is runtime
suspended...

>
>
> >Do note, as part of the mmc_claim_host() we may also runtime resume the
> >host, if it was runtime suspended (which is quite likely). To runtime resume a
> >host via runtime PM, we may end up ungating device clocks, power on
> >corresponding PM domains, run a so called re-tuning sequence to restore
> >communication with the card, etc, etc. The point is, all these things must also
> >be possible to do, without locks and by using a polling based "mode"...
> >
> >> +       mmc_wait_for_pstore_req(host, mrq);
> >
> >Okay, so let's assume that we are lucky and succeed to claim and runtime
> >resume the host above.
> >
> >Then we also need to runtime resume the card, as it may be runtime
> >suspended. In the "worst case", runtime resuming the card means a complete
> >re-initialization of it, covering a series of commands and turning on regulators,
> >for example.
> >
> >> +       mmc_release_host(card->host);
> >> +}
>
>
> All the above said things (runtime resuming host, clocks being updated, restoring
> communication with host) are valid even for the newly asked request path. They cannot
> be avoided as we have to terminate the ongoing requests to complete the panic write.

Exactly. That's why I wonder if it's really worth it to support the
panic writes at all.

I realize that the host driver you are working on doesn't support
runtime PM, so it's not a problem for you, but for many other cases I
assume it would be.

Perhaps we could check that runtime PM is disabled for the mmc host as
a pre-condition to support this feature?

>
> >> +
> >> +static ssize_t mmcpstore_panic_write(const char *buf, size_t size,
> >> +loff_t off) {
> >> +       struct mmcpstore_context *cxt = &oops_cxt;
> >> +
> >> +       mmcpstore_panic_write_req(buf, (size >> SECTOR_SHIFT),
> >> +                       cxt->start_sect + (off >> SECTOR_SHIFT));
> >> +       return size;
> >> +}
> >
> >[...]
> >
> >Having said the above, I am not entirely convinced that it makes sense to
> >support this, at all.
> >
> >Not only, will the support be highly fragile from the mmc core point of view,
> >but there is also a significant complexity for an mmc host driver to support this
> >(at least in general).
> >
>
> I am not sure if the comments on host driver complexity is true. Terminating
> ongoing requests and introducing polling functions on host drivers should be
> straight forward. None those would disturb the core functionality. They are
> completely independent.

I think you are underestimating the part with terminating ongoing
requests. It sounds to me that you really haven't been terminating any
requests at all, but rather just doing a reset of the mmc controller
(which is what I observed in patch2).

When it comes to adding the new host ops to support the polling
functions, I have in principle no objections to that.

Kind regards
Uffe
