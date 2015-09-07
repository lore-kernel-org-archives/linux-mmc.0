From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: detect sd card reader on asus x205ta
Date: Mon, 7 Sep 2015 09:03:07 +0300
Message-ID: <55ED289B.7010709@intel.com>
References: <1441435792-446-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41330 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbIGGF4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Sep 2015 02:05:56 -0400
In-Reply-To: <1441435792-446-1-git-send-email-michele.curti@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michele Curti <michele.curti@gmail.com>, ulf.hansson@linaro.org
Cc: andriy.shevchenko@linux.intel.com, yunpeng.gao@intel.com, peter.griffin@linaro.org, rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/09/15 09:49, Michele Curti wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 22d929f..78aa16a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -247,6 +247,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>  	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
>  	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
>  	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
> +	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
>  	{ "PNP0D40"  },
>  	{ },
>  };
> 

