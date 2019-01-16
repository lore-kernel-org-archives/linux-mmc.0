From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date: Wed, 16 Jan 2019 14:20:31 +0100
Message-ID: <20190116142031.54bc0f9a@windsurf>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
        <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
        <d92a5588-ffdd-5198-b985-04d9b8dae601@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d92a5588-ffdd-5198-b985-04d9b8dae601@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
List-Id: linux-mmc@vger.kernel.org

Hello Adrian,

On Wed, 16 Jan 2019 14:59:32 +0200, Adrian Hunter wrote:

> > The below patch simply changes sdhci_check_ro() to use the value of
> > the WP GPIO if available. We need to adjust the prototype of the
> > function to use a mmc_host* as argument instead of sdhci_host*, since
> > the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.  
> 
> Why not just use host->mmc

Could do that. I just found it weird that the calling function has the
mmc_host structure, does some gymnastic to find sdhci_host, and then in
the called function, we do the opposite gymnastic to find mmc_host from
sdhci_host. But if that's the preference, I'm happy to change the patch
accordingly.


> >  	if (host->flags & SDHCI_DEVICE_DEAD)
> >  		is_readonly = 0;
> > +	else if (mmc_can_gpio_ro(mmc))
> > +		is_readonly = mmc_gpio_get_ro(mmc);  
> 
> Perhaps host->ops->get_ro should be checked before mmc_can_gpio_ro()?

That is actually a good point, using ->get_ro() should come before
using the GPIO. Indeed, some drivers may potentially have a ->get_ro
with custom logic *and* a WP GPIO, and in this case, we want ->get_ro
to take precedence. I'll send a v2 with this, once you let me know your
decision about the previous point.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
