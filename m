From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] sdhci-s3c: add missing remove function
Date: Fri, 9 Jul 2010 14:26:17 -0700
Message-ID: <20100709142617.50892f8b.akpm@linux-foundation.org>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
	<1276670996-17729-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33910 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753853Ab0GIV0h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jul 2010 17:26:37 -0400
In-Reply-To: <1276670996-17729-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com

On Wed, 16 Jun 2010 08:49:54 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index af21792..ad30f07 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -365,6 +365,26 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  {
> +	struct sdhci_host *host =  platform_get_drvdata(pdev);
> +	struct sdhci_s3c *sc = sdhci_priv(host);
> +	int ptr;
> +
> +	sdhci_remove_host(host, 1);
> +
> +	for (ptr = 0; ptr < 3; ptr++) {
> +		clk_disable(sc->clk_bus[ptr]);
> +		clk_put(sc->clk_bus[ptr]);
> +	}
> +	clk_disable(sc->clk_io);
> +	clk_put(sc->clk_io);
> +
> +	iounmap(host->ioaddr);
> +	release_resource(sc->ioarea);
> +	kfree(sc->ioarea);
> +
> +	sdhci_free_host(host);
> +	platform_set_drvdata(pdev, NULL);
> +
>  	return 0;
>  }

This looks like it fixes a pretty serious omission.  What happens if
the user rmmods this driver on a 2.6.34 kernel?

Because I have a suspicion that this fix should be backported into
2.6.34.x?

