From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter mapping to slave devices
Date: Tue, 01 Dec 2015 11:14:29 +0100
Message-ID: <4013235.sXCFUFy4j4@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com> <7490116.jHcmUxB3Rf@wuerfel> <565D6F5D.3060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56774 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbbLAKPC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 05:15:02 -0500
In-Reply-To: <565D6F5D.3060603@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org

On Tuesday 01 December 2015 11:58:53 Peter Ujfalusi wrote:
> On 11/30/2015 04:11 PM, Arnd Bergmann wrote:
> > On Monday 30 November 2015 15:45:34 Peter Ujfalusi wrote:
> >> @@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
> >>  }
> >>  EXPORT_SYMBOL(edma_filter_fn);
> >>  
> >> +static bool edma_filter_for_map(struct dma_chan *chan, void *param)
> >> +{
> >> +       bool match = false;
> >> +
> >> +       if (chan->device->dev->driver == &edma_driver.driver) {
> >> +               struct edma_chan *echan = to_edma_chan(chan);
> >> +               unsigned ch_req = (unsigned)param;
> >> +               if (ch_req == echan->ch_num) {
> >> +                       /* The channel is going to be used as HW synchronized */
> >> +                       echan->hw_triggered = true;
> >> +                       match = true;
> >> +               }
> >> +       }
> >> +       return match;
> >> +}
> >> +
> >>  static int edma_init(void)
> >>
> > 
> > I don't see the difference between edma_filter_fn and edma_filter_for_map.
> > Why do you need both?
> 
> edma_filter_fn:
>         unsigned ch_req = *(unsigned *)param;
> 
> edma_filter_for_map:
>         unsigned ch_req = (unsigned)param;

I see.

> If I want to reuse the edma_filter_fn, I would need an unsigned array for the
> eDMA event numbers in the board files to be able to provide the pointer to
> each of them.

How about this:

#define EDMA_CTLR_CHANP(ctlr, chan)      ((const int[]){ [0] = ((ctlr) << 16) | (chan)})

static struct dma_filter_map da830_edma_map[] = {
         { "davinci-mcasp.0", "rx", EDMA_CTLR_CHANP(0, 0)},
         { "davinci-mcasp.0", "tx", EDMA_CTLR_CHANP(0, 1)},
         { "davinci-mcasp.1", "rx", EDMA_CTLR_CHANP(0, 2)},
         ...
};

That way, you create an anonymous constant integer expression and the data
points to that.

	Arnd
