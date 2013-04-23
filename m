From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/6] at_hdmac: move to generic DMA binding
Date: Tue, 23 Apr 2013 09:14:07 +0530
Message-ID: <20130423034407.GY24632@intel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-2-git-send-email-ludovic.desroches@atmel.com>
 <51750F68.4040701@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51750F68.4040701-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 22, 2013 at 12:22:32PM +0200, Nicolas Ferre wrote:
> On 04/19/2013 11:11 AM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> > From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> > +#ifdef CONFIG_OF
> > +static bool at_dma_filter(struct dma_chan *chan, void *slave)
this is not defined for else case here. Also this could be CONFIG_DMA_OF...?
> > +{
> > +	struct at_dma_slave *atslave = slave;
> > +
> > +	if (atslave->dma_dev == chan->device->dev) {
> > +		chan->private = atslave;
> > +		return true;
> > +	} else {
> > +		return false;
> > +	}
> > +}

--
~Vinod
