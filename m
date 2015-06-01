From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func
 driver
Date: Mon, 1 Jun 2015 12:42:09 -0700
Message-ID: <20150601194209.GB30024@dtor-ws>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36013 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbFATmO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 15:42:14 -0400
Received: by ieclw1 with SMTP id lw1so21909435iec.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 12:42:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>

Hi Ulf,

On Mon, Jun 01, 2015 at 12:18:25PM +0200, Ulf Hansson wrote:
> Other subsystem buses attach PM domains during probe, but prior calling
> the driver's ->probe() method. During the removal phase, detaching the PM
> domain will be done after invoking the driver's ->remove() callback.
> 
> Convert the SDIO bus to follow this behavior and add error handling.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> A similar patch as $subject patch has been posted and discussed earlier.
> 
> According to Aaron Lu, who added the initial support for the ACPI PM domain to
> the SDIO bus, this change is safe.
> http://www.spinics.net/lists/linux-mmc/msg28946.html
> 
> ---
>  drivers/mmc/core/sdio_bus.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index bee02e6..7e327a6 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -137,6 +137,10 @@ static int sdio_bus_probe(struct device *dev)
>  	if (!id)
>  		return -ENODEV;
>  
> +	ret = dev_pm_domain_attach(dev, false);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;

Why do we handle only -EPROBE_DEFER? What about other errors? Maybe
dev_pm_domain_attach() is too chatty?

> +
>  	/* Unbound SDIO functions are always suspended.
>  	 * During probe, the function is set active and the usage count
>  	 * is incremented.  If the driver supports runtime PM,
> @@ -166,6 +170,7 @@ static int sdio_bus_probe(struct device *dev)
>  disable_runtimepm:
>  	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>  		pm_runtime_put_noidle(dev);
> +	dev_pm_domain_detach(dev, false);

If dev_pm_domain_attach() returned -EEXIST (which means that someone
else attached the device to the domain) should we be detaching it?

I realize that the other buses do the same thing, so these questions are
general.

Thanks.

-- 
Dmitry
