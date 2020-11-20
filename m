Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE1C63777
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0822272
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPvliV37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKTNVL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgKTNVK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2020 08:21:10 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF7C0617A7
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2020 05:21:10 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id r5so4969938vsp.7
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2020 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK56yKmfXToTHG1Aog80N3QGp6B5xwGAT/pojMG3X24=;
        b=kPvliV37SX9Aw4HJu6bnVq56Addz0VdnBN5IcECmXREQ2HsMxa+0yfSkfpvqJrSamM
         ZDhjuImgApE5HiiqSO/QeWJuEnvx4iZUACq3vcEJoZBfRr2WnehG75mRRDpHsGH4kcP4
         AK7pZGgPdhszL+w3AAbfAJ2DtdqV+ly3a8ll6KP11GCzL0bXWEopH7LS5aXaHmsBb8Ob
         adlohVJGXTceEyfyDveW4OsYN0DRTJu/VF0f4s3wS83a3ioTTbPN/SeQVSYgxEc3dtfG
         zvgcpoZZKv9jU6z5ww4rRXpVcxJyJz55gqm41AmvkPlR9Qjqxughd0YBDxuKxbj4AYtd
         i+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK56yKmfXToTHG1Aog80N3QGp6B5xwGAT/pojMG3X24=;
        b=myk/jLNyGXhFeXKYUoVasAxkIp5AmB3LDiX29tBMMaKXnxDLicSEZgZcyx5W3RjeeX
         EyHrSy5qgO73BI7LSPICDdWl4rBF8hn6OQJgjynZrUuFXjCZItYCU/3JgthNJn9QAK7z
         xULcrIX3jZRCOiOGsQZZgp8Slp59cX7kmATE7ffSNsddKa1ycR1CtQ7HE+syOP7lo7ig
         tuQ7/hlaZaB8w8FNpY5h0Zo2g4tdj/P/JLsz3ZLYbL7w836UDBhRV5OrA7ffANiP4lnH
         9QdWvCWp0/BLkFJfXNuS8gu7iCDbilQCbC26eiPtxVqFlPOBAUXkevD0/WSApv+9/auy
         /kWg==
X-Gm-Message-State: AOAM530xz/BQts+/FFtVRV9lbTxnbyzQchdkikvUMfjmx+rAMJKbgYTb
        eqrZvih3OmRewowKhSBNtUE3Ny8ZnyHHY4OHrWVa+A==
X-Google-Smtp-Source: ABdhPJzTngCZGBFx8AT7Z9dUTUDmNC7cmaIA8Odzur7G2W+hDQ+CaVo7eR3GJBrRlfdkgZ4ax4WMYoNqgX6ePB87dLE=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr12033513vsd.55.1605878469279;
 Fri, 20 Nov 2020 05:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20201112062422.32212-1-bbudiredla@marvell.com> <20201112062422.32212-2-bbudiredla@marvell.com>
In-Reply-To: <20201112062422.32212-2-bbudiredla@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Nov 2020 14:20:32 +0100
Message-ID: <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, sgoutham@marvell.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Nov 2020 at 07:24, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
> This patch introduces to mmcpstore. The functioning of mmcpstore is
> is similar to mtdpstore. mmcpstore works on FTL based flash devices
> whereas mtdpstore works on raw flash devices. When the system crashes,
> mmcpstore stores the kmsg panic and oops logs to a user specified
> MMC device.
>
> It collects the details about the host MMC device through pstore/blk
> "blkdev" parameter. The user can specify the MMC device in many ways
> by checking in Documentation/admin-guide/pstore-blk.rst.
>
> The individual mmc host drivers have to define suitable polling
> subroutines to write kmsg panic/oops logs through mmcpstore.

I don't like that changes to host drivers are needed to support this,
but perhaps there is no other good way!?

