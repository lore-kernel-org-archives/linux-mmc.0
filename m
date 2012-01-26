From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [alsa-devel] [PATCH 1/7 v2] dmaengine: add a simple dma library
Date: Thu, 26 Jan 2012 22:07:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201262206530.10057@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de>
 <20120126173444.GM5446@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53795 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2AZVI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2012 16:08:28 -0500
In-Reply-To: <20120126173444.GM5446@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

Hi Sascha

On Thu, 26 Jan 2012, Sascha Hauer wrote:

> Hi Guennadi,
> 
> On Thu, Jan 26, 2012 at 03:56:18PM +0100, Guennadi Liakhovetski wrote:
> > This patch adds a library of functions, helping to implement dmaengine
> > drivers for hardware, unable to handle scatter-gather lists natively.
> > The first version of this driver only supports memcpy and slave DMA
> > operation.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> 
> [...]
> 
> > +
> > +/*
> > + * For slave DMA we assume, that there is a finite number of DMA slaves in the
> > + * system, and that each such slave can only use a finite number of channels.
> > + * We use slave channel IDs to make sure, that no such slave channel ID is
> > + * allocated more than once.
> > + */
> > +static unsigned int slave_num = 256;
> > +module_param(slave_num, uint, 0444);
> > +
> > +/* A bitmask with slave_num bits */
> > +static unsigned long *simple_slave_used;
> 
> You never check that the slave ids passed into this code are
> within the range of slave_num. Given that this is a user changeable
> value this is a bit flawy.

Right, never trust the user;-) I'll fix that.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
