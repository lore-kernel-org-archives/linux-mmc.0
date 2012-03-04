From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Sun, 4 Mar 2012 01:01:52 +0100
Message-ID: <201203040101.53177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53888 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833Ab2CDAA5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 3 Mar 2012 19:00:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

Hi all,

The goal of this patchset is to allow user space to control the
responsiveness of the MMC stack related to runtime power management.

Namely, on systems that contain power domains, the time necessary
to bring an MMC host up after it has been runtime-suspended may
depend not only on the MMC core and host driver, but also on the platform
and other devices in the same power domain(s) that contain(s) the MMC
host.  Although that obviously may influence the MMC performance,
currently, there is no way to control it through the MMC subsystem.
Moreover, the only available way to control it at all is by using PM QoS
latency requests, so it is necessary to add some kind of support for that
to MMC.

Patch [1/3] adds PM QoS-related fields to struct mmc_host and introduces
a new sysfs attribute for MMC hosts, pm_latency_limit_ms, allowing user
space to influence the MMC host's runtime PM via PM QoS.  Whether or not
this attribute will be created (and PM QoS will be used for the given host)
depends on the host driver, so host drivers that don't (plan) to support
PM QoS don't need to do anything about that.

Patches [2/3] and [3/3] add the corresponding host driver bits to the
tmio_mmc and sh_mmcif drivers, respectively.

Thanks,
Rafael
