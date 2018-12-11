From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Date: Tue, 11 Dec 2018 14:42:13 +0000
Message-ID: <20181211144213.GF9507@n2100.armlinux.org.uk>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
 <20181211134937.GE9507@n2100.armlinux.org.uk>
 <1ecb5b44-92a9-cf05-cb5f-eabb1f3b001f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1ecb5b44-92a9-cf05-cb5f-eabb1f3b001f@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 11, 2018 at 04:33:26PM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 11/12/2018 15.49, Russell King - ARM Linux wrote:
> >>> The only thing I can think of doing is adding into omap_hsmmc:
> >>>
> >>>         mmc->max_seg_size = min(mmc->max_req_size,
> >>>                                 min(dma_get_max_seg_size(host->rx_chan->device->dev),
> >>>                                     dma_get_max_seg_size(host->tx_chan->device->dev)));
> >>>
> >>> to limit the maximum segment size to that of the device _and_ dma
> >>> engine's capabilities.
> >>>
> >>> Doing this solves the problem for me.
> >>
> >> Thanks for the suggestion - it sounds like a reasonable way to fix the
> >> problem, at least for now.
> > 
> > I don't think there's any "at least for now" about this approach - it's
> > not something that the MMC core can know about, because whether a driver
> > uses DMA engine or not, and how many channels it uses is completely
> > driver specific.
> 
> I agree.
> 
> > The only questionable thing is around the dma_get_max_seg_size()
> > interface, but the only way that's going to get solved is to eliminate
> > it entirely as it isn't a per-device property with some DMA engines
> > such as omap-dma - it's a per-request property.  That also means
> > killing the check in the DMA debug code, which isn't going to go down
> > very well.
> > 
> >> Do you want to send to patch or do you expect someone else to do it?
> > 
> > I'll send a patch once I've checked the corner cases, and whether
> > we should go further and include other DMA parameters from the
> > dma engine.
> 
> There is one thing which I'm trying to figure out:
> sDMA (and EDMA also) have limitation on the length of each sg segment.
> 
> To make things a bit more interesting the limit is not in bytes, but in
> number of bursts:
> 
> 65535 * burst * addr_width = max_sg_segment_len in bytes.
> 
> We can not set this to a static value as depending on the addr_width and
> burst it can be different for each transfer.

However, it does have to be a static value as it's at device level,
rather than per-channel or per-request.  If it is set dynamically
by a request submission, it could vary wildly depending on the burst
and address width of the last request submitted to DMA engine, and
so the parameter becomes meaningless.

Consider what would happen to the value if we had one channel being
used with burst=32 addr_width=4 and another channel also being used
simultaneously with burst=8 addr_width=1...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
