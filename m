From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH 1/1 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 27 Feb 2014 18:29:26 -0800
Message-ID: <CANEJEGvqk3J-4UmpAhckJ_pceVTUYxa4wZ-qo=u2HVC=+zmzLw@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE63F49709D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CANEJEGudCOTViPR6UJcEAuCcS64P9Uh1G-TtE7BL3hJ4TU+MuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:43066 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaB1C30 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 21:29:26 -0500
Received: by mail-oa0-f51.google.com with SMTP id j17so3416359oag.38
        for <linux-mmc@vger.kernel.org>; Thu, 27 Feb 2014 18:29:26 -0800 (PST)
In-Reply-To: <CANEJEGudCOTViPR6UJcEAuCcS64P9Uh1G-TtE7BL3hJ4TU+MuQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

Sorry. Gmail isn't vi and accidentally sent this prematurely. /o\
Continuing the review comments...

On Thu, Feb 27, 2014 at 6:12 PM, Grant Grundler <grundler@chromium.org> wrote:
...
>> +
>> +/*
>> + * Map memory into a scatterlist.
>> + */
>> +static int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, unsigned long size,
>> +       struct scatterlist *sglist, unsigned int max_segs,
>> +       unsigned int max_seg_sz, unsigned int *sg_len,
>> +       int min_sg_len)
>> +{
>> +       struct scatterlist *sg = NULL;
>> +       unsigned int i;
>> +       unsigned long sz = size;
>> +
>> +       sg_init_table(sglist, max_segs);
>> +       if (min_sg_len > max_segs)
>> +               min_sg_len = max_segs;
>> +
>> +       *sg_len = 0;
>
> and add

And add "sg = sglist;" here.

>
>> +       do {
>> +               for (i = 0; i < mem->cnt; i++) {
>> +                       unsigned long len = PAGE_SIZE <<
>> + mem->arr[i].order;
>
> This word wrap is likely wrong in the source code (not mangled by the
> mail handler).
>
>> +
>> +                       if (min_sg_len && (size / min_sg_len < len))
>> +                               len = ALIGN(size / min_sg_len, CARD_BLOCK_SIZE);
>> +                       if (len > sz)
>> +                               len = sz;
>> +                       if (len > max_seg_sz)
>> +                               len = max_seg_sz;
>> +                       if (sg)
>> +                               sg = sg_next(sg);
>> +                       else
>> +                               sg = sglist;
>
> can't we initialize "sg" outside the loop to sglist?
>
>> +                       if (!sg)
>> +                               return -EINVAL;
>
> This test is for "sg = sg_next(sg)" code...both should move to the end
> of the loop.
>
>> +                       sg_set_page(sg, mem->arr[i].page, len, 0);
>
> This should be at the top of the loop?
>
>> +                       sz -= len;
>> +                       *sg_len += 1;
>> +                       if (!sz)
>> +                               break;
>
> move this test into the for() loop condition
> It's a bit confusing...why do{ } while (sz)?
>
> A comment explaining the relationship between sz and mem->cnt could
> justify the do/while loop.
>
>> +               }
>> +       } while (sz);
>> +
>> +       if (sg)
>
> We will have returned -EINVAL if this is not true. We shouldn't need
> to test here.
>
>> +               sg_mark_end(sg);
>> +
>> +       return 0;
>> +}
>> +
>> +static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem) {

I'd prefer:
   static void mmc_ffu_free( struct mmc_ffu_pages mem_arr[], cnt)

but that's just my $0.02.

>> +       if (!mem)
>> +               return;
>> +       while (mem->cnt--)
>> +               __free_pages(mem->arr[mem->cnt].page, mem->arr[mem->cnt].order);
>> +       kfree(mem->arr);

and then don't need to kalloc or kfree this object.

>> +}
>> +
>> +/*
>> + * Cleanup struct mmc_ffu_area.
>> + */
>> +static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area) {
>> +       kfree(area->sg);
>> +       mmc_ffu_free_mem(area->mem);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Allocate a lot of memory, preferably max_sz but at least min_sz. In
>> +case
>> + * there isn't much memory do not exceed 1/16th total low mem pages.
>> +Also do
>> + * not exceed a maximum number of segments and try not to make segments
>> +much
>> + * bigger than maximum segment size.
>
> The comment doesn't explain WHY the code needs to do all the memory
> allocation gymnastics.
> It lists several the constraints, most of which are obvious from the
> code, but only explains one (why 1/16th total low mem pages).
>
> This feels like a lot of code to do what copy_from_user() and DMA API
> should be taking care of.
> (just guessing at this point though).
>
>> + */
>> +static struct mmc_ffu_mem *mmc_ffu_alloc_mem(unsigned long min_sz,
>> +       unsigned long max_sz, unsigned int max_segs, unsigned int
>> +max_seg_sz) {
>> +       unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
>> +       unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
>> +       unsigned long max_seg_page_cnt = DIV_ROUND_UP(max_seg_sz, PAGE_SIZE);
>> +       unsigned long page_cnt = 0;
>> +       unsigned long limit = nr_free_buffer_pages() >> 4;
>> +       struct mmc_ffu_mem *mem;
>> +
>> +       if (max_page_cnt > limit)
>> +               max_page_cnt = limit;
>> +       if (min_page_cnt > max_page_cnt)
>> +               min_page_cnt = max_page_cnt;
>> +
>> +       if (max_seg_page_cnt > max_page_cnt)
>> +               max_seg_page_cnt = max_page_cnt;
>> +
>> +       if (max_segs > max_page_cnt)
>> +               max_segs = max_page_cnt;
>> +
>> +       mem = kzalloc(sizeof(struct mmc_ffu_mem), GFP_KERNEL);
>> +       if (!mem)
>> +               return NULL;
>> +
>> +       mem->arr = kzalloc(sizeof(struct mmc_ffu_pages) * max_segs, GFP_KERNEL);
>> +       if (!mem->arr)
>> +               goto out_free;
>> +
>> +       while (max_page_cnt) {
>> +               struct page *page;
>> +               unsigned int order;
>> +               gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
>> +                       __GFP_NORETRY;
>> +
>> +               order = get_order(max_seg_page_cnt << PAGE_SHIFT);
>> +               while (1) {
>> +                       page = alloc_pages(flags, order);
>> +                       if (page || !order)
>> +                               break;
>> +                       order -= 1;
>> +               }
>
> Would this be cleaner to write as:
>    do {
>      page = alloc_pages(flags, order);
>    while (!page && order--);
>
> "Nice" side effects: order will still have the same value if the
> allocation succeeds.
>
>> +               if (!page) {
>> +                       if (page_cnt < min_page_cnt)
>> +                               goto out_free;
>> +                       break;
>> +               }
>> +               mem->arr[mem->cnt].page = page;
>> +               mem->arr[mem->cnt].order = order;
>> +               mem->cnt += 1;
>
> These three lines make sense - just recording what was allocated.
>
>> +               if (max_page_cnt <= (1UL << order))
>> +                       break;
>> +               max_page_cnt -= 1UL << order;
>> +               page_cnt += 1UL << order;
>> +               if (mem->cnt >= max_segs) {
>
> Make this part of the while() loop condition.
>
>> +                       if (page_cnt < min_page_cnt)
>> +                               goto out_free;
>
> move this test out of the loop.
>
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return mem;
>
> if (page_cnt >= min_page_cnt)
>     return mem;
>
>> +
>> +out_free:
>> +       mmc_ffu_free_mem(mem);
>> +       return NULL;
>> +}
>> +
>> +/*
>> + * Initialize an area for data transfers.
>> + * Copy the data to the allocated pages.
>> + */
>> +static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card *card,
>> +       u8 *data, unsigned int size)
>> +{
>> +       int ret, i, length;
>> +
>> +       area->max_segs = card->host->max_segs;
>> +       area->max_seg_sz = card->host->max_seg_size & ~(CARD_BLOCK_SIZE - 1);
>> +       area->max_tfr = size;
>> +
>> +       if (area->max_tfr >> 9 > card->host->max_blk_count)
>> +               area->max_tfr = card->host->max_blk_count << 9;
>> +       if (area->max_tfr > card->host->max_req_size)
>> +               area->max_tfr = card->host->max_req_size;
>> +       if (area->max_tfr / area->max_seg_sz > area->max_segs)
>> +               area->max_tfr = area->max_segs * area->max_seg_sz;
>> +
>> +       /*
>> +        * Try to allocate enough memory for a max. sized transfer. Less is OK
>> +        * because the same memory can be mapped into the scatterlist more than
>> +        * once. Also, take into account the limits imposed on scatterlist
>> +        * segments by the host driver.
>> +        */
>> +       area->mem = mmc_ffu_alloc_mem(1, area->max_tfr, area->max_segs,
>> +                       area->max_seg_sz);
>> +       if (!area->mem)
>> +               return -ENOMEM;
>> +
>> +       /* copy data to page */
>> +       length = 0;
>> +       for (i = 0; i < area->mem->cnt; i++) {
>> +                memcpy(page_address(area->mem->arr[i].page), data + length,
>> +                       min(size - length, area->max_seg_sz));
>> +               length += area->max_seg_sz;
>> +       }
>> +
>> +       area->sg = kmalloc(sizeof(struct scatterlist) * area->max_segs,
>> +               GFP_KERNEL);
>> +       if (!area->sg) {
>> +               ret = -ENOMEM;
>> +               goto out_free;
>> +       }
>> +
>> +       ret = mmc_ffu_map_sg(area->mem, size, area->sg,
>> +                       area->max_segs, area->max_seg_sz, &area->sg_len,
>> + 1);
>> +
>> +       if (ret != 0)
>> +               goto out_free;
>> +
>> +       return 0;
>> +
>> +out_free:
>> +       mmc_ffu_area_cleanup(area);
>> +       return ret;
>> +}
>> +
>> +static int mmc_ffu_write(struct mmc_card *card, u8 *src, u32 arg,
>> +       int size)
>> +{
>> +       int rc;
>> +       struct mmc_ffu_area mem;
>> +
>> +       mem.sg = NULL;
>> +       mem.mem = NULL;
>> +
>> +       if (!src) {
>> +               pr_err("FFU: %s: data buffer is NULL\n",
>> +                       mmc_hostname(card->host));
>> +               return -EINVAL;
>> +       }
>> +       rc = mmc_ffu_area_init(&mem, card, src, size);
>> +       if (rc != 0)
>> +               goto exit;
>> +
>> +       rc = mmc_ffu_simple_transfer(card, mem.sg, mem.sg_len, arg,
>> +               size / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE, 1);
>> +
>> +exit:
>> +       mmc_ffu_area_cleanup(&mem);
>> +       return rc;
>> +}
>> +/* Flush all scheduled work from the MMC work queue.
>> + * and initialize the MMC device */
>> +static int mmc_ffu_restart(struct mmc_card *card) {
>> +       struct mmc_host *host = card->host;
>> +       int err = 0;
>> +
>> +       mmc_cache_ctrl(host, 0);

Did you mean mmc_flush() here?

>> +       err = mmc_power_save_host(host);
>> +       if (err) {
>> +               pr_warn("%s: going to sleep failed (%d)!!!\n",
>> +                       __func__ , err);
>> +               goto exit;
>> +       }
>> +
>> +       err = mmc_power_restore_host(host);
>> +
>> +exit:
>> +
>> +       return err;
>> +}
>> +
>> +/* Host set the EXT_CSD */
>> +static int mmc_host_set_ffu(struct mmc_card *card, u32 ffu_enable) {
>> +       int err;
>> +
>> +       /* check if card is eMMC 5.0 or higher */
>> +       if (card->ext_csd.rev < 7)
>> +               return -EINVAL;
>> +
>> +       if (FFU_ENABLED(ffu_enable)) {
>> +               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                       EXT_CSD_FW_CONFIG, MMC_FFU_ENABLE,
>> +                       card->ext_csd.generic_cmd6_time);
>> +               if (err) {
>> +                       pr_err("%s: switch to FFU failed with error %d\n",
>> +                               mmc_hostname(card->host), err);
>> +                       return err;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
>> +       u8 *data, int buf_bytes)
>> +{
>> +       u8 ext_csd[CARD_BLOCK_SIZE];
>> +       int err;
>> +       int ret;
>> +
>> +       /* Read the EXT_CSD */
>> +       err = mmc_send_ext_csd(card, ext_csd);
>> +       if (err) {
>> +               pr_err("FFU: %s: error %d sending ext_csd\n",
>> +                       mmc_hostname(card->host), err);
>> +               goto exit;
>> +       }
>> +
>> +       /* Check if FFU is supported by card */
>> +       if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])) {
>> +               err = -EINVAL;
>> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> +                       mmc_hostname(card->host), err);
>> +               goto exit;
>> +       }
>> +
>> +       err = mmc_host_set_ffu(card, ext_csd[EXT_CSD_FW_CONFIG]);
>> +       if (err) {
>> +               pr_err("FFU: %s: error %d FFU is not supported\n",

mmc_host_set_ffu is already printing an error message. Both don't need
to be verbose about the same error.

>> +                       mmc_hostname(card->host), err);
>> +               err = -EINVAL;

Clobbering the err that was returned?

>> +               goto exit;
>> +       }
>> +
>> +       /* set device to FFU mode */
>> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_MODE_CONFIG,
>> +               MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);

Not calling mmc_host_set_ffu() to do this?

>> +       if (err) {
>> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> +                       mmc_hostname(card->host), err);
>> +               goto exit_normal;
>> +       }
>> +
>> +       /* set CMD ARG */
>> +       cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
>> +               ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
>> +               ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
>> +               ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
>> +
>> +       err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);
>> +
>> +exit_normal:
>> +       /* host switch back to work in normal MMC Read/Write commands */
>> +       ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +               EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
>> +               card->ext_csd.generic_cmd6_time);
>> +       if (ret)
>> +               err = ret;
>> +
>> +exit:
>> +       return err;
>> +}
>> +EXPORT_SYMBOL(mmc_ffu_download);


Ok...no additional comments for now...but I am pretty sure I need to
stare at this more to understand how it works.

cheers,
grant
