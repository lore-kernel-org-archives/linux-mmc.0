From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] MMC: mmci: Add required documentation for Device Tree bindings
Date: Thu, 15 Mar 2012 17:49:07 +0000
Message-ID: <201203151749.07673.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-6-git-send-email-lee.jones@linaro.org> <20120315173508.GE15988@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031939Ab2CORtZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:49:25 -0400
In-Reply-To: <20120315173508.GE15988@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> 
> On Wed, Mar 14, 2012 at 02:20:03PM +0000, Lee Jones wrote:
> > +ux500 variant specific properties:
> > +- gpio-en                : contains the level-shifter enable gpio
> > +- gpio-vsel              : contains the level-shifter voltage select gpio
> > +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> > +- rx_src_dev_type        : contains the rx source device (DMA)
> 
> So what about the DMA support being proposed elsewhere?
> 
> This sounds like we're inventing one DMA solution for one bit of the tree
> and another DMA solution for another bit.  This is madness.

Agreed. I originally made a similar comment for an early version but had not
noticed that it made it into this one. This should be using the proper DMA
bindings, or just auxdata while we're not entirely there yet.

	Arnd
