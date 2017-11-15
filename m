From: Park Huijin <bbang.huijin.park@gmail.com>
Subject: Re: [PATCH] mmc: card: increase wait time
Date: Wed, 15 Nov 2017 13:52:08 +0900
Message-ID: <CAFwFC8TEmtKPnW7mkYqiM8R3yuxJm-8FEHvuwDf2HjDjT6aWhA@mail.gmail.com>
References: <CGME20171114024825eucas1p218873c4ff649c17d4061b6660aa6264f@eucas1p2.samsung.com>
 <1510627683-5209-1-git-send-email-huijin.park@samsung.com> <DM5PR04MB1085B1BAE62048DF2054E5B2FC280@DM5PR04MB1085.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:45036 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdKOEwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Nov 2017 23:52:10 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so329832itc.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2017 20:52:09 -0800 (PST)
In-Reply-To: <DM5PR04MB1085B1BAE62048DF2054E5B2FC280@DM5PR04MB1085.namprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Huijin Park <huijin.park@samsung.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The" [__mmc_send_status] 5" doesn't wait 5[msec].
So it wait up to 5[msec] x 50.

Thanks.

2017-11-14 21:44 GMT+09:00 Avri Altman <Avri.Altman@wdc.com>:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Huijin Park
>> Sent: Tuesday, November 14, 2017 4:48 AM
>> To: ulf.hansson@linaro.org
>> Cc: linux-mmc@vger.kernel.org; bbang.huijin.park@gmail.com; Huijin Park
>> <huijin.park@samsung.com>
>> Subject: [PATCH] mmc: card: increase wait time
>>
>> Some eMMC products keep busy time a little longer intermittently.
>> (eg. prepare free blocks, garbage collection...) In this case, we recommend to
>> wait a little longer than fail.
>>
>> Signed-off-by: Huijin Park <huijin.park@samsung.com>
>> ---
>>  drivers/mmc/core/block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>> ea80ff4..b5b0fe6 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -584,7 +584,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
>> *card, struct mmc_blk_data *md,
>>                * Ensure RPMB command has completed by polling CMD13
>>                * "Send Status".
>>                */
>> -             err = ioctl_rpmb_card_status_poll(card, &status, 5);
>> +             err = ioctl_rpmb_card_status_poll(card, &status, 50);
>  Is this up to 1.25 sec or am I counting wrong?
> 5[msec] x 5 [__mmc_send_status] x 50
>
>>               if (err)
>>                       dev_err(mmc_dev(card->host),
>>                                       "%s: Card Status=0x%08X, error
>> %d\n",
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
