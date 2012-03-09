From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/10 v3] mmc: tmio/sdhi: hotplug & PM
Date: Thu, 08 Mar 2012 23:17:12 -0500
Message-ID: <m2obs6qugn.fsf@bob.laptop.org>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35722 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754276Ab2CIERS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 23:17:18 -0500
In-Reply-To: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Thu, 9 Feb 2012 22:57:06 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Thu, Feb 09 2012, Guennadi Liakhovetski wrote:
> This is v3 of a patch series, that uses the recently committed generic 
> GPIO card hotplug handler, fixes minor PM issues, adds some cosmetic 
> clean up. The series applies on top of mmc-next of 09 Feb. 2012.
>
> Guennadi Liakhovetski (10):
>   mmc: simplify mmc_cd_gpio_request() by removing two parameters
>   mmc: tmio: calculate the native hotplug condition only once
>   mmc: tmio_mmc: support the generic MMC GPIO card hotplug helper
>   mmc: sh_mobile_sdhi: pass card hotplug GPIO number to TMIO MMC
>   ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
>     hotplug helper
>   ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO
>     hotplug helper
>   mmc: tmio_mmc: power status flag doesn't have to be exposed in
>     platform data
>   mmc: tmio_mmc: remove unused sdio_irq_enabled flag
3C>   mmc: sh_mobile_sdhi: do not manage PM clocks manually
>   mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function

Looks like you didn't get any ACKs for these, and the ARM patches no
longer apply -- would you like me to take all but the two ARM patches
and leave those to you?  (Does that result in working systems?)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
