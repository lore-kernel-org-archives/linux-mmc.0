From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/4] mmc: dw_mmc: Invalidate cache of current_speed
 after suspend/resume
Date: Thu, 22 Aug 2013 09:25:54 -0700
Message-ID: <CAD=FV=VdmRnE+2mOQU19JG7V8Dh5PwXn=-SS_=+4Db1uijcuuw@mail.gmail.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-1-git-send-email-dianders@chromium.org>
	<1375825071-20922-2-git-send-email-dianders@chromium.org>
	<001801ce9504$d9976ab0$8cc64010$%jun@samsung.com>
	<CAD=FV=VmtoxnRzjsKF1rVTwvkJRAxKGUvNZHAEwuWaeVokzSZA@mail.gmail.com>
	<000c01ce972b$9ba23590$d2e6a0b0$%jun@samsung.com>
	<CAD=FV=WVFGwG7KGBritORUMvWUVH19uaoMLyQufnL5D-Rd76Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:60732 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab3HVQZz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2013 12:25:55 -0400
Received: by mail-qc0-f182.google.com with SMTP id c11so1129496qcv.27
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2013 09:25:54 -0700 (PDT)
In-Reply-To: <CAD=FV=WVFGwG7KGBritORUMvWUVH19uaoMLyQufnL5D-Rd76Ww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Seungwon,

On Wed, Aug 21, 2013 at 5:54 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Doug, your analysis is right.
>> But, let me suggest another approach.
>> After step #1, core layer actually call mmc_power_off because slot is empthy(get_cd() is '0').
>> Then, set_ios is requested with 'ios->clock'.
>> However, because current implementation doesn't update current_speed in case ios->clock is '0'.
>> It causes current_speed has invalid clock rate in resume of dw-mmc.
>>
>> So, if we can update slot->clock properly, it will be fixed.
>>
>> -static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>> +static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>>  {
>>         struct dw_mci *host = slot->host;
>>         u32 div;
>>         u32 clk_en_a;
>>
>> -       if (slot->clock != host->current_speed || force_clkinit) {
>> +       if (slot->clock && (slot->clock != host->current_speed)) {
>>
>>
>> @@ -807,13 +807,11 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>         mci_writel(slot->host, UHS_REG, regs);
>>
>> -       if (ios->clock) {
>> -               /*
>> -                * Use mirror of ios->clock to prevent race with mmc
>> -                * core ios update when finding the minimum.
>> -                */
>> -               slot->clock = ios->clock;
>> -       }
>> +       /*
>> +        * Use mirror of ios->clock to prevent race with mmc
>> +        * core ios update when finding the minimum.
>> +        */
>> +       slot->clock = ios->clock;
>
> So this scares me a little bit but you're correct that it's probably
> the right thing.  Mostly it scares me to remove code that someone
> clearly added on purpose without understanding why they originally
> added it and why that reason is not valid (or is no longer valid due
> to other changes).

OK, I posted up a new patch series.  Hopefully this looks good to you.
 I did a suspend/resume stress test last night on our chromeos-3.8
branch and things worked well.


> I've come up with a new patch that's a little bit more than just your
> patch.  It actually does something in the case of a zero clock (it
> turns the clock off).  My patch seems to work OK on my 3.8 branch but
> I want to do a little more testing tomorrow.  ...but booting on ToT
> linux seems broken now on the ARM chromebook (it fails in several
> different ways and sometimes works).  Sigh.

Somehow this morning ToT linux (same revision) was working much better
on exynos5250-snow.  I was able to boot reliably and even
suspend/resume reliably.  I think there may be a few niggling issues
that we'll have to track down before too long, though...

-Doug
