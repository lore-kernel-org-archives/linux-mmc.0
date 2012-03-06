From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency
 constraints
Date: Tue, 6 Mar 2012 14:39:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203061436200.9300@axis700.grange>
References: <201203040101.53177.rjw@sisk.pl> <4F55E73C.10907@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63900 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757800Ab2CFNjv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 08:39:51 -0500
In-Reply-To: <4F55E73C.10907@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Tue, 6 Mar 2012, Adrian Hunter wrote:

> On 04/03/12 02:01, Rafael J. Wysocki wrote:
> > Hi all,
> > 
> > The goal of this patchset is to allow user space to control the
> > responsiveness of the MMC stack related to runtime power management.
> 
> I wonder why this is build into mmc and not just a generic runtime pm
> facility. e.g.
> 
> 	/* Set maximum resume latency target to 100ms */
> 	pm_runtime_set_max_latency(dev, 100);
> 
> And then runtime pm will create sysfs attributes etc

+1. Having to do essentially exactly the same for each driver subsystem 
seems counterproductive.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
