From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func
 driver
Date: Tue, 2 Jun 2015 12:07:15 +0100
Message-ID: <20150602110715.GA20704@n2100.arm.linux.org.uk>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
 <20150601194209.GB30024@dtor-ws>
 <CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
 <20150602085101.GY2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59637 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbbFBLHZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2015 07:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20150602085101.GY2067@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>

On Tue, Jun 02, 2015 at 09:51:01AM +0100, Russell King - ARM Linux wrote:
> What would resolve that would be to have the device registration succeed,
> but also to scan all devices in the system when a PM domain is attached
> and attach the PM domain to matching devices.  The problem you then have
> is the same race between attaching the PM domain to all devices in the
> domain, and devices being probed.  Remember, this may not be happening at
> boot time, but during module load, which on some systems is multithreaded.
> So, the problem of not having all devices in the PM domain hasn't changed
> and nothing is solved by this approach - the only thing is the code has
> become more complex.
> 
> I don't think that's an improvement.

Another idea, which I came up with while replying to Ivan on a different
but related topic is:

* When we create a device which we know has a PM domain which should be
  attached, try to look up that PM domain.
* If we find the PM domain, attach the domain, otherwise create the
  domain but mark it "incomplete".
* When the device is attempted to be probed, force the probe to defer if
  the PM domain is inccomplete.
* When a PM domain is initialised, search for any incomplete PM domain,
  and if found, connect with the domain and arrange to handle it.

The problem you still run into is whether all devices have been registered
into the domain, but I really think that expecting all devices to be
registered is in itself a problem.

Consider the case where a PM domain spreads between a parent device (eg,
a bridge) and a set of child devices.  We may need to probe the bridge
in order to discover and register the child devices.  If we're expecting
the PM domain to be fully populated with all devices before that happens,
we're in a catch-22 situation: we can't register the child devices until
the bridge has been probed, and we can't probe the bridge because the
PM domain is incomplete.

I don't think there's a good answer to that one, not without going back
to today's model, where a PM domain is able to be brought up and down
without all of its associated devices attached.  That, in itself, should
not be a problem since drivers should _not_ assume that the device has
any context preserved from the last time it saw it (eg, consider the
random state of a device when a crashed kernel kexecs into a new kernel.)
Doing anything else is just fragile.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
