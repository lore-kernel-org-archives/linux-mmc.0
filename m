From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-cadence: fix the return value of sdhci_cdns_get_timeout_clock
Date: Tue, 28 Feb 2017 22:43:01 +0900
Message-ID: <CAK7LNAQs7-eJbvsTBEeOBU3Gcd57uJX7OSEOwEhv02xFQGwsuw@mail.gmail.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com> <1488184144-122285-5-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:64224 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdB1Nng (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2017 08:43:36 -0500
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com [209.85.161.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id v1SDh31C007129
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2017 22:43:03 +0900
Received: by mail-yw0-f179.google.com with SMTP id l138so8041495ywc.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2017 05:43:03 -0800 (PST)
In-Reply-To: <1488184144-122285-5-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>

Hi.


2017-02-27 17:29 GMT+09:00 Shawn Lin <shawn.lin@rock-chips.com>:
> Return the timeout clock rate in Hz for sdhci core.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>


I do not like the subject
"mmc: sdhci-cadence: fix the return value of sdhci_cdns_get_timeout_clock".

You are not fixing this driver,
but you are changing the API, right?

(More precisely, you are breaking it by 2/4, then fixing it by 4/4.
Right, you are fixing...)

Anyway, this would not be a problem because
Adrian requested to squash all the patches in this series.




> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-cadence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 316cfec..bb3951a 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -103,9 +103,10 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  {
>         /*
>          * Cadence's spec says the Timeout Clock Frequency is the same as the
> -        * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
> +        * Base Clock Frequency. Return a value in Hz per the requirement of
> +        * .get_timeout_clock callback.
>          */
> -       return host->max_clk / 1000;
> +       return DIV_ROUND_UP(DIV_ROUND_UP(host->max_clk, 1000), 1000);
>  }
>
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,


As Adrian pointed out, simply "return host->max_clk".

Also, please just remove the comment "Divide it by 1000 to return a
value in kHz."



-- 
Best Regards
Masahiro Yamada
