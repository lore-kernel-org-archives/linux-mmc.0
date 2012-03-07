From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Wed, 7 Mar 2012 22:31:17 +0100
Message-ID: <201203072231.18081.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203072151.07432.rjw@sisk.pl> <20120307205439.GM3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60796 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932686Ab2CGV1P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 16:27:15 -0500
In-Reply-To: <20120307205439.GM3107@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Wednesday, March 07, 2012, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 09:51:07PM +0100, Rafael J. Wysocki wrote:
> 
> > That would be fine, but it doesn't _conflict_ with a more direct (so to
> > speak) knob in sysfs, does it?
> 
> Well, perhaps - one of the issues I remember from last time we discussed
> this was that there's a tension between the embedded space where the
> idea of userspace charging around and playing with low level parameters
> to make things hang together is scary and the PC space where the kernel
> just isn't going to be able to cope with everyone's systems reliably as
> it's got too little information about the hardware.

Definitely, on the PC side we would like user space to have access to
low-level settings.

Anyway, I suggest that we wait a bit until I post updated patches and then
you'll tell me why they are wrong, OK?

Rafael
