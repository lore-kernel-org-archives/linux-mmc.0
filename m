From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/1 v8]mmc: Support-FFU-for-eMMC-v5.0
Date: Mon, 18 Aug 2014 12:56:31 +0200
Message-ID: <CAPDyKFoFq+XkjVqycEorUDU_aKACPQkHvEsdJjJkj+P=FET5cA@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64B934609@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr52GkJC-2A4b6dy7VYZZsVgCHnT-GdL_9ZkF=Hd4H=Jw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AE73534@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:50186 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaHRK4c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 06:56:32 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so906348qgd.5
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 03:56:31 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333AE73534@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Grant Grundler <grundler@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "Gwendal Grignou (gwendal@chromium.org)" <gwendal@chromium.org>

On 14 August 2014 14:37, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Ulf,
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, August 13, 2014 3:47 PM
>> To: Avi Shchislowski; Grant Grundler; Alex Lemberg
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org
>> Subject: Re: [RFC PATCH 1/1 v8]mmc: Support-FFU-for-eMMC-v5.0
>>
>> On 16 July 2014 17:47, Avi Shchislowski <Avi.Shchislowski@sandisk.com>
>> wrote:
>> > The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
>> JESD84-B50.pdf)
>> >
>> > http://www.jedec.org/standards-documents/technology-focus-
>> areas/flash-
>> > memory-ssds-ufs-emmc/e-mmc
>> >
>> > An ioctl has been added to provide the new firmware image's file name to
>> the  mmc driver and udev is then used to retrieve its data.
>> >
>> > Two new ioctls have been added:
>> > 1. FFU download firmware - transfer the new firmware data from user
>> > space to the eMMC device 2. FFU install - initializes the new firmware
>> > update
>> >
>> >
>> > Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
>> > Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>>
>> Hi guys,
>>
>> Sorry for the delay in providing feeback, but hey better late than never. :-)
>
> Thanks, we appreciate your comments!
>>
>> >
>> > ---
>> > V8:
>> > - Modified according to Gwendal Grignou comments and patch:
>> >    [PATCH] Fix on top of sandisk patches
>> >
>> > V7:
>> > - fixed mangled white space
>> >
>> > V5:
>> > - provides udev (request_firmware) implementation as advised in patch
>> > v2 comments.
>> >
>> > diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig index
>> > 5562308..19ba729 100644
>> > --- a/drivers/mmc/card/Kconfig
>> > +++ b/drivers/mmc/card/Kconfig
>> > @@ -68,3 +68,11 @@ config MMC_TEST
>> >
>> >           This driver is only of interest to those developing or
>> >           testing a host driver. Most people should say N here.
>> > +
>> > +config MMC_FFU
>> > +       bool "FFU SUPPORT"
>> > +       depends on MMC != n
>> > +       help
>> > +         This is an option to run firmware update on eMMC 5.0.
>> > +         Field firmware updates (FFU) enables features enhancment
>> > +         in the field.
>>
>> Why do we need a new Kconfig for this? I think we can drop it.
>
> The motivation was to let vendor decide if FFU code should be included in his release or not.
> Some vendors prefer using this FFU functionality during production/testing/development only.

OK, I see.

