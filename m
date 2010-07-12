From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] sdhci-s3c: add missing remove function
Date: Mon, 12 Jul 2010 16:52:28 -0700
Message-ID: <20100712165228.ea719738.akpm@linux-foundation.org>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
	<1276670996-17729-2-git-send-email-m.szyprowski@samsung.com>
	<20100709142617.50892f8b.akpm@linux-foundation.org>
	<000201cb21b1$fc69c7f0$f53d57d0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40089 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751776Ab0GLXwx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jul 2010 19:52:53 -0400
In-Reply-To: <000201cb21b1$fc69c7f0$f53d57d0$%szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: kgene.kim@samsung.com, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On Mon, 12 Jul 2010 13:04:09 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > >  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
> > >  {
> > > +	struct sdhci_host *host =  platform_get_drvdata(pdev);
> > > +	struct sdhci_s3c *sc = sdhci_priv(host);
> > > +	int ptr;
> > > +
> > > +	sdhci_remove_host(host, 1);
> > > +
> > > +	for (ptr = 0; ptr < 3; ptr++) {
> > > +		clk_disable(sc->clk_bus[ptr]);
> > > +		clk_put(sc->clk_bus[ptr]);
> > > +	}
> > > +	clk_disable(sc->clk_io);
> > > +	clk_put(sc->clk_io);
> > > +
> > > +	iounmap(host->ioaddr);
> > > +	release_resource(sc->ioarea);
> > > +	kfree(sc->ioarea);
> > > +
> > > +	sdhci_free_host(host);
> > > +	platform_set_drvdata(pdev, NULL);
> > > +
> > >  	return 0;
> > >  }
> > 
> > This looks like it fixes a pretty serious omission.  What happens if
> > the user rmmods this driver on a 2.6.34 kernel?
> 
> System will crash sooner or later once the memory with the code of the
> s3c-sdhci.ko module is reused for something else. I really have no idea
> how the lack of remove function went unnoticed into the mainline code.
>  
> > Because I have a suspicion that this fix should be backported into
> > 2.6.34.x?
> 
> Right, this is really a good idea. This patch applies cleanly onto
> v2.6.34 too.

OK, thanks, I added the Cc: <stable@kernel.org> to the changelog and
moved the patch into my for-2.6.35 queue.

