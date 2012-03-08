From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Thu, 08 Mar 2012 15:18:31 -0800
Message-ID: <87zkbq8ywo.fsf@ti.com>
References: <201203040101.53177.rjw@sisk.pl> <201203082227.50138.rjw@sisk.pl>
	<87haxyaguz.fsf@ti.com> <201203082337.23821.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:57577 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756413Ab2CHXSb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 18:18:31 -0500
Received: by mail-iy0-f172.google.com with SMTP id z13so1504226iaz.31
        for <linux-mmc@vger.kernel.org>; Thu, 08 Mar 2012 15:18:30 -0800 (PST)
In-Reply-To: <201203082337.23821.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 8 Mar 2012 23:37:23 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, March 08, 2012, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Thursday, March 08, 2012, Kevin Hilman wrote:
>> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> >> 
>> >> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> >> >
>> >> > A runtime suspend of a device (e.g. an MMC controller) belonging to
>> >> > a power domain or, in a more complicated scenario, a runtime suspend
>> >> > of another device in the same power domain, may cause power to be
>> >> > removed from the entire domain.  In that case, the amount of time
>> >> > necessary to runtime-resume the given device (e.g. the MMC
>> >> > controller) is often substantially greater than the time needed to
>> >> > run its driver's runtime resume callback.  That may hurt performance
>> >> > in some situations, because user data may need to wait for the
>> >> > device to become operational, so we should make it possible to
>> >> > prevent that from happening.
>> >> >
>> >> > For this reason, introduce a new sysfs attribute for devices,
>> >> > power/pm_qos_latency_us, allowing user space to specify the upper
>> >> 
>> >> If we're expecting to have more of these knobs, maybe having a pm_qos
>> >> subdir under power will keep down the clutter in /sys/devices/.../power.
>> >> This knob would then be /sys/devices/.../power/pm_qos/pm_qos_latency_us.
>> >
>> > I'm not sure how difficult it is to create a subdir in sysfs under something
>> > that is not a kobject.
>> >
>> > Besides, this follows the convention already used by wakeup and runtime PM
>> > attributes that don't have their own subdirs (although there may be a number
>> > of them in each category).
>> 
>> OK
>> 
>> >> I think 'latency' alone is a bit too vague (wakeup latency?  interrupt
>> >> latency?  I think wakeup latency is clearer.  Another possibility is
>> >> resume latency, IMO, that will lead to confusion about whether this
>> >> field also affects system suspend/resume.
>> >
>> > I think "wakeup latency" will lead to more confusion because of the
>> > wakeup-related attributes.  
>> 
>> What confusion?  All of those are related to device wakeups from some
>> low power state, and so is this proposed latency attribute.  So I don't
>> understand the potential confusion.
>
> The word "wakeup" may refer to many different things, as well as the word
> "resume". :-)

Yes, but what's the confusion in this case?

IMO, The existing /sys/devices/.../power/wakeup* meaning is the same
meaning as as for the wakeup latency in this patch, so I don't
understand where the confusion would be.

Kevin
