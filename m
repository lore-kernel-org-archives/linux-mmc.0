From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/6] FROMLIST: mmc: core: Support FFU for eMMC v5.0
Date: Thu, 14 Apr 2016 10:48:14 +0200
Message-ID: <CAPDyKFqMyV4rqsn0KQy6o3pARrcTaa+HnDZo9H3HpuRhieV9+g@mail.gmail.com>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
	<1460586824-40688-4-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35672 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbcDNIsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 04:48:16 -0400
Received: by mail-wm0-f54.google.com with SMTP id a140so137025386wma.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2016 01:48:15 -0700 (PDT)
In-Reply-To: <1460586824-40688-4-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Avi Shchislowski <avi.shchislowski@sandisk.com>, yaniv.agman@sandisk.com, Holger Schurig <holgerschurig@gmail.com>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 14 April 2016 at 00:33, Gwendal Grignou <gwendal@chromium.org> wrote:
> The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec
> (Jedec: JESD84-B50.pdf)
>
> * This solution allows to:
>   - Complete eMMC 5.0 FFU procedure as an atomic operation, without
>     being interrupted by other IO requests
>   - Not limited Firmware data size. Using Multiple Write operations.
>   - Support of both EXT_CSD_MODE_OPERATION_CODES modes
> * The solution is using "udev" device manager to transfer FW data from
>   user space to eMMC driver
> * Pre-existing functions from mmc_test were used in this solution.
>
> Changes from the list patch:
> - fix patch in order to apply it with 'git apply'
> - rename file ffu.c
> - run checkpatch.pl
> - other minor cleanups.
>
>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> Signed-off-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Yaniv Agman <yaniv.agman@sandisk.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> ---
>  drivers/mmc/card/Kconfig    |   8 +
>  drivers/mmc/card/block.c    |   1 +
>  drivers/mmc/card/mmc_test.c |  96 +--------
>  drivers/mmc/core/Makefile   |   1 +
>  drivers/mmc/core/core.c     | 125 ++++++++++++
>  drivers/mmc/core/ffu.c      | 479 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h    |   1 +
>  include/linux/mmc/core.h    |   9 +
>  include/linux/mmc/ffu.h     |  46 +++++
>  include/linux/mmc/mmc.h     |   7 +
>  10 files changed, 687 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/mmc/core/ffu.c
>  create mode 100644 include/linux/mmc/ffu.h

I think I have told this before. This isn't possible for me to review,
you need to split it up in smaller pieces.

Re-factoring and moving code around needs to be done in separate
patches. Moreover, I think I have stated the importance of not
duplicating code, but as I didn't move further in the review perhaps
that is already addressed in $subject patch!?

Kind regards
Uffe