>
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  drivers/mmc/core/Kconfig     |   7 +
>  drivers/mmc/core/Makefile    |   1 +
>  drivers/mmc/core/block.c     |  20 +++
>  drivers/mmc/core/block.h     |   3 +
>  drivers/mmc/core/core.c      |  24 +++
>  drivers/mmc/core/mmcpstore.c | 318 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   4 +
>  include/linux/mmc/core.h     |   4 +
>  include/linux/mmc/host.h     |   6 +
>  9 files changed, 387 insertions(+)
>  create mode 100644 drivers/mmc/core/mmcpstore.c
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index c12fe13e4b14..cafb367c482d 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -81,3 +81,10 @@ config MMC_TEST
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
>
> +config MMC_PSTORE
> +       bool "Log panic/oops to a MMC buffer"
> +       depends on PSTORE
> +       depends on PSTORE_BLK
> +       help
> +         Backend driver to store the kmsg crash dumps to a user specified MMC
> +         device. The driver is based on pstore/blk.
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 95ffe008ebdf..5f4230b79ac6 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -17,4 +17,5 @@ mmc_core-$(CONFIG_DEBUG_FS)   += debugfs.o
>  obj-$(CONFIG_MMC_BLOCK)                += mmc_block.o
>  mmc_block-objs                 := block.o queue.o
>  obj-$(CONFIG_MMC_TEST)         += mmc_test.o
> +obj-$(CONFIG_MMC_PSTORE)       += mmcpstore.o
>  obj-$(CONFIG_SDIO_UART)                += sdio_uart.o
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d3df0be0355..f11c21d60b67 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2870,6 +2870,21 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>
>  #endif /* CONFIG_DEBUG_FS */
>
> +#ifdef CONFIG_MMC_PSTORE
> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num, sector_t *size)
> +{
> +       struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
> +       struct gendisk *disk = md->disk;
> +       struct disk_part_tbl *part_tbl = disk->part_tbl;
> +
> +       if (part_num < 0 || part_num >= part_tbl->len)
> +               return 0;
> +
> +       *size = part_tbl->part[part_num]->nr_sects << SECTOR_SHIFT;
> +       return part_tbl->part[part_num]->start_sect;
> +}
> +#endif
> +
>  static int mmc_blk_probe(struct mmc_card *card)
>  {
>         struct mmc_blk_data *md, *part_md;
> @@ -2913,6 +2928,11 @@ static int mmc_blk_probe(struct mmc_card *card)
>                         goto out;
>         }
>
> +#ifdef CONFIG_MMC_PSTORE

Avoid using ifdefs in common functions like these, please. I think
it's more clean to add a stub function and then just call it
unconditionally here.

> +       if (mmc_card_mmc(card) || mmc_card_sd(card))
> +               mmcpstore_card_set(card, md->disk->disk_name);
> +#endif
> +
>         /* Add two debugfs entries */
>         mmc_blk_add_debugfs(card, md);
>
> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
> index 31153f656f41..2a2b81635508 100644
> --- a/drivers/mmc/core/block.h
> +++ b/drivers/mmc/core/block.h
> @@ -16,5 +16,8 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq);
>  struct work_struct;
>
>  void mmc_blk_mq_complete_work(struct work_struct *work);
> +#ifdef CONFIG_MMC_PSTORE
> +sector_t mmc_blk_get_part(struct mmc_card *card, int part_num, sector_t *size);
> +#endif
>
>  #endif
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d42037f0f10d..7cc3d81f6a9a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_cqe_recovery);
>
> +
> +#ifdef CONFIG_MMC_PSTORE
> +/**
> + *     mmc_wait_for_pstore_req - initiate a blocking mmc request
> + *     @host: MMC host to start command
> + *     @mrq: MMC request to start
> + *
> + *     Start a new MMC custom command request for a host, and
> + *     wait for the command to complete based on request data timeout.
> + */
> +void mmc_wait_for_pstore_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       unsigned int timeout;
> +
> +       host->ops->req_cleanup_pending(host);
> +       mmc_start_request(host, mrq);
> +
> +       if (mrq->data) {
> +               timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
> +               host->ops->req_completion_poll(host, timeout);
> +       }
> +}

