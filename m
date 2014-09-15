From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Add delay between CMD6 and CMD13 for Sandisk eMMC
 cards
Date: Mon, 15 Sep 2014 19:44:28 +0900
Message-ID: <5416C30C.6010400@samsung.com>
References: <1410265614-3275-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <54110B29.7030303@samsung.com>
 <CAL8zT=iezoevh_12GAZyDOdRy1dAS876RZDUJGVTZyY4zYZbaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAL8zT=iezoevh_12GAZyDOdRy1dAS876RZDUJGVTZyY4zYZbaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
List-Id: linux-mmc@vger.kernel.org

On 09/15/2014 07:08 PM, Jean-Michel Hautbois wrote:
> Hi Jaehoon,
> 
>> On 09/09/2014 09:26 PM, Jean-Michel Hautbois wrote:
>>> Tested on a i.MX6 board, with Sandisk SDIN5D1-2G.
>>> Without this patch, I/O errors occur.
>>> This eMMC seems to have a different Manufacturer ID as it reads 0x45
>>> and not 0x2 as specified in datasheet.
>>
>> I think this patch don't merge into mainline.
>> This is not solution for problem.
>> you mentioned the below comment, this is workaround.
> 
> Yes
> 
>>>
>>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
>>> ---
>>>  drivers/mmc/core/mmc_ops.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index f51b5ba..91babaa 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -458,6 +458,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>       if (!use_busy_signal)
>>>               return 0;
>>>
>>> +     /* WORKAROUND: for Sandisk eMMC cards, it might need certain delay
>>> +      * before sending CMD13 after CMD6
>>> +      * On SDIN5D1-2G MANFID is 0x45 and not 0x2 as specified in datasheet
>>> +      */
>>> +     if (card->cid.manfid == CID_MANFID_SANDISK ||
>>> +             card->cid.manfid == 0x45) {
>>> +             msleep(1);
>>> +     }
>>
>> If it's a general problem of Sandisk SDIN5D1-2G,
>> I think you need to verify this problem. And can you use the MMC_FIXUP() and QUIRK?
> 
> Well, this is difficult to verify, I know that on all my SDIN5D1-2G I
> have this MANFID different from what is defined by CID_MANFID_SANDISK.
> How should I use MMC_FIXUP ? Like this ?

I think you need to explain why delay is need.
i didn't have same card, but it might be your host controller or other problem. 

You can define the 0x45 with other naming.
ex) CID_MANFID_SANDISK_2	0x45 ? Just example.:)

And Your first patch is applied for every Sandisk card, isn't?

Best Regards,
Jaehoon Chung

> MMC_FIXUP("SEM02G", 0x45, CID_OEMID_ANY, add_quirk, MMC_QUIRK_INAND_CMD13) ?
> 
> If so, can I use :
> if (card->quirks & MMC_QUIRK_INAND_CMD38)
>     msleep(1);
> 
> In drivers/mmc/core/mmc_ops.c ?
> Is this the good way ?
> 
> Thanks,
> JM
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
