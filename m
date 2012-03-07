From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Wed, 7 Mar 2012 10:05:54 +0100
Message-ID: <201203071005.54890.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203062214.53988.rjw@sisk.pl> <4F571CC9.7050609@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59529 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2CGJBt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 04:01:49 -0500
In-Reply-To: <4F571CC9.7050609@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Wednesday, March 07, 2012, Adrian Hunter wrote:
> On 06/03/12 23:14, Rafael J. Wysocki wrote:
> > On Tuesday, March 06, 2012, Guennadi Liakhovetski wrote:
> >> On Tue, 6 Mar 2012, Adrian Hunter wrote:
> >>
> >>> On 04/03/12 02:01, Rafael J. Wysocki wrote:
> >>>> Hi all,
> >>>>
> >>>> The goal of this patchset is to allow user space to control the
> >>>> responsiveness of the MMC stack related to runtime power management.
> >>>
> >>> I wonder why this is build into mmc and not just a generic runtime pm
> >>> facility. e.g.
> > 
> > Because of the user space interface (it doesn't necessarily make sense
> > for all devices) and to allow drivers to opt-in (if they don't, the interface
> > won't be created), which is not possible at the core level (we don't know in
> > advance what drivers will handle the given devices and if they will support
> > PM QoS).
> 
> Even "opt-in" is undesirable, because it is really up to userspace not the
> driver.
> 
> > 
> >>> 	/* Set maximum resume latency target to 100ms */
> >>> 	pm_runtime_set_max_latency(dev, 100);
> >>>
> >>> And then runtime pm will create sysfs attributes etc
> >>
> >> +1. Having to do essentially exactly the same for each driver subsystem 
> >> seems counterproductive.
> > 
> > Other subsystems need not do that in the same way.
> 
> Maybe this needs to be re-thought.  Userspace needs a simple, consistent and
> understandable set of pm controls across the entire kernel, not piecemeal
> across different subsystems.

Well, that's my opinion too, but other people don't seem to agree with it.

Thanks,
Rafael
