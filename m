From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Thu, 13 Dec 2012 17:39:02 +0800
Message-ID: <CADz5_gL_bvF_MkdNXG7=MdJngD_hbWuKWqqyP7a9=LgEao1jpQ@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
	<CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
	<CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:37259 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2LMJjE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Dec 2012 04:39:04 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so691103wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Dec 2012 01:39:03 -0800 (PST)
In-Reply-To: <CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

2012/12/13 Ulf Hansson <ulf.hansson@linaro.org>:
> On 13 December 2012 02:51, Kevin Liu <keyuan.liu@gmail.com> wrote:
>>> -----Original Message-----
>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Linus Walleij
>>> Sent: Thursday, December 13, 2012 2:54 AM
>>> To: Ulf Hansson
>>> Cc: Russell King - ARM Linux; Ulf Hansson; linux-mmc@vger.kernel.org; Chris Ball; linux-arm-kernel@lists.infradead.org
>>> Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
>>>
>>> On Wed, Dec 12, 2012 at 12:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 12 December 2012 07:53, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>>>> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
>>>>> which means that the ios will be called with f=0 whenever
>>>>> the card is unused, taking into account the required number
>>>>> of clocks to the card.
>>>>
>>>> I think MMC_CLKGATE was a good initiative in the past. But that was
>>>> before runtime pm was there to use. Runtime pm suits much better for
>>>> handling clock gating and other runtime power save actions that could
>>>> be possible for a host driver to do.
>>>>
>>>> I would even suggest the MMC_CLKGATE should be removed from the
>>>> protocol layer, once we see that all host drivers that used it has
>>>> switch to runtime pm.
>>>
>>> Ah now I remember that you've actually even explained this to me ...
>>> memory is too short sometimes. But I follow this idea.
>>>
>>> Then we have only the coordination between runtime suspend
>>> and suspend proper to iron out.
>>>
>>> Russell's concern is valid if suspend() will not wait for runtime_suspend()
>>> to complete the last cycle before suspending.
>
> A valid point, thanks for pointing this out clearly Linus!
>
> Anyway, this need to be thought of as future step, since this patch is
> not changing anything to that sequence as Kevin also is pointing out.
>
> So, the next step is to figure how we can properly do similar actions
> as in the runtime_suspend callback but as part of the suspend sequence
> instead and at the same time cope with 8 clock cycles. I will push a
> patch for this later, so then we can discuss more about that.
>
>>>
>>
>> pm_runtime_get_noresume is called before suspend and there are
>> sdhci_runtime_pm_get/sdhci_runtime_pm_put within sdhci suspend/resume
>> function. So the actual runtime_suspend won't be called after suspend
>> finished. So it's same as original code without pm_runtime during
>> suspend/resume.
>>
>>> Hm this sounds scaringly familiar to what we've discussed with
>>> Kevin Hilman et al recently...
>>>
>
> May I have your Acks on this patch?
>
Sure, my pleasure.

Acked-by: Kevin Liu <kliu5@marvell.com>

> Kind regards
> Ulf Hansson
