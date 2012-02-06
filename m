From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 6/7 v2] ASoC: SIU: prepare for conversion to simple DMA
Date: Mon, 6 Feb 2012 10:11:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202061010300.10363@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-7-git-send-email-g.liakhovetski@gmx.de>
 <1328495625.26182.55.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58461 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab2BFJLf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 04:11:35 -0500
In-Reply-To: <1328495625.26182.55.camel@vkoul-udesk3>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Hi Vinod

On Mon, 6 Feb 2012, Vinod Koul wrote:

> On Thu, 2012-01-26 at 15:56 +0100, Guennadi Liakhovetski wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  sound/soc/sh/siu_pcm.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
> > index 0193e59..414bb35 100644
> > --- a/sound/soc/sh/siu_pcm.c
> > +++ b/sound/soc/sh/siu_pcm.c
> > @@ -330,12 +330,12 @@ static bool filter(struct dma_chan *chan, void *slave)
> >  {
> >  	struct sh_dmae_slave *param = slave;
> >  
> > -	pr_debug("%s: slave ID %d\n", __func__, param->slave_id);
> > +	pr_debug("%s: slave ID %d\n", __func__, param->simple_slave.slave_id);
> >  
> >  	if (unlikely(param->dma_dev != chan->device->dev))
> >  		return false;
> >  
> > -	chan->private = param;
> > +	chan->private = &param->simple_slave;
> While at it, Can you fix the sh-mobile driver to NOT use chan->private?

This is an independent change and for it I need my recent RFC PATCH 
"[PATCH/RFC] dmaengine: add a slave parameter to __dma_request_channel()"

http://marc.info/?l=linux-kernel&m=132811019930675&w=2

Thanks
Guennadi

> >  	return true;
> >  }
> >  
> > @@ -360,12 +360,12 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
> >  	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  		siu_stream = &port_info->playback;
> >  		param = &siu_stream->param;
> > -		param->slave_id = port ? pdata->dma_slave_tx_b :
> > +		param->simple_slave.slave_id = port ? pdata->dma_slave_tx_b :
> >  			pdata->dma_slave_tx_a;
> >  	} else {
> >  		siu_stream = &port_info->capture;
> >  		param = &siu_stream->param;
> > -		param->slave_id = port ? pdata->dma_slave_rx_b :
> > +		param->simple_slave.slave_id = port ? pdata->dma_slave_rx_b :
> >  			pdata->dma_slave_rx_a;
> >  	}
> >  
> 
> 
> -- 
> ~Vinod
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
