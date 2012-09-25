From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Proper signal voltage switch
Date: Tue, 25 Sep 2012 10:40:55 +0200
Message-ID: <CA+20K0B+9TKG4V0uHoCn0+1TMdxhwBjn1gSwLkAoAJ=+4L=NbQ@mail.gmail.com>
References: <1348556622-2068-1-git-send-email-johan.rudholm@stericsson.com>
	<CAPDyKFrwQGAW8ApGci7F1Vu6_N-E6=FBDU5uYenY5SOupFBNOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38226 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab2IYIk4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 04:40:56 -0400
Received: by ieak13 with SMTP id k13so13242047iea.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 01:40:56 -0700 (PDT)
In-Reply-To: <CAPDyKFrwQGAW8ApGci7F1Vu6_N-E6=FBDU5uYenY5SOupFBNOQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Hi Ulf,

2012/9/25 Ulf Hansson <ulf.hansson@linaro.org>:
> On 25 September 2012 09:03, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
>> @@ -1243,8 +1244,29 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>>         host->ios.signal_voltage = signal_voltage;
>>
>>         if (host->ops->start_signal_voltage_switch) {
>> +               u32 clock = host->ios.clock;
>> +
>>                 mmc_host_clk_hold(host);
>> +               host->ios.clock = 0;
>> +               mmc_set_ios(host);
>>                 err = host->ops->start_signal_voltage_switch(host, &host->ios);
>> +
>> +               /* Hold clock for at least 5 ms according to spec */
>
> This also potentially affects eMMC. Is that really what you want?
> According to commit msg you will only fixup something for SD and SDIO.

No, this should only happen when the switch is preceeded by CMD11. I
will address this, thanks.

> By the way, it seems like some fixes for drivers/mmc/core/sdio.c
> should be included in this patch as well? Or do you intend to send
> those changes as a separate patch?

I will address the SDIO changes in a separate patch. I was a bit
hesitant about how to do this, since we have no SDIO card (or host)
that supports UHS. However, I'll compose a patch set and submit it and
ask for help to verify it.

>> +               mmc_delay(5);
>> +               host->ios.clock = clock;
>> +               mmc_set_ios(host);
>> +
>> +               /* Wait for at least 1 ms until we check if card is ready */
>> +               mmc_delay(1);
>> +
>> +               /* Check busy */
>> +               if (cmd11 && host->ops->card_busy &&
>> +                                               host->ops->card_busy(host)) {
>> +                       host->ios.signal_voltage = old_voltage;
>
> Why bother about restoring signal voltage state? Could that not be
> handled from upper layer?

I guess, but I thought it nicer if the function restores the signal
voltage to the original state before returning failure. Also, if we do
it from the upper layers it would mean doing it at several places and
not only one. I'd prefer to keep it here, but I'll move it if you feel
strongly about it?

Kind regards, Johan
