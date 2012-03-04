From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Sun, 4 Mar 2012 20:53:19 +0100
Message-ID: <201203042053.19314.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54398 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336Ab2CDTxJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Mar 2012 14:53:09 -0500
In-Reply-To: <201203040101.53177.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

Hi all,

On Sunday, March 04, 2012, Rafael J. Wysocki wrote:
> Hi all,
> 
> The goal of this patchset is to allow user space to control the
> responsiveness of the MMC stack related to runtime power management.
> 
> Namely, on systems that contain power domains, the time necessary
> to bring an MMC host up after it has been runtime-suspended may
> depend not only on the MMC core and host driver, but also on the platform
> and other devices in the same power domain(s) that contain(s) the MMC
> host.  Although that obviously may influence the MMC performance,
> currently, there is no way to control it through the MMC subsystem.
> Moreover, the only available way to control it at all is by using PM QoS
> latency requests, so it is necessary to add some kind of support for that
> to MMC.
> 
> Patch [1/3] adds PM QoS-related fields to struct mmc_host and introduces
> a new sysfs attribute for MMC hosts, pm_latency_limit_ms, allowing user
> space to influence the MMC host's runtime PM via PM QoS.  Whether or not
> this attribute will be created (and PM QoS will be used for the given host)
> depends on the host driver, so host drivers that don't (plan) to support
> PM QoS don't need to do anything about that.
> 
> Patches [2/3] and [3/3] add the corresponding host driver bits to the
> tmio_mmc and sh_mmcif drivers, respectively.

After posting the patches I noticed that the changelog of patch [1/3] and
the documentation of the new sysfs attribute were not 100% accurate, because
the PM QoS request really applies to the time between a resume request and
the moment the device is operational again and not the time from runtime
suspend (the latter would imply some kind of autoresume mechanism, which isn't
there).

I also thought it would be cleaner to allocate the val and attr fields along
with the request, because in the previous version of the patchset they weren't
used when req was NULL, resulting in (a little) wasted memory.

Updated patches follow.

Thanks,
Rafael
