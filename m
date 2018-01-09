From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/3] mmc: sdhci-esdhc-imx: Manage sdhci_runtime_suspend_host
 error code
Date: Tue, 9 Jan 2018 09:23:24 +0100
Message-ID: <CAPDyKFpOxunaKwEW8i18Z=pNqLZQy+u8_C7My-ZJDZxagOtxjw@mail.gmail.com>
References: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45981 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbeAIIXZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jan 2018 03:23:25 -0500
Received: by mail-io0-f196.google.com with SMTP id e20so17614474iof.12
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jan 2018 00:23:25 -0800 (PST)
In-Reply-To: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 4 January 2018 at 16:30, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> We need to return in case of error even if the actual implementation
> of sdhci_runtime_suspend_host always return 0. We don't want to
> power down the clock and the assuption is that the sdhci_runtime_suspend_host
> always let the system consistent in case of failure
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Thanks, applied for next!

Adrian, please tell me if you are not happy with this.

Kind regards
Uffe

> ---
> Changes None
>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85140c9..d08c21e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1389,6 +1389,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>         int ret;
>
>         ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
> --
> 2.7.4
>
