From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 resend 1/3] mmc: sdhci-acpi: Remove unneeded
 acpi_bus_get_status() call
Date: Thu, 8 Jun 2017 15:52:13 +0200
Message-ID: <CAPDyKFrnZW+N+e4s8-aEjBQqUqO+C0TCJBvrq6n1Qq-wGK-jsA@mail.gmail.com>
References: <20170524104755.25274-1-hdegoede@redhat.com> <20170524104755.25274-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35506 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdFHNwP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:52:15 -0400
Received: by mail-qt0-f181.google.com with SMTP id w1so41776130qtg.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:52:14 -0700 (PDT)
In-Reply-To: <20170524104755.25274-2-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 May 2017 at 12:47, Hans de Goede <hdegoede@redhat.com> wrote:
> The acpi-subsys already calls acpi_bus_get_status() and checks that
> device->status.present is set before even registering the platform_device
> so out probe function will never get called if device->status.present is
> false and there is no need for this check.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> -This is a new patch replacing "mmc: sdhci-acpi: Check device status
>  before calling fix_up_power()"
> ---
>  drivers/mmc/host/sdhci-acpi.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index c6a9a1bfaa22..89d9a8c014f5 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -396,9 +396,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>                 if (child->status.present && child->status.enabled)
>                         acpi_device_fix_up_power(child);
>
> -       if (acpi_bus_get_status(device) || !device->status.present)
> -               return -ENODEV;
> -
>         if (sdhci_acpi_byt_defer(dev))
>                 return -EPROBE_DEFER;
>
> --
> 2.13.0
>
