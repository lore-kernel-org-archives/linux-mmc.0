From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: Enabling MMC BKOPs in kernel based on host caps
Date: Wed, 12 Oct 2016 20:30:42 +0900
Message-ID: <fda7b509-0e03-9ca6-0cde-7bbc47db7787@samsung.com>
References: <1475491384-15818-1-git-send-email-rk@ti.com>
 <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
 <dfcdad0d-0780-0641-cb0a-46557334fa16@ti.com>
 <4cf40ed6-85c1-a879-ef7a-ff9d5c9b24fe@intel.com>
 <CGME20161012075912epcas1p4e8896d7e8f5c6068b160cf677342f72b@epcas1p4.samsung.com>
 <CAPDyKFqCg6kuTHhuMNmtZcL6+8wOTky+_8SsvedcPbPcaaoohA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57818 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbcJLLlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2016 07:41:46 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OEX01G71MN2OH60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Oct 2016 20:30:42 +0900 (KST)
In-reply-to: <CAPDyKFqCg6kuTHhuMNmtZcL6+8wOTky+_8SsvedcPbPcaaoohA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ravikumar <a0131654@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ravikumar Kattekola <rk@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 10/12/2016 04:58 PM, Ulf Hansson wrote:
> On 12 October 2016 at 09:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 05/10/16 14:55, Ravikumar wrote:
>>> Hi Shawn,
>>>
>>>
>>> On Wednesday 05 October 2016 03:07 PM, Shawn Lin wrote:
>>>> Hi Ravikumar,
>>>>
>>>> + Alex,
>>>>
>>>> 在 2016/10/3 18:43, Ravikumar Kattekola 写道:
>>>>> Hi all,
>>>>>     I’ve seen an eMMC failure due to pending background operations on a
>>>>> certain OMAP device since bkops enable bit was not set.
>>
>> It is not clear what you are talking about. BKOPS_EN is
>> one-time-programmable so you can just set when the device is provisioned.
>>
>> However BKOPS_EN does not really enable background operations.  It is an
>> indication from the host to the card about whether the card may delay
>> maintenance operations.  The definition is:
>>
>> "This field allows the host to indicate to the device if it is expected to
>> periodically manually start background operations by writing to the
>> BKOPS_START field."
>>
>> Currently the kernel does not do periodic background operations, so having
>> the kernel set BKOPS_EN would not make sense - even if it wasn't
>> one-time-programmable.
> 
> Agree!
> 
> However, in cases when the BKOPS_EN bit has been set (in one way or
> the other), this do becomes a problem as we currently only supports
> urgent background operations.
> Perhaps we should print a warning when BKOPS_EN is set during card
> initialization, as this isn't currently supported.

When i had added the bkops features, i remembered that discussed about this.
(set BKOPS_EN from kernel..or not..)

When enable the bkops_en by default, there should be a problem...
(I'm not sure..but at that time..Chris had wanted to remove the enabling bkops by default.)

For just understanding..i added the changelog for my bkops patch.

https://patchwork.kernel.org/patch/1466501/

> 
>>
>>>>> Further investigation showed me that someone already posted patch to
>>>>> enable Background operations in kernel  based on a host capability check
>>>>> (Caps2 & BK_OPS_EN)
>>>>> but was turned down quoting that it should be enabled from user space
>>>>> using mmc-utils.
>>>>>
>>>>> Enabling this would add one additional check for exception event in the
>>>>> response R1 or R1B (only on hosts that explicitly set BK_OPS_EN in caps2).
>>>>> But not enabling this could lead to a system failure especially when the
>>>>> Filesystem is on eMMC and the card stops responding due to pending
>>>>> critical bkops.
>>
>> Yes the kernel only does urgent background operations if BKOPS_EN is set.
>> You seem to be suggesting that the cards are violating the specification by
>> delaying maintenance operations even though they are not allowed to because
>> BKOPS_EN is not set.  Is that the case?
>>
> 
> If this is the case, the solution would probably be to actually set
> the BKOPS_EN bit from the kernel, perhaps via using a card quirk.
> 
> Although, to do that, we first need to add proper background
> operations support. I guess that is what Alex intends to do here [1].
> 
> [...]
> 
> [1]
> http://www.spinics.net/lists/linux-mmc/msg38952.html
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