>
>>
>> > diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
>> > index c73b406..1e9223b 100644
>> > --- a/drivers/mmc/card/Makefile
>> > +++ b/drivers/mmc/card/Makefile
>> > @@ -8,3 +8,4 @@ obj-$(CONFIG_MMC_TEST)          += mmc_test.o
>> >
>> >  obj-$(CONFIG_SDIO_UART)                += sdio_uart.o
>> >
>> > +obj-$(CONFIG_MMC_FFU)          += ffu.o
>> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index
>> > 7b5424f..3ed900b 100644
>> > --- a/drivers/mmc/card/block.c
>> > +++ b/drivers/mmc/card/block.c
>> > @@ -41,6 +41,7 @@
>> >  #include <linux/mmc/host.h>
>> >  #include <linux/mmc/mmc.h>
>> >  #include <linux/mmc/sd.h>
>> > +#include <linux/mmc/ffu.h>
>> >
>> >  #include <asm/uaccess.h>
>> >
>> > @@ -523,8 +524,18 @@ static int mmc_blk_ioctl_cmd(struct block_device
>> > *bdev,
>> >
>> >         mrq.cmd = &cmd;
>> >
>> > +       if (cmd.opcode == MMC_FFU_DOWNLOAD_OP) {
>> > +                       err = mmc_ffu_download(card, idata->buf);
>> > +                       goto cmd_done;
>> > +               }
>> > +
>> >         mmc_get_card(card);
>> >
>> > +       if (cmd.opcode == MMC_FFU_INSTALL_OP) {
>> > +               err = mmc_ffu_install(card);
>> > +               goto cmd_rel_host;
>> > +       }
>> > +
>>
>> I think one FFU operation code should be enough. Overall that would also
>> simplify management and thus code.
>
> The reason for splitting it to two operation codes is providing flexibility to hosts
> due to different implementation of power_off routine.
> Some mmc hosts could not  support suspend/resume, so this split will allow to make
> "manual" power reset instead of running MMC_FFU_INSTALL_OP. (JEDEC spec allows doing power cycle).

To clarify the terms here. All hosts supports system PM suspend/resume.

Most of the suspend/resume operations are handled by the mmc core. The
host's ->set_ios callback will though be invoked by the core to give
the option for the host, to cut the power(s) to the card. Depending on
host and hw, it varies what power(s) will be cut.

Now, I don't understand how the upper layers will know which way it
should complete the FFU upgrade process?

>
>
>
>>
>> Additionally I think it's better to move these "if statements" prior a potential
>> data transfer is set up. You don't use the mrq struct anyway.
>
> Agree
>
>>
>> >         err = mmc_blk_part_switch(card, md);
>> >         if (err)
>> >                 goto cmd_rel_host;
>> > diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c new file
>> > mode 100644 index 0000000..783673e
>> > --- /dev/null
>> > +++ b/drivers/mmc/card/ffu.c
>>
>> I am wondering whether this code should belong to
>> drivers/mmc/core/mmc.c instead. Or unless it becomes too big, we could
>> have a separate file called mmc_ffu.[c|h], but in the core directory.
>
> For easiest maintenance we prefer using separate file.
> mmc_ffu.[c|h] in core directory - will do.
>
>>
>> > @@ -0,0 +1,607 @@
>> > +/*
>> > + * *  ffu.c
>> > + *
>> > + *  Copyright 2007-2008 Pierre Ossman
>> > + *
>> > + *  Modified by SanDisk Corp., Copyright (c) 2013 SanDisk Corp.
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > +modify
>> > + * it under the terms of the GNU General Public License as published
>> > +by
>> > + * the Free Software Foundation; either version 2 of the License, or
>> > +(at
>> > + * your option) any later version.
>> > + *
>> > + * This program includes bug.h, card.h, host.h, mmc.h, scatterlist.h,
>> > + * slab.h, ffu.h & swap.h header files
>> > + * The original, unmodified version of this program - the mmc_test.c
>> > + * file - is obtained under the GPL v2.0 license that is available
>> > +via
>> > + * http://www.gnu.org/licenses/,
>> > + * or http://www.opensource.org/licenses/gpl-2.0.php
>> > +*/
>> > +
>> > +#include <linux/bug.h>
>> > +#include <linux/errno.h>
>> > +#include <linux/mmc/card.h>
>> > +#include <linux/mmc/host.h>
>> > +#include <linux/mmc/mmc.h>
>> > +#include <linux/scatterlist.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/swap.h>
>> > +#include <linux/mmc/ffu.h>
>> > +#include <linux/firmware.h>
>> > +
>> > +/**
>> > + * struct mmc_ffu_pages - pages allocated by 'alloc_pages()'.
>> > + * @page: first page in the allocation
>> > + * @order: order of the number of pages allocated  */ struct
>> > +mmc_ffu_pages {
>> > +       struct page *page;
>> > +       unsigned int order;
>> > +};
>> > +
>> > +/**
>> > + * struct mmc_ffu_mem - allocated memory.
>> > + * @arr: array of allocations
>> > + * @cnt: number of allocations
>> > + */
>> > +struct mmc_ffu_mem {
>> > +       struct mmc_ffu_pages *arr;
>> > +       unsigned int cnt;
>> > +};
>> > +
>> > +struct mmc_ffu_area {
>> > +       unsigned long max_sz;
>> > +       unsigned int max_tfr;
>> > +       unsigned int max_segs;
>> > +       unsigned int max_seg_sz;
>> > +       unsigned int blocks;
>> > +       unsigned int sg_len;
>> > +       struct mmc_ffu_mem *mem;
>> > +       struct scatterlist *sg;
>> > +};
>> > +
>> > +static void mmc_ffu_prepare_mrq(struct mmc_card *card,
>> > +       struct mmc_request *mrq, struct scatterlist *sg, unsigned int sg_len,
>> > +       u32 arg, unsigned int blocks, unsigned int blksz) {
>> > +       BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
>> > +
>> > +       if (blocks > 1)
>> > +               mrq->cmd->opcode = MMC_WRITE_MULTIPLE_BLOCK;
>> > +       else
>> > +               mrq->cmd->opcode = MMC_WRITE_BLOCK;
>> > +
>> > +       mrq->cmd->arg = arg;
>> > +       if (!mmc_card_blockaddr(card))
>> > +               mrq->cmd->arg <<= 9;
>> > +
>> > +       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>> > +       if (blocks == 1) {
>> > +               mrq->stop = NULL;
>> > +       } else {
>> > +               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
>> > +               mrq->stop->arg = 0;
>> > +               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
>> > +       }
>> > +
>> > +       mrq->data->blksz = blksz;
>> > +       mrq->data->blocks = blocks;
>> > +       mrq->data->flags = MMC_DATA_WRITE;
>> > +       mrq->data->sg = sg;
>> > +       mrq->data->sg_len = sg_len;
>> > +
>> > +       mmc_set_data_timeout(mrq->data, card); }
>> > +
>> > +/*
>> > + * Checks that a normal transfer didn't have any errors  */ static
>> > +int mmc_ffu_check_result(struct mmc_request *mrq) {
>> > +       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
>> > +
>> > +       if (mrq->cmd->error != 0)
>> > +               return -EINVAL;
>> > +
>> > +       if (mrq->data->error != 0)
>> > +               return -EINVAL;
>> > +
>> > +       if (mrq->stop != NULL && mrq->stop->error != 0)
>> > +               return -1;
>> > +
>> > +       if (mrq->data->bytes_xfered != (mrq->data->blocks * mrq->data-
>> >blksz))
>> > +               return -EINVAL;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int mmc_ffu_busy(struct mmc_command *cmd) {
>> > +       return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
>> > +               (R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG); }
>> > +
>> > +static int mmc_ffu_wait_busy(struct mmc_card *card) {
>> > +       int ret, busy = 0;
>> > +       struct mmc_command cmd = {0};
>> > +
>> > +       memset(&cmd, 0, sizeof(struct mmc_command));
>> > +       cmd.opcode = MMC_SEND_STATUS;
>> > +       cmd.arg = card->rca << 16;
>> > +       cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
>> > +
>> > +       do {
>> > +               ret = mmc_wait_for_cmd(card->host, &cmd, 0);
>> > +               if (ret)
>> > +                       break;
>> > +
>> > +               if (!busy && mmc_ffu_busy(&cmd)) {
>> > +                       busy = 1;
>> > +                       if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) {
>> > +                               pr_warn("%s: Warning: Host did not "
>> > +                                       "wait for busy state to end.\n",
>> > +                                       mmc_hostname(card->host));
>> > +                       }
>> > +               }
>> > +
>> > +       } while (mmc_ffu_busy(&cmd));
>> > +
>> > +       return ret;
>> > +}
>>
>> By just browsing through the code for preparing and handling the mmc data
>> request in the above functions, I find quite some duplication of code from
>> the card/*.c files. Could we maybe share some code between these layers to
>> avoid duplications, and thus errors?
>
> Yes, we are aware of some duplications and tried to avoid it.
> Eventually, sharing code to avoid duplications will require changes in existing card/*c files.
> We preferred not changing existing code as much as possible.

Breaking out code and doing re-factoring in sometimes necessary. I
certainly think we should give it a try.

My concern is not just duplication of code, but also duplication of
errors as that follows with it.

>
>>
>> > +
>> > +/*
>> > + * transfer with certain parameters
>> > + */
>> > +static int mmc_ffu_simple_transfer(struct mmc_card *card,
>> > +       struct scatterlist *sg, unsigned int sg_len, u32 arg,
>> > +       unsigned int blocks, unsigned int blksz) {
>> > +       struct mmc_request mrq = {0};
>> > +       struct mmc_command cmd = {0};
>> > +       struct mmc_command stop = {0};
>> > +       struct mmc_data data = {0};
>> > +
>> > +       mrq.cmd = &cmd;
>> > +       mrq.data = &data;
>> > +       mrq.stop = &stop;
>> > +       mmc_ffu_prepare_mrq(card, &mrq, sg, sg_len, arg, blocks, blksz);
>> > +       mmc_wait_for_req(card->host, &mrq);
>> > +
>> > +       mmc_ffu_wait_busy(card);
>> > +
>> > +       return mmc_ffu_check_result(&mrq); }
>> > +
>> > +/*
>> > + * Map memory into a scatterlist.
>> > + */
>> > +static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int
>> size,
>> > +       struct scatterlist *sglist, unsigned int max_segs,
>> > +       unsigned int max_seg_sz)
>> > +{
>> > +       struct scatterlist *sg = sglist;
>> > +       unsigned int i;
>> > +       unsigned long sz = size;
>> > +       unsigned int sctr_len = 0;
>> > +       unsigned long len;
>> > +
>> > +       sg_init_table(sglist, max_segs);
>> > +
>> > +       for (i = 0; i < mem->cnt && sz; i++, sz -= len) {
>> > +               len = PAGE_SIZE * (1 << mem->arr[i].order);
>> > +
>> > +               if (len > sz) {
>> > +                       len = sz;
>> > +                       sz = 0;
>> > +               }
>> > +
>> > +               sg_set_page(sg, mem->arr[i].page, len, 0);
>> > +               sg = sg_next(sg);
>> > +               sctr_len += 1;
>> > +       }
>> > +       sg_mark_end(sg);
>> > +
>> > +       return sctr_len;
>> > +}
>> > +
>> > +static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem) {
>> > +       if (!mem)
>> > +               return;
>> > +
>> > +       while (mem->cnt--)
>> > +               __free_pages(mem->arr[mem->cnt].page,
>> > + mem->arr[mem->cnt].order);
>> > +
>> > +       kfree(mem->arr);
>> > +       kfree(mem);
>> > +}
>> > +
>> > +/*
>> > + * Cleanup struct mmc_ffu_area.
>> > + */
>> > +static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area) {
>> > +       kfree(area->sg);
>> > +       mmc_ffu_free_mem(area->mem);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +/*
>> > + * Allocate a lot of memory, preferably max_sz but at least min_sz.
>> > +In case
>> > + * there isn't much memory do not exceed 1/16th total low mem pages.
>> > +Also do
>> > + * not exceed a maximum number of segments and try not to make
>> > +segments much
>> > + * bigger than maximum segment size.
>> > + */
>> > +static struct mmc_ffu_mem *mmc_ffu_alloc_mem(unsigned long min_sz,
>> > +       unsigned long max_sz, unsigned int max_segs, unsigned int
>> > +max_seg_sz) {
>> > +       unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
>> > +       unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
>> > +       unsigned long max_seg_page_cnt = DIV_ROUND_UP(max_seg_sz,
>> PAGE_SIZE);
>> > +       unsigned long page_cnt = 0;
>> > +       /* we divide by 16 to ensure we will not allocate a big amount
>> > +        * of unnecessary pages */
>> > +       unsigned long limit = nr_free_buffer_pages() >> 4;
>> > +       struct mmc_ffu_mem *mem;
>> > +       gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
>> > +__GFP_NORETRY;
>> > +
>> > +       if (max_page_cnt > limit)
>> > +               max_page_cnt = limit;
>> > +
>> > +       if (min_page_cnt > max_page_cnt)
>> > +               min_page_cnt = max_page_cnt;
>> > +
>> > +       if (max_segs * max_seg_page_cnt > max_page_cnt)
>> > +               max_segs = DIV_ROUND_UP(max_page_cnt,
>> > + max_seg_page_cnt);
>> > +
>> > +       mem = kzalloc(sizeof(struct mmc_ffu_mem), GFP_KERNEL);
>> > +       if (!mem)
>> > +               return NULL;
>> > +
>> > +       mem->arr = kzalloc(sizeof(struct mmc_ffu_pages) * max_segs,
>> > +               GFP_KERNEL);
>> > +       if (!mem->arr)
>> > +               goto out_free;
>> > +
>> > +       while (max_page_cnt) {
>> > +               struct page *page;
>> > +               unsigned int order;
>> > +
>> > +               order = get_order(max_seg_page_cnt << PAGE_SHIFT);
>> > +
>> > +               do {
>> > +                       page = alloc_pages(flags, order);
>> > +               } while (!page && order--);
>> > +
>> > +               if (!page)
>> > +                       goto out_free;
>> > +
>> > +               mem->arr[mem->cnt].page = page;
>> > +               mem->arr[mem->cnt].order = order;
>> > +               mem->cnt += 1;
>> > +               if (max_page_cnt <= (1UL << order))
>> > +                       break;
>> > +               max_page_cnt -= 1UL << order;
>> > +               page_cnt += 1UL << order;
>> > +       }
>> > +
>> > +       if (page_cnt < min_page_cnt)
>> > +               goto out_free;
>> > +
>> > +       return mem;
>> > +
>> > +out_free:
>> > +       mmc_ffu_free_mem(mem);
>> > +       return NULL;
>> > +}
>> > +
>> > +/*
>> > + * Initialize an area for data transfers.
>> > + * Copy the data to the allocated pages.
>> > + */
>> > +static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct
>> mmc_card *card,
>> > +       const u8 *data, int size)
>> > +{
>> > +       int ret;
>> > +       int i;
>> > +       int length = 0;
>> > +
>> > +       area->max_tfr = size;
>> > +
>> > +       /* Try to allocate enough memory for a max. sized transfer. Less is OK
>> > +        * because the same memory can be mapped into the scatterlist more
>> than
>> > +        * once. Also, take into account the limits imposed on scatterlist
>> > +        * segments by the host driver.
>> > +        */
>> > +       area->mem = mmc_ffu_alloc_mem(1, area->max_tfr, area-
>> >max_segs,
>> > +               area->max_seg_sz);
>> > +       if (!area->mem)
>> > +               return -ENOMEM;
>> > +
>> > +       /* copy data to page */
>> > +       for (i = 0; i < area->mem->cnt; i++) {
>> > +               if (length > size) {
>> > +                       ret = -EINVAL;
>> > +                       goto out_free;
>> > +               }
>> > +
>> > +               memcpy(page_address(area->mem->arr[i].page), data + length,
>> > +                       min(size - length, (int)area->max_seg_sz));
>> > +               length += area->max_seg_sz;
>> > +       }
>> > +
>> > +       area->sg = kmalloc(sizeof(struct scatterlist) * area->mem->cnt,
>> > +               GFP_KERNEL);
>> > +       if (!area->sg) {
>> > +               ret = -ENOMEM;
>> > +               goto out_free;
>> > +       }
>> > +
>> > +       area->sg_len = mmc_ffu_map_sg(area->mem, size, area->sg,
>> > +               area->max_segs, area->mem->cnt);
>> > +
>> > +       return 0;
>> > +
>> > +out_free:
>> > +       mmc_ffu_area_cleanup(area);
>> > +       return ret;
>> > +}
>> > +
>> > +static int mmc_ffu_write(struct mmc_card *card, const u8 *src, u32 arg,
>> > +       int size)
>> > +{
>> > +       int rc;
>> > +       struct mmc_ffu_area area;
>> > +       int max_tfr;
>> > +
>> > +       area.sg = NULL;
>> > +       area.mem = NULL;
>> > +       area.max_segs = card->host->max_segs;
>> > +       area.max_seg_sz = card->host->max_seg_size & ~(CARD_BLOCK_SIZE
>> - 1);
>> > +       do {
>> > +               max_tfr = size;
>> > +               if (max_tfr >> 9 > card->host->max_blk_count)
>> > +                       max_tfr = card->host->max_blk_count << 9;
>> > +               if (max_tfr > card->host->max_req_size)
>> > +                       max_tfr = card->host->max_req_size;
>> > +               if (DIV_ROUND_UP(max_tfr, area.max_seg_sz) > area.max_segs)
>> > +                       max_tfr = area.max_segs * area.max_seg_sz;
>> > +
>> > +               rc = mmc_ffu_area_init(&area, card, src, max_tfr);
>> > +               if (rc != 0)
>> > +                       goto exit;
>> > +
>> > +               rc = mmc_ffu_simple_transfer(card, area.sg, area.sg_len, arg,
>> > +                       max_tfr / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE);
>> > +               if (rc != 0)
>> > +                       goto exit;
>> > +
>> > +               src += max_tfr;
>> > +               size -= max_tfr;
>> > +       } while (size > 0);
>> > +
>> > +exit:
>> > +       mmc_ffu_area_cleanup(&area);
>> > +       return rc;
>> > +}
>> > +
>> > +/* Flush all scheduled work from the MMC work queue.
>> > + * and initialize the MMC device */
>> > +static int mmc_ffu_restart(struct mmc_card *card) {
>> > +       struct mmc_host *host = card->host;
>> > +       int err = 0;
>> > +
>> > +       mmc_cache_ctrl(host, 0);
>>
>> Isn't cache flushing a bit late to consider here?
>
> I think we need to call mmc_flush_cache() instead of mmc_cache_ctrl().
>
>>
>> I would, as stated earlier, prefer one FFU operational code. Thus it would be
>> possible, before starting the FFU seuquence, to for example do cache
>> flushing, stopping BKOPS and suspend/flush the blk queue etc.
>> I think this would be more safe.
>
> Agree, it probably  would be more safe, but:
> - as mentioned before, we would like to split the process into two operational codes due
>    to different host power implementations
> - We implemented FFU as non-blocking procedure, which allows host sending regular R/W commands
>    between  downloading FW data process and FW install

Is there really a valid use case for that?

The reason we are considering to have this in-kernel is to get
robustness and to make sure the procedure don't get interrupted, at
least that is how I have interpreted the previous discussions.

Maybe you can elaborate on the reasons for in-kernel once more?

>
>
>>
>> > +       err = mmc_power_save_host(host);
>>
>> This is fragile. There are no guarantees the eMMC card will be properly
>> power cycled, I guess that is the requirement.
>
> The FFU requirement is not necessarily making power cycle, but performing "eMMC init"
> sequence (CMD0, CMD1,...).
> Once host cycling the power, it will run eMMC init sequence anyway.

Ah, that could simplify things a bit. In principle we could just run a
suspend/resume cycle to complete the operation.

>
>
>>
>> In some cases we can power cycle the card in some cases not, depending on
>> the hardware design. Are there other ways of telling the card to start using
>> the new firmware, but doing a full power cycle?
>>
>> Another concern I see, is if the card might change identity due to the
>> firmware upgrade. The card identity is validated each system resume cycle
>> and failed validation is an error we can't recover from.
>
> The current assumption is that device will change its identity during the FFU.
> But your concern is correct.
> In order to support this, the mmc_init_card() function call should be modified and assume that the card is not "oldcard".

This will be far more complex to support. It means we actually need to
remove the old card's struct device, it's corresponding blk device and
the blk device queue and for a NON_REMOVABLE host. Then trigger a new
mmc_rescan to detect and initialize the card again. I wondering what
upper mounted rootfs file systems thinks about that. :-)

So, as for now, we should aim for the simple approach and thus don't
do re-initiation/power-cycle. Instead let's leave that to be done by a
"manual" power cycle of the platform.

>
>>

[snip]

>> > +       /* eMMC v5 or later */
>> > +       if (card->ext_csd.rev >= 7) {
>> > +               card->ext_csd.ffu_capable =
>> > +                       ((ext_csd[EXT_CSD_SUPPORTED_MODE] & 1) == 1) &&
>> > +                       ((ext_csd[EXT_CSD_FW_CONFIG] & 1) == 0);
>> > +       } else {
>> > +               card->ext_csd.ffu_capable = false;
>> > +       }
>>
>> I would like to add the "ffu_capable" field from a standalone separate patch.
>
> No problem. Let us know if you prefer us doing this.

Yes, please!


Kind regards
Uffe
