From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Add delay between CMD6 and CMD13 for Sandisk eMMC
 cards
Date: Mon, 22 Sep 2014 11:59:34 +0900
Message-ID: <541F9096.3050700@samsung.com>
References: <1410265614-3275-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <54110B29.7030303@samsung.com>
 <CAL8zT=iezoevh_12GAZyDOdRy1dAS876RZDUJGVTZyY4zYZbaQ@mail.gmail.com>
 <5416C30C.6010400@samsung.com> <20140921174827.GB11414@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140921174827.GB11414@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 09/22/2014 02:48 AM, Pavel Machek wrote:
> On Mon 2014-09-15 19:44:28, Jaehoon Chung wrote:
>> On 09/15/2014 07:08 PM, Jean-Michel Hautbois wrote:
>>> Hi Jaehoon,
>>>
>>>> On 09/09/2014 09:26 PM, Jean-Michel Hautbois wrote:
>>>>> Tested on a i.MX6 board, with Sandisk SDIN5D1-2G.
>>>>> Without this patch, I/O errors occur.
>>>>> This eMMC seems to have a different Manufacturer ID as it reads 0x45
>>>>> and not 0x2 as specified in datasheet.
>>>>
>>>> I think this patch don't merge into mainline.
>>>> This is not solution for problem.
>>>> you mentioned the below comment, this is workaround.
>>>
>>> Yes
>>>
>>>>>
>>>>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
>>>>> ---
>>>>>  drivers/mmc/core/mmc_ops.c | 9 +++++++++
>>>>>  1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>>>> index f51b5ba..91babaa 100644
>>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>>> @@ -458,6 +458,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>>>       if (!use_busy_signal)
>>>>>               return 0;
>>>>>
>>>>> +     /* WORKAROUND: for Sandisk eMMC cards, it might need certain delay
>>>>> +      * before sending CMD13 after CMD6
>>>>> +      * On SDIN5D1-2G MANFID is 0x45 and not 0x2 as specified in datasheet
>>>>> +      */
>>>>> +     if (card->cid.manfid == CID_MANFID_SANDISK ||
>>>>> +             card->cid.manfid == 0x45) {
>>>>> +             msleep(1);
>>>>> +     }
>>>>
>>>> If it's a general problem of Sandisk SDIN5D1-2G,
>>>> I think you need to verify this problem. And can you use the MMC_FIXUP() and QUIRK?
>>>
>>> Well, this is difficult to verify, I know that on all my SDIN5D1-2G I
>>> have this MANFID different from what is defined by CID_MANFID_SANDISK.
>>> How should I use MMC_FIXUP ? Like this ?
>>
>> I think you need to explain why delay is need.
>> i didn't have same card, but it might be your host controller or other problem. 
> 
> Datasheet says it is needed, so we need to do the delay.
> 
> Adding pointer to the datasheet (page, chapter) to the comment might be good idea.

It's good. Then i think good that it will add the delay with the MMC_FIXUP and QUIRK.

Best Regards,
Jaehoon Chung

> 
> 
