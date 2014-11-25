From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: add core-level function for sending tuning commands
Date: Tue, 25 Nov 2014 11:32:17 +0100
Message-ID: <CAPDyKFpRQs-S7FjSQ57M8_ZzOL+b_DkP6X61AKw7gE8J0MfYqw@mail.gmail.com>
References: <1416581201-9851-1-git-send-email-21cnbao@gmail.com>
	<CAPDyKFp_BRyh_0VGQckkdo=brdYCcMN+hi=8puGD9qzG211SOg@mail.gmail.com>
	<CAGsJ_4y2BhGrykY9jxwCiSdhkW0jDQ4yQ0OawHv=09W1RgZVCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:61022 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKYKcS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 05:32:18 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so154891qcx.41
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 02:32:17 -0800 (PST)
In-Reply-To: <CAGsJ_4y2BhGrykY9jxwCiSdhkW0jDQ4yQ0OawHv=09W1RgZVCg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 25 November 2014 at 04:19, Barry Song <21cnbao@gmail.com> wrote:
> 2014-11-24 19:44 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 21 November 2014 at 15:46, Barry Song <21cnbao@gmail.com> wrote:
>>> From: Minda Chen <Minda.Chen@csr.com>
>>>
>>> According to the SD card spec, Add a manual tuning command function
>>> for SDR104/HS200 by sending command 19 or command 21 to read data
>>> and compare with the tuning block pattern.
>>>
>>> this patch will help to decrease some platform private codes in
>>> SDHCI platform_execute_tuning() callbacks.
>>>
>>> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>  drivers/mmc/core/mmc_ops.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mmc/core.h   |  1 +
>>>  2 files changed, 66 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index 7911e05..ecc7789 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -543,6 +543,71 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>  }
>>>  EXPORT_SYMBOL_GPL(mmc_switch);
>>>
>>> +int mmc_send_tuning(struct mmc_card *card, u32 opcode)
>>> +{
>>> +       struct mmc_request mrq = {NULL};
>>> +       struct mmc_command cmd = {0};
>>> +       struct mmc_data data = {0};
>>> +       struct scatterlist sg;
>>> +       struct mmc_host *mmc = card->host;
>>> +       struct mmc_ios *ios = &mmc->ios;
>>> +       const u8 *tuning_block_pattern;
>>> +       int size, err = 0;
>>> +       u8 *data_buf;
>>> +
>>> +       if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
>>
>> I don't think we need to care about the opcode. Let's just check the bus_width.
>>
>>> +               if (ios->bus_width == MMC_BUS_WIDTH_8) {
>>> +                       tuning_block_pattern = tuning_blk_pattern_8bit;
>>> +                       size = sizeof(tuning_blk_pattern_8bit);
>>> +               } else if (ios->bus_width == MMC_BUS_WIDTH_4) {
>>> +                       tuning_block_pattern = tuning_blk_pattern_4bit;
>>> +                       size = sizeof(tuning_blk_pattern_4bit);
>>> +               } else
>>> +                       return -EINVAL;
>>> +       } else if (opcode == MMC_SEND_TUNING_BLOCK) {
>>> +               tuning_block_pattern = tuning_blk_pattern_4bit;
>>> +               size = sizeof(tuning_blk_pattern_4bit);
>>> +       } else
>>> +               return -EINVAL;
>>> +
>>> +       data_buf = kmalloc(size, GFP_KERNEL);
>>
>> You should use kzalloc() to get the zeroed buffer you want.
>>
>>> +       if (!data_buf)
>>> +               return -ENOMEM;
>>> +
>>> +       mrq.cmd = &cmd;
>>> +       mrq.data = &data;
>>> +
>>> +       cmd.opcode = opcode;
>>> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>>> +
>>> +       data.blksz = size;
>>> +       data.blocks = 1;
>>> +       data.flags = MMC_DATA_READ;
>>
>> These needs to be assigned as well:
>>
>> data.sg = &sg;
>> data.sg_len = 1;
>>
>>> +
>>> +       mmc_set_data_timeout(&data, card);
>>
>> mmc_set_data_timeout() doesn't handle CMD21/19.
>>
>> The specs tells us about 40 commands should be executed within 150ms.
>> I would pick a value of 150ms, just to be sure we are inside that
>> range. Also, assign "data->timeout_ns" here, instead of relying on
>> mmc_set_data_timeout().
>>
>>> +       sg_init_one(&sg, data_buf, size);
>>> +       memset(data_buf, 0, size);
>>> +       mmc_wait_for_req(mmc, &mrq);
>>> +
>>> +       if (cmd.error) {
>>> +               err = cmd.error;
>>> +               goto out;
>>> +       }
>>> +
>>> +       if (data.error) {
>>> +               err = data.error;
>>> +               goto out;
>>> +       }
>>> +
>>> +       if (memcmp(data_buf, tuning_block_pattern, size))
>>> +               err = -EIO;
>>> +
>>> +out:
>>> +       kfree(data_buf);
>>> +       return err;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mmc_send_tuning);
>>> +
>>>  static int
>>>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>>>                   u8 len)
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>> index f206e29..82a0119 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -154,6 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
>>>  extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
>>>                         bool, bool);
>>>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>>> +extern int mmc_send_tuning(struct mmc_card *, u32);
>>>  extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
>>>
>>>  #define MMC_ERASE_ARG          0x00000000
>>> --
>>> 2.1.1
>>>
>
> What about?
>
> 546 int mmc_send_tuning(struct mmc_card *card)
> 547 {
> 548         struct mmc_request mrq = {NULL};
> 549         struct mmc_command cmd = {0};
> 550         struct mmc_data data = {0};
> 551         struct scatterlist sg;
> 552         struct mmc_host *mmc = card->host;
> 553         struct mmc_ios *ios = &mmc->ios;
> 554         const u8 *tuning_block_pattern;
> 555         int size, err = 0;
> 556         u8 *data_buf;
> 557         u32 opcode;
> 558
> 559         if (ios->bus_width == MMC_BUS_WIDTH_8) {
> 560                 tuning_block_pattern = tuning_blk_pattern_8bit;
> 561                 size = sizeof(tuning_blk_pattern_8bit);
> 562                 opcode = MMC_SEND_TUNING_BLOCK_HS200;
> 563         } else if (ios->bus_width == MMC_BUS_WIDTH_4) {
> 564                 tuning_block_pattern = tuning_blk_pattern_4bit;
> 565                 size = sizeof(tuning_blk_pattern_4bit);
> 566                 opcode = MMC_SEND_TUNING_BLOCK;
> 567         } else
> 568                 return -EINVAL;
> 569
> 570         data_buf = kzalloc(size, GFP_KERNEL);
> 571         if (!data_buf)
> 572                 return -ENOMEM;
> 573
> 574         mrq.cmd = &cmd;
> 575         mrq.data = &data;
> 576
> 577         cmd.opcode = opcode;
> 578         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> 579
> 580         data.blksz = size;
> 581         data.blocks = 1;
> 582         data.flags = MMC_DATA_READ;
> 583
> 584         /*
> 585          * According to the tuning specs, Tuning process
> 586          * is normally shorter 40 executions of CMD19,
> 587          * and timeout value should be shorter than 150 ms
> 588          */
> 589         data.timeout_ns = 150 * NSEC_PER_MSEC;
> 590
> 591         data.sg = &sg;
> 592         data.sg_len = 1;
> 593         sg_init_one(&sg, data_buf, size);
> 594
> 595         mmc_wait_for_req(mmc, &mrq);
> 596
> 597         if (cmd.error) {
> 598                 err = cmd.error;
> 599                 goto out;
> 600         }
> 601
> 602         if (data.error) {
> 603                 err = data.error;
> 604                 goto out;
> 605         }
> 606
> 607         if (memcmp(data_buf, tuning_block_pattern, size))
> 608                 err = -EIO;
> 609
> 610 out:
> 611         kfree(data_buf);
> 612         return err;
> 613 }
> 614 EXPORT_SYMBOL_GPL(mmc_send_tuning);
>

Looks good!

Kind regards
Uffe
