From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Tue, 13 Mar 2012 01:02:59 +0100
Message-ID: <201203130102.59390.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203090001.06683.rjw@sisk.pl> <CACRpkdYo65VhM+ZAHLy=xQyQqTMnkExAE3WuTre1gH7ye9Q-DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40528 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2CLX6t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Mar 2012 19:58:49 -0400
In-Reply-To: <CACRpkdYo65VhM+ZAHLy=xQyQqTMnkExAE3WuTre1gH7ye9Q-DQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

On Monday, March 12, 2012, Linus Walleij wrote:
> On Fri, Mar 9, 2012 at 12:01 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > A runtime suspend of a device (e.g. an MMC controller) belonging to
> > a power domain or, in a more complicated scenario, a runtime suspend
> > of another device in the same power domain, may cause power to be
> > removed from the entire domain.  In that case, the amount of time
> > necessary to runtime-resume the given device (e.g. the MMC
> > controller) is often substantially greater than the time needed to
> > run its driver's runtime resume callback.  That may hurt performance
> > in some situations, because user data may need to wait for the
> > device to become operational, so we should make it possible to
> > prevent that from happening.
> >
> > For this reason, introduce a new sysfs attribute for devices,
> > power/pm_qos_resume_latency_us, allowing user space to specify the
> > upper bound of the time necessary to bring the (runtime-suspended)
> > device up after the resume of it has been requested.  However, make
> > that attribute appear only for the devices whose drivers declare
> > support for it by calling the (new) dev_pm_qos_expose_latency_limit()
> > helper function with the appropriate initial value of the attribute.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Rafael
