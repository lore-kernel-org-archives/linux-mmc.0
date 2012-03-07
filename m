From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Wed, 07 Mar 2012 12:38:54 -0800
Message-ID: <878vjcgn8h.fsf@ti.com>
References: <201203040101.53177.rjw@sisk.pl> <201203062214.53988.rjw@sisk.pl>
	<4F571CC9.7050609@intel.com> <201203071005.54890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47037 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756772Ab2CGUi4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Mar 2012 15:38:56 -0500
Received: by mail-iy0-f182.google.com with SMTP id k25so10838367iah.41
        for <linux-mmc@vger.kernel.org>; Wed, 07 Mar 2012 12:38:55 -0800 (PST)
In-Reply-To: <201203071005.54890.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 7 Mar 2012 10:05:54 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> Maybe this needs to be re-thought.  Userspace needs a simple, consistent and
>> understandable set of pm controls across the entire kernel, not piecemeal
>> across different subsystems.
>
> Well, that's my opinion too, but other people don't seem to agree with it.

I don't agree because when it comes to PM, subsystems can be quite
different in what they want to expose to userspace.  

IMO, it's the subsystems/drivers that should decide what to expose to
userspace for PM, just like they decide what gets exposed to userspace
for the rest of their functionality.

In other words, in my view, keeping PM knobs/controls outside the
management of the subsystem is creating a strange boundary for
userspace.  Applications have to do all their "normal" interactions with
the subsystem/driver, but for PM, they have to find the right sysfs
magic and twiddle that.    I would much rather see the
subsystems/drivers grow their own PM functionality and expose it to
userspace as they see fit.

One of the examples used to discuss this in the past has been the
touchscreen sample rate.  Touchscreens can save power by having a lower
sample rate at the expense of less precision.  For finger/thumb type
interface, a lower sample rate might be fine, but for handwriting
recognition with a stylus, a higher sample rate could be required.

Using a subsystem-generic (presumably sysfs-based) interface, the
application would be required to find the right sysfs magic in addition
to its interactions with tslib.  (is there really a generic "sampling
rate" knob that would make sense for all subsystems?)

To me it seems more logical for the touchscreen/input subystem to expose
this "sampling rate" knob in a subsystem-specific way to userspace,
which could then be handled by tslib.

Kevin
