From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 5/6] mmc: sdhci: calculate max_discard_to dynamically for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Wed, 11 Dec 2013 13:06:41 +0800
Message-ID: <CAA+hA=R1K3g+h-0FWprRjqJ_wtsF=DyV4pY3coxocanfaOwWig@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
	<1386680168-5227-6-git-send-email-b29396@freescale.com>
	<20131211040511.GJ18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:40440 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab3LKFGm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:06:42 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so4421236qac.20
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2013 21:06:41 -0800 (PST)
In-Reply-To: <20131211040511.GJ18380@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 12:05 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 10, 2013 at 08:56:07PM +0800, Dong Aisheng wrote:
>>  static inline void sdhci_update_clock(struct sdhci_host *host)
>> @@ -2939,10 +2952,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>       if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>>               host->timeout_clk = mmc->f_max / 1000;
>
> Since max_discard_to calculation below will not happen for
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK case, does it still make sense to
> keep the above code?
>

Right, i missed to remove it.
Will update in v2.

> Or put it in the other way, if we keep the above code and do not make
> the change below, will there be any problem besides the max_discard_to
> initialization plays for nothing?
>
> All in all, I'm just confused why we keep the above code and make the
> change below at the same time.
>

THe max_discard_to should be dynamically updated for
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
when changing the clock, so we can remove above lines.

Regards
Dong Aisheng

> Shawn
>
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
