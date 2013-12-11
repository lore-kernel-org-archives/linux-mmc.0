From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 11 Dec 2013 11:03:31 +0800
Message-ID: <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
	<1386680168-5227-4-git-send-email-b29396@freescale.com>
	<20131211021646.GC18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:61279 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3LKDDc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 22:03:32 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so4342499qaq.7
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2013 19:03:31 -0800 (PST)
In-Reply-To: <20131211021646.GC18380@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 10:16 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 10, 2013 at 08:56:05PM +0800, Dong Aisheng wrote:
>> Currently the common code assume 0xE is the maximum timeout counter
>> value and use it to write into the timeout counter register.
>> However, it's fairly possible that the different SoCs may have
>> different register layout on the timeout counter register.
>> That means 0xE may not be the correct maximum timeout value, then
>> the 0xE becomes meaningless.
>>
>> To be flexible, this patch provides another approach for platforms
>> to set the correct timeout on their way.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   19 ++++++++++++++-----
>>  drivers/mmc/host/sdhci.h |    2 ++
>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 464d42c..4cc3bd6 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -726,19 +726,28 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
>>               sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
>>  }
>>
>> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>> +static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>       u8 count;
>> +
>> +     if (host->ops->set_timeout) {
>> +             host->ops->set_timeout(host, cmd);
>> +     } else {
>> +             count = sdhci_calc_timeout(host, cmd);
>> +             sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>> +     }
>> +}
>> +
>> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>> +{
>>       u8 ctrl;
>>       struct mmc_data *data = cmd->data;
>>       int ret;
>>
>>       WARN_ON(host->data);
>>
>> -     if (data || (cmd->flags & MMC_RSP_BUSY)) {
>> -             count = sdhci_calc_timeout(host, cmd);
>
> From what I read the commit log, I think it might be more appropriate to
> patch sdhci_calc_timeout() like the following?
>
>         if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>                 if (host->ops->get_max_timeout)
>                         return host->ops->get_max_timeout(host);
>                 else
>                         return 0xE;
>

The return val of sdhci_calc_timeout is the register value to be
written into timeout counter register.
host->ops->get_max_timeout returns the max timeout in miliseconds directly.
So we can not do like that here.
They're two concepts.

Regards
Dong Aisheng

> Shawn
>
>> -             sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>> -     }
>> +     if (data || (cmd->flags & MMC_RSP_BUSY))
>> +             sdhci_set_timeout(host, cmd);
>>
>>       if (!data)
>>               return;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 1591cbb..a4851a0 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -282,6 +282,8 @@ struct sdhci_ops {
>>       unsigned int    (*get_min_clock)(struct sdhci_host *host);
>>       unsigned int    (*get_timeout_clock)(struct sdhci_host *host);
>>       unsigned int    (*get_max_timeout)(struct sdhci_host *host);
>> +     void            (*set_timeout)(struct sdhci_host *host,
>> +                                             struct mmc_command *cmd);
>>       int             (*platform_bus_width)(struct sdhci_host *host,
>>                                              int width);
>>       void (*platform_send_init_74_clocks)(struct sdhci_host *host,
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
