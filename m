From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 5/6] mmc: sdhci: calculate max_discard_to dynamically for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Wed, 11 Dec 2013 11:13:38 +0800
Message-ID: <CAA+hA=T=099ZDnvUS4r_OenEBMp3N6k6UQ_6JWNd98VoJKNkvQ@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
	<1386680168-5227-6-git-send-email-b29396@freescale.com>
	<20131211030147.GE18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:42841 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3LKDNj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 22:13:39 -0500
Received: by mail-qc0-f169.google.com with SMTP id r5so4715030qcx.28
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2013 19:13:38 -0800 (PST)
In-Reply-To: <20131211030147.GE18380@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 11:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 10, 2013 at 08:56:07PM +0800, Dong Aisheng wrote:
>> For host controllers using SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK, since the card
>> clock is changed dynamically for different cards, it does not make sense
>> to use the maximum host clock to calculate max_discard_to which may lead
>> the max_discard_to to be much smaller than its capbility and affect the card
>> discard performance a lot.
>> e.g. the host clock is 200Mhz, but the card is working on 50Mhz. Then the
>> max_discard_to is only 1/4 of its real capbility.
>>
>> In this patch, it uses the actual_clock to calculate the max_discard_to
>> dynamically as long as a new clock speed is set.
>>
>> Tested with a high speed SDHC card shows:
>> Originally:
>> mmc1: new high speed SDHC card at address aaaa
>> mmc1: calculated max. discard sectors 49152 for timeout 1355 ms
>> Now:
>> mmc1: new high speed SDHC card at address aaaa
>> mmc1: calculated max. discard sectors 712704 for timeout 5422 ms
>> The max_discard_sectors will increase a lot which will also improve discard
>> performance a lot.
>>
>> The one known limitation of this approach is that it does not cover the special
>> case for user changes the clock via sysfs, since the max_discard_to is only
>> initialised for one time during the mmc queue init.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++++------
>>  1 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 4cc3bd6..9be8a79 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1143,14 +1143,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>       unsigned long timeout;
>>
>>       if (clock && clock == host->clock)
>> -             return;
>> +             goto out;
>
> I do not quite understand this change.  Why do we need to recalculate
> max_discard_to if the clock does not change since the last time that
> the function is called?
>

Good catch.
It's safe to return directly here.
Will update in v2.

Regards
Dong Aisheng

> Shawn
>
>>
>>       host->mmc->actual_clock = 0;
>>
>>       if (host->ops->set_clock) {
>>               host->ops->set_clock(host, clock);
>>               if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
>> -                     return;
>> +                     goto out;
>>       }
>>
>>       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>> @@ -1249,6 +1249,19 @@ clock_set:
>>
>>  out:
>>       host->clock = clock;
>> +
>> +     /* update timeout_clk and max_discard_to once the SDCLK is changed */
>> +     if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK && clock) {
>> +             host->timeout_clk = host->mmc->actual_clock ?
>> +                                     host->mmc->actual_clock / 1000 :
>> +                                     host->clock / 1000;
>> +             if (host->ops->get_max_timeout)
>> +                     host->mmc->max_discard_to =
>> +                                     host->ops->get_max_timeout(host);
>> +             else
>> +                     host->mmc->max_discard_to = (1 << 27) /
>> +                                     host->timeout_clk;
>> +     }
>>  }
>>
>>  static inline void sdhci_update_clock(struct sdhci_host *host)
>> @@ -2939,10 +2952,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>       if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>>               host->timeout_clk = mmc->f_max / 1000;
>>
>> -     if (host->ops->get_max_timeout)
>> -             mmc->max_discard_to = host->ops->get_max_timeout(host);
>> -     else
>> -             mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>> +     if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
>> +             if (host->ops->get_max_timeout)
>> +                     mmc->max_discard_to = host->ops->get_max_timeout(host);
>> +             else
>> +                     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>> +     }
>>
>>       mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>>
>> --
>> 1.7.2.rc3
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
