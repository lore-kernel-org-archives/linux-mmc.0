From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 11 Dec 2013 11:35:17 +0800
Message-ID: <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
	<1386680168-5227-4-git-send-email-b29396@freescale.com>
	<20131211021646.GC18380@S2101-09.ap.freescale.net>
	<CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
	<20131211031853.GG18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:38311 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3LKDfS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 22:35:18 -0500
Received: by mail-qa0-f52.google.com with SMTP id cm18so217548qab.11
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2013 19:35:18 -0800 (PST)
In-Reply-To: <20131211031853.GG18380@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 11:18 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 11:03:31AM +0800, Dong Aisheng wrote:
>> >> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>> >> +{
>> >>       u8 ctrl;
>> >>       struct mmc_data *data = cmd->data;
>> >>       int ret;
>> >>
>> >>       WARN_ON(host->data);
>> >>
>> >> -     if (data || (cmd->flags & MMC_RSP_BUSY)) {
>> >> -             count = sdhci_calc_timeout(host, cmd);
>> >
>> > From what I read the commit log, I think it might be more appropriate to
>> > patch sdhci_calc_timeout() like the following?
>> >
>> >         if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>> >                 if (host->ops->get_max_timeout)
>> >                         return host->ops->get_max_timeout(host);
>> >                 else
>> >                         return 0xE;
>> >
>>
>> The return val of sdhci_calc_timeout is the register value to be
>> written into timeout counter register.
>> host->ops->get_max_timeout returns the max timeout in miliseconds directly.
>> So we can not do like that here.
>> They're two concepts.
>
> I did not make my comment clear.  The .get_max_timeout() is not the one
> you defined in patch #1 any more, but something like the following for
> esdhc driver, which returns correct timeout value not milliseconds.
>
> unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
> {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = pltfm_host->priv;
>
>         return esdhc_is_usdhc(imx_data) ? 0xF : 0xE;
>
> }
>
> Does that match the problem you described in the commit log better?
>

This actually is the register value, not the max timeout counter value.
Then you may want define the API as:
unsigned int    (*get_max_timeout_val)(struct sdhci_host *host);
But i don't think it's necessary to do the max timeout setting in two steps.
First, deinfe a API to get the max timeout counter val,
Second, write this val into register.
Why not simply implement .set_timeout and handle the details in
platform specific
host driver respectively?

Furthermore, this API does not  help for the patch#1 issue.


Regards
Dong Aisheng


> Shawn
>
