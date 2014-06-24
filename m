From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: [PATCH] mmc-utils:add KSI eMMC 5.0 FFU support
Date: Tue, 24 Jun 2014 09:54:34 +0800
Message-ID: <CAC1bqKjKNT_Mk_HUq5UGttf+sFLT-WdbDamA_TwqnemOhL4q+w@mail.gmail.com>
References: <CANCcNXdAX9C--u9vQojJ=3W-NT0HCuhCz2eVo9otTXCDmQU=ZQ@mail.gmail.com>
	<CANEJEGvJjE1x3+TQcyW+3R8+ek4CRueOsWZdsrp8061HpTmtWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37048 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaFXByg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jun 2014 21:54:36 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so5121256wiv.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2014 18:54:34 -0700 (PDT)
In-Reply-To: <CANEJEGvJjE1x3+TQcyW+3R8+ek4CRueOsWZdsrp8061HpTmtWw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Darren Chen <Darren_Chen@kingstonsolutionsinc.com>, MMC list <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>

I am interested in this topic too.

I have some issues want to discuss here.

Should we check the firmware binary file before we execute FFU? (for
example, execute checksum to
verify firmware bin file)  Should eMMC controller vendors cover this issue?

Another issue is about interrupt, because FFU is trigger by ioctl
therefore FFU will be execute on OS (like Android) environment.
Should OS (host) guarantee the FFU not to be interruptable or eMMC
(device) need to handle interrupt when execute FFU?

thanks,
hsinhsiang

