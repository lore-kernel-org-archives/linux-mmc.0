From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: remove unused struct sdhci_host variable
Date: Thu, 27 Jul 2017 16:48:16 +0200
Message-ID: <CAPDyKFrrLfPJi0a30K=eiNwtyfZ6eC42PDEqhHURUWRZWPTtOg@mail.gmail.com>
References: <1500599990-170932-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35355 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdG0OsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:18 -0400
Received: by mail-qk0-f181.google.com with SMTP id d145so97639615qkc.2
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:17 -0700 (PDT)
In-Reply-To: <1500599990-170932-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 21 July 2017 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It was never used and introduce a warning
>
> drivers/mmc/host/sdhci-acpi.c: In function 'sdhci_acpi_sdio_probe_slot':
> drivers/mmc/host/sdhci-acpi.c:297:21: warning: variable 'host' set but
> not used [-Wunused-but-set-variable]
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-acpi.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index ac678e9..2b1df88 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -294,13 +294,10 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
>                                       const char *hid, const char *uid)
>  {
>         struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> -       struct sdhci_host *host;
>
>         if (!c || !c->host)
>                 return 0;
>
> -       host = c->host;
> -
>         /* Platform specific code during sdio probe slot goes here */
>
>         return 0;
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
