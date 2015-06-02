From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func
 driver
Date: Tue, 2 Jun 2015 09:51:01 +0100
Message-ID: <20150602085101.GY2067@n2100.arm.linux.org.uk>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
 <20150601194209.GB30024@dtor-ws>
 <CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59309 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbFBIvQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2015 04:51:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>

On Tue, Jun 02, 2015 at 09:54:13AM +0200, Ulf Hansson wrote:
> On the other hand, the "long term plan" is to have PM domain pointers
> assigned at device registration point instead of at probe. Since
> driver core then invokes the ->activate|sync|dismiss() callbacks, it
> will make the dev_pm_domain_attach|detach() APIs redundant.

How does that work if the PM domain doesn't exist yet, because the driver
supplying it hasn't had its own device probed ?

You can't return -EPROBE_DEFER to anything that isn't being called via a
driver's probe function.  So, when the OF code is scanning the device
tree, creating the various struct device's, returning -EPROBE_DEFER will
cause it to fail to register that struct device and there is no mechanism
to retry.

Also, your idea above goes against the grain that other resources are
heading - that is, towards probe time resolution of resources.  IRQ
resources have the same problem, and this has caused real problems on
platforms to have the IRQ resources resolved to a number at registration
time.

To me, your idea sounds like the wrong approach and unworkable.

What would resolve that would be to have the device registration succeed,
but also to scan all devices in the system when a PM domain is attached
and attach the PM domain to matching devices.  The problem you then have
is the same race between attaching the PM domain to all devices in the
domain, and devices being probed.  Remember, this may not be happening at
boot time, but during module load, which on some systems is multithreaded.
So, the problem of not having all devices in the PM domain hasn't changed
and nothing is solved by this approach - the only thing is the code has
become more complex.

I don't think that's an improvement.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