As I said above, I would like to avoid host specific deployments from
being needed. Is there a way we can avoid this?

> +#endif
> +
>  /**
>   *     mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
>   *     @host: MMC host
> diff --git a/drivers/mmc/core/mmcpstore.c b/drivers/mmc/core/mmcpstore.c
> new file mode 100644
> index 000000000000..ffa44c859e10
> --- /dev/null
> +++ b/drivers/mmc/core/mmcpstore.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
> +       mmc_wait_for_pstore_req(host, mrq);
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
> +
> +static struct block_device *mmcpstore_open_backend(const char *device)
> +{
> +       struct block_device *bdev;
> +       dev_t devt;
> +
> +       bdev = blkdev_get_by_path(device, FMODE_READ, NULL);
> +       if (IS_ERR(bdev)) {
> +               devt = name_to_dev_t(device);
> +               if (devt == 0)
> +                       return ERR_PTR(-ENODEV);
> +
> +               bdev = blkdev_get_by_dev(devt, FMODE_READ, NULL);
> +               if (IS_ERR(bdev))
> +                       return bdev;
> +       }
> +
> +       return bdev;
> +}
> +
> +static void mmcpstore_close_backend(struct block_device *bdev)
> +{
> +       if (!bdev)
> +               return;
> +       blkdev_put(bdev, FMODE_READ);
> +}
> +
> +void mmcpstore_card_set(struct mmc_card *card, const char *disk_name)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       struct pstore_blk_config *conf = &cxt->conf;
> +       struct pstore_device_info *dev = &cxt->dev;
> +       struct block_device *bdev;
> +       struct mmc_command *stop;
> +       struct mmc_command *cmd;
> +       struct mmc_request *mrq;
> +       struct mmc_data *data;
> +       int ret;
> +
> +       if (!conf->device[0])
> +               return;
> +
> +       /* Multiple backend devices not allowed */
> +       if (cxt->dev_name[0])
> +               return;
> +
> +       bdev =  mmcpstore_open_backend(conf->device);
> +       if (IS_ERR(bdev)) {
> +               pr_err("%s failed to open with %ld\n",
> +                               conf->device, PTR_ERR(bdev));
> +               return;
> +       }
> +
> +       bdevname(bdev, cxt->dev_name);
> +       cxt->partno = bdev->bd_part->partno;
> +       mmcpstore_close_backend(bdev);
> +
> +       if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> +               return;
> +
> +       cxt->start_sect = mmc_blk_get_part(card, cxt->partno, &cxt->size);
> +       if (!cxt->start_sect) {
> +               pr_err("Non-existent partition %d selected\n", cxt->partno);
> +               return;
> +       }
> +
> +       /* Check for host mmc panic write polling function definitions */
> +       if (!card->host->ops->req_cleanup_pending ||
> +                       !card->host->ops->req_completion_poll)
> +               return;
> +
> +       cxt->card = card;
> +
> +       cxt->sub = kmalloc(conf->kmsg_size, GFP_KERNEL);
> +       if (!cxt->sub)
> +               goto out;
> +
> +       mrq = kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
> +       if (!mrq)
> +               goto free_sub;
> +
> +       cmd = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> +       if (!cmd)
> +               goto free_mrq;
> +
> +       stop = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> +       if (!stop)
> +               goto free_cmd;
> +
> +       data = kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
> +       if (!data)
> +               goto free_stop;
> +
> +       mrq->cmd = cmd;
> +       mrq->data = data;
> +       mrq->stop = stop;
> +       cxt->mrq = mrq;
> +
> +       dev->total_size = cxt->size;
> +       dev->flags = PSTORE_FLAGS_DMESG;
> +       dev->read = mmcpstore_read;
> +       dev->write = mmcpstore_write;
> +       dev->erase = NULL;
> +       dev->panic_write = mmcpstore_panic_write;
> +
> +       ret = register_pstore_device(&cxt->dev);

