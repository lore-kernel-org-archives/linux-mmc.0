From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap_hsmmc: SDIO IRQ on AM335x family
Date: Fri, 30 Nov 2012 09:40:22 -0800
Message-ID: <20121130174022.GM5312@atomide.com>
References: <20121130111847.GA24674@blumentopf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26482 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933531Ab2K3Rk0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Nov 2012 12:40:26 -0500
Content-Disposition: inline
In-Reply-To: <20121130111847.GA24674@blumentopf>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Daniel Mack <daniel@zonque.org>

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [121130 03:21]:
> 
> The alternative was to configure dat1 line as a GPIO, while
> waiting for an IRQ. Then configuring it back as dat1 when the
> SDIO card is signalling an IRQ. Or the host starts a transfer. I
> guess this will perform poorly, hence not considering it really.

This might work for SDIO cards. It should be disabled for data
cards naturally to avoid potential data corruption.

The way to implement this is set named states in the .dts file
for the pins using pinctrl-single.c, then have the MMC driver
request states "default" "active" and "idle" during the probe,
then toggle between active and idle during the runtime.

As far as I remember the GPIO functionality does not need to
be enabled, just muxing the pin to GPIO mode for the wake-up
is enough.

Regards,

Tony
