From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH v2 0/1] mmc: dw_mmc: Fix UHS tuning on some brand of
 cards.
Date: Mon, 20 Jun 2016 17:02:03 +0900
Message-ID: <5767A2FB.1040904@samsung.com>
References: <1461657838-25484-1-git-send-email-enric.balletbo@collabora.com>
 <572079BE.9000006@samsung.com> <57207E00.8070704@collabora.com>
 <CGME20160620075933epcas1p3c4af53fe808f8bd30c2c4652b8837bcf@epcas1p3.samsung.com>
 <CAFqH_52hxXY5KzVCp2RRvwqPXif83u9Q1GQLUjE2AaUok9Ot3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60016 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbcFTICI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 04:02:08 -0400
In-reply-to: <CAFqH_52hxXY5KzVCp2RRvwqPXif83u9Q1GQLUjE2AaUok9Ot3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Enric,

On 06/20/2016 04:59 PM, Enric Balletbo Serra wrote:
> Hi Jaehoon,
> 
> 2016-04-27 10:53 GMT+02:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
>>
>>
>> On 27/04/16 10:35, Jaehoon Chung wrote:
>>> On 04/26/2016 05:03 PM, Enric Balletbo i Serra wrote:
>>>> Hi,
>>>>
>>>> I introduced the cover letter to give some background about this.
>>>>
>>>> I have been investigating a problem related to at least one specific sdcard when
>>>> UHS-I is set. The card is not detected due the tuning phase reports a
>>>> failure. Since the problem is only reproduced with a single model of a single
>>>> brand of card, it is probably a card firmware issue, but the card works fine
>>>> on my laptop.
>>>
>>> I think you have analyzed many case..of course..it was successful to switch voltage, right?
>>> Maybe this patch too old..so can you remember which specific sdcard is produced?
>>>
>>
>> Yes it was successful to switch voltage. The specific card is an UNIREX 16GB Class 10
>> SD card (Compatible with UHS-1)
>>
> 
> Any feedback for this patch?

Sorry..I missed this patch..Thanks for reminding!
I will check this patch as soon as possible.

Best Regards,
Jaehoon Chung

> 
> 
>>>>
>>>> The first attempt to fix this was a patch sent by Doug Anderson [1], but Alim
>>>> Akhtar found that this produced randomly a hung task on Peach-pi. I can confirm
>>>> that it's easy to reproduce the hung task, either, with cold boots or suspend to
>>>> ram tests.
>>>
>>> Yep..I have already tested and checked for this.
>>>
>>>>
>>>> I tried to fix both problems (the original issue and the one introduced by the
>>>> patch) in different ways, but I ended thinking that this second proposal is the
>>>> most simple that solves both issues. So let's try to fix this by handling the
>>>> response CRC error slightly differently when tuning command is happening.
>>>>
>>>> I tested the patch on both platforms, on exynos and on rockhip. I did lots of
>>>> tests and at the moment the patch seems to fix the rockchip issue and don't
>>>> hung on exynos. I'll continue testing meanwhile we discuss about it.
>>>>
>>>> I think the patch, at least, needs the Doug's approval (as he dig into the issue
>>>> before) and the Tested-by Alim. So will be good if you have a slot of time to
>>>> look a bit into this.
>>>>
>>>> Thanks in advance.
>>>>  Enric
>>>>
>>>> [1] https://lkml.org/lkml/2015/5/18/495
>>>>
>>>> Changelog since v1:
>>>> - Fix the issue found by Alim with exynos letting the data transfer
>>>>   take place only when MMC_SEND_TUNING_BLOCK is issued.
>>>>
>>>> Doug Anderson (1):
>>>>   mmc: dw_mmc: Wait for data transfer after response errors.
>>>>
>>>>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>
> 
> 
> 

