From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 4/4] sdio: pm: set device's power state after driver runtime suspended it
Date: Fri, 19 Oct 2012 01:39:25 +0200
Message-ID: <8682251.Y8RZX4ziBd@vostro.rjw.lan>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com> <1350011561-21039-5-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53769 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2JRXfk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 19:35:40 -0400
In-Reply-To: <1350011561-21039-5-git-send-email-aaron.lu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday 12 of October 2012 11:12:41 Aaron Lu wrote:
> In sdio bus level runtime callback function, after call the driver's
> runtime suspend callback, we will check if the device supports a
> platform level power management, and if so, a proper power state is
> chosen by the corresponding platform callback and then set.
> 
> Platform level runtime wakeup is also set, if device is enabled for
> runtime wakeup by its driver, it will be armed the ability to generate
> a wakeup event by the platform.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/mmc/core/sdio_bus.c | 49 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index aaec9e2..d83dea8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -23,6 +23,7 @@
>  
>  #include "sdio_cis.h"
>  #include "sdio_bus.h"
> +#include "sdio.h"
>  #include "sdio_acpi.h"
>  
>  /* show configuration fields */
> @@ -194,10 +195,54 @@ static int sdio_bus_remove(struct device *dev)
>  }
>  
>  #ifdef CONFIG_PM
> +
> +static int sdio_bus_runtime_suspend(struct device *dev)
> +{
> +	int ret;
> +	sdio_power_t state;
> +
> +	ret = pm_generic_runtime_suspend(dev);
> +	if (ret)
> +		goto out;
> +
> +	if (!platform_sdio_power_manageable(dev))
> +		goto out;
> +
> +	platform_sdio_run_wake(dev, true);
> +
> +	state = platform_sdio_choose_power_state(dev);
> +	if (state == SDIO_POWER_ERROR) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = platform_sdio_set_power_state(dev, state);
> +
> +out:
> +	return ret;
> +}
> +
> +static int sdio_bus_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	if (platform_sdio_power_manageable(dev)) {
> +		platform_sdio_run_wake(dev, false);
> +		ret = platform_sdio_set_power_state(dev, SDIO_D0);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = pm_generic_runtime_resume(dev);
> +
> +out:
> +	return ret;
> +}
> +

Most likely we will need to make analogous changes for other bus types that
don't support power management natively, like platform, SPI, I2C etc.  In all
of them the _runtime_suspend() and _runtime_resume() routine will look
almost exactly the same except for the platform_sdio_ prefix.

For this reason, I think it would be better to simply define two functions
acpi_pm_runtime_suspend() and acpi_pm_runtime_resume() that will do all of
the ACPI-specific operations related to runtime suspend/resume.  Then, we
will be able to use these functions for all of the bus types in question
in the same way (we may also need to add analogous functions for system
suspend/resume handling).

If we do that, then the sdio_platform_pm_ops structure from the previous
patch won't be necessary any more.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
