From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 13 Jul 2011 17:09:08 +0800
Message-ID: <5D8008F58939784290FAB48F5497519846C4113396@shsmsx502.ccr.corp.intel.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<1309538376-23260-3-git-send-email-balajitk@ti.com> <8739ig8wby.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <8739ig8wby.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Balaji T K <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "kishore.kadiyala@ti.com" <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, July 09, 2011 2:24 AM
> To: Balaji T K
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; cjb@laptop.org;
> tony@atomide.com; madhu.cr@ti.com; b-cousson@ti.com; paul@pwsan.com;
> kishore.kadiyala@ti.com
> Subject: Re: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
> 
> Balaji T K <balajitk@ti.com> writes:
> 
> > add runtime pm support to HSMMC host controller
> > Use runtime pm API to enable/disable HSMMC clock
> > Use runtime autosuspend APIs to enable auto suspend delay
> >
> > Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore
> Kadiyala
> >
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> 
> It's not relevant for this merge window, but I'm exploring some future
> changes to our PM core code and have a question about how MMC works for
> system suspend.
> 
> Basially, the question is: can the driver be reworked such that a system
> suspend does not need to runtime resume the device?  For most devices,
> we kind of expect that if the device is runtime suspended, a system
> suspend will have nothing extra to do, but this driver runtime resumes
> the device during system suspend in order to do "stuff", which I
> admitedly don't fully undestand.
> 
> Ideally, the "stuff" needed for runtime suspend and system suspend could
> be made to be common such that a system suspend of a runtime suspended
> device would be a noop.
> 
> Is this possible?
> 
> Kevin

During system suspended patch, a callback named .prepare will be first done before .suspend is called, and .complete callback will be called after .resume is called. These two callbacks are in pair. If driver can implement the .prepare and hold the usage count in this callback, then runtime pm suspend/resume will not happen during device suspending. So there will be no need to add pm_runtime_get* and pm_runtime_put* in .suspend/.resume.
BTW, if .prepare has hold the usage count, then .complete callback need to release the usage count and put device in runtime suspended mode.

Thanks
Chuanxiao

> 
> > @@ -2100,6 +2087,7 @@ static int omap_hsmmc_suspend(struct device *dev)
> >  		return 0;
> >
> >  	if (host) {
> > +		pm_runtime_get_sync(host->dev);
> >  		host->suspended = 1;
> >  		if (host->pdata->suspend) {
> >  			ret = host->pdata->suspend(&pdev->dev,
> > @@ -2114,13 +2102,11 @@ static int omap_hsmmc_suspend(struct device
> *dev)
> >  		}
> >  		cancel_work_sync(&host->mmc_carddetect_work);
> >  		ret = mmc_suspend_host(host->mmc);
> > -		mmc_host_enable(host->mmc);
> > +
> >  		if (ret == 0) {
> >  			omap_hsmmc_disable_irq(host);
> >  			OMAP_HSMMC_WRITE(host->base, HCTL,
> >  				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
> > -			mmc_host_disable(host->mmc);
> > -			clk_disable(host->iclk);
> >  			if (host->got_dbclk)
> >  				clk_disable(host->dbclk);
> >  		} else {
> > @@ -2132,9 +2118,8 @@ static int omap_hsmmc_suspend(struct device *dev)
> >  					dev_dbg(mmc_dev(host->mmc),
> >  						"Unmask interrupt failed\n");
> >  			}
> > -			mmc_host_disable(host->mmc);
> >  		}
> > -
> > +		pm_runtime_put_sync(host->dev);
> >  	}
> >  	return ret;
> >  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
