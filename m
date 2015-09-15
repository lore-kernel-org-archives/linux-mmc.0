From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: detect sd card reader on asus x205ta
Date: Tue, 15 Sep 2015 13:33:45 +0200
Message-ID: <CAPDyKFoXWKAHitneifG_sFFynwH1mQBXib0vFJkb=B2Fb5R-cw@mail.gmail.com>
References: <1441435792-446-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33543 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbIOLdr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 07:33:47 -0400
Received: by wiclk2 with SMTP id lk2so24256065wic.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 04:33:46 -0700 (PDT)
In-Reply-To: <1441435792-446-1-git-send-email-michele.curti@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>, Peter Griffin <peter.griffin@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 5 September 2015 at 08:49, Michele Curti <michele.curti@gmail.com> wrote:
> Add an entry to the sdhci_acpi_uids list to detect the SD card
> reader on the Asus X205Ta laptop.
>
> dstd table:
>
> Device (SDHC)
> {
>     Name (_ADR, Zero)  // _ADR: Address
>     Name (_HID, "PNP0FFF")  // _HID: Hardware ID
>     Name (_CID, "PNP0D40" /* SDA Standard Compliant SD Host Controller */)
>     Name (_DDN, "Intel(R) SD Card Controller - 80860F16")  // _DDN: DOS Dev
>     Name (_UID, 0x03)  // _UID: Unique ID
>     Name (RDEP, Package (0x02)
>
> Signed-off-by: Michele Curti <michele.curti@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 22d929f..78aa16a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -247,6 +247,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>         { "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
>         { "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
>         { "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
> +       { "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
>         { "PNP0D40"  },
>         { },
>  };
> --
> 2.5.1
>
