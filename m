From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Enable delay circuit calibration
 clocks
Date: Wed, 23 Aug 2017 10:28:28 -0700
Message-ID: <20170823172828.GA29306@minitux>
References: <20170818175506.5035-1-bjorn.andersson@linaro.org>
 <20170818175506.5035-3-bjorn.andersson@linaro.org>
 <CAPDyKFphMcVfbPUacG-iJEhwT0m6uKXFs6wjgS=YXOK2c_bqEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFphMcVfbPUacG-iJEhwT0m6uKXFs6wjgS=YXOK2c_bqEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Tue 22 Aug 03:45 PDT 2017, Ulf Hansson wrote:

> [...]
> 
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 71e01cbc38b6..7b47906ba447 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -131,7 +131,7 @@ struct sdhci_msm_host {
> >         struct clk *pclk;       /* SDHC peripheral bus clock */
> >         struct clk *bus_clk;    /* SDHC bus voter clock */
> >         struct clk *xo_clk;     /* TCXO clk needed for FLL feature of cm_dll*/
> > -       struct clk_bulk_data bulk_clks[2];
> > +       struct clk_bulk_data bulk_clks[4];
> >         unsigned long clk_rate;
> >         struct mmc_host *mmc;
> >         bool use_14lpp_dll_reset;
> > @@ -1125,6 +1125,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >         struct sdhci_pltfm_host *pltfm_host;
> >         struct sdhci_msm_host *msm_host;
> >         struct resource *core_memres;
> > +       struct clk *clk;
> >         int ret;
> >         u16 host_version, core_minor;
> >         u32 core_version, config;
> > @@ -1194,6 +1195,14 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >         msm_host->bulk_clks[0].clk = msm_host->clk;
> >         msm_host->bulk_clks[1].clk = msm_host->pclk;
> >
> > +       clk = devm_clk_get(&pdev->dev, "cal");
> > +       if (!IS_ERR(clk))
> > +               msm_host->bulk_clks[2].clk = clk;
> > +
> > +       clk = devm_clk_get(&pdev->dev, "sleep");
> > +       if (!IS_ERR(clk))
> > +               msm_host->bulk_clks[3].clk = clk;
> > +
> 
> First, both these clocks needs to be documented in DT doc.
> 

Of course, sorry for missing this part.

> Second, I think you should initialize bulk_clks[2|3] to NULL, in case
> the new optional clocks can't be fetched.
> 

msm_host does come from a kzalloc() in mmc_alloc_host(), but I can write
this differently to not rely on this "fact".

> >         ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> >                                       msm_host->bulk_clks);
> >         if (ret)
> > --
> > 2.12.0
> >
> 
> Another observation is the number of clocks for this device. In some
> cases, now six clocks are needed!? Is that really correct? Just wanted
> to point it out as it seems a bit too much. :-)
> 

* we need "iface" and "core" for normal operation

* "xo" is the base clock of the entire system and is always present,
  question is why its clock rate isn't hard coded in the driver.

* "bus" should probably not be handled directly in the driver, but
  rather through the upcoming "interconnect" framework

* And finally these two new clocks are needed on some HS400-enabled
  platforms, for calibrating the separate (RCLK) clock delay circuit

So I believe the right answer should have been 2 required and 2 optional
clocks.  But we need the interconnect framework and I'll look into why
we need to specify "xo".

Regards,
Bjorn
