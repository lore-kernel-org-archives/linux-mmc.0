From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 4/4] sdio: pm: set device's power state after driver
 runtime suspended it
Date: Sat, 20 Oct 2012 15:15:41 +0800
Message-ID: <20121020071539.GB4798@localhost.localdomain>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
 <1350011561-21039-5-git-send-email-aaron.lu@intel.com>
 <8682251.Y8RZX4ziBd@vostro.rjw.lan>
 <96495050.e1u1tibeG9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36653 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2JTHPr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Oct 2012 03:15:47 -0400
Content-Disposition: inline
In-Reply-To: <96495050.e1u1tibeG9@vostro.rjw.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Fri, Oct 19, 2012 at 08:08:38PM +0200, Rafael J. Wysocki wrote:
> On Friday 19 of October 2012 01:39:25 Rafael J. Wysocki wrote:
> > On Friday 12 of October 2012 11:12:41 Aaron Lu wrote:
> > > In sdio bus level runtime callback function, after call the driver's
> > > runtime suspend callback, we will check if the device supports a
> > > platform level power management, and if so, a proper power state is
> > > chosen by the corresponding platform callback and then set.
> > > 
> > > Platform level runtime wakeup is also set, if device is enabled for
> > > runtime wakeup by its driver, it will be armed the ability to generate
> > > a wakeup event by the platform.
> > > 
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > ---
> > >  drivers/mmc/core/sdio_bus.c | 49 +++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 47 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> > > index aaec9e2..d83dea8 100644
> > > --- a/drivers/mmc/core/sdio_bus.c
> > > +++ b/drivers/mmc/core/sdio_bus.c
> > > @@ -23,6 +23,7 @@
> > >  
> > >  #include "sdio_cis.h"
> > >  #include "sdio_bus.h"
> > > +#include "sdio.h"
> > >  #include "sdio_acpi.h"
> > >  
> > >  /* show configuration fields */
> > > @@ -194,10 +195,54 @@ static int sdio_bus_remove(struct device *dev)
> > >  }
> > >  
> > >  #ifdef CONFIG_PM
> > > +
> > > +static int sdio_bus_runtime_suspend(struct device *dev)
> > > +{
> > > +	int ret;
> > > +	sdio_power_t state;
> > > +
> > > +	ret = pm_generic_runtime_suspend(dev);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	if (!platform_sdio_power_manageable(dev))
> > > +		goto out;
> > > +
> > > +	platform_sdio_run_wake(dev, true);
> > > +
> > > +	state = platform_sdio_choose_power_state(dev);
> > > +	if (state == SDIO_POWER_ERROR) {
> > > +		ret = -EIO;
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret = platform_sdio_set_power_state(dev, state);
> > > +
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > > +static int sdio_bus_runtime_resume(struct device *dev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (platform_sdio_power_manageable(dev)) {
> > > +		platform_sdio_run_wake(dev, false);
> > > +		ret = platform_sdio_set_power_state(dev, SDIO_D0);
> > > +		if (ret)
> > > +			goto out;
> > > +	}
> > > +
> > > +	ret = pm_generic_runtime_resume(dev);
> > > +
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > 
> > Most likely we will need to make analogous changes for other bus types that
> > don't support power management natively, like platform, SPI, I2C etc.  In all
> > of them the _runtime_suspend() and _runtime_resume() routine will look
> > almost exactly the same except for the platform_sdio_ prefix.
> > 
> > For this reason, I think it would be better to simply define two functions
> > acpi_pm_runtime_suspend() and acpi_pm_runtime_resume() that will do all of
> > the ACPI-specific operations related to runtime suspend/resume.  Then, we
> > will be able to use these functions for all of the bus types in question
> > in the same way (we may also need to add analogous functions for system
> > suspend/resume handling).
> 
> Something like in the (totally untested) patch below.

Looks good to me.
I'll test the code and put it into v2 of the patchset with your
sign-off, is it OK?

Thanks,
Aaron

> 
> With this code the SDIO bus type should be able to use
> acpi_subsys_runtime_suspend() and acpi_subsys_runtime_resume() as its
> bus-type-level runtime suspend/resume callback routines, respectively.
> 
> Thanks,
> Rafael
> 
> 
> Prototype, no sign-off.
> ---
>  drivers/acpi/dev_pm.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h  |   12 +++++++++++
>  2 files changed, 66 insertions(+)
> 
> Index: linux-pm/drivers/acpi/dev_pm.c
> ===================================================================
> --- /dev/null
> +++ linux-pm/drivers/acpi/dev_pm.c
> @@ -0,0 +1,54 @@
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <acpi/acpi_bus.h>
> +
> +int acpi_dev_runtime_suspend(struct device *dev)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> +	bool enable_wakeup;
> +	int power_state;
> +
> +	if (!handle || !acpi_bus_power_manageable(handle))
> +		return 0;
> +
> +	enable_wakeup = dev_pm_qos_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP))
> +				!= PM_QOS_FLAGS_NONE;
> +	acpi_pm_device_run_wake(dev, enable_wakeup);
> +
> +	power_state = acpi_pm_device_sleep_state(dev, NULL, ACPI_STATE_D3);
> +	if (power_state < ACPI_STATE_D0 || power_state > ACPI_STATE_D3)
> +		return -EIO;
> +
> +	return acpi_bus_set_power(handle, power_state);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_runtime_suspend);
> +
> +int acpi_dev_runtime_resume(struct device *dev)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> +
> +	if (!handle || !acpi_bus_power_manageable(handle))
> +		return 0;
> +
> +	acpi_pm_device_run_wake(dev, false);
> +	return acpi_bus_set_power(handle, ACPI_STATE_D0);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
> +
> +int acpi_subsys_runtime_suspend(struct device *dev)
> +{
> +	int ret = pm_generic_runtime_suspend(dev);
> +	return ret ? ret : acpi_dev_runtime_suspend(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
> +
> +int acpi_subsys_runtime_resume(struct device *dev)
> +{
> +	int ret = acpi_dev_runtime_resume(dev);
> +	return ret ? ret : pm_generic_runtime_resume(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -434,4 +434,16 @@ acpi_status acpi_os_prepare_sleep(u8 sle
>  #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
>  #endif
>  
> +#if defined(CONFIG_ACPI) && defined (CONFIG_PM_RUNTIME)
> +int acpi_dev_runtime_suspend(struct device *dev);
> +int acpi_dev_runtime_resume(struct device *dev);
> +int acpi_subsys_runtime_suspend(struct device *dev);
> +int acpi_subsys_runtime_resume(struct device *dev);
> +#else
> +static inline acpi_dev_runtime_suspend(struct device *dev) { return 0; }
> +static inline acpi_dev_runtime_resume(struct device *dev) { return 0; }
> +static inline acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
> +static inline acpi_subsys_runtime_resume(struct device *dev) { return 0; }
> +#endif
> +
>  #endif	/*_LINUX_ACPI_H*/
> 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
