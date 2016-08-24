From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: sdio: deploy error handling instead of
 triggering BUG_ON
Date: Wed, 24 Aug 2016 18:04:19 +0800
Message-ID: <31369909-fc8a-0efc-7488-591859fc5e15@rock-chips.com>
References: <1472025499-6758-1-git-send-email-shawn.lin@rock-chips.com>
 <1472025499-6758-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrt3ZHrzR9TovG2a3nqs7pKqdVHoU-KXtgRsnFGaJK4DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:58968 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbcHXKFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 06:05:32 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.190])
        by lucky1.263xmail.com (Postfix) with ESMTP id 78D2A53D1B
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2016 18:04:23 +0800 (CST)
In-Reply-To: <CAPDyKFrt3ZHrzR9TovG2a3nqs7pKqdVHoU-KXtgRsnFGaJK4DQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>

在 2016/8/24 17:30, Ulf Hansson 写道:
> On 24 August 2016 at 09:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> When using mmc_io_rw_extended, it's intent to avoid null
>> pointer of card and invalid func number. But actually it
>> didn't prevent that as the seg_size already use the card.
>> Currently the wrapper function sdio_io_rw_ext_helper already
>> use card before calling mmc_io_rw_extended, so we should move
>> this check to there. As to the func number, it was token from
>> '(ocr & 0x70000000) >> 28' which should be enough to guarantee
>> that it won't be larger than 7. But we should prevent the
>> caller like wifi drivers modify this value. So let's move this
>> check into sdio_io_rw_ext_helper either.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - remove the BUG_ON and move these into sdio_io_rw_ext_helper
>>
>>  drivers/mmc/core/sdio_io.c  | 3 +++
>>  drivers/mmc/core/sdio_ops.c | 2 --
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
>> index 78cb4d5..18f2938 100644
>> --- a/drivers/mmc/core/sdio_io.c
>> +++ b/drivers/mmc/core/sdio_io.c
>> @@ -307,6 +307,9 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>>         unsigned max_blocks;
>>         int ret;
>>
>> +       if ((!func->card) || (func->num > 7))
>
> You also need to validate func and before func->card.

Good catch, thanks.

>
>> +               return -EINVAL;
>> +
>>         /* Do the bulk of the transfer using block mode (if supported). */
>>         if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
>>                 /* Blocks per command is limited by host count, host transfer
>> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
>> index 34f6e80..45397e8 100644
>> --- a/drivers/mmc/core/sdio_ops.c
>> +++ b/drivers/mmc/core/sdio_ops.c
>> @@ -129,8 +129,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>>         unsigned int nents, left_size, i;
>>         unsigned int seg_size = card->host->max_seg_size;
>>
>> -       BUG_ON(!card);
>> -       BUG_ON(fn > 7);
>>         WARN_ON(blksz == 0);
>>
>>         /* sanity check */
>> --
>> 2.3.7
>>
>>
>
> There are a couple of more BUG_ONs() that is being invoked when SDIO
> func drivers abuses the SDIO func API.
>
> In cases when the API allows us to propagate error codes we should do
> that and just when the sdio_io_rw_ext_helper() is involved. In case
> when the API don't allows to propagate error codes, we should convert
> the BUG_ON() to  "if (WARN_ON()) return;".

Right, I was wondering that why there are so many BUG_ON for SDIO routine.

I will look at all of these API routines and check them
one by one.

>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

