From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Tue, 6 Mar 2012 22:14:53 +0100
Message-ID: <201203062214.53988.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <4F55E73C.10907@intel.com> <Pine.LNX.4.64.1203061436200.9300@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58562 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031166Ab2CFVKs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Mar 2012 16:10:48 -0500
In-Reply-To: <Pine.LNX.4.64.1203061436200.9300@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Tuesday, March 06, 2012, Guennadi Liakhovetski wrote:
> On Tue, 6 Mar 2012, Adrian Hunter wrote:
> 
> > On 04/03/12 02:01, Rafael J. Wysocki wrote:
> > > Hi all,
> > > 
> > > The goal of this patchset is to allow user space to control the
> > > responsiveness of the MMC stack related to runtime power management.
> > 
> > I wonder why this is build into mmc and not just a generic runtime pm
> > facility. e.g.

Because of the user space interface (it doesn't necessarily make sense
for all devices) and to allow drivers to opt-in (if they don't, the interface
won't be created), which is not possible at the core level (we don't know in
advance what drivers will handle the given devices and if they will support
PM QoS).

> > 	/* Set maximum resume latency target to 100ms */
> > 	pm_runtime_set_max_latency(dev, 100);
> > 
> > And then runtime pm will create sysfs attributes etc
> 
> +1. Having to do essentially exactly the same for each driver subsystem 
> seems counterproductive.

Other subsystems need not do that in the same way.

Thanks,
Rafael
