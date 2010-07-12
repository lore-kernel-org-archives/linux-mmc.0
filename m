From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/3] sdhci-s3c: add missing remove function
Date: Mon, 12 Jul 2010 13:04:09 +0200
Message-ID: <000201cb21b1$fc69c7f0$f53d57d0$%szyprowski@samsung.com>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
 <1276670996-17729-2-git-send-email-m.szyprowski@samsung.com>
 <20100709142617.50892f8b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53644 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0GLLFj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jul 2010 07:05:39 -0400
In-reply-to: <20100709142617.50892f8b.akpm@linux-foundation.org>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: kgene.kim@samsung.com, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

Hello,

On Friday, July 09, 2010 11:26 PM Andrew Morton wrote:

> On Wed, 16 Jun 2010 08:49:54 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-s3c.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index af21792..ad30f07 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -365,6 +365,26 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> >
> >  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
> >  {
> > +	struct sdhci_host *host =  platform_get_drvdata(pdev);
> > +	struct sdhci_s3c *sc = sdhci_priv(host);
> > +	int ptr;
> > +
> > +	sdhci_remove_host(host, 1);
> > +
> > +	for (ptr = 0; ptr < 3; ptr++) {
> > +		clk_disable(sc->clk_bus[ptr]);
> > +		clk_put(sc->clk_bus[ptr]);
> > +	}
> > +	clk_disable(sc->clk_io);
> > +	clk_put(sc->clk_io);
> > +
> > +	iounmap(host->ioaddr);
> > +	release_resource(sc->ioarea);
> > +	kfree(sc->ioarea);
> > +
> > +	sdhci_free_host(host);
> > +	platform_set_drvdata(pdev, NULL);
> > +
> >  	return 0;
> >  }
> 
> This looks like it fixes a pretty serious omission.  What happens if
> the user rmmods this driver on a 2.6.34 kernel?

System will crash sooner or later once the memory with the code of the
s3c-sdhci.ko module is reused for something else. I really have no idea
how the lack of remove function went unnoticed into the mainline code.
 
> Because I have a suspicion that this fix should be backported into
> 2.6.34.x?

Right, this is really a good idea. This patch applies cleanly onto
v2.6.34 too.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

