From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-acpi: Check device status before calling
 fix_up_power()
Date: Thu, 2 Mar 2017 13:53:32 +0200
Message-ID: <4481f84f-22a6-4ee6-9875-d5e03729b6fd@intel.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
 <20170225172357.26294-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdCBMkb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Mar 2017 07:40:31 -0500
In-Reply-To: <20170225172357.26294-3-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>
Cc: Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 25/02/17 19:23, Hans de Goede wrote:
> Calling acpi_device_fix_up_power() on a device which is not present
> is not a good idea.
> 
> While at it also call acpi_bus_get_status() on the children before
> the status check to make sure that child->status contains valid data.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 96465ff..873beae 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -394,15 +394,15 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	if (acpi_bus_get_device(handle, &device))
>  		return -ENODEV;
>  
> +	if (acpi_bus_get_status(device) || !device->status.present)
> +		return -ENODEV;
> +
>  	/* Power on the SDHCI controller and its children */
>  	acpi_device_fix_up_power(device);
>  	list_for_each_entry(child, &device->children, node)
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

