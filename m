From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] mmc: dw_mmc: skip the execute_tuning after checking timiing
Date: Wed, 31 Aug 2016 20:30:00 +0900
Message-ID: <be0f0564-4770-6c38-7724-1249ebb2ece4@samsung.com>
References: <1472622687-16389-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160831071421epcas1p1efea97a79334edb2a4665e130e84f1f4@epcas1p1.samsung.com>
 <7be25c6e-ceed-bc70-55a0-540468577a64@rock-chips.com>
 <196d3b32-9367-de38-5ae6-96c6a56db6a5@samsung.com>
 <CAPDyKFrdNCP51BPZKS+puc=OVGtB3aM4FeVj555OPs3jAjPakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34392 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbcHaLaD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 07:30:03 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OCR02A9KUM0R410@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Aug 2016 20:30:00 +0900 (KST)
In-reply-to: <CAPDyKFrdNCP51BPZKS+puc=OVGtB3aM4FeVj555OPs3jAjPakA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>, "Jinguojun (A)" <kid.jin@hisilicon.com>

On 08/31/2016 08:10 PM, Ulf Hansson wrote:
> On 31 August 2016 at 12:48, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> On 08/31/2016 04:13 PM, Shawn Lin wrote:
>>> On 2016/8/31 13:51, Jaehoon Chung wrote:
>>>> HS400 mode doesn't need to do execute_tuning, because it's already
>>>> tuned in HS200 mode. And Tuning command is optional for UHS50 mode.
>>>>
>>>> In future, the general execute_tuning sequence can be included in this
>>>> function.
>>>
>>> Maybe this isn't what we want for mmc.
>>>
>>> I see both of sd and sdio call mmc_execute_tuning by checking
>>> the ios.timing, and explicitly we need to do tuning for
>>> MMC_TIMING_UHS_SDR50 as the mmc core asks we to do that.
>>>
>>> Moreover, why mmc didn't do something like:
>>>
>>> if (card->host->ios.timing == MMC_TIMING_XXXXX || ....)
>>>     mmc_execute_tuning()
>>>
>>> So we don't need every host driver to add these check and I do
>>> see some host drivers check these timing for their execute_tuning
>>> callback..
>>>
>>> What is your opinion? :)
>>
>> Yep, your comment makes sense..So i'm checking SD specification.
>> I think it needs to know which UHS card is..(UHS50 or UHS104)..
>> But current kernel can't distinguish these..
> 
> What about MMC_TIMING_UHS_SDR50 and MMC_TIMING_UHS_SDR104? Are you
> saying we need some more additional timing type(s)?

Not timing types,,SD card types.. SD card are UHS50 and UHS104.
I'm not sure yet..i'm reading SD Physical Layer Specification in more detail..
But until now, it looks like my misunderstanding..

UHS104 card might be checked with Access mode field from switch Mode 1 operation.
(in current kernel.)

So I'm checking whether it's helpful or not for distinguishing card types..maybe not..

Best Regards,
Jaehoon Chung

> 
>>
>> According to spec, we can distinguish UHS50 and UHS104 with TRAN_SPEED field.
>>
>> "UHS50 Card set TRANS_SPEED to 0Bh (100Mbit/sec), for both SDR50 and DDR50 modes.
>> UHS104 Card set TRAN_SPEED to 2Bh (200Mbit/sec)"
>>
> 
> [...]
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

