From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Fri, 9 Mar 2012 21:59:40 +0100
Message-ID: <201203092159.40409.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1203091015290.1527-100000@iolanthe.rowland.org> <87pqcl4s4d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36501 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841Ab2CIUzd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Mar 2012 15:55:33 -0500
In-Reply-To: <87pqcl4s4d.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Friday, March 09, 2012, Kevin Hilman wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> [...]
> 
> > How about calling it "runtime latency"?  Or "runtime wakeup latency" in 
> > case people think there might be some other sort of latency associated 
> > with runtime power management.
> 
> Either is better than just latency, but I would vote for runtime wakeup
> latency.

Well, that would be pm_qos_runtime_wakeup_latency_us.  Kind of long, IMHO.
Apart from this "wakeup" may be thought to refer to "remote wakeup", which
is when a device is resumed as a result of an external signal.

pm_qos_resume_latency_us is shorter and since it is referred to in the
documentation as "resume latency", I don't see any problems with that name.

Thanks,
Rafael
