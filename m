From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 06/12] mmc: sdhci-of-at91: use sdhci_pltfm_init for
 private allocation
Date: Wed, 6 Jan 2016 11:11:55 +0100
Message-ID: <20160106101155.GI2334@odux.rfo.atmel.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
 <1452052565-4232-7-git-send-email-jszhang@marvell.com>
 <20160106090215.GG2334@odux.rfo.atmel.com>
 <20160106172248.7ab58050@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160106172248.7ab58050@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org, arnd@arndb.de, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 06, 2016 at 05:22:48PM +0800, Jisheng Zhang wrote:
> Dear Ludovic,
> 
> On Wed, 6 Jan 2016 10:02:15 +0100 Ludovic Desroches wrote:
> 
> > Hi Jisheng,
> > 
> > Thanks for your patch but it needs to be updated since it breaks this
> > driver.
> > 
> > -       struct sdhci_at91_priv  *priv = pltfm_host->priv;
> > +       struct sdhci_at91_priv  *priv = sdhci_pltfm_priv(pltfm_host);
> > 
> > is missing in sdhci_at91_runtime_suspend and sdhci_at91_runtime_resume
> > causing a NULL pointer dereference.
> 
> My code base is 4.4-rc8.
> I didn't see sdhci_at91_runtime_suspend and sdhci_at91_runtime_resume
> functions in the sdhci-of-at91.c. Seems the at91 runtime pm support
> is newly added and intends for 4.5.
> 
> So the question is which code base should I use? 

I did the test on next-20151222 since next-20160104 is broken for many
ARM SoC.

> 
> Hi Ulf,
> 
> could you please give some suggestions?
> 
> Thanks in advance,
> Jisheng
> 
> > 
> > On Wed, Jan 06, 2016 at 11:55:59AM +0800, Jisheng Zhang wrote:
> > > Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> > > allows users of sdhci_pltfm to allocate private space in calls to
> > > sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
> > > sdhci-of-at91 driver to this allocation.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/mmc/host/sdhci-of-at91.c | 21 ++++++++-------------
> > >  1 file changed, 8 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > > index 06d0b50..765eb09 100644
> > > --- a/drivers/mmc/host/sdhci-of-at91.c
> > > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > > @@ -68,11 +68,13 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> > >  		return -EINVAL;
> > >  	soc_data = match->data;
> > >  
> > > -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > -	if (!priv) {
> > > -		dev_err(&pdev->dev, "unable to allocate private data\n");
> > > -		return -ENOMEM;
> > > -	}
> > > +	host = sdhci_pltfm_init(pdev, soc_data,
> > > +				sizeof(*priv));  
> > 
> > Can be on the same line.
> 
> Great! will do in v3.
> 
> > 
> > Regards
> > 
> > Ludovic
> > 
> > > +	if (IS_ERR(host))
> > > +		return PTR_ERR(host);
> > > +
> > > +	pltfm_host = sdhci_priv(host);
> > > +	priv = sdhci_pltfm_priv(pltfm_host);
> > >  
> > >  	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
> > >  	if (IS_ERR(priv->mainck)) {
> > > @@ -92,10 +94,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> > >  		return PTR_ERR(priv->gck);
> > >  	}
> > >  
> > > -	host = sdhci_pltfm_init(pdev, soc_data, 0);
> > > -	if (IS_ERR(host))
> > > -		return PTR_ERR(host);
> > > -
> > >  	/*
> > >  	 * The mult clock is provided by as a generated clock by the PMC
> > >  	 * controller. In order to set the rate of gck, we have to get the
> > > @@ -135,9 +133,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> > >  	clk_prepare_enable(priv->mainck);
> > >  	clk_prepare_enable(priv->gck);
> > >  
> > > -	pltfm_host = sdhci_priv(host);
> > > -	pltfm_host->priv = priv;
> > > -
> > >  	ret = mmc_of_parse(host->mmc);
> > >  	if (ret)
> > >  		goto clocks_disable_unprepare;
> > > @@ -163,7 +158,7 @@ static int sdhci_at91_remove(struct platform_device *pdev)
> > >  {
> > >  	struct sdhci_host	*host = platform_get_drvdata(pdev);
> > >  	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
> > > -	struct sdhci_at91_priv	*priv = pltfm_host->priv;
> > > +	struct sdhci_at91_priv	*priv = sdhci_pltfm_priv(pltfm_host);
> > >  
> > >  	sdhci_pltfm_unregister(pdev);
> > >  
> > > -- 
> > > 2.7.0.rc3
> > >   
> 
