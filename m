From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix UHS tuning on some brand of cards.
Date: Tue, 26 Apr 2016 16:44:10 +0900
Message-ID: <571F1C4A.1060804@samsung.com>
References: <1461597529-6470-1-git-send-email-enric.balletbo@collabora.com>
 <CAFqH_53yuoeNgrsmHBrN5ELqapti-UeLQ7pRiXrpd7VNEH=+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56703 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcDZHoN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2016 03:44:13 -0400
In-reply-to: <CAFqH_53yuoeNgrsmHBrN5ELqapti-UeLQ7pRiXrpd7VNEH=+wA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Enric,

On 04/26/2016 12:29 AM, Enric Balletbo Serra wrote:
> Oh, damn, I didn't include the proper tags,
> 
> [PATCH v2] mmc: dw_mmc: Wait for data transfer after response errors.
> [PATCH v2] mmc: dw_mmc: Fix UHS tuning on some brand of cards
> 
> should be
> 
> [PATCH v2 0/1] mmc: dw_mmc: Fix UHS tuning on some brand of cards
> [PATCH v2 1/1] mmc: dw_mmc: Wait for data transfer after response errors.

What changed from patch V1?
Anyway, thanks for reminding! :)

Best Regards,
Jaehoon Chung

> 
> 2016-04-25 17:18 GMT+02:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
>> Hi,
>>
>> I introduced the cover letter to give some background about this.
>>
>> I have been investigating a problem related to at least one specific sdcard when
>> UHS-I is set. The card is not detected due the tuning phase reports a
>> failure. Since the problem is only reproduced with a single model of a single
>> brand of card, it is probably a card firmware issue, but the card works fine
>> on my laptop.
>>
>> The first attempt to fix this was a patch sent by Doug Anderson [1], but Alim
>> Akhtar found that this produced randomly a hung task on Peach-pi. I can confirm
>> that it's easy to reproduce the hung task, either, with cold boots or suspend to
>> ram tests.
>>
>> I tried to fix both problems (the original issue and the one introduced by the
>> patch) in different ways, but I ended thinking that this second proposal is the
>> most simple that solves both issues. So let's try to fix this by handling the
>> response CRC error slightly differently when tuning command is happening.
>>
>> I tested the patch on both platforms, on exynos and on rockhip. I did lots of
>> tests and at the moment the patch seems to fix the rockchip issue and don't
>> hung on exynos. I'll continue testing meanwhile we discuss about it.
>>
>> I think the patch, at least, needs the Doug's approval (as he dig into the issue
>> before) and the Tested-by Alim. So will be good if you have a slot of time to
>> look a bit into this.
>>
>> Thanks in advance.
>>  Enric
>>
>> [1] https://lkml.org/lkml/2015/5/18/495
>>
>> Doug Anderson (1):
>>   mmc: dw_mmc: Wait for data transfer after response errors.
>>
>>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> --
>> 2.1.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

