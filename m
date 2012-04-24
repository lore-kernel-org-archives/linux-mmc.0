From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] dmaengine: split out virtual channel DMA support
	from sa11x0 driver
Date: Tue, 24 Apr 2012 11:50:45 +0100
Message-ID: <20120424105045.GD25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk> <4F9681F1.2090408@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F9681F1.2090408@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 24, 2012 at 04:05:29PM +0530, Laxman Dewangan wrote:
> On Wednesday 18 April 2012 03:41 PM, Russell King wrote:
>> +/**
>> + * vchan_cookie_complete - report completion of a descriptor
>> + * vd: virtual descriptor to update
>> + *
>> + * vc.lock must be held by caller
>> + */
>> +static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
>> +{
>> +       struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>> +
>> +       dma_cookie_complete(&vd->tx);
>> +       dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
>> +               vd, vd->tx.cookie);
>> +       list_add_tail(&vd->node,&vc->desc_completed);
>> +
>> +       tasklet_schedule(&vc->task);
>> +}
>
> For cyclic case, we will not like to call the  dma_cookie_complete() but  
> want to put the desc in callback list.
> So can we have one more arg on this function which byspass the call of  
> dma_cookie_complete()

See the discussion on what's supposed to happen with cyclic transfers.
Cyclic transfers don't complete, so adding them to the completed list
and marking them complete is the wrong thing to be doing.  So arguably
calling this function is also the wrong thing to be doing because
you're not completing the transfer.

I'll be addressing the issue of cyclic transfers when I eventually get
to sorting out the OMAP ASoC driver.
