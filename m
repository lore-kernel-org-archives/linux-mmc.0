From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: All OMAP platforms: MMC is broken
Date: Mon, 5 Oct 2015 19:38:13 +0100
Message-ID: <20151005183813.GD21626@n2100.arm.linux.org.uk>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
 <20150924233756.GN23801@atomide.com>
 <20151001093325.GU21513@n2100.arm.linux.org.uk>
 <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
 <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40865 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbJESia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 14:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20151005171155.GF23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 05, 2015 at 10:11:56AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151005 07:57]:
> > * Tony Lindgren <tony@atomide.com> [151005 07:44]:
> > > * Tony Lindgren <tony@atomide.com> [151005 04:28]:
> > > 
> > > Based on some tests it seems that the duovero unpaired regulator usage
> > > is fixed by reverting:
> > > 
> > > c55d7a055364 ("mmc: host: omap_hsmmc: use regulator_is_enabled to
> > > find pbias status")
> > 
> > With commit c55d7a055364 my guess is that the PBIAS regulator is
> > already on from an earlier MMC probe and getting re-enabled when
> > a deferred probe happens?
> 
> Unless somebody has a better fix in mind for the above, I suggest
> we revert it for the -rc kernel.

Let me try reverting that in my build tree, and...

> > > And it seems that omap3 legacy MMC is broken earlier in the
> > > series with:
> > > 
> > > 7d607f917008 ("mmc: host: omap_hsmmc: use
> > > devm_regulator_get_optional() for vmmc")
> > > 
> > > This one does not cleanly revert so have not yet tried reverting
> > > it.
> > 
> > And with commit 7d607f917008 I'm guessing we can't return an
> > error if the PBIAS regulator does not exist as that's not there
> > for the legacy booting.
> 
> For omap3 legacy booting, we keep getting -EPROBE_DEFER for
> all the optional regulators.
> 
> Something like the following might be the minimal fix for the -rc
> cycle?

applying this patch.  If that gets things going again, then we
_definitely_ should get both of these to Linus ASAP.  The breakage
has been around far too long already.

> 8< ----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 5 Oct 2015 09:37:36 -0700
> Subject: [PATCH] mmc: host: omap_hsmmc: Fix MMC for omap3 legacy booting
> 
> Starting with commit 7d607f917008 ("mmc: host: omap_hsmmc: use
> devm_regulator_get_optional() for vmmc") MMC on omap3 stopped working
> for legacy booting.
> 
> This is because legacy booting sets up some of the resource in the
> platform init code, and for optional regulators always seem to
> return -EPROBE_DEFER for the legacy booting.
> 
> Let's fix the issue by checking for device tree based booting for
> now. Then when omap3 boots in device tree only mode, this patch
> can be just reverted.
> 
> Fixes: 7d607f917008 ("mmc: host: omap_hsmmc: use
> devm_regulator_get_optional() for vmmc")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -478,7 +478,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  	mmc->supply.vmmc = devm_regulator_get_optional(host->dev, "vmmc");
>  	if (IS_ERR(mmc->supply.vmmc)) {
>  		ret = PTR_ERR(mmc->supply.vmmc);
> -		if (ret != -ENODEV)
> +		if ((ret != -ENODEV) && host->dev->of_node)
>  			return ret;
>  		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
>  			PTR_ERR(mmc->supply.vmmc));
> @@ -493,7 +493,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  	mmc->supply.vqmmc = devm_regulator_get_optional(host->dev, "vmmc_aux");
>  	if (IS_ERR(mmc->supply.vqmmc)) {
>  		ret = PTR_ERR(mmc->supply.vqmmc);
> -		if (ret != -ENODEV)
> +		if ((ret != -ENODEV) && host->dev->of_node)
>  			return ret;
>  		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
>  			PTR_ERR(mmc->supply.vqmmc));
> @@ -503,7 +503,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
>  	if (IS_ERR(host->pbias)) {
>  		ret = PTR_ERR(host->pbias);
> -		if (ret != -ENODEV)
> +		if ((ret != -ENODEV) && host->dev->of_node)
>  			return ret;
>  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
>  			PTR_ERR(host->pbias));

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
