From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Tue, 7 Feb 2017 09:14:03 +0800
Message-ID: <d5d1e06e-439a-70fc-f879-4729205ef23e@rock-chips.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
 <695B0367-2BA5-4B95-AF75-6BD43FE17528@sandisk.com>
 <2a786eb3-d782-bb87-4ff5-29640b00ad2f@rock-chips.com>
 <1FB1DA84-7E5A-4C0C-BDFE-4F4B406A4B78@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55936 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdBGBOH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 20:14:07 -0500
In-Reply-To: <1FB1DA84-7E5A-4C0C-BDFE-4F4B406A4B78@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Uri Yanai <Uri.Yanai@sandisk.com>, "ulf. org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>

Hi Alex,

On 2017/2/6 20:20, Alex Lemberg wrote:
>
>> On Feb 6, 2017, at 8:46 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi Alex,
>>
>> On 2017/2/5 23:13, Alex Lemberg wrote:
>>> Hi Shawn,
>>>
>>> On 2/5/17, 3:43 AM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>>>
>>>
>>>    >
>>>    > Hmm.
>>>    >
>>>    > Shouldn't we abort (return -EBUSY) also in the system PM suspend case
>>>    > and not only for runtime PM suspend?
>>>
>>>    I would rather we don't abort runtime PM, but do it for system PM
>>>    instead. What we do for runtime PM is just for saving power for
>>>    our hosts including manipulating clock and genpd etc.. Thus we don't
>>>    touch any power-supply for eMMC. If so, it could still be possible
>>>    for eMMC firmware to work on doing bkops in rpm context.
>>>
>>> If I understand correctly, you are suggesting do not send SLEEP command
>>> on Runtime Suspend?
>>
>> yes.
>>
>>> If so, and if mmc host does not touch any power supply for eMMC,
>>> the device can continue doing Auto BKOPS during Runtime Suspend.
>>> The question is why the Sleep command is sent now,
>>> in the original implementation?
>>> I assume it is sent for saving a power from the device side as well?
>>
>> right, it was invented with the cap of MMC_CAP_AGGRESSIVE_PM, so some platforms ask for the aggressive power policy will send sleep command
>> to the cards in rpm context. So I assume they care power-saving more
>> than others.
>>
>
> OK, I see the MMC_CAP_AGGRESSIVE_PM is already checked in the
> mmc_runtime_suspend() function, so your approach, do not send
> Sleep command on Runtime Suspend, is already supported.
> In case the MMC_CAP_AGGRESSIVE_PM is not set, Sleep command
> will not be sent, and the device will be able to perform its
> AUTO_BKOPS (if needed).
>
> However, as far as I see in modern mobile hosts,
> the Sleep is sent on every Suspend, so I assume the
> MMC_CAP_AGGRESSIVE_PM is enabled in most of the cases?

Only Intel platforms add this caps on upstreamed kernel tree and
no, AOSP kernel tree didn't change that much either. But I guess
some vendors want aggressive pm policy for their production?

IMHO, the basic concept of mmc stack is that we could provide
the solutions to support different perf & pm policy for folks but
it's their call to decide it by adding these caps there.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

