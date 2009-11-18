From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH] mmci-omap: free irq resource
Date: Wed, 18 Nov 2009 20:05:20 +0100
Message-ID: <20091118190520.GA7941@localhost.localdomain>
References: <20091101115905.GB15144@localhost.localdomain> <20091109142749.0d8f6967.akpm@linux-foundation.org>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:33473 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757883AbZKRSF3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Nov 2009 13:05:29 -0500
Content-Disposition: inline
In-Reply-To: <20091109142749.0d8f6967.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org

On Mon, Nov 09, 2009 at 02:27:49PM -0800, Andrew Morton wrote:
> On Sun, 1 Nov 2009 12:59:05 +0100
> Ladislav.Michl@seznam.cz wrote:
> 
> > Free IRQ on remove.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> > index 5d773b8..5f970e2 100644
> > --- a/drivers/mmc/host/omap.c
> > +++ b/drivers/mmc/host/omap.c
> > @@ -1529,6 +1529,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
> >  		host->pdata->cleanup(&pdev->dev);
> >  
> >  	mmc_omap_fclk_enable(host, 0);
> > +	free_irq(host->irq, host);
> >  	clk_put(host->fclk);
> >  	clk_disable(host->iclk);
> >  	clk_put(host->iclk);
> 
> This is a poor changelog.

I'm sorry for that as well as for sending this patch twice. I will do better
next time.

> The reader doesn't know what the implication of the bug is.  I _assume_
> that it means that the driver can only be loaded a single time.  That
> on a second modprobe, it fails to allocate the interrupt and fails.

This is perfectly correct assumption.

> In which case this is a fairly serious bug and perhaps the patch should
> be backported into the -stable tree.

There is no point backporting it as this driver is broken for ages without
single complain.
(details here: http://article.gmane.org/gmane.linux.kernel.mmc/649)

> Or I could be all wrong about all of that.  This is why it's better if
> the patch submitter *explains* these things, rather than leaving others
> to guess.

Best regards,
	ladis
