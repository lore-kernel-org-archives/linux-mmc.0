From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v3 2/4] mmc: sdhci-pxav2: switch to managed clk and
 sdhci_pltfm_unregister()
Date: Tue, 22 Aug 2017 18:13:02 +0800
Message-ID: <20170822181302.28215e03@xhacker>
References: <1502811922-9346-1-git-send-email-yamada.masahiro@socionext.com>
        <1502811922-9346-3-git-send-email-yamada.masahiro@socionext.com>
        <9574e0c7-4ac4-63d3-3cdf-7ca0e27a7a12@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57788 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932317AbdHVKSF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 06:18:05 -0400
In-Reply-To: <9574e0c7-4ac4-63d3-3cdf-7ca0e27a7a12@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>

On Mon, 21 Aug 2017 15:03:42 +0300 Adrian Hunter wrote:

> On 15/08/17 18:45, Masahiro Yamada wrote:
> > The difference between sdhci_pxav2_remove() and sdhci_pltfm_unregister()
> > is clk_put().  It will go away by using the managed resource clk, then
> > sdhci_pltfm_unregister() can be reused.
> > 
> > Also, rename the jump labels to say what the goto does. (Coding style
> > suggested by Documentation/process/coding-style.rst)
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>  
> 
> Cc'ing Jisheng Zhang, but looks ok to me.

I have no platforms with sdhci-pxav2 now.
These patch looks good to me.

> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> > ---
> > 
> > Changes in v3:
> >   - Newly added
> > 
> > Changes in v2: None
> > 
> >  drivers/mmc/host/sdhci-pxav2.c | 30 +++++++-----------------------
> >  1 file changed, 7 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> > index 995083ce1c46..8986f9d9cf98 100644
> > --- a/drivers/mmc/host/sdhci-pxav2.c
> > +++ b/drivers/mmc/host/sdhci-pxav2.c
> > @@ -178,17 +178,17 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
> >  
> >  	pltfm_host = sdhci_priv(host);
> >  
> > -	clk = clk_get(dev, "PXA-SDHCLK");
> > +	clk = devm_clk_get(dev, "PXA-SDHCLK");
> >  	if (IS_ERR(clk)) {
> >  		dev_err(dev, "failed to get io clock\n");
> >  		ret = PTR_ERR(clk);
> > -		goto err_clk_get;
> > +		goto free;
> >  	}
> >  	pltfm_host->clk = clk;
> >  	ret = clk_prepare_enable(clk);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "failed to enable io clock\n");
> > -		goto err_clk_enable;
> > +		goto free;
> >  	}
> >  
> >  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
> > @@ -223,34 +223,18 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
> >  	ret = sdhci_add_host(host);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "failed to add host\n");
> > -		goto err_add_host;
> > +		goto disable_clk;
> >  	}
> >  
> >  	return 0;
> >  
> > -err_add_host:
> > +disable_clk:
> >  	clk_disable_unprepare(clk);
> > -err_clk_enable:
> > -	clk_put(clk);
> > -err_clk_get:
> > +free:
> >  	sdhci_pltfm_free(pdev);
> >  	return ret;
> >  }
> >  
> > -static int sdhci_pxav2_remove(struct platform_device *pdev)
> > -{
> > -	struct sdhci_host *host = platform_get_drvdata(pdev);
> > -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -
> > -	sdhci_remove_host(host, 1);
> > -
> > -	clk_disable_unprepare(pltfm_host->clk);
> > -	clk_put(pltfm_host->clk);
> > -	sdhci_pltfm_free(pdev);
> > -
> > -	return 0;
> > -}
> > -
> >  static struct platform_driver sdhci_pxav2_driver = {
> >  	.driver		= {
> >  		.name	= "sdhci-pxav2",
> > @@ -258,7 +242,7 @@ static struct platform_driver sdhci_pxav2_driver = {
> >  		.pm	= &sdhci_pltfm_pmops,
> >  	},
> >  	.probe		= sdhci_pxav2_probe,
> > -	.remove		= sdhci_pxav2_remove,
> > +	.remove		= sdhci_pltfm_unregister,
> >  };
> >  
> >  module_platform_driver(sdhci_pxav2_driver);
> >   
> 

