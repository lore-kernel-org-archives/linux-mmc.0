From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency
 constraints
Date: Thu, 8 Mar 2012 22:23:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203082218520.29847@axis700.grange>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
 <201203080027.27435.rjw@sisk.pl> <201203080028.12547.rjw@sisk.pl>
 <87aa3rdluj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab2CHVXP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 16:23:15 -0500
In-Reply-To: <87aa3rdluj.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, 8 Mar 2012, Kevin Hilman wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > A runtime suspend of a device (e.g. an MMC controller) belonging to
> > a power domain or, in a more complicated scenario, a runtime suspend
> > of another device in the same power domain, may cause power to be
> > removed from the entire domain.  In that case, the amount of time
> > necessary to runtime-resume the given device (e.g. the MMC
> > controller) is often substantially greater than the time needed to
> > run its driver's runtime resume callback.  That may hurt performance
> > in some situations, because user data may need to wait for the
> > device to become operational, so we should make it possible to
> > prevent that from happening.
> >
> > For this reason, introduce a new sysfs attribute for devices,
> > power/pm_qos_latency_us, allowing user space to specify the upper
> 
> If we're expecting to have more of these knobs, maybe having a pm_qos
> subdir under power will keep down the clutter in /sys/devices/.../power.
> This knob would then be /sys/devices/.../power/pm_qos/pm_qos_latency_us.

If this change does have to be made, I'd propose

.../power/qos/latency...

removing redundancy.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
