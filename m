From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 12:34:35 +0900
Message-ID: <CAKYAXd_pNg0MwX5vR2Pegn0UeSX3=qO4WU70QExfiFooD8yLuw@mail.gmail.com>
References: <1337185615-17202-1-git-send-email-saugata.das@stericsson.com>
	<CAKYAXd8PsrTjTvfM3y4PFg-oHGZs2ayUFrFAG1=_7NXvYRngfg@mail.gmail.com>
	<CAKLKtzeZaOJ7vKqLgj5HYJF18ww+=C5LwWkU_i-77D0Xz6EVSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33247 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2EQDeg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 23:34:36 -0400
Received: by obbtb18 with SMTP id tb18so1916533obb.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 May 2012 20:34:35 -0700 (PDT)
In-Reply-To: <CAKLKtzeZaOJ7vKqLgj5HYJF18ww+=C5LwWkU_i-77D0Xz6EVSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, venkat@linaro.org, patches@linaro.org, arnd.bergmann@linaro.org, lporzio@micron.com

2012/5/17, Saugata Das <saugata.das@linaro.org>:
> On 17 May 2012 06:35, Namjae Jeon <linkinjeon@gmail.com> wrote:
>> 2012/5/17, Saugata Das <saugata.das@stericsson.com>:
>>> From: Saugata Das <saugata.das@linaro.org>
>>>
>>> This patch adds the support for large sector size of 4KB by disabling
>>> emulation.
>>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
>>> mmc_blk_alloc_req.
>>>
>>> In order to use this patch for 4KB sector size, ensure that
>>> USE_NATIVE_SECTOR
>>> is enabled, partition table is 4KB sector size aligned and file system
>>> block
>>> size is 4KB.
>> If you change native 4K from 512B emulation, filesystem sector size is
>> also 4KB align as well block size.
>> because default block size of most of filesystem is 4KB, but
>> filesystem sector size is 512B,
>> So filesystem corruption can be occured on native 4K device.
>>>
>
> I have tested ext4 with 4KB block size and I did not see an instance
> where it requested 512B.
-> yes, you can not see it, because when formating parittion, sector
size is set to 4K by I/O topology. As you know, several filesystems
can be used on eMMC not only Ext4. You should mention filesystem
sector size align in changelog.
> For sure, if someone is using file system with 512B sector on eMMC
> then the USE_NATIVE_SECTOR should not be enabled.
-> it will be the reason about below my question.
>
> The idea behind the patch is, MMC driver should notify the sector size
> information in a generic manner to file system. So, we depend here on
> ext_csd.data_sector_size, which should work in both 512B and 4KB case.
>
>
>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>> ---
>>>  drivers/mmc/card/block.c |   16 ++++++++++++++--
>>>  drivers/mmc/core/mmc.c   |    2 ++
>>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 91cda75..b4d0eb1 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1284,7 +1284,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>>> *mq,
>>> struct request *rqc)
>>>       int ret = 1, disable_multi = 0, retry = 0, type;
>>>       enum mmc_blk_status status;
>>>       struct mmc_queue_req *mq_rq;
>>> -     struct request *req;
>>> +     struct request *req = rqc;
>>>       struct mmc_async_req *areq;
>>>
>>>       if (!rqc && !mq->mqrq_prev->req)
>>> @@ -1292,6 +1292,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>>> *mq,
>>> struct request *rqc)
>>>
>>>       do {
>>>               if (rqc) {
>>> +
>>> +                     /*
>>> +                       * When 4KB native sector is enabled, single
>>> block
>>> +                       * read or write is not allowed
>>> +                       */
>>> +                     if ((brq->data.blocks == 1) &&
>>> +                             (card->ext_csd.data_sector_size == 4096))
>>> +                             goto cmd_abort;
>>                                               Why did you add this
>> code in any case ?
>>
>
> This was pointed during the previous review that with 4KB sector mode,
> 512B transfer is not allowed. So, this check has been added here.
-> I think that you should add error log to inform user error case.
>
>>>                       mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
>>>                       areq = &mq->mqrq_cur->mmc_active;
>>>               } else
>>> @@ -1539,7 +1547,11 @@ static struct mmc_blk_data
>>> *mmc_blk_alloc_req(struct
>>> mmc_card *card,
>>>       snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>>>                "mmcblk%d%s", md->name_idx, subname ? subname : "");
>>>
>>> -     blk_queue_logical_block_size(md->queue.queue, 512);
>>> +     if (mmc_card_mmc(card))
>>> +             blk_queue_logical_block_size(md->queue.queue,
>>> +                     card->ext_csd.data_sector_size);
>>> +     else
>>> +             blk_queue_logical_block_size(md->queue.queue, 512);
>>>       set_capacity(md->disk, size);
>>>
>>>       if (mmc_host_cmd23(card->host)) {
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 7268c26..11444c6 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -516,6 +516,8 @@ static int mmc_read_ext_csd(struct mmc_card *card,
>>> u8
>>> *ext_csd)
>>>               } else {
>>>                       card->ext_csd.data_tag_unit_size = 0;
>>>               }
>>> +     } else {
>>> +             card->ext_csd.data_sector_size = 512;
>>>       }
>>>
>>>  out:
>>> --
>>> 1.7.4.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
