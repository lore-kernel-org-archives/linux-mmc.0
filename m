From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/12] mmc: omap: add DMA engine support
Date: Mon, 30 Apr 2012 08:59:38 -0700
Message-ID: <20120430155937.GB3739@atomide.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
 <20120424001330.GD3739@atomide.com>
 <20120428163716.GI28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2D3QAE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Apr 2012 12:00:04 -0400
Content-Disposition: inline
In-Reply-To: <20120428163716.GI28062@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120428 09:40]:
> On Mon, Apr 23, 2012 at 05:13:30PM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:11]:
> > > Add DMA engine support to the OMAP driver.  This supplements the
> > > private DMA API implementation contained within this driver, and the
> > > driver can be switched at build time between using DMA engine and the
> > > private DMA API.
> > 
> > Below is what's needed to use DMA request lines from platform data.
> > Note also the release_mem_region change that we'll now need for
> > this one also (but not as a fix).
> > 
> > I've posted a cleanup patch series to mostly remove plat-omap/devices.c
> > that takes care of passing the DMA request lines in platform data.
> > That series should get merged before the driver changes for this
> > driver to keep DMA working.
> 
> Okay, how do we want to handle this patch?  I don't think there's any
> urgency for this patch at the present time, so I'm quite happy for this
> to be delayed after the next merge window after we have the pre-requisits
> for it in place.  (And trying to get it in earlier is only going to give
> us git tree dependencies to deal with.)

Sounds good to me.

Regards,

Tony