By looking at all of the code above, lots are duplicated from the mmc
block device implementation. Isn't there a way to make the pstore
block device to push a request through the regular blk-mq path
instead?

That said, I wonder why you don't call register_pstore_blk(), as I
thought that was the interface to be used for regular block devices,
no?


> +       if (ret) {
> +               pr_err("%s registering with psblk failed (%d)\n",
> +                               cxt->dev_name, ret);
> +               goto free_data;
> +       }
> +
> +       pr_info("%s registered as psblk backend\n", cxt->dev_name);
> +       return;
> +
> +free_data:
> +       kfree(data);
> +free_stop:
> +       kfree(stop);
> +free_cmd:
> +       kfree(cmd);
> +free_mrq:
> +       kfree(mrq);
> +free_sub:
> +       kfree(cxt->sub);
> +out:
> +       return;
> +}
> +EXPORT_SYMBOL(mmcpstore_card_set);
> +
> +static int __init mmcpstore_init(void)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +       struct pstore_blk_config *conf = &cxt->conf;
> +       int err;
> +
> +       err = pstore_blk_get_config(conf);
> +       if (unlikely(err))
> +               return err;

Looks like that this can be moved to mmc_blk_probe() function instead.

> +
> +       if (!conf->device[0]) {
> +               pr_err("psblk backend is empty\n");
> +               return -EINVAL;
> +       }
> +
> +       return err;
> +}
> +
> +static void __exit mmcpstore_exit(void)
> +{
> +       struct mmcpstore_context *cxt = &oops_cxt;
> +
> +       unregister_pstore_device(&cxt->dev);
> +       kfree(cxt->mrq->data);
> +       kfree(cxt->mrq->stop);
> +       kfree(cxt->mrq->cmd);
> +       kfree(cxt->mrq);
> +       kfree(cxt->sub);
> +       cxt->card = NULL;

Can we do this via mmc_blk_remove() instead?

> +}
> +
> +module_init(mmcpstore_init);
> +module_exit(mmcpstore_exit);
> +
> +MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
> +MODULE_DESCRIPTION("MMC backend for pstore/blk");
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 42df06c6b19c..76ae8ae61d31 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -322,6 +322,10 @@ static inline bool mmc_large_sector(struct mmc_card *card)
>
>  bool mmc_card_is_blockaddr(struct mmc_card *card);
>
> +#ifdef CONFIG_MMC_PSTORE
> +void mmcpstore_card_set(struct mmc_card *card, const char *disk_name);
> +#endif /* CONFIG_MMC_PSTORE */
> +
>  #define mmc_card_mmc(c)                ((c)->type == MMC_TYPE_MMC)
>  #define mmc_card_sd(c)         ((c)->type == MMC_TYPE_SD)
>  #define mmc_card_sdio(c)       ((c)->type == MMC_TYPE_SDIO)
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 29aa50711626..21dcd79f8f0e 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -166,6 +166,10 @@ struct mmc_request {
>
>  struct mmc_card;
>
> +#ifdef CONFIG_MMC_PSTORE
> +extern void mmc_wait_for_pstore_req(struct mmc_host *, struct mmc_request *);
> +#endif /* CONFIG_MMC_PSTORE */
> +
>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c079b932330f..ef57313ee3ea 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -173,6 +173,12 @@ struct mmc_host_ops {
>          */
>         int     (*multi_io_quirk)(struct mmc_card *card,
>                                   unsigned int direction, int blk_size);
> +
> +#ifdef CONFIG_MMC_PSTORE
> +       void    (*req_cleanup_pending)(struct mmc_host *host);
> +       int     (*req_completion_poll)(struct mmc_host *host,
> +                                       unsigned long timeout);

If these really will be needed, please add some comments about what
they are intended to help with.

> +#endif
>  };
>
>  struct mmc_cqe_ops {

Kind regards
Uffe
