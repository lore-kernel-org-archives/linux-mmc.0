From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Fri, 9 Mar 2012 00:30:40 +0100
Message-ID: <201203090030.41190.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203082337.23821.rjw@sisk.pl> <87zkbq8ywo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34662 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab2CHX0f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 18:26:35 -0500
In-Reply-To: <87zkbq8ywo.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Friday, March 09, 2012, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday, March 08, 2012, Kevin Hilman wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> > On Thursday, March 08, 2012, Kevin Hilman wrote:
> >> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> >> 
> >> >> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >> >> >
> >> >> > A runtime suspend of a device (e.g. an MMC controller) belonging to
> >> >> > a power domain or, in a more complicated scenario, a runtime suspend
> >> >> > of another device in the same power domain, may cause power to be
> >> >> > removed from the entire domain.  In that case, the amount of time
> >> >> > necessary to runtime-resume the given device (e.g. the MMC
> >> >> > controller) is often substantially greater than the time needed to
> >> >> > run its driver's runtime resume callback.  That may hurt performance
> >> >> > in some situations, because user data may need to wait for the
> >> >> > device to become operational, so we should make it possible to
> >> >> > prevent that from happening.
> >> >> >
> >> >> > For this reason, introduce a new sysfs attribute for devices,
> >> >> > power/pm_qos_latency_us, allowing user space to specify the upper
> >> >> 
> >> >> If we're expecting to have more of these knobs, maybe having a pm_qos
> >> >> subdir under power will keep down the clutter in /sys/devices/.../power.
> >> >> This knob would then be /sys/devices/.../power/pm_qos/pm_qos_latency_us.
> >> >
> >> > I'm not sure how difficult it is to create a subdir in sysfs under something
> >> > that is not a kobject.
> >> >
> >> > Besides, this follows the convention already used by wakeup and runtime PM
> >> > attributes that don't have their own subdirs (although there may be a number
> >> > of them in each category).
> >> 
> >> OK
> >> 
> >> >> I think 'latency' alone is a bit too vague (wakeup latency?  interrupt
> >> >> latency?  I think wakeup latency is clearer.  Another possibility is
> >> >> resume latency, IMO, that will lead to confusion about whether this
> >> >> field also affects system suspend/resume.
> >> >
> >> > I think "wakeup latency" will lead to more confusion because of the
> >> > wakeup-related attributes.  
> >> 
> >> What confusion?  All of those are related to device wakeups from some
> >> low power state, and so is this proposed latency attribute.  So I don't
> >> understand the potential confusion.
> >
> > The word "wakeup" may refer to many different things, as well as the word
> > "resume". :-)
> 
> Yes, but what's the confusion in this case?
> 
> IMO, The existing /sys/devices/.../power/wakeup* meaning is the same
> meaning as as for the wakeup latency in this patch,

No, it is not.  They refer to system wakeup. :-)

> so I don't understand where the confusion would be.

See above. ;-)

Rafael
