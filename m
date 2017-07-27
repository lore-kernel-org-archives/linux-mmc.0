From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] sdhci: acpi: Use new method to get ACPI companion
Date: Thu, 27 Jul 2017 16:49:15 +0200
Message-ID: <CAPDyKFqk54683ffm=g4Pefr6iveY5eHxzHu1KQPTGUczTKoA4Q@mail.gmail.com>
References: <20170724145958.34478-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:38401 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbdG0OtR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:49:17 -0400
Received: by mail-qk0-f179.google.com with SMTP id x191so37505655qka.5
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:49:16 -0700 (PDT)
In-Reply-To: <20170724145958.34478-1-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 July 2017 at 16:59, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> ACPI_COMPANION() macro reduces a code to get a companion device out of
> struct device.
>
> Use it instead of an old method.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index ac678e9fb19a..4bbce8919c30 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -432,7 +432,6 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>  static int sdhci_acpi_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       acpi_handle handle = ACPI_HANDLE(dev);
>         struct acpi_device *device, *child;
>         struct sdhci_acpi_host *c;
>         struct sdhci_host *host;
> @@ -442,7 +441,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         const char *uid;
>         int err;
>
> -       if (acpi_bus_get_device(handle, &device))
> +       device = ACPI_COMPANION(dev);
> +       if (!device)
>                 return -ENODEV;
>
>         hid = acpi_device_hid(device);
> --
> 2.13.2
>
