From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Tue, 7 Feb 2017 16:24:29 +0800
Message-ID: <721d35e5-590b-f4a3-ed25-c63ecb234484@rock-chips.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
 <695B0367-2BA5-4B95-AF75-6BD43FE17528@sandisk.com>
 <2a786eb3-d782-bb87-4ff5-29640b00ad2f@rock-chips.com>
 <1FB1DA84-7E5A-4C0C-BDFE-4F4B406A4B78@sandisk.com>
 <d5d1e06e-439a-70fc-f879-4729205ef23e@rock-chips.com>
 <CAPDyKFryoFBZK9fgif5-UpMFgm4AmMyKrcTSn4Nw9AHaBK5k5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39580 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBGIYg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 03:24:36 -0500
In-Reply-To: <CAPDyKFryoFBZK9fgif5-UpMFgm4AmMyKrcTSn4Nw9AHaBK5k5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Uri Yanai <Uri.Yanai@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>



On 2017/2/7 15:54, Ulf Hansson wrote:
> [...]
>
>>>
>>> OK, I see the MMC_CAP_AGGRESSIVE_PM is already checked in the
>>> mmc_runtime_suspend() function, so your approach, do not send
>>> Sleep command on Runtime Suspend, is already supported.
>>> In case the MMC_CAP_AGGRESSIVE_PM is not set, Sleep command
>>> will not be sent, and the device will be able to perform its
>>> AUTO_BKOPS (if needed).
>>>
>>> However, as far as I see in modern mobile hosts,
>>> the Sleep is sent on every Suspend, so I assume the
>>> MMC_CAP_AGGRESSIVE_PM is enabled in most of the cases?
>>
>>
>> Only Intel platforms add this caps on upstreamed kernel tree and
>> no, AOSP kernel tree didn't change that much either. But I guess
>> some vendors want aggressive pm policy for their production?
>>
>> IMHO, the basic concept of mmc stack is that we could provide
>> the solutions to support different perf & pm policy for folks but
>> it's their call to decide it by adding these caps there.
>>
>
> I assume you know the consequences of using MMC_CAP_AGGRESSIVE_PM,
> still allow me to elaborate a bit on my view.
>
> So, MMC_CAP_AGGRESSIVE_PM tells runtime PM suspend of the card to put
> it into sleep/power off, meaning saving power! However, it also means
> preventing the eMMC from performing any background operations.
>
> The similar applies to the system PM suspend case, no matter if you
> are using MMC_CAP_AGGRESSIVE_PM or not.
>
> To me it seems like we somehow need to start to consider the eMMC'ss
> BKOPS status in these paths. Depending on the BKOPS state, we may
> abort the sleep/power off things via returning -EBUSY etc, as
> otherwise we could end up with poor performing eMMCs, couldn't we!?

Nope, we could. But I just wonder how *aggressive* folks wanted.. Do
they would rather sacrificing the performace to save more power when
adding this caps before?

To me, things like this didn't always exist the "best choice", but we
could find a "better choice". :)


>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

