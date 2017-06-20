From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] mmc: block: Refactor mmc_blk_part_switch()
Date: Tue, 20 Jun 2017 13:23:46 +0200
Message-ID: <CACRpkdZCjQEQ0FdyfqqiXuNO-TuWdye9iSgztztOhFqMv=z+xw@mail.gmail.com>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-3-linus.walleij@linaro.org> <CA+i0qc75-YSj6-H5qpPi0f4BF_25k_fL53Nmg7QYu61QaWU9HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36485 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdFTLXs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 07:23:48 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so12186742iti.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2017 04:23:48 -0700 (PDT)
In-Reply-To: <CA+i0qc75-YSj6-H5qpPi0f4BF_25k_fL53Nmg7QYu61QaWU9HA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomas Winkler <tomasw@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Tomas Winkler <tomas.winkler@intel.com>

On Mon, Jun 19, 2017 at 9:53 PM, Tomas Winkler <tomasw@gmail.com> wrote:
> On Thu, Jun 15, 2017 at 3:12 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Instead of passing a struct mmc_blk_data * to mmc_blk_part_switch()
>> let's pass the actual partition type we want to switch to. This
>> is necessary in order not to have a block device with a backing
>> mmc_blk_data and request queue and all for every hardware partition,
>> such as RPMB.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/mmc/core/block.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index d1b824e65590..94b97f97be1a 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -127,7 +127,7 @@ module_param(perdev_minors, int, 0444);
>>  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
>>
>>  static inline int mmc_blk_part_switch(struct mmc_card *card,
>> -                                     struct mmc_blk_data *md);
>> +                                     unsigned int part_type);
>
> Maybe it's time to change this misleading 'part_type' name, this a bit
> that represent  the actual  partition to
> access and not a type of an partition. Maybe part_to_access will more
> reflect the spec wording.
> Need to change also  in mmc_blk_data;

That would be a separate patch I think (one patch, one technical step)
what about target_partition or something?

>>                 /* Always switch back to main area after RPMB access */
>>                 if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
>> -                       mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
>> +                       mmc_blk_part_switch(card, main_md->part_type);
>
> Actually this switch back should be probably done for any partition
> which is not user data area.
> so this should be
>  if (md->area_type != MMC_BLK_DATA_AREA_MAIN)

That is another technical step so it should be a separate patch as
well.

Actually I think this code is broken in several ways, especially if
you do something crazy like access the main partition, both boot
partitions and the RPMB partition at the same time. It will invariably
screw something up.

I am trying to rework this to use the block layer properly, RPMB is
just the first step...

Yours,
Linus Walleij
