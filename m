From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci-acpi: Remove unneeded
 acpi_bus_get_status() call
Date: Thu, 13 Apr 2017 15:25:08 +0300
Message-ID: <a62177bf-224f-6e56-ba37-0d5e93da9273@intel.com>
References: <20170412181922.31833-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32129 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbdDMMat (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Apr 2017 08:30:49 -0400
In-Reply-To: <20170412181922.31833-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

On 12/04/17 21:19, Hans de Goede wrote:
> The acpi-subsys already calls acpi_bus_get_status() and checks that
> device->status.present is set before even registering the platform_device
> so out probe function will never get called if device->status.present is
> false and there is no need for this check.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> -This is a new patch replacing "mmc: sdhci-acpi: Check device status
>  before calling fix_up_power()"
> ---
>  drivers/mmc/host/sdhci-acpi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 237f318..9fd8d7a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -399,9 +399,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  		if (child->status.present && child->status.enabled)
>  			acpi_device_fix_up_power(child);
>  
> -	if (acpi_bus_get_status(device) || !device->status.present)
> -		return -ENODEV;
> -
>  	if (sdhci_acpi_byt_defer(dev))
>  		return -EPROBE_DEFER;
>  
> 

