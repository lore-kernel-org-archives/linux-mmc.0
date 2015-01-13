From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] sdhci-acpi: fix copy'n'paste typos in the comments
Date: Tue, 13 Jan 2015 09:34:06 +0100
Message-ID: <CAPDyKFrCRTfMwye3veP3nH4Eqeb1G-nEP8M5kbRGpfiRpRSxzw@mail.gmail.com>
References: <1421084245-16656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:58906 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbAMIeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 03:34:07 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so1195591qcy.7
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 00:34:06 -0800 (PST)
In-Reply-To: <1421084245-16656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 12 January 2015 at 18:37, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Just fix the comments, no functional changes.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index dffd2c2..b11a3cb 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -158,7 +158,7 @@ static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
>
>         host = c->host;
>
> -       /* Platform specific code during emmc proble slot goes here */
> +       /* Platform specific code during emmc probe slot goes here */
>
>         if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
>             sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
> @@ -179,7 +179,7 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
>
>         host = c->host;
>
> -       /* Platform specific code during emmc proble slot goes here */
> +       /* Platform specific code during sdio probe slot goes here */
>
>         return 0;
>  }
> @@ -195,7 +195,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>
>         host = c->host;
>
> -       /* Platform specific code during emmc proble slot goes here */
> +       /* Platform specific code during sd probe slot goes here */
>
>         return 0;
>  }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
