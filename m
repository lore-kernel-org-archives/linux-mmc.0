From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Wed, 7 Mar 2012 10:05:25 +0100
Message-ID: <201203071005.25257.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203062247.21596.rjw@sisk.pl> <4F570913.8030805@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59513 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab2CGJBT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 04:01:19 -0500
In-Reply-To: <4F570913.8030805@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Wednesday, March 07, 2012, Adrian Hunter wrote:
> On 06/03/12 23:47, Rafael J. Wysocki wrote:
> > On Tuesday, March 06, 2012, Adrian Hunter wrote:
> >> On 04/03/12 02:01, Rafael J. Wysocki wrote:
> >>> Hi all,
> >>>
> >>> The goal of this patchset is to allow user space to control the
> >>> responsiveness of the MMC stack related to runtime power management.
> >>
> >> I wonder why this is build into mmc and not just a generic runtime pm
> >> facility. e.g.
> >>
> >> 	/* Set maximum resume latency target to 100ms */
> >> 	pm_runtime_set_max_latency(dev, 100);
> > 
> > That actually is
> > 
> >  	dev_pm_qos_add_request(dev, req, 100);
> > 
> > where req is used as a handle for your request (it may be used, for
> > example, to remove the request or update it).
> > 
> >> And then runtime pm will create sysfs attributes etc
> > 
> > Well, there may be an interface for drivers analogous to
> > device_wakeup_enable()/device_wakeup_disable() allowing them
> > to add/remove a sysfs attribute for user space to control
> > a single PM QoS constraint.  That even sounds like a good idea. :-)
> 
> Does that mean you are going to change your patch?

Yes, it does.

Thanks,
Rafael
