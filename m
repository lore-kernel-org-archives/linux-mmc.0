From: Eliad Peller <eliad@wizery.com>
Subject: Re: [PATCH] mmc: core: don't call bus_ops->power_restore if already on
Date: Mon, 11 May 2015 15:02:58 +0300
Message-ID: <CAB3XZEfO3PfqMk389shSYG_1=8m2jZdYE9ck07aNHLPLNbHZRQ@mail.gmail.com>
References: <1430841827-7834-1-git-send-email-eliad@wizery.com>
	<CAPDyKFrF=6GRiSvDPnyV5mAozu1N54e+HrTvjRbH-FyTmj6hqA@mail.gmail.com>
	<CAB3XZEe_SjhHU-mRbG-X_7PNQHCaVGHfmx66dEUhdZsexYciyQ@mail.gmail.com>
	<CAPDyKFoOKeBxUFcKVR0ueiO5nP4A_X5LhMDN_dOgVh=3xc5u7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35218 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbEKMC7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 08:02:59 -0400
Received: by igbyr2 with SMTP id yr2so67478819igb.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 05:02:58 -0700 (PDT)
In-Reply-To: <CAPDyKFoOKeBxUFcKVR0ueiO5nP4A_X5LhMDN_dOgVh=3xc5u7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ido Yariv <ido@wizery.com>

On Mon, May 11, 2015 at 2:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 May 2015 at 13:07, Eliad Peller <eliad@wizery.com> wrote:
>> On Mon, May 11, 2015 at 11:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 5 May 2015 at 18:03, Eliad Peller <eliad@wizery.com> wrote:
>>>> mmc_power_restore_host() calls mmc_power_up(), which
>>>> returns immediately if power is already on.
>>>>
>>>> However, it still calls host->bus_ops->power_restore,
>>>> which might result in various errors if the bus_ops
>>>> doesn't handle it well (e.g. failing to run init
>>>> sequence twice)
>>>>
>>>> Simply bail out in this case, without further calling
>>>> bus_ops->power_restore.
>>>>
>>>> Specifically, this solves issue with wl18xx sdio card,
>>>> where the mmc core powers on the card on resume (while
>>>> MMC_PM_KEEP_POWER is not set), and the wl18xx device
>>>> driver calls mmc_power_restore_host() once more.
>>>
>>> Could you elaborate on why that driver calls mmc_power_restore_host()
>>> after the system PM suspend sequence? I am trying to understand the
>>> use case.
>>>
>> The driver assumes control over the mmc power, in order to save power
>> when no interface is up.
>
> Makes sense!
>
>> It basically uses runtime_pm for it, but calls the power functions
>> explicitly if pm_runtime returned non-zero (this is needed for some
>> corner cases, e.g. runtime pm is disabled).
>
> I have some ideas about changing the way runtime PM shall be used for
> SDIO func drivers. Instead of using it to control power to the SDIO
> card, it should be used to deal with "idle operations".
>
> That would mean SDIO func drivers would use only
> mmc_power_save|restore_host() APIs, to control the power to the SDIO
> card.
>
> Do you see any issues with such an approach?
>
actually, the current driver code (to use runtime_pm, and then call
the power functions explicitly in some cases) looks a bit weird.
so your approach makes sense to me.

>>
>> On suspend (if wowlan is not configured), all the wlan interfaces are
>> taken down, and the driver powers off the device.
>> On resume, the interfaces are taken up again, and the driver powers on
>> the device, by calling mmc_power_restore_host().
>
> That raises the following question.
>
> When mmc_power_save_host() has been called for an SDIO card, should
> really the mmc core restore power to that card during system PM
> resume? Isn't it better to leave that to the SDIO func driver?
>
yes. but i didn't want to make a major change :)

note that the suspend/resume flow used to work properly.
iirc, we did some bisect when the issue first showed up, which showed
it started by:
7459026 mmc: core: Push common suspend|resume code into each bus_ops
(the reason might have been different, but it did used to work before
this patch)

Eliad.
