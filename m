From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Thu, 08 Mar 2012 09:49:24 -0800
Message-ID: <87aa3rdluj.fsf@ti.com>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
	<201203080027.27435.rjw@sisk.pl> <201203080028.12547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:52993 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790Ab2CHRzm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 12:55:42 -0500
Received: by iajr24 with SMTP id r24so1185029iaj.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Mar 2012 09:55:41 -0800 (PST)
In-Reply-To: <201203080028.12547.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 8 Mar 2012 00:28:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> A runtime suspend of a device (e.g. an MMC controller) belonging to
> a power domain or, in a more complicated scenario, a runtime suspend
> of another device in the same power domain, may cause power to be
> removed from the entire domain.  In that case, the amount of time
> necessary to runtime-resume the given device (e.g. the MMC
> controller) is often substantially greater than the time needed to
> run its driver's runtime resume callback.  That may hurt performance
> in some situations, because user data may need to wait for the
> device to become operational, so we should make it possible to
> prevent that from happening.
>
> For this reason, introduce a new sysfs attribute for devices,
> power/pm_qos_latency_us, allowing user space to specify the upper

If we're expecting to have more of these knobs, maybe having a pm_qos
subdir under power will keep down the clutter in /sys/devices/.../power.
This knob would then be /sys/devices/.../power/pm_qos/pm_qos_latency_us.

I think 'latency' alone is a bit too vague (wakeup latency?  interrupt
latency?  I think wakeup latency is clearer.  Another possibility is
resume latency, IMO, that will lead to confusion about whether this
field also affects system suspend/resume.

That brings up another point: I think the docs should be very clear
about how this affects system suspend/resume.  From my understanding, it
is only intended to affect runtime suspend/resume but I think the
docs/comments need to be very clear about this since as you know the
overlap between system PM and runtime PM has been a source of
confusion.

> bound of the time necessary to bring the (runtime-suspended) device
> up after the resume of it has been requested.  However, make that
> attribute appear ony for the devices whose drivers declare support

s/ony/only/

> for by calling the (new) dev_pm_qos_expose_latency_limit() helper
> function with the appropriate initial value of the attribute.

Yes.  I really like the ability to hide/expose this feature, and that
the default is that it's hidden.

That feature addresses my primary concern about exposing too much to
userspace for certain subsystems.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Since I've objected to this kind of feature in the past, I'll just say
for the record that I'm fine with selectively exposing this particular
knob.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