>
> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
> index 5562308..19ba729 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -68,3 +68,11 @@ config MMC_TEST
>
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
> +
> +config MMC_FFU
> +       bool "FFU SUPPORT"
> +       depends on MMC != n
> +       help
> +         This is an option to run firmware update on eMMC 5.0.
> +         Field firmware updates (FFU) enables features enhancment
> +         in the field.
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 0bd0b9d..c543dd9 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -45,6 +45,7 @@
>  #include <linux/mmc/sd.h>
>
>  #include <asm/uaccess.h>
> +#include <linux/mmc/ffu.h>
>
>  #include "queue.h"
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 7fc9174..ceba898 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -191,43 +191,9 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
>         struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
>         unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
>  {
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
>
> -       if (blocks > 1) {
> -               mrq->cmd->opcode = write ?
> -                       MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
> -       } else {
> -               mrq->cmd->opcode = write ?
> -                       MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
> -       }
> -
> -       mrq->cmd->arg = dev_addr;
> -       if (!mmc_card_blockaddr(test->card))
> -               mrq->cmd->arg <<= 9;
> -
> -       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> -
> -       if (blocks == 1)
> -               mrq->stop = NULL;
> -       else {
> -               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
> -               mrq->stop->arg = 0;
> -               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> -       }
> -
> -       mrq->data->blksz = blksz;
> -       mrq->data->blocks = blocks;
> -       mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
> -       mrq->data->sg = sg;
> -       mrq->data->sg_len = sg_len;
> -
> -       mmc_set_data_timeout(mrq->data, test->card);
> -}
> -
> -static int mmc_test_busy(struct mmc_command *cmd)
> -{
> -       return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
> -               (R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
> +       mmc_prepare_mrq(test->card, mrq, sg, sg_len,
> +                       dev_addr, blocks, blksz, write);
>  }
>
>  /*
> @@ -235,30 +201,9 @@ static int mmc_test_busy(struct mmc_command *cmd)
>   */
>  static int mmc_test_wait_busy(struct mmc_test_card *test)
>  {
> -       int ret, busy;
> -       struct mmc_command cmd = {0};
> -
> -       busy = 0;
> -       do {
> -               memset(&cmd, 0, sizeof(struct mmc_command));
> -
> -               cmd.opcode = MMC_SEND_STATUS;
> -               cmd.arg = test->card->rca << 16;
> -               cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> -
> -               ret = mmc_wait_for_cmd(test->card->host, &cmd, 0);
> -               if (ret)
> -                       break;
> -
> -               if (!busy && mmc_test_busy(&cmd)) {
> -                       busy = 1;
> -                       if (test->card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -                               pr_info("%s: Warning: Host did not "
> -                                       "wait for busy state to end.\n",
> -                                       mmc_hostname(test->card->host));
> -               }
> -       } while (mmc_test_busy(&cmd));
> +       int ret;
>
> +       ret = mmc_wait_busy(test->card);
>         return ret;
>  }
>
> @@ -689,20 +634,8 @@ static int mmc_test_check_result(struct mmc_test_card *test,
>  {
>         int ret;
>
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
> -
>         ret = 0;
> -
> -       if (!ret && mrq->cmd->error)
> -               ret = mrq->cmd->error;
> -       if (!ret && mrq->data->error)
> -               ret = mrq->data->error;
> -       if (!ret && mrq->stop && mrq->stop->error)
> -               ret = mrq->stop->error;
> -       if (!ret && mrq->data->bytes_xfered !=
> -               mrq->data->blocks * mrq->data->blksz)
> -               ret = RESULT_FAIL;
> -
> +       ret = mmc_check_result(mrq);
>         if (ret == -EINVAL)
>                 ret = RESULT_UNSUP_HOST;
>
> @@ -838,23 +771,14 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
>         struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
>         unsigned blocks, unsigned blksz, int write)
>  {
> -       struct mmc_request mrq = {0};
> -       struct mmc_command cmd = {0};
> -       struct mmc_command stop = {0};
> -       struct mmc_data data = {0};
> -
> -       mrq.cmd = &cmd;
> -       mrq.data = &data;
> -       mrq.stop = &stop;
> +       int ret;
>
> -       mmc_test_prepare_mrq(test, &mrq, sg, sg_len, dev_addr,
> +       ret = mmc_simple_transfer(test->card, sg, sg_len, dev_addr,
>                 blocks, blksz, write);
> +       if (ret == -EINVAL)
> +               ret = RESULT_UNSUP_HOST;
>
> -       mmc_wait_for_req(test->card->host, &mrq);
> -
> -       mmc_test_wait_busy(test);
> -
> -       return mmc_test_check_result(test, &mrq);
> +       return ret;
>  }
>
>  /*
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 2c25138..3316703 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -10,3 +10,4 @@ mmc_core-y                    := core.o bus.o host.o \
>                                    quirks.o slot-gpio.o
>  mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o pwrseq_emmc.o
>  mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
> +obj-$(CONFIG_MMC_FFU)          += ffu.o
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3f9cf1b..4194012 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2835,6 +2835,131 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  }
>  #endif
>
> +/*
> + * Fill in the mmc_request structure for read or write command,
> + * with the scatter gather list data.
> + */
> +void mmc_prepare_mrq(struct mmc_card *card,
> +       struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
> +       unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
> +{
> +       BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
> +
> +       if (blocks > 1) {
> +               mrq->cmd->opcode = write ?
> +                       MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
> +       } else {
> +               mrq->cmd->opcode = write ?
> +                       MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
> +       }
> +
> +       mrq->cmd->arg = dev_addr;
> +       if (!mmc_card_blockaddr(card))
> +               mrq->cmd->arg <<= 9;
> +
> +       mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       if (blocks == 1) {
> +               mrq->stop = NULL;
> +       } else {
> +               mrq->stop->opcode = MMC_STOP_TRANSMISSION;
> +               mrq->stop->arg = 0;
> +               mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> +       }
> +
> +       mrq->data->blksz = blksz;
> +       mrq->data->blocks = blocks;
> +       mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
> +       mrq->data->sg = sg;
> +       mrq->data->sg_len = sg_len;
> +
> +       mmc_set_data_timeout(mrq->data, card);
> +}
> +EXPORT_SYMBOL(mmc_prepare_mrq);
> +
> +static int mmc_busy(u32 status)
> +{
> +       return !(status & R1_READY_FOR_DATA) ||
> +               (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> +}
> +
> +/*
> + * Wait for the card to finish the busy state
> + */
> +int mmc_wait_busy(struct mmc_card *card)
> +{
> +       int ret, busy = 0;
> +       u32 status;
> +
> +       do {
> +               ret = mmc_send_status(card, &status);
> +               if (ret)
> +                       break;
> +
> +               if (!busy && mmc_busy(status)) {
> +                       busy = 1;
> +                       if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) {
> +                               pr_warn("%s: Warning: %s\n",
> +                                       mmc_hostname(card->host),
> +                                       "Host did not wait end of busy state.");
> +                       }
> +               }
> +
> +       } while (mmc_busy(status));
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(mmc_wait_busy);
> +
> +int mmc_check_result(struct mmc_request *mrq)
> +{
> +       int ret;
> +
> +       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
> +
> +       ret = 0;
> +
> +       if (!ret && mrq->cmd->error)
> +               ret = mrq->cmd->error;
> +       if (!ret && mrq->data->error)
> +               ret = mrq->data->error;
> +       if (!ret && mrq->stop && mrq->stop->error)
> +               ret = mrq->stop->error;
> +       if (!ret && mrq->data->bytes_xfered !=
> +               mrq->data->blocks * mrq->data->blksz)
> +               ret = -EPERM;
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(mmc_check_result);
> +
> +/*
> + * transfer with certain parameters
> + */
> +int mmc_simple_transfer(struct mmc_card *card,
> +       struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
> +       unsigned blocks, unsigned blksz, int write)
> +{
> +       struct mmc_request mrq = {0};
> +       struct mmc_command cmd = {0};
> +       struct mmc_command stop = {0};
> +       struct mmc_data data = {0};
> +
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +       mrq.stop = &stop;
> +
> +       mmc_prepare_mrq(card, &mrq, sg, sg_len, dev_addr,
> +                       blocks, blksz, write);
> +
> +       mmc_wait_for_req(card->host, &mrq);
> +
> +       mmc_wait_busy(card);
> +
> +       return mmc_check_result(&mrq);
> +}
> +EXPORT_SYMBOL(mmc_simple_transfer);
> +
>  /**
>   * mmc_init_context_info() - init synchronization context
>   * @host: mmc host
> diff --git a/drivers/mmc/core/ffu.c b/drivers/mmc/core/ffu.c
> new file mode 100644
> index 0000000..c2883a8
> --- /dev/null
> +++ b/drivers/mmc/core/ffu.c
> @@ -0,0 +1,479 @@
> +/*
> + * *  ffu.c
> + *
> + *  Copyright 2007-2008 Pierre Ossman
> + *
> + *  Modified by SanDisk Corp.
> + *  Modified by Google Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + *
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/core.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/swap.h>
> +#include <linux/mmc/ffu.h>
> +#include <linux/firmware.h>
> +
> +/**
> + * struct mmc_ffu_pages - pages allocated by 'alloc_pages()'.
> + * @page: first page in the allocation
> + * @order: order of the number of pages allocated
> + */
> +struct mmc_ffu_pages {
> +       struct page *page;
> +       unsigned int order;
> +};
> +
> +/**
> + * struct mmc_ffu_mem - allocated memory.
> + * @arr: array of allocations
> + * @cnt: number of allocations
> + */
> +struct mmc_ffu_mem {
> +       struct mmc_ffu_pages *arr;
> +       unsigned int cnt;
> +};
> +
> +struct mmc_ffu_area {
> +       unsigned long max_sz;
> +       unsigned int max_tfr;
> +       unsigned int max_segs;
> +       unsigned int max_seg_sz;
> +       unsigned int blocks;
> +       unsigned int sg_len;
> +       struct mmc_ffu_mem mem;
> +       struct sg_table sgtable;
> +};
> +
> +/*
> + * Map memory into a scatterlist.
> + */
> +static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int size,
> +       struct scatterlist *sglist)
> +{
> +       struct scatterlist *sg = sglist;
> +       unsigned int i;
> +       unsigned long sz = size;
> +       unsigned int sctr_len = 0;
> +       unsigned long len;
> +
> +       for (i = 0; i < mem->cnt && sz; i++, sz -= len) {
> +               len = PAGE_SIZE << mem->arr[i].order;
> +
> +               if (len > sz) {
> +                       len = sz;
> +                       sz = 0;
> +               }
> +
> +               sg_set_page(sg, mem->arr[i].page, len, 0);
> +               sg = sg_next(sg);
> +               sctr_len++;
> +       }
> +
> +       return sctr_len;
> +}
> +
> +static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem)
> +{
> +       if (!mem)
> +               return;
> +
> +       while (mem->cnt--)
> +               __free_pages(mem->arr[mem->cnt].page, mem->arr[mem->cnt].order);
> +
> +       kfree(mem->arr);
> +}
> +
> +/*
> + * Cleanup struct mmc_ffu_area.
> + */
> +static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area)
> +{
> +       sg_free_table(&area->sgtable);
> +       mmc_ffu_free_mem(&area->mem);
> +       return 0;
> +}
> +
> +/*
> + * Allocate a lot of memory, preferably max_sz but at least min_sz. In case
> + * there isn't much memory do not exceed 1/16th total low mem pages. Also do
> + * not exceed a maximum number of segments and try not to make segments much
> + * bigger than maximum segment size.
> + */
> +static int mmc_ffu_alloc_mem(struct mmc_ffu_area *area, unsigned long min_sz)
> +{
> +       unsigned long max_page_cnt = DIV_ROUND_UP(area->max_tfr, PAGE_SIZE);
> +       unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
> +       unsigned long max_seg_page_cnt = DIV_ROUND_UP(area->max_seg_sz,
> +                                                     PAGE_SIZE);
> +       unsigned long page_cnt = 0;
> +       /*
> +        * We divide by 16 to ensure we will not allocate a big amount
> +        * of unnecessary pages.
> +        */
> +       unsigned long limit = nr_free_buffer_pages() >> 4;
> +
> +       gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN | __GFP_NORETRY;
> +
> +       if (max_page_cnt > limit)
> +               max_page_cnt = limit;
> +
> +       if (min_page_cnt > max_page_cnt)
> +               min_page_cnt = max_page_cnt;
> +
> +       if (area->max_segs * max_seg_page_cnt > max_page_cnt)
> +               area->max_segs = DIV_ROUND_UP(max_page_cnt, max_seg_page_cnt);
> +
> +       area->mem.arr = kcalloc(area->max_segs,
> +                               sizeof(*area->mem.arr),
> +                               GFP_KERNEL);
> +       if (!area->mem.arr)
> +               return -ENOMEM;
> +       area->mem.cnt = 0;
> +
> +       while (max_page_cnt) {
> +               struct page *page;
> +               unsigned int order;
> +
> +               order = get_order(max_seg_page_cnt << PAGE_SHIFT);
> +
> +               do {
> +                       page = alloc_pages(flags, order);
> +               } while (!page && order--);
> +
> +               if (!page)
> +                       goto out_free;
> +
> +               area->mem.arr[area->mem.cnt].page = page;
> +               area->mem.arr[area->mem.cnt].order = order;
> +               area->mem.cnt++;
> +               page_cnt += 1UL << order;
> +               if (max_page_cnt <= (1UL << order))
> +                       break;
> +               max_page_cnt -= 1UL << order;
> +       }
> +
> +       if (page_cnt < min_page_cnt)
> +               goto out_free;
> +
> +       return 0;
> +
> +out_free:
> +       mmc_ffu_free_mem(&area->mem);
> +       return -ENOMEM;
> +}
> +
> +/*
> + * Initialize an area for data transfers.
> + * Copy the data to the allocated pages.
> + */
> +static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card *card,
> +       const u8 *data, int size)
> +{
> +       int ret;
> +       int i;
> +       int length = 0, page_length;
> +       int min_size = 0;
> +
> +       area->max_tfr = size;
> +
> +       ret = mmc_ffu_alloc_mem(area, 1);
> +       for (i = 0; i < area->mem.cnt; i++) {
> +               if (length > size) {
> +                       ret = -EINVAL;
> +                       goto out_free;
> +               }
> +               page_length = PAGE_SIZE << area->mem.arr[i].order;
> +               min_size = min(size - length, page_length);
> +               memcpy(page_address(area->mem.arr[i].page), data + length,
> +                      min(size - length, page_length));
> +               length += page_length;
> +       }
> +
> +       ret = sg_alloc_table(&area->sgtable, area->mem.cnt, GFP_KERNEL);
> +       if (ret)
> +               goto out_free;
> +
> +       area->sg_len = mmc_ffu_map_sg(&area->mem, size, area->sgtable.sgl);
> +
> +
> +       return 0;
> +
> +out_free:
> +       mmc_ffu_free_mem(&area->mem);
> +       return ret;
> +}
> +
> +static int mmc_ffu_write(struct mmc_card *card, const u8 *src, u32 arg,
> +       int size)
> +{
> +       int rc;
> +       struct mmc_ffu_area area = {0};
> +       int max_tfr;
> +
> +       area.max_segs = card->host->max_segs;
> +       area.max_seg_sz = card->host->max_seg_size;
> +
> +       do {
> +               max_tfr = size;
> +               if ((max_tfr >> 9) > card->host->max_blk_count)
> +                       max_tfr = card->host->max_blk_count << 9;
> +               if (max_tfr > card->host->max_req_size)
> +                       max_tfr = card->host->max_req_size;
> +               if (DIV_ROUND_UP(max_tfr, area.max_seg_sz) > area.max_segs)
> +                       max_tfr = area.max_segs * area.max_seg_sz;
> +
> +               rc = mmc_ffu_area_init(&area, card, src, max_tfr);
> +               if (rc != 0)
> +                       goto exit;
> +
> +               rc = mmc_simple_transfer(card, area.sgtable.sgl, area.sg_len,
> +                       arg, max_tfr >> 9, 512, 1);
> +               mmc_ffu_area_cleanup(&area);
> +               if (rc != 0) {
> +                       pr_err("%s mmc_ffu_simple_transfer %d\n", __func__, rc);
> +                       goto exit;
> +               }
> +               src += max_tfr;
> +               size -= max_tfr;
> +
> +       } while (size > 0);
> +
> +exit:
> +       return rc;
> +}
> +
> +static int mmc_ffu_switch_mode(struct mmc_card *card, int mode)
> +{
> +       int err = 0;
> +       int offset;
> +
> +       switch (mode) {
> +       case MMC_FFU_MODE_SET:
> +       case MMC_FFU_MODE_NORMAL:
> +               offset = EXT_CSD_MODE_CONFIG;
> +               break;
> +       case MMC_FFU_INSTALL_SET:
> +                       offset = EXT_CSD_MODE_OPERATION_CODES;
> +                       mode = 0x1;
> +                       break;
> +       default:
> +               err = -EINVAL;
> +               break;
> +       }
> +
> +       if (!err) {
> +               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                       offset, mode,
> +                       card->ext_csd.generic_cmd6_time);
> +       }
> +
> +       return err;
> +}
> +
> +static int mmc_ffu_install(struct mmc_card *card, u8 **ext_csd)
> +{
> +       int err;
> +       u32 timeout;
> +
> +       /* check mode operation */
> +       if (!card->ext_csd.ffu_mode_op) {
> +               /* host switch back to work in normal MMC Read/Write commands */
> +               err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
> +               if (err) {
> +                       pr_err("FFU: %s: switch to normal mode error %d:\n",
> +                              mmc_hostname(card->host), err);
> +                       return err;
> +               }
> +
> +               /* restart the eMMC */
> +               err = mmc_hw_reset(card->host);
> +               if (err) {
> +                       pr_err("FFU: %s: install error %d:\n",
> +                              mmc_hostname(card->host), err);
> +                       return err;
> +               }
> +       } else {
> +               timeout = (*ext_csd)[EXT_CSD_OPERATION_CODE_TIMEOUT];
> +               if (timeout == 0 || timeout > 0x17) {
> +                       timeout = 0x17;
> +                       pr_warn("FFU: %s: Using maximum timeout: %s\n",
> +                               mmc_hostname(card->host),
> +                               "operation code timeout out of range");
> +               }
> +
> +               /* timeout is at millisecond resolution */
> +               timeout = DIV_ROUND_UP((100 * (1 << timeout)), 1000);
> +
> +               /* set ext_csd to install mode */
> +               err = mmc_ffu_switch_mode(card, MMC_FFU_INSTALL_SET);
> +               if (err) {
> +                       pr_err("FFU: %s: error %d setting install mode\n",
> +                              mmc_hostname(card->host), err);
> +                       return err;
> +               }
> +       }
> +
> +       /*
> +        * Free ext_csd allocation from previous mmc_get_ext_csd() call, and
> +        * zero it out so no one touches it again
> +        */
> +       kfree(*ext_csd);
> +       *ext_csd = NULL;
> +       /* read ext_csd */
> +       err = mmc_get_ext_csd(card, ext_csd);
> +       if (err) {
> +               pr_err("FFU: %s: error %d sending ext_csd\n",
> +                      mmc_hostname(card->host), err);
> +               return err;
> +       }
> +
> +       /* return status */
> +       err = (*ext_csd)[EXT_CSD_FFU_STATUS];
> +       if (err) {
> +               pr_err("FFU: %s: FFU status 0x%02x, expected 0\n",
> +                      mmc_hostname(card->host), err);
> +               return  -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +int mmc_ffu_invoke(struct mmc_card *card, const char *name)
> +{
> +       u8 *ext_csd = NULL;
> +       int err;
> +       u32 arg;
> +       u32 fw_prog_bytes;
> +       const struct firmware *fw;
> +
> +       /* Check if FFU is supported */
> +       if (!card->ext_csd.ffu_capable) {
> +               pr_err("FFU: %s: error FFU is not supported %d rev %d\n",
> +                      mmc_hostname(card->host), card->ext_csd.ffu_capable,
> +                      card->ext_csd.rev);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (strlen(name) > 512) {
> +               pr_err("FFU: %s: name %.20s is too long.\n",
> +                      mmc_hostname(card->host), name);
> +               return -EINVAL;
> +       }
> +
> +       /* setup FW data buffer */
> +       err = request_firmware(&fw, name, &card->dev);
> +       if (err) {
> +               pr_err("FFU: %s: Firmware request failed %d\n",
> +                      mmc_hostname(card->host), err);
> +               return err;
> +       }
> +       if ((fw->size % 512)) {
> +               pr_warn("FFU: %s: Warning %zd firmware data size unaligned!\n",
> +                       mmc_hostname(card->host),
> +                       fw->size);
> +       }
> +
> +       mmc_get_card(card);
> +
> +       /* trigger flushing*/
> +       err = mmc_flush_cache(card);
> +       if (err) {
> +               pr_err("FFU: %s: error %d flushing data\n",
> +                      mmc_hostname(card->host), err);
> +               goto exit;
> +       }
> +
> +       /* Read the EXT_CSD */
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       if (err) {
> +               pr_err("FFU: %s: error %d sending ext_csd\n",
> +                      mmc_hostname(card->host), err);
> +               goto exit;
> +       }
> +
> +       /* set CMD ARG */
> +       arg = ext_csd[EXT_CSD_FFU_ARG] |
> +               ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
> +               ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
> +               ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
> +
> +       /* set device to FFU mode */
> +       err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_SET);
> +       if (err) {
> +               pr_err("FFU: %s: error %d FFU is not supported\n",
> +                      mmc_hostname(card->host), err);
> +               goto exit;
> +       }
> +
> +       err = mmc_ffu_write(card, fw->data, arg, fw->size);
> +       if (err) {
> +               pr_err("FFU: %s: write error %d\n",
> +                      mmc_hostname(card->host), err);
> +               goto exit;
> +       }
> +       /* payload  will be checked only in op_mode supported */
> +       if (card->ext_csd.ffu_mode_op) {
> +               /*
> +                * Free ext_csd allocation from previous mmc_get_ext_csd()
> +                * call, and zero it out in case it gets used again.
> +                */
> +               kfree(ext_csd);
> +               ext_csd = NULL;
> +               /* Read the EXT_CSD */
> +               err = mmc_get_ext_csd(card, &ext_csd);
> +               if (err) {
> +                       pr_err("FFU: %s: error %d sending ext_csd\n",
> +                              mmc_hostname(card->host), err);
> +                       goto exit;
> +               }
> +
> +               /* check that the eMMC has received the payload */
> +               fw_prog_bytes = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
> +
> +               fw_prog_bytes *= card->ext_csd.data_sector_size;
> +               if (fw_prog_bytes != fw->size) {
> +                       err = -EINVAL;
> +                       pr_err("FFU: %s: error %d: incorrect programmation\n",
> +                              __func__, err);
> +                       pr_err("FFU: sectors written: %d, expected %zd\n",
> +                              fw_prog_bytes, fw->size);
> +                       goto exit;
> +               }
> +       }
> +
> +       err = mmc_ffu_install(card, &ext_csd);
> +       if (err) {
> +               pr_err("FFU: %s: error firmware install %d\n",
> +                      mmc_hostname(card->host), err);
> +               goto exit;
> +       }
> +
> +exit:
> +       if (err != 0) {
> +               /*
> +                * Host switch back to work in normal MMC
> +                * Read/Write commands.
> +               */
> +               mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
> +       }
> +       release_firmware(fw);
> +       mmc_put_card(card);
> +       kfree(ext_csd);
> +       return err;
> +}
> +EXPORT_SYMBOL(mmc_ffu_invoke);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8df2846..f16ec68 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -82,6 +82,7 @@ struct mmc_ext_csd {
>         bool                    hpi_en;                 /* HPI enablebit */
>         bool                    hpi;                    /* HPI support bit */
>         unsigned int            hpi_cmd;                /* cmd used as HPI */
> +       bool                    ffu_mode_op;       /* FFU mode operation code */
>         bool                    bkops;          /* background support bit */
>         bool                    man_bkops_en;   /* manual bkops enable bit */
>         unsigned int            data_sector_size;       /* 512 bytes or 4KB */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 37967b6..95137d7 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -196,6 +196,15 @@ extern int mmc_flush_cache(struct mmc_card *);
>
>  extern int mmc_detect_card_removed(struct mmc_host *host);
>
> +extern void mmc_prepare_mrq(struct mmc_card *card,
> +       struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
> +       unsigned dev_addr, unsigned blocks, unsigned blksz, int write);
> +extern int mmc_wait_busy(struct mmc_card *card);
> +extern int mmc_check_result(struct mmc_request *mrq);
> +extern int mmc_simple_transfer(struct mmc_card *card,
> +       struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
> +       unsigned blocks, unsigned blksz, int write);
> +
>  /**
>   *     mmc_claim_host - exclusively claim a host
>   *     @host: mmc host to claim
> diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h
> new file mode 100644
> index 0000000..f307742
> --- /dev/null
> +++ b/include/linux/mmc/ffu.h
> @@ -0,0 +1,46 @@
> +/*
> + *  ffu.h
> + *
> + * Copyright (C) 2015 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * This program was created by SanDisk Corp
> + */
> +
> +#ifndef _FFU_H_
> +#define _FFU_H_
> +
> +#include <linux/mmc/card.h>
> +
> +/*
> + * eMMC5.0 Field Firmware Update (FFU) opcodes
> +*/
> +#define MMC_FFU_INVOKE_OP 302
> +
> +#define MMC_FFU_MODE_SET 0x1
> +#define MMC_FFU_MODE_NORMAL 0x0
> +#define MMC_FFU_INSTALL_SET 0x2
> +
> +#ifdef CONFIG_MMC_FFU
> +#define MMC_FFU_FEATURES 0x1
> +#define FFU_FEATURES(ffu_features) (ffu_features & MMC_FFU_FEATURES)
> +
> +int mmc_ffu_invoke(struct mmc_card *card, const char *name);
> +
> +#else
> +static inline int mmc_ffu_invoke(struct mmc_card *card, const char *name)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +#endif /* FFU_H_ */
> +
> +
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 15f2c4a..212b0a8 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -272,6 +272,9 @@ struct _mmc_csd {
>   * EXT_CSD fields
>   */
>
> +#define EXT_CSD_FFU_STATUS             26      /* R */
> +#define EXT_CSD_MODE_OPERATION_CODES   29      /* W */
> +#define EXT_CSD_MODE_CONFIG            30      /* R/W */
>  #define EXT_CSD_FLUSH_CACHE            32      /* W */
>  #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
> @@ -330,6 +333,10 @@ struct _mmc_csd {
>  #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
>  #define EXT_CSD_PWR_CL_DDR_200_360     253     /* RO */
>  #define EXT_CSD_FIRMWARE_VERSION       254     /* RO, 8 bytes */
> +#define EXT_CSD_NUM_OF_FW_SEC_PROG     302     /* RO, 4 bytes */
> +#define EXT_CSD_FFU_ARG                        487     /* RO, 4 bytes */
> +#define EXT_CSD_OPERATION_CODE_TIMEOUT 491     /* RO */
> +#define EXT_CSD_FFU_FEATURES           492     /* RO */
>  #define EXT_CSD_SUPPORTED_MODE         493     /* RO */
>  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
>  #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
> --
> 2.8.0.rc3.226.g39d4020
>
