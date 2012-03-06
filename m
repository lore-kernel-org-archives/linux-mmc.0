From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] MMC / PM: Make it possible to use PM QoS latency constraints, v2
Date: Tue, 6 Mar 2012 22:06:20 +0100
Message-ID: <201203062206.20854.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042055.28111.rjw@sisk.pl> <Pine.LNX.4.64.1203061028450.9300@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58502 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031061Ab2CFVCO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Mar 2012 16:02:14 -0500
In-Reply-To: <Pine.LNX.4.64.1203061028450.9300@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Tuesday, March 06, 2012, Guennadi Liakhovetski wrote:
> Hi Rafael
> 
> On Sun, 4 Mar 2012, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > A runtime suspend of an MMC controller belonging to a power domain
> > or, in a more complicated scenario, a runtime suspend of another
> > device in the same power domain, may cause power to be removed from
> > the entire domain.  In that case, the amount of time necessary to
> > runtime-resume the MMC controller is often substantially greater
> > than the time needed to enable its clock.  That may hurt performance
> > in some situations, because user data may need to wait for the
> > controller to become operational, so we should make it possible to
> > prevent that from happening.
> > 
> > For this reason, introduce a new sysfs attribute for MMC hosts,
> > pm_latency_limit_ms, allowing user space to specify the upper bound
> > of the time necessary to bring the (runtime-suspended) host up after
> > the resume of it has been requested.  However, make that attribute
> > appear ony for the hosts whose drivers declare support for PM QoS by
> > populating the pm_qos member of struct mmc_host before registering
> > the host.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  Documentation/mmc/mmc-dev-attrs.txt |   24 ++++++++++++
> >  drivers/mmc/core/host.c             |   67 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h            |    9 ++++
> >  3 files changed, 100 insertions(+)
> > 
> > Index: linux/drivers/mmc/core/host.c
> > ===================================================================
> > --- linux.orig/drivers/mmc/core/host.c
> > +++ linux/drivers/mmc/core/host.c
> > @@ -293,6 +293,68 @@ static inline void mmc_host_clk_sysfs_in
> >  
> >  #endif
> >  
> > +static ssize_t pm_qos_val_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> > +	return snprintf(buf, PAGE_SIZE, "%d\n", host->pm_qos->val);
> > +}
> > +
> > +static ssize_t pm_qos_val_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> > +	s32 value;
> > +	int ret;
> > +
> > +	if (kstrtos32(buf, 0, &value))
> > +		return -EINVAL;
> > +
> > +	if (value < 0)
> > +		return -EINVAL;
> > +
> > +	host->pm_qos->val = value;
> > +	ret = dev_pm_qos_update_request(&host->pm_qos->req, value);
> 
> This seems strange, is this really needed? First assign the new value to 
> the request,

Not to the request, but to the val field which is in the same structure.

This field is needed anyway for initialization (the initial value is
passed through it from the driver to the core) and I don't see why not to
update it later (which allows it to be used by pm_qos_val_show without
looking into pm_qos->req).

However, I should update it only if the result returned by
dev_pm_qos_update_request() is not an error code.  Will fix.

> and then pass it to dev_pm_qos_update_request() with the 
> request and as a separate parameter additionally?
>
> Further, isn't value, used in dev_pm_qos*() calls in microseconds, whereas 
> your patch is supposed to operate in miliseconds?

Yes, it is in microseconds, sorry for the confusion.

Thanks,
Rafael
