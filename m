From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 2/4] mmc: sdio: bind sdio device with acpi device
Date: Fri, 19 Oct 2012 01:25:46 +0200
Message-ID: <1834995.5UHtKnYTb2@vostro.rjw.lan>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com> <1350011561-21039-3-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53684 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab2JRXWB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 19:22:01 -0400
In-Reply-To: <1350011561-21039-3-git-send-email-aaron.lu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday 12 of October 2012 11:12:39 Aaron Lu wrote:
> ACPI spec defines the _ADDR encoding for sdio bus as:
> High word - slot number (0 based)
> Low word  - function number
> 
> This patch adds support for sdio device binding with acpi using the
> generic ACPI glue framework.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/mmc/core/Makefile    |  1 +
>  drivers/mmc/core/sdio_acpi.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sdio_bus.c  | 14 ++++++++++++--
>  drivers/mmc/core/sdio_bus.h  |  2 ++
>  4 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/core/sdio_acpi.c
> 
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 38ed210..c8300aa 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -10,3 +10,4 @@ mmc_core-y			:= core.o bus.o host.o \
>  				   quirks.o slot-gpio.o
>  
>  mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
> +mmc_core-$(CONFIG_ACPI)		+= sdio_acpi.o
> diff --git a/drivers/mmc/core/sdio_acpi.c b/drivers/mmc/core/sdio_acpi.c
> new file mode 100644
> index 0000000..0f92e90
> --- /dev/null
> +++ b/drivers/mmc/core/sdio_acpi.c
> @@ -0,0 +1,35 @@
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/sdhci.h>
> +#include <linux/mmc/sdio_func.h>
> +#include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
> +#include "sdio_bus.h"
> +
> +static int acpi_sdio_find_device(struct device *dev, acpi_handle *handle)
> +{
> +	struct sdio_func *func;
> +	struct sdhci_host *host;
> +	u64 addr;
> +
> +	func = dev_to_sdio_func(dev);
> +	host = mmc_priv(func->card->host);
> +
> +	addr = (host->slotno << 16) | func->num;
> +
> +	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev), addr);
> +	if (!*handle)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static struct acpi_bus_type acpi_sdio_bus = {
> +	.bus = &sdio_bus_type,
> +	.find_device = acpi_sdio_find_device,
> +};
> +
> +int sdio_acpi_register(void)

I'd call it sdio_acpi_register_bus().

> +{
> +	return register_acpi_bus_type(&acpi_sdio_bus);
> +}
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 6bf6879..aaec9e2 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -23,6 +23,7 @@
>  
>  #include "sdio_cis.h"
>  #include "sdio_bus.h"
> +#include "sdio_acpi.h"
>  
>  /* show configuration fields */
>  #define sdio_config_attr(field, format_string)				\
> @@ -209,7 +210,7 @@ static const struct dev_pm_ops sdio_bus_pm_ops = {
>  
>  #endif /* !CONFIG_PM */
>  
> -static struct bus_type sdio_bus_type = {
> +struct bus_type sdio_bus_type = {
>  	.name		= "sdio",
>  	.dev_attrs	= sdio_dev_attrs,
>  	.match		= sdio_bus_match,
> @@ -221,7 +222,16 @@ static struct bus_type sdio_bus_type = {
>  
>  int sdio_register_bus(void)
>  {
> -	return bus_register(&sdio_bus_type);
> +	int ret;
> +
> +	ret = bus_register(&sdio_bus_type);
> +	if (ret)
> +		goto out;
> +
> +	ret = sdio_acpi_register();

What happens if this fails?

> +
> +out:
> +	return ret;
>  }
>  
>  void sdio_unregister_bus(void)
> diff --git a/drivers/mmc/core/sdio_bus.h b/drivers/mmc/core/sdio_bus.h
> index 567a768..91c0e93 100644
> --- a/drivers/mmc/core/sdio_bus.h
> +++ b/drivers/mmc/core/sdio_bus.h
> @@ -18,5 +18,7 @@ void sdio_remove_func(struct sdio_func *func);
>  int sdio_register_bus(void);
>  void sdio_unregister_bus(void);
>  
> +extern struct bus_type sdio_bus_type;
> +
>  #endif

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
