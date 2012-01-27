From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/7 v2] dmaengine: add a simple dma library
Date: Fri, 27 Jan 2012 09:48:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201270946150.32661@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de> <4F22624E.2090201@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4F22624E.2090201@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-san

On Fri, 27 Jan 2012, Shimoda, Yoshihiro wrote:

> Hello Guennadi-san,
> 
> 2012/01/26 23:56, Guennadi Liakhovetski wrote:
> > This patch adds a library of functions, helping to implement dmaengine
> > drivers for hardware, unable to handle scatter-gather lists natively.
> > The first version of this driver only supports memcpy and slave DMA
> > operation.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > v2:
> > 
> > 1. switch from using a tasklet to threaded IRQ, which allowed to
> 
> I tested this driver on 2 environment, but it could not work correctly.
>  - renesas_usbhs driver with shdma driver on the mackerel board
>  - renesas_usbhs driver with experimental SUDMAC driver
> 
> In this case, should we modify the renesas_usbhs driver?

Yes, you do. Please, see the respective version of the shdma patch. It 
doesn't request channel IRQs any more directly, instead, it uses a 
dma-simple wrapper function. Also operations change a bit.

Thanks
Guennadi

> For reference, if I changed the threaded IRQ to tasklet,
> the 2 environment worked correctly:
> ==============
> diff --git a/drivers/dma/dma-simple.c b/drivers/dma/dma-simple.c
> index 49d8f7d..65a5170 100644
> --- a/drivers/dma/dma-simple.c
> +++ b/drivers/dma/dma-simple.c
> @@ -715,16 +715,18 @@ static irqreturn_t chan_irq(int irq, void *dev)
> 
>  	spin_lock(&schan->chan_lock);
> 
> -	ret = ops->chan_irq(schan, irq) ? IRQ_WAKE_THREAD : IRQ_NONE;
> +	ret = ops->chan_irq(schan, irq) ? IRQ_HANDLED : IRQ_NONE;
> +	if (ret == IRQ_HANDLED)
> +		tasklet_schedule(&schan->tasklet);
> 
>  	spin_unlock(&schan->chan_lock);
> 
>  	return ret;
>  }
> 
> -static irqreturn_t chan_irqt(int irq, void *dev)
> +static void chan_irqt(unsigned long dev)
>  {
> -	struct dma_simple_chan *schan = dev;
> +	struct dma_simple_chan *schan = (struct dma_simple_chan *)dev;
>  	const struct dma_simple_ops *ops =
>  		to_simple_dev(schan->dma_chan.device)->ops;
>  	struct dma_simple_desc *sdesc;
> @@ -744,15 +746,13 @@ static irqreturn_t chan_irqt(int irq, void *dev)
>  	spin_unlock_irq(&schan->chan_lock);
> 
>  	simple_chan_ld_cleanup(schan, false);
> -
> -	return IRQ_HANDLED;
>  }
> 
>  int dma_simple_request_irq(struct dma_simple_chan *schan, int irq,
>  			   unsigned long flags, const char *name)
>  {
> -	int ret = request_threaded_irq(irq, chan_irq, chan_irqt,
> -				       flags, name, schan);
> +	int ret = request_irq(irq, chan_irq, flags, name, schan);
> +	tasklet_init(&schan->tasklet, chan_irqt, (unsigned long)schan);
> 
>  	schan->irq = ret < 0 ? ret : irq;
> 
> diff --git a/include/linux/dma-simple.h b/include/linux/dma-simple.h
> index 5336674..beb1489 100644
> --- a/include/linux/dma-simple.h
> +++ b/include/linux/dma-simple.h
> @@ -68,6 +68,7 @@ struct dma_simple_chan {
>  	int id;				/* Raw id of this channel */
>  	int irq;			/* Channel IRQ */
>  	enum dma_simple_pm_state pm_state;
> +	struct tasklet_struct tasklet;
>  };
> 
>  /**
> ==============
> 
> Best regards,
> Yoshihiro Shimoda
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
