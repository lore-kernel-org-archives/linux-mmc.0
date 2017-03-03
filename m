From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/3] mmc: sdhci-acpi: Check device status before calling
 fix_up_power()
Date: Fri, 3 Mar 2017 10:09:05 +0100
Message-ID: <20170303100905.090e0364@endymion>
References: <20170225172357.26294-1-hdegoede@redhat.com>
        <20170225172357.26294-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55169 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbdCCJoi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 04:44:38 -0500
In-Reply-To: <20170225172357.26294-3-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hans, Adrian,

On Sat, 25 Feb 2017 18:23:56 +0100, Hans de Goede wrote:
> Calling acpi_device_fix_up_power() on a device which is not present
> is not a good idea.

How bad is it?

This was introduced by commit e5bbf30733f9, which was backported to
several stable branches. If it causes real trouble then this fix-up
patch should be annotated with

Fixes: e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are powered when")

and Cc's to stable@, so it can be propagated to all affected trees.

> While at it also call acpi_bus_get_status() on the children before
> the status check to make sure that child->status contains valid data.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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


-- 
Jean Delvare
SUSE L3 Support