2014-06-24 1:17 GMT+08:00 Grant Grundler <grundler@chromium.org>:
> Hi Darren!
> Did you understand what Puthikorn was asking for?
>
> linux-mmc maintainers don't care about Chrome-OS branches
> (stabilize-5784.0.B). Puthikorn was just pointing out the patch needs
> to be against something that linux-mmc can build.
>
> This Kingston support patch is a good example of why Avi's "[v7] mmc:
> Support-FFU-for-eMMC-v5.0" patch should be included into linux-mmc
> tree. Makes life simpler for everyone.
>
> cheers,
> grant
>
> On Tue, Jun 17, 2014 at 2:00 PM, Puthikorn Voravootivat
> <puthik@chromium.org> wrote:
>> Hi Darren
>>
>> Thanks for the patch. To make the reviewers job easier, could you send the patch
>> against [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0 by avi.
>> You can find that patch at http://www.spinics.net/lists/linux-mmc/msg26519.html
>>
>> Also, please include the "Signed-off-by:" field in the patch.
>>
>> Thanks.
>>
>> On Tue, Jun 17, 2014 at 1:41 AM,  <Darren_Chen@kingstonsolutionsinc.com> wrote:
>>> By Field Firmware Update feature in JEDEC eMMC 5.0 spec.
>>> Verified successfully in daisy.
>>> Note,also has to patch kernel drivers.
>>> Diff with stabilize-5784.0.B
>>>
>>> diff --git a/mmc.c b/mmc.c
>>> index a30426d..98c1950 100644
>>> --- a/mmc.c
>>> +++ b/mmc.c
>>> @@ -115,6 +115,11 @@ static struct Command commands[] = {
>>>                  "Send Sanitize command to the <device>.\nThis will delete
>>> the unmapped memory region of the device.",
>>>            NULL
>>>          },
>>> +        { do_emmc50_ffu, -2,
>>> +                  "ffu", "<image name> <device>\n"
>>> +                        "run eMMC 5.0 Field firmware update.\n.",
>>> +                  NULL
>>> +        },
>>>          { 0, 0, 0, 0 }
>>>  };
>>>
>>> diff --git a/mmc.h b/mmc.h
>>> index 9871d62..b338e1d 100644
>>> --- a/mmc.h
>>> +++ b/mmc.h
>>> @@ -64,6 +64,7 @@
>>>  #define EXT_CSD_ENH_START_ADDR_2        138
>>>  #define EXT_CSD_ENH_START_ADDR_1        137
>>>  #define EXT_CSD_ENH_START_ADDR_0        136
>>> +#define EXT_CSD_REV                        192
>>>  #define EXT_CSD_NATIVE_SECTOR_SIZE        63 /* R */
>>>  #define EXT_CSD_USE_NATIVE_SECTOR        62 /* R/W */
>>>  #define EXT_CSD_DATA_SECTOR_SIZE        61 /* R */
>>> @@ -79,6 +80,9 @@
>>>   */
>>>  #define BKOPS_ENABLE        (1<<0)
>>>
>>> +#define MMC_FFU_DOWNLOAD_OP        302
>>> +#define MMC_FFU_INSTALL_OP        303
>>> +
>>>  /*
>>>   * EXT_CSD field definitions
>>>   */
>>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>>> index b61f6ae..6811ab4 100644
>>> --- a/mmc_cmds.c
>>> +++ b/mmc_cmds.c
>>> @@ -1243,7 +1243,7 @@ int do_sanitize(int nargs, char **argv)
>>>          char *device;
>>>
>>>          CHECK(nargs != 2, "Usage: mmc sanitize </path/to/mmcblkX>\n",
>>> -                        exit(1));
>>> +                exit(1));
>>>
>>>          device = argv[1];
>>>
>>> @@ -1264,3 +1264,94 @@ int do_sanitize(int nargs, char **argv)
>>>
>>>  }
>>>
>>> +static int ffu_download_image(char *fname, int mmc_fd, int blk_size)
>>> +{
>>> +        int ret = 0;
>>> +        struct mmc_ioc_cmd mmc_ioc_cmd;
>>> +        char firmware_name[512];
>>> +
>>> +        memset(firmware_name, 0, sizeof(firmware_name));
>>> +        memcpy(firmware_name, fname, strlen(fname));
>>> +
>>> +        /* prepare and send ioctl */
>>> +        memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
>>> +        mmc_ioc_cmd.opcode = MMC_FFU_DOWNLOAD_OP;
>>> +        mmc_ioc_cmd.blksz = blk_size;
>>> +        mmc_ioc_cmd.blocks = 1;
>>> +        mmc_ioc_cmd.arg = 0;
>>> +        mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>>> +        mmc_ioc_cmd.write_flag = 1;
>>> +        mmc_ioc_cmd_set_data(mmc_ioc_cmd, firmware_name);
>>> +        ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
>>> +        if (ret) {
>>> +                fprintf(stderr, "ioctl FW download error%d\n", ret);
>>> +                return ret;
>>> +        }
>>> +
>>> +        return ret;
>>> +}
>>> +
>>> +static int ffu_install(int mmc_fd, int blk_size)
>>> +{
>>> +        int ret;
>>> +        struct mmc_ioc_cmd mmc_ioc_cmd;
>>> +
>>> +        memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
>>> +        mmc_ioc_cmd.opcode = MMC_FFU_INSTALL_OP;
>>> +        mmc_ioc_cmd.blksz = blk_size;
>>> +        mmc_ioc_cmd.blocks = 0;
>>> +        mmc_ioc_cmd.arg = 0;
>>> +        mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>>> +        mmc_ioc_cmd.write_flag = 0;
>>> +        ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
>>> +
>>> +        return ret;
>>> +}
>>> +
>>> +int do_emmc50_ffu (int nargs, char **argv)
>>> +{
>>> +        int fd, ret;
>>> +        char *device;
>>> +        char *path;
>>> +        __u8 ext_csd[512];
>>> +        int blk_size;
>>> +
>>> +        CHECK(nargs != 3, "Usage: ffu <image name> </path/to/mmcblkX> \n",
>>> +                exit(1));
>>> +
>>> +        device = argv[2];
>>> +        fd = open(device, O_RDWR);
>>> +        if (fd < 0) {
>>> +                perror("open");
>>> +                exit(1);
>>> +        }
>>> +
>>> +        ret = read_extcsd(fd, ext_csd);
>>> +        if (ret) {
>>> +                fprintf(stderr, "Could not read EXT_CSD from %s\n",
>>> device);
>>> +                exit(1);
>>> +        }
>>> +
>>> +        if (ext_csd[EXT_CSD_REV] < 6) {
>>> +                fprintf(stderr, "FFU is not supported on device %s\n",
>>> device);
>>> +                exit(1);
>>> +        }
>>> +
>>> +        blk_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
>>> +        path = argv[1];
>>> +        ret = ffu_download_image(path, fd, blk_size);
>>> +        if (ret) {
>>> +                fprintf(stderr, "FFU failed %d\n", ret);
>>> +                exit(1);
>>> +        }
>>> +
>>> +        ret = ffu_install(fd, blk_size);
>>> +        if (ret) {
>>> +                fprintf(stderr, "FFU failed %d\n", ret);
>>> +                exit(1);
>>> +        }
>>> +
>>> +        close(fd);
>>> +        fprintf(stderr, "FFU finished with status %d \n", ret);
>>> +        return ret;
>>> +}
>>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>>> index f023fb0..4c7b6ed 100644
>>> --- a/mmc_cmds.h
>>> +++ b/mmc_cmds.h
>>> @@ -29,3 +29,4 @@ int do_sanitize(int nargs, char **argv);
>>>  int do_status_get(int nargs, char **argv);
>>>  int do_enh_area_set(int nargs, char **argv);
>>>  int do_write_reliability_set(int nargs, char **argv);
>>> +int do_emmc50_ffu(int nargs, char **argv);
>>>
>>>
>>>
>>>
>>>
>>>
>>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>>> index 8f3194b..b616591 100644
>>> --- a/drivers/base/Kconfig
>>> +++ b/drivers/base/Kconfig
>>> @@ -85,7 +85,7 @@ config PREVENT_FIRMWARE_BUILD
>>>
>>>  config FW_LOADER
>>>          tristate "Userspace firmware loading support" if EXPERT
>>> -        default y
>>> +        default n
>>>          ---help---
>>>            This option is provided for the case where none of the in-tree
>>> modules
>>>            require userspace firmware loading support, but a module built
>>> @@ -94,7 +94,7 @@ config FW_LOADER
>>>  config FIRMWARE_IN_KERNEL
>>>          bool "Include in-kernel firmware blobs in kernel binary"
>>>          depends on FW_LOADER
>>> -        default y
>>> +        default n
>>>          help
>>>            The kernel source tree includes a number of firmware 'blobs'
>>>            that are used by various drivers. The recommended way to
>>> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
>>> index 3b1f783..66f141f 100644
>>> --- a/drivers/mmc/card/Kconfig
>>> +++ b/drivers/mmc/card/Kconfig
>>> @@ -67,3 +67,12 @@ config MMC_TEST
>>>
>>>            This driver is only of interest to those developing or
>>>            testing a host driver. Most people should say N here.
>>> +
>>> +config MMC_FFU
>>> +        bool "FFU SUPPORT"
>>> +        depends on MMC != n
>>> +        default y
>>> +        help
>>> +          This is an option to run firmware update on eMMC 5.0.
>>> +          Field firmware updates (FFU) enables features enhancment
>>> +          in the field.
>>> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
>>> index c73b406..1e9223b 100644
>>> --- a/drivers/mmc/card/Makefile
>>> +++ b/drivers/mmc/card/Makefile
>>> @@ -8,3 +8,4 @@ obj-$(CONFIG_MMC_TEST)                += mmc_test.o
>>>
>>>  obj-$(CONFIG_SDIO_UART)                += sdio_uart.o
>>>
>>> +obj-$(CONFIG_MMC_FFU)                += ffu.o
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 7fcf041..b60cfaa 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -40,6 +40,7 @@
>>>  #include <linux/mmc/host.h>
>>>  #include <linux/mmc/mmc.h>
>>>  #include <linux/mmc/sd.h>
>>> +#include <linux/mmc/ffu.h>
>>>
>>>  #include <asm/uaccess.h>
>>>
>>> @@ -487,6 +488,17 @@ static int mmc_blk_ioctl_cmd(struct block_device
>>> *bdev,
>>>
>>>          mmc_claim_host(card->host);
>>>
>>> +        if (cmd.opcode == MMC_FFU_DOWNLOAD_OP) {
>>> +                err = mmc_ffu_download(card, &cmd , idata->buf,
>>> +                        idata->buf_bytes);
>>> +                goto cmd_rel_host;
>>> +        }
>>> +
>>> +        if (cmd.opcode == MMC_FFU_INSTALL_OP) {
>>> +                err = mmc_ffu_install(card);
>>> +                goto cmd_rel_host;
>>> +        }
>>> +
>>>          err = mmc_blk_part_switch(card, md);
>>>          if (err)
>>>                  goto cmd_rel_host;
>>> diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c
>>> new file mode 100644
>>> index 0000000..9e7a4ca
>>> --- /dev/null
>>> +++ b/drivers/mmc/card/ffu.c
>>> @@ -0,0 +1,605 @@
>>> +/*
>>> + * *  ffu.c
>>> + *
>>> + *  Copyright 2007-2008 Pierre Ossman
>>> + *
>>> + *  Modified by SanDisk Corp., Copyright (c) 2013 SanDisk Corp.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> +(at
>>> + * your option) any later version.
>>> + *
>>> + * This program includes bug.h, card.h, host.h, mmc.h, scatterlist.h,
>>> + * slab.h, ffu.h & swap.h header files
>>> + * The original, unmodified version of this program - the mmc_test.c
>>> + * file - is obtained under the GPL v2.0 license that is available via
>>> + * http://www.gnu.org/licenses/,
>>> + * or http://www.opensource.org/licenses/gpl-2.0.php
>>> +*/
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/bug.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/mmc/card.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/mmc/mmc.h>
>>> +#include <linux/scatterlist.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/swap.h>
>>> +#include <linux/mmc/ffu.h>
>>> +#include <linux/firmware.h>
>>> +#include "../core/mmc_ops.h"
>>> +
>>> +/**
>>> + * struct mmc_ffu_pages - pages allocated by 'alloc_pages()'.
>>> + * @page: first page in the allocation
>>> + * @order: order of the number of pages allocated  */ struct
>>> +mmc_ffu_pages {
>>> +        struct page *page;
>>> +        unsigned int order;
>>> +};
>>> +
>>> +/**
>>> + * struct mmc_ffu_mem - allocated memory.
>>> + * @arr: array of allocations
>>> + * @cnt: number of allocations
>>> + */
>>> +struct mmc_ffu_mem {
>>> +        struct mmc_ffu_pages *arr;
>>> +        unsigned int cnt;
>>> +};
>>> +
>>> +struct mmc_ffu_area {
>>> +        unsigned long max_sz;
>>> +        unsigned int max_tfr;
>>> +        unsigned int max_segs;
>>> +        unsigned int max_seg_sz;
>>> +        unsigned int blocks;
>>> +        unsigned int sg_len;
>>> +        struct mmc_ffu_mem *mem;
>>> +        struct scatterlist *sg;
>>> +};
>>> +
>>> +static void mmc_ffu_prepare_mrq(struct mmc_card *card,
>>> +        struct mmc_request *mrq, struct scatterlist *sg, unsigned int
>>> sg_len,
>>> +        u32 arg, unsigned int blocks, unsigned int blksz, int write) {
>>> +        BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
>>> +
>>> +        if (blocks > 1) {
>>> +                mrq->cmd->opcode = write ?
>>> +                        MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
>>> +        } else {
>>> +                mrq->cmd->opcode = write ? MMC_WRITE_BLOCK :
>>> +                        MMC_READ_SINGLE_BLOCK;
>>> +        }
>>> +
>>> +        mrq->cmd->arg = arg;
>>> +        if (!mmc_card_blockaddr(card))
>>> +                mrq->cmd->arg <<= 9;
>>> +
>>> +        mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>>> +        if (blocks == 1) {
>>> +                mrq->stop = NULL;
>>> +        } else {
>>> +                mrq->stop->opcode = MMC_STOP_TRANSMISSION;
>>> +                mrq->stop->arg = 0;
>>> +                mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
>>> +        }
>>> +
>>> +        mrq->data->blksz = blksz;
>>> +        mrq->data->blocks = blocks;
>>> +        mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>>> +        mrq->data->sg = sg;
>>> +        mrq->data->sg_len = sg_len;
>>> +
>>> +        mmc_set_data_timeout(mrq->data, card); }
>>> +
>>> +/*
>>> + * Checks that a normal transfer didn't have any errors  */ static int
>>> +mmc_ffu_check_result(struct mmc_request *mrq) {
>>> +        BUG_ON(!mrq || !mrq->cmd || !mrq->data);
>>> +
>>> +        if (mrq->cmd->error != 0)
>>> +                return -EINVAL;
>>> +
>>> +        if (mrq->data->error != 0)
>>> +                return -EINVAL;
>>> +
>>> +        if (mrq->stop != NULL && mrq->stop->error != 0)
>>> +                return -1;
>>> +
>>> +        if (mrq->data->bytes_xfered != (mrq->data->blocks * mrq->data-
>>>>blksz))
>>> +                return -EINVAL;
>>> +
>>> +        return 0;
>>> +}
>>> +
>>> +static int mmc_ffu_busy(struct mmc_command *cmd) {
>>> +        return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
>>> +                (R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG); }
>>> +
>>> +static int mmc_ffu_wait_busy(struct mmc_card *card) {
>>> +        int ret, busy = 0;
>>> +        struct mmc_command cmd = {0};
>>> +
>>> +        memset(&cmd, 0, sizeof(struct mmc_command));
>>> +        cmd.opcode = MMC_SEND_STATUS;
>>> +        cmd.arg = card->rca << 16;
>>> +        cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
>>> +
>>> +        do {
>>> +                ret = mmc_wait_for_cmd(card->host, &cmd, 0);
>>> +                if (ret)
>>> +                        break;
>>> +
>>> +                if (!busy && mmc_ffu_busy(&cmd)) {
>>> +                        busy = 1;
>>> +                        if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) {
>>> +                                pr_warn("%s: Warning: Host did not "
>>> +                                        "wait for busy state to end.\n",
>>> +                                        mmc_hostname(card->host));
>>> +                        }
>>> +                }
>>> +
>>> +        } while (mmc_ffu_busy(&cmd));
>>> +
>>> +        return ret;
>>> +}
>>> +
>>> +/*
>>> + * transfer with certain parameters
>>> + */
>>> +static int mmc_ffu_simple_transfer(struct mmc_card *card,
>>> +        struct scatterlist *sg, unsigned int sg_len, u32 arg,
>>> +        unsigned int blocks, unsigned int blksz, int write) {
>>> +        struct mmc_request mrq = {0};
>>> +        struct mmc_command cmd = {0};
>>> +        struct mmc_command stop = {0};
>>> +        struct mmc_data data = {0};
>>> +
>>> +        mrq.cmd = &cmd;
>>> +        mrq.data = &data;
>>> +        mrq.stop = &stop;
>>> +        mmc_ffu_prepare_mrq(card, &mrq, sg, sg_len, arg, blocks, blksz,
>>> +                write);
>>> +        mmc_wait_for_req(card->host, &mrq);
>>> +
>>> +        mmc_ffu_wait_busy(card);
>>> +
>>> +        return mmc_ffu_check_result(&mrq);
>>> +}
>>> +
>>> +/*
>>> + * Map memory into a scatterlist.
>>> + */
>>> +static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int size,
>>> +        struct scatterlist *sglist, unsigned int max_segs,
>>> +        unsigned int max_seg_sz)
>>> +{
>>> +        struct scatterlist *sg = sglist;
>>> +        unsigned int i;
>>> +        unsigned long sz = size;
>>> +        unsigned int sctr_len = 0;
>>> +        unsigned long len;
>>> +
>>> +        sg_init_table(sglist, max_segs);
>>> +
>>> +        for (i = 0; i < mem->cnt && sz; i++, sz -= len) {
>>> +                len = PAGE_SIZE * (1 << mem->arr[i].order);
>>> +
>>> +                if (len > sz) {
>>> +                        len = sz;
>>> +                        sz = 0;
>>> +                }
>>> +
>>> +                sg_set_page(sg, mem->arr[i].page, len, 0);
>>> +                sg = sg_next(sg);
>>> +                sctr_len += 1;
>>> +        }
>>> +        sg_mark_end(sg);
>>> +
>>> +        return sctr_len;
>>> +}
>>> +
>>> +static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem) {
>>> +        if (!mem)
>>> +                return;
>>> +
>>> +        while (mem->cnt--)
>>> +                __free_pages(mem->arr[mem->cnt].page, mem->arr[mem-
>>>>cnt].order);
>>> +
>>> +        kfree(mem->arr);
>>> +        kfree(mem);
>>> +}
>>> +
>>> +/*
>>> + * Cleanup struct mmc_ffu_area.
>>> + */
>>> +static int mmc_ffu_area_cleanup(struct mmc_ffu_area *area) {
>>> +        kfree(area->sg);
>>> +        mmc_ffu_free_mem(area->mem);
>>> +
>>> +        return 0;
>>> +}
>>> +
>>> +/*
>>> + * Allocate a lot of memory, preferably max_sz but at least min_sz. In
>>> +case
>>> + * there isn't much memory do not exceed 1/16th total low mem pages.
>>> +Also do
>>> + * not exceed a maximum number of segments and try not to make segments
>>> +much
>>> + * bigger than maximum segment size.
>>> + */
>>> +static struct mmc_ffu_mem *mmc_ffu_alloc_mem(unsigned long min_sz,
>>> +        unsigned long max_sz, unsigned int max_segs, unsigned int
>>> max_seg_sz)
>>> +{
>>> +        unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
>>> +        unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
>>> +        unsigned long max_seg_page_cnt = DIV_ROUND_UP(max_seg_sz,
>>> PAGE_SIZE);
>>> +        unsigned long page_cnt = 0;
>>> +        /* we divide by 16 to ensure we will not allocate a big amount
>>> +         * of unnecessary pages */
>>> +        unsigned long limit = nr_free_buffer_pages() >> 4;
>>> +        struct mmc_ffu_mem *mem;
>>> +        gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN | __GFP_NORETRY;
>>> +
>>> +        if (max_page_cnt > limit)
>>> +                max_page_cnt = limit;
>>> +
>>> +        if (min_page_cnt > max_page_cnt)
>>> +                min_page_cnt = max_page_cnt;
>>> +
>>> +        if (max_segs * max_seg_page_cnt > max_page_cnt)
>>> +                max_segs = DIV_ROUND_UP(max_page_cnt, max_seg_page_cnt);
>>> +
>>> +        mem = kzalloc(sizeof(struct mmc_ffu_mem), GFP_KERNEL);
>>> +        if (!mem)
>>> +                return NULL;
>>> +
>>> +        mem->arr = kzalloc(sizeof(struct mmc_ffu_pages) * max_segs,
>>> +                GFP_KERNEL);
>>> +        if (!mem->arr)
>>> +                goto out_free;
>>> +
>>> +        while (max_page_cnt) {
>>> +                struct page *page;
>>> +                unsigned int order;
>>> +
>>> +                order = get_order(max_seg_page_cnt << PAGE_SHIFT);
>>> +
>>> +                do {
>>> +                        page = alloc_pages(flags, order);
>>> +                } while (!page && order--);
>>> +
>>> +                if (!page)
>>> +                        goto out_free;
>>> +
>>> +                mem->arr[mem->cnt].page = page;
>>> +                mem->arr[mem->cnt].order = order;
>>> +                mem->cnt += 1;
>>> +                if (max_page_cnt <= (1UL << order))
>>> +                        break;
>>> +                max_page_cnt -= 1UL << order;
>>> +                page_cnt += 1UL << order;
>>> +        }
>>> +
>>> +        if (page_cnt < min_page_cnt)
>>> +                goto out_free;
>>> +
>>> +        return mem;
>>> +
>>> +out_free:
>>> +        mmc_ffu_free_mem(mem);
>>> +        return NULL;
>>> +}
>>> +
>>> +/*
>>> + * Initialize an area for data transfers.
>>> + * Copy the data to the allocated pages.
>>> + */
>>> +static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card
>>> *card,
>>> +        u8 *data, int size)
>>> +{
>>> +        int ret;
>>> +        int i;
>>> +        int length = 0;
>>> +
>>> +        area->max_tfr = size;
>>> +
>>> +        /* Try to allocate enough memory for a max. sized transfer. Less
>>> is OK
>>> +         * because the same memory can be mapped into the scatterlist more
>>> than
>>> +         * once. Also, take into account the limits imposed on scatterlist
>>> +         * segments by the host driver.
>>> +         */
>>> +        area->mem = mmc_ffu_alloc_mem(1, area->max_tfr, area->max_segs,
>>> +                area->max_seg_sz);
>>> +        if (!area->mem)
>>> +                return -ENOMEM;
>>> +
>>> +        /* copy data to page */
>>> +        for (i = 0; i < area->mem->cnt; i++) {
>>> +                if (length > size) {
>>> +                        ret = -EINVAL;
>>> +                        goto out_free;
>>> +                }
>>> +
>>> +                memcpy(page_address(area->mem->arr[i].page), data + length,
>>> +                        min(size - length, (int)area->max_seg_sz));
>>> +                length += area->max_seg_sz;
>>> +        }
>>> +
>>> +        area->sg = kmalloc(sizeof(struct scatterlist) * area->mem->cnt,
>>> +                GFP_KERNEL);
>>> +        if (!area->sg) {
>>> +                ret = -ENOMEM;
>>> +                goto out_free;
>>> +        }
>>> +
>>> +        area->sg_len = mmc_ffu_map_sg(area->mem, size, area->sg,
>>> +                area->max_segs, area->mem->cnt);
>>> +
>>> +        return 0;
>>> +
>>> +out_free:
>>> +        mmc_ffu_area_cleanup(area);
>>> +        return ret;
>>> +}
>>> +
>>> +static int mmc_ffu_write(struct mmc_card *card, u8 *src, u32 arg,
>>> +        int size)
>>> +{
>>> +        int rc;
>>> +        struct mmc_ffu_area area;
>>> +        int max_tfr;
>>> +
>>> +        area.sg = NULL;
>>> +        area.mem = NULL;
>>> +        area.max_segs = card->host->max_segs;
>>> +        area.max_seg_sz = card->host->max_seg_size & ~(CARD_BLOCK_SIZE -
>>> 1);
>>> +        do {
>>> +                max_tfr = size;
>>> +                if (max_tfr >> 9 > card->host->max_blk_count)
>>> +                        max_tfr = card->host->max_blk_count << 9;
>>> +                if (max_tfr > card->host->max_req_size)
>>> +                        max_tfr = card->host->max_req_size;
>>> +                if (DIV_ROUND_UP(max_tfr, area.max_seg_sz) > area.max_segs)
>>> +                        max_tfr = area.max_segs * area.max_seg_sz;
>>> +
>>> +                rc = mmc_ffu_area_init(&area, card, src, max_tfr);
>>> +                if (rc != 0)
>>> +                        goto exit;
>>> +
>>> +                rc = mmc_ffu_simple_transfer(card, area.sg, area.sg_len,
>>> arg,
>>> +                        max_tfr / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE, 1);
>>> +                if (rc != 0)
>>> +                        goto exit;
>>> +
>>> +                src += max_tfr;
>>> +                size -= max_tfr;
>>> +        } while (size > 0);
>>> +
>>> +exit:
>>> +        mmc_ffu_area_cleanup(&area);
>>> +        return rc;
>>> +}
>>> +
>>> +/* Flush all scheduled work from the MMC work queue.
>>> + * and initialize the MMC device */
>>> +static int mmc_ffu_restart(struct mmc_card *card) {
>>> +        struct mmc_host *host = card->host;
>>> +        int err = 0;
>>> +
>>> +        mmc_cache_ctrl(host, 0);
>>> +        err = mmc_power_save_host(host);
>>> +        if (err) {
>>> +                pr_warn("%s: going to sleep failed (%d)!!!\n",
>>> +                        __func__ , err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        err = mmc_power_restore_host(host);
>>> +
>>> +exit:
>>> +
>>> +        return err;
>>> +}
>>> +
>>> +int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
>>> +        u8 *data, int buf_bytes)
>>> +{
>>> +        u8 ext_csd[CARD_BLOCK_SIZE];
>>> +        int err;
>>> +        int ret;
>>> +        u8 *buf = NULL;
>>> +        const struct firmware *fw;
>>> +
>>> +        /* Read the EXT_CSD */
>>> +        err = mmc_send_ext_csd(card, ext_csd);
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d sending ext_csd\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        /* check if card is eMMC 5.0 or higher */
>>> +        if (card->ext_csd.rev < 6)
>>> +                return -EINVAL;
>>> +
>>> +        /* Check if FFU is supported */
>>> +        if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE]) ||
>>> +                FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
>>> +                err = -EINVAL;
>>> +                pr_err("FFU: %s: error %d FFU is not supported\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        /* setup FW data buffer */
>>> +        err = request_firmware(&fw, data, &card->dev);
>>> +        if (err) {
>>> +                pr_err("Firmware request failed %d\n", err);
>>> +                goto exit_normal;
>>> +        }
>>> +
>>> +        buf = kmalloc(fw->size, GFP_KERNEL);
>>> +        if (buf == NULL) {
>>> +                pr_err("Allocating memory for firmware failed!\n");
>>> +                goto exit_normal;
>>> +        }
>>> +
>>> +        if ((fw->size % CARD_BLOCK_SIZE)) {
>>> +                pr_warn("FFU: %s: Warning %zd firmware data is not
>>> aligned!!!\n",
>>> +                        mmc_hostname(card->host), fw->size);
>>> +        }
>>> +
>>> +        memcpy(buf, fw->data, fw->size);
>>> +
>>> +        /* set device to FFU mode */
>>> +        err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_MODE_CONFIG,
>>> +                MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d FFU is not supported\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit_normal;
>>> +        }
>>> +
>>> +        /* Read the EXT_CSD */
>>> +        err = mmc_send_ext_csd(card, ext_csd);
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d sending ext_csd\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        /* set CMD ARG */
>>> +        cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
>>> +        ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
>>> +        ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
>>> +        ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
>>> +
>>> +        err = mmc_ffu_write(card, buf, cmd->arg, (int)fw->size);
>>> +
>>> +exit_normal:
>>> +        release_firmware(fw);
>>> +        kfree(buf);
>>> +
>>> +        /* host switch back to work in normal MMC Read/Write commands */
>>> +        ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +                EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
>>> +                card->ext_csd.generic_cmd6_time);
>>> +        if (ret)
>>> +                err = ret;
>>> +exit:
>>> +        return err;
>>> +}
>>> +//EXPORT_SYMBOL(mmc_ffu_download);
>>> +
>>> +int mmc_ffu_install(struct mmc_card *card) {
>>> +        u8 ext_csd[CARD_BLOCK_SIZE];
>>> +        int err;
>>> +        u32 ffu_data_len;
>>> +        u32 timeout;
>>> +
>>> +        err = mmc_send_ext_csd(card, ext_csd);
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d sending ext_csd\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        /* Check if FFU is supported */
>>> +        if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE]) ||
>>> +                FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
>>> +                err = -EINVAL;
>>> +                pr_err("FFU: %s: error %d FFU is not supported\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
>>> +
>>> +        printk("FFU programmed data length in sector = %
>>> d\r\n",ffu_data_len);
>>> +
>>> +        /* check mode operation */
>>> +        if (!FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES])) {
>>> +                /* restart the eMMC */
>>> +                err = mmc_ffu_restart(card);
>>> +                if (err) {
>>> +                        pr_err("FFU: %s: error %d FFU install:\n",
>>> +                                mmc_hostname(card->host), err);
>>> +                }
>>> +        } else {
>>> +
>>> +                ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
>>> +                        ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
>>> +
>>> +
>>> +                if (!ffu_data_len) {
>>> +                        pr_err("EPERM FFU programmed data length in sector
>>> = %d\r\n",ffu_data_len);
>>> +                        err = -EPERM;
>>> +                        return err;
>>> +                }
>>> +                /* set device to FFU mode */
>>> +                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +                        EXT_CSD_MODE_CONFIG, 0x1,
>>> +                        card->ext_csd.generic_cmd6_time);
>>> +
>>> +                if (err) {
>>> +                        pr_err("FFU: %s: error %d FFU is not supported\n",
>>> +                                mmc_hostname(card->host), err);
>>> +                        goto exit;
>>> +                }
>>> +
>>> +                timeout = ext_csd[EXT_CSD_OPERATION_CODE_TIMEOUT];
>>> +                if (timeout == 0 || timeout > 0x17) {
>>> +                        timeout = 0x17;
>>> +                        pr_warn("FFU: %s: operation code timeout is out "
>>> +                                "of range. Using maximum timeout.\n",
>>> +                                mmc_hostname(card->host));
>>> +                }
>>> +
>>> +                /* timeout is at millisecond resolution */
>>> +                timeout = (100 * (1 << timeout) / 1000) + 1;
>>> +
>>> +                /* set ext_csd to install mode */
>>> +                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +                        EXT_CSD_MODE_OPERATION_CODES,
>>> +                        MMC_FFU_INSTALL_SET, timeout);
>>> +
>>> +                if (err) {
>>> +                        pr_err("FFU: %s: error %d setting install mode\n",
>>> +                                mmc_hostname(card->host), err);
>>> +                        goto exit;
>>> +                }
>>> +        }
>>> +
>>> +        /* read ext_csd */
>>> +        err = mmc_send_ext_csd(card, ext_csd);
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d sending ext_csd\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                goto exit;
>>> +        }
>>> +
>>> +        /* return status */
>>> +        err = ext_csd[EXT_CSD_FFU_STATUS];
>>> +        if (err) {
>>> +                pr_err("FFU: %s: error %d FFU install:\n",
>>> +                        mmc_hostname(card->host), err);
>>> +                err = -EINVAL;
>>> +                goto exit;
>>> +        }
>>> +
>>> +exit:
>>> +        return err;
>>> +}
>>> +//EXPORT_SYMBOL(mmc_ffu_install);
>>> +
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 428aca1..1ec14b2 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2558,6 +2558,38 @@ int mmc_resume_host(struct mmc_host *host)
>>>  }
>>>  EXPORT_SYMBOL(mmc_resume_host);
>>>
>>> +int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
>>> +{
>>> +        struct mmc_card *card = host->card;
>>> +        unsigned int timeout;
>>> +        int err = 0;
>>> +
>>> +        if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
>>> +                        mmc_card_is_removable(host))
>>> +                return err;
>>> +
>>> +        if (card && mmc_card_mmc(card) &&
>>> +                        (card->ext_csd.cache_size > 0)) {
>>> +                enable = !!enable;
>>> +
>>> +                if (card->ext_csd.cache_ctrl ^ enable) {
>>> +                        timeout = enable ? card-
>>>>ext_csd.generic_cmd6_time : 0;
>>> +                        err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +                                        EXT_CSD_CACHE_CTRL, enable,
>>> timeout);
>>> +                        if (err)
>>> +                               pr_err("%s: cache %s error %d\n",
>>> +                                                mmc_hostname(card->host),
>>> +                                                enable ? "on" : "off",
>>> +                                                err);
>>> +                        else
>>> +                                card->ext_csd.cache_ctrl = enable;
>>> +                }
>>> +        }
>>> +
>>> +        return err;
>>> +}
>>> +EXPORT_SYMBOL(mmc_cache_ctrl);
>>> +
>>>  /* Do the card removal on suspend if card is assumed removeable
>>>   * Do that in pm notifier while userspace isn't yet frozen, so we will be
>>> able
>>>     to sync the card.
>>> diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h
>>> new file mode 100644
>>> index 0000000..4924b8e7
>>> --- /dev/null
>>> +++ b/include/linux/mmc/ffu.h
>>> @@ -0,0 +1,56 @@
>>> +/*
>>> + *
>>> + *  ffu.h
>>> + *
>>> + * Copyright (c) 2013 SanDisk Corp.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program was created by SanDisk Corp
>>> + * The ffu.h file is obtained under the GPL v2.0 license that is
>>> + * available via http://www.gnu.org/licenses/,
>>> + * or http://www.opensource.org/licenses/gpl-2.0.php
>>> + */
>>> +
>>> +#if !defined(_FFU_H_)
>>> +#define _FFU_H_
>>> +
>>> +#include <linux/mmc/card.h>
>>> +
>>> +#define CARD_BLOCK_SIZE 512
>>> +
>>> +/*
>>> + * eMMC5.0 Field Firmware Update (FFU) opcodes
>>> + */
>>> +#define MMC_FFU_DOWNLOAD_OP 302
>>> +#define MMC_FFU_INSTALL_OP 303
>>> +
>>> +#define MMC_FFU_MODE_SET 0x1
>>> +#define MMC_FFU_MODE_NORMAL 0x0
>>> +#define MMC_FFU_INSTALL_SET 0x1
>>> +
>>> +#ifdef CONFIG_MMC_FFU
>>> +
>>> +#define MMC_FFU_ENABLE 0x0
>>> +#define MMC_FFU_CONFIG 0x1
>>> +#define MMC_FFU_SUPPORTED_MODES 0x1
>>> +#define MMC_FFU_FEATURES 0x1
>>> +
>>> +#define FFU_ENABLED(ffu_enable)        (ffu_enable & MMC_FFU_CONFIG)
>>> +#define FFU_SUPPORTED_MODE(ffu_sup_mode) (ffu_sup_mode &&
>>> MMC_FFU_SUPPORTED_MODES)
>>> +#define FFU_CONFIG(ffu_config) (ffu_config & MMC_FFU_CONFIG)
>>> +#define FFU_FEATURES(ffu_fetures) (ffu_fetures & MMC_FFU_FEATURES)
>>> +
>>> +int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd, u8
>>> *data, int buf_bytes);
>>> +int mmc_ffu_install(struct mmc_card *card);
>>> +
>>> +#else
>>> +
>>> +static inline int mmc_ffu_download(struct mmc_card *card, struct
>>> mmc_command *cmd, u8 *data, int buf_bytes) { return -ENOSYS; }
>>> +static inline int mmc_ffu_install(struct mmc_card *card) { return -
>>> ENOSYS; }
>>> +
>>> +#endif
>>> +#endif /* _FFU_H_ */
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 91caaa9..b589381 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -248,6 +248,7 @@ struct mmc_host {
>>>          u32                        caps2;                /* More host
>>> capabilities
>>> */
>>>
>>>  #define MMC_CAP2_BOOTPART_NOACC        (1 << 0)        /* Boot partition
>>> no access */
>>> +#define MMC_CAP2_CACHE_CTRL        (1 << 1)        /* Allow cache control
>>> */
>>>  #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)        /* Notify poweroff
>>> supported */
>>>  #define MMC_CAP2_NO_MULTI_READ        (1 << 3)        /* Multiblock reads
>>> don't
>>> work */
>>>  #define MMC_CAP2_NO_SLEEP_CMD        (1 << 4)        /* Don't allow sleep
>>> command */
>>> @@ -372,6 +373,8 @@ extern int mmc_power_restore_host(struct mmc_host
>>> *host);
>>>  extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
>>>  extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
>>>
>>> +extern int mmc_cache_ctrl(struct mmc_host *, u8);
>>> +
>>>  static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>>>  {
>>>          host->ops->enable_sdio_irq(host, 0);
>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>> index 94d532e..d58e14b 100644
>>> --- a/include/linux/mmc/mmc.h
>>> +++ b/include/linux/mmc/mmc.h
>>> @@ -272,6 +272,9 @@ struct _mmc_csd {
>>>   * EXT_CSD fields
>>>   */
>>>
>>> +#define EXT_CSD_FFU_STATUS                26        /* R */
>>> +#define EXT_CSD_MODE_OPERATION_CODES        29        /* W */
>>> +#define EXT_CSD_MODE_CONFIG                30        /* R/W */
>>>  #define EXT_CSD_FLUSH_CACHE                32      /* W */
>>>  #define EXT_CSD_CACHE_CTRL                33      /* R/W */
>>>  #define EXT_CSD_POWER_OFF_NOTIFICATION        34        /* R/W */
>>> @@ -287,6 +290,7 @@ struct _mmc_csd {
>>>  #define EXT_CSD_SANITIZE_START                165     /* W */
>>>  #define EXT_CSD_WR_REL_PARAM                166        /* RO */
>>>  #define EXT_CSD_RPMB_MULT                168        /* RO */
>>> +#define EXT_CSD_FW_CONFIG                169        /* R/W */
>>>  #define EXT_CSD_BOOT_WP                        173        /* R/W */
>>>  #define EXT_CSD_ERASE_GROUP_DEF                175        /* R/W */
>>>  #define EXT_CSD_PART_CONFIG                179        /* R/W */
>>> @@ -322,6 +326,11 @@ struct _mmc_csd {
>>>  #define EXT_CSD_POWER_OFF_LONG_TIME        247        /* RO */
>>>  #define EXT_CSD_GENERIC_CMD6_TIME        248        /* RO */
>>>  #define EXT_CSD_CACHE_SIZE                249        /* RO, 4 bytes */
>>> +#define EXT_CSD_NUM_OF_FW_SEC_PROG        302        /* RO */
>>> +#define EXT_CSD_FFU_ARG                        487        /* RO, 4 bytes */
>>> +#define EXT_CSD_OPERATION_CODE_TIMEOUT        491        /* RO */
>>> +#define EXT_CSD_FFU_FEATURES                492        /* RO */
>>> +#define EXT_CSD_SUPPORTED_MODE                493        /* RO */
>>>  #define EXT_CSD_TAG_UNIT_SIZE                498        /* RO */
>>>  #define EXT_CSD_DATA_TAG_SUPPORT        499        /* RO */
>>>  #define EXT_CSD_BKOPS_SUPPORT                502        /* RO */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
