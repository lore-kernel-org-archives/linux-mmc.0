From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus
Date: Mon, 5 Dec 2016 14:18:53 +0100
Message-ID: <CAPDyKFq=noqw4tBWwyFzrFYWJMefBsVOwyL0OnSQYAMwsEXmUw@mail.gmail.com>
References: <20161201203303.24676-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35825 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbcLENS4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 08:18:56 -0500
Received: by mail-wm0-f46.google.com with SMTP id a197so96699467wmd.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 05:18:55 -0800 (PST)
In-Reply-To: <20161201203303.24676-1-drake@endlessm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux@endlessm.com

On 1 December 2016 at 21:33, Daniel Drake <drake@endlessm.com> wrote:
> Add an entry for the SDIO bus in the ECS EF20 cherry trail laptop:
>
>   Device (SDHB) {
>     Name (_ADR, 0x00110000)
>     Name (_HID, "80860F14" /* Intel Baytrail SDIO/MMC Host Controller */)
>     Name (_CID, "PNP0D40" /* SDA Standard Compliant SD Host Controller */)
>     Name (_DDN, "Intel(R) SDIO Controller - 80862295")
>     Name (_UID, 0x02)
>     Name (_HRV, One)
>
> A SDHB device with the same _HID and _UID can also be found on other
> cherry trail products like Chuwi Hi10.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 81d4dc0..160f695 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -328,6 +328,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>         { "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
>         { "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
>         { "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
> +       { "80860F14" , "2" , &sdhci_acpi_slot_int_sdio },
>         { "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
>         { "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
>         { "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
> --
> 2.9.3
>
