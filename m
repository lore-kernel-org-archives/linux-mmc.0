From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: sdhci-acpi: Use helper function acpi_device_uid()
Date: Fri, 20 Oct 2017 12:03:29 +0200
Message-ID: <CAPDyKFohcWcMrWJM4DVK2kmSSeydBPoX4Zs5MJZkJXcQvKg5Sg@mail.gmail.com>
References: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com> <1508409706-27026-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:46451 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdJTKDa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:03:30 -0400
Received: by mail-it0-f65.google.com with SMTP id f187so13410093itb.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:03:30 -0700 (PDT)
In-Reply-To: <1508409706-27026-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 October 2017 at 12:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Make use of acpi_device_uid() instead of open coding.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 08ae0ff13513..e4b7fac5efb2 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -443,7 +443,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>                 return -ENODEV;
>
>         hid = acpi_device_hid(device);
> -       uid = device->pnp.unique_id;
> +       uid = acpi_device_uid(device);
>
>         /* Power on the SDHCI controller and its children */
>         acpi_device_fix_up_power(device);
> --
> 1.9.1
>
