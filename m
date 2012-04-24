From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 3/8] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
Date: Tue, 24 Apr 2012 16:05:29 +0530
Message-ID: <4F9681F1.2090408@nvidia.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 18 April 2012 03:41 PM, Russell King wrote:
> +/**
> + * vchan_cookie_complete - report completion of a descriptor
> + * vd: virtual descriptor to update
> + *
> + * vc.lock must be held by caller
> + */
> +static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
> +{
> +       struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> +
> +       dma_cookie_complete(&vd->tx);
> +       dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> +               vd, vd->tx.cookie);
> +       list_add_tail(&vd->node,&vc->desc_completed);
> +
> +       tasklet_schedule(&vc->task);
> +}

For cyclic case, we will not like to call the  dma_cookie_complete() but 
want to put the desc in callback list.
So can we have one more arg on this function which byspass the call of 
dma_cookie_complete()
