From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [RESEND PATCH v2 0/1] mmc: dw_mmc: Fix UHS tuning on some brand
 of cards.
Date: Wed, 27 Apr 2016 10:53:20 +0200
Message-ID: <57207E00.8070704@collabora.com>
References: <1461657838-25484-1-git-send-email-enric.balletbo@collabora.com> <572079BE.9000006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <572079BE.9000006@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 27/04/16 10:35, Jaehoon Chung wrote:
> On 04/26/2016 05:03 PM, Enric Balletbo i Serra wrote:
>> Hi,
>>
>> I introduced the cover letter to give some background about this.
>>
>> I have been investigating a problem related to at least one specific sdcard when
>> UHS-I is set. The card is not detected due the tuning phase reports a
>> failure. Since the problem is only reproduced with a single model of a single
>> brand of card, it is probably a card firmware issue, but the card works fine
>> on my laptop.
> 
> I think you have analyzed many case..of course..it was successful to switch voltage, right?
> Maybe this patch too old..so can you remember which specific sdcard is produced?
> 

Yes it was successful to switch voltage. The specific card is an UNIREX 16GB Class 10
SD card (Compatible with UHS-1)

>>
>> The first attempt to fix this was a patch sent by Doug Anderson [1], but Alim
>> Akhtar found that this produced randomly a hung task on Peach-pi. I can confirm
>> that it's easy to reproduce the hung task, either, with cold boots or suspend to
>> ram tests.
> 
> Yep..I have already tested and checked for this.
> 
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
>> Changelog since v1:
>> - Fix the issue found by Alim with exynos letting the data transfer
>>   take place only when MMC_SEND_TUNING_BLOCK is issued.
>>
>> Doug Anderson (1):
>>   mmc: dw_mmc: Wait for data transfer after response errors.
>>
>>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
> 
