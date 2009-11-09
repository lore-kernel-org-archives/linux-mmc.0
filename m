From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmci-omap: free irq resource
Date: Mon, 9 Nov 2009 14:27:49 -0800
Message-ID: <20091109142749.0d8f6967.akpm@linux-foundation.org>
References: <20091101115905.GB15144@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57470 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbZKIW2D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2009 17:28:03 -0500
In-Reply-To: <20091101115905.GB15144@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Ladislav.Michl@seznam.cz, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org

On Sun, 1 Nov 2009 12:59:05 +0100
Ladislav.Michl@seznam.cz wrote:

> Free IRQ on remove.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5d773b8..5f970e2 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1529,6 +1529,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
>  		host->pdata->cleanup(&pdev->dev);
>  
>  	mmc_omap_fclk_enable(host, 0);
> +	free_irq(host->irq, host);
>  	clk_put(host->fclk);
>  	clk_disable(host->iclk);
>  	clk_put(host->iclk);

This is a poor changelog.

The reader doesn't know what the implication of the bug is.  I _assume_
that it means that the driver can only be loaded a single time.  That
on a second modprobe, it fails to allocate the interrupt and fails.

In which case this is a fairly serious bug and perhaps the patch should
be backported into the -stable tree.

Or I could be all wrong about all of that.  This is why it's better if
the patch submitter *explains* these things, rather than leaving others
to guess.

