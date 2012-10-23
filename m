From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: Defer probe if regulator_get fails
Date: Tue, 23 Oct 2012 14:36:35 +0100
Message-ID: <20121023133635.GV21164@n2100.arm.linux.org.uk>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com> <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com> <4F1DF342-A2C4-434A-B878-A11374089E6E@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F1DF342-A2C4-434A-B878-A11374089E6E-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philip Rakity <prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 23, 2012 at 03:21:58PM +0200, Philip Rakity wrote:
> On 23 Oct 2012, at 09:19, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > -	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> > +	/*
> > +	 * If vqmmc regulator and no 1.8V signalling, then there's no UHS.
> > +	 * vqmmc regulator should be present. If it's not present,
> > +	 * assume the regulator driver registration is not yet done and
> > +	 * defer the probe.
> > +	 */
> > 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> > 	if (IS_ERR(host->vqmmc)) {
> > -		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> > +		pr_err("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> > 		host->vqmmc = NULL;
> > +		return -EPROBE_DEFER;
> 
> Some systems exist where vmmc regulator exists and vqmmc regulator does not.  The vmmc regular is fixed at 3.3v.  
> Deferring the probe will cause issues.

That's one of the issues of deferred probing: you don't know if one of the
_get() functions failed because it just isn't present, or whether it's
failed because it hasn't been registered yet.

The two conditions are indistinguishable from the driver point of view.

The solution to it is to ensure that those drivers where hardware resource
X is optional provide a dummy resource to the driver when the hardware
resource is not available.  That means, as far as the driver is concerned,
that it will always expect to get a full set of resources whether or not
the hardware has them.

If drivers care about such stuff, then we should have xxx_is_dummy()
functions (eg, clk_is_dummy(clk)) which return TRUE when the hardware
resource is not available.  (which we could use NULL to indicate and
would be in keeping with the specified IS_ERR() usage of these APIs.)
