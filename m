From: Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Date: Thu, 31 Jan 2019 09:20:06 +0100
Message-ID: <20190131092006.363d1dd4@erd987>
References: <20190128144119.10092-1-martink@posteo.de>
        <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Martin Kepplinger <martink@posteo.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 28 Jan 2019 22:15:23 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:
> >
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >
> > This adds support for explicitly switching the mmc's power on and off
> > which is needed for example for WL1837 WL1271 wifi controllers on imx28.
> >
> > While the wifi's vmmc-supply regulator can be configured in devicetree,
> > "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> > to hangs when loading firmware, for example.
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> >
> >
> > revision history
> > ----------------
> > v4: re-added forgotten regulator_enable() during probe
> > v3: improve API usage as suggested by Ulf
> > v2: tested patch with changes suggested by Robin
> > v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
> >
> >
> >  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > index add1e70195ea..23d275269d61 100644
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >         else
> >                 host->bus_width = 0;
> >
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_OFF:
> > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > +                       mmc_regulator_set_ocr(host->mmc,
> > +                                             host->mmc->supply.vmmc, 0);
> > +               break;
> > +       case MMC_POWER_UP:
> > +               if (!IS_ERR(host->mmc->supply.vmmc))
> > +                       mmc_regulator_set_ocr(host->mmc,
> > +                                             host->mmc->supply.vmmc,
> > +                                             ios->vdd);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> >         if (ios->clock)
> >                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
> >  }
> > @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> >         struct mmc_host *mmc;
> >         struct resource *iores;
> >         int ret = 0, irq_err;
> > -       struct regulator *reg_vmmc;
> >         struct mxs_ssp *ssp;
> >
> >         irq_err = platform_get_irq(pdev, 0);
> > @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> >         host->mmc = mmc;
> >         host->sdio_irq_en = 0;
> >
> > -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> > -       if (!IS_ERR(reg_vmmc)) {
> > -               ret = regulator_enable(reg_vmmc);
> > -               if (ret) {
> > -                       dev_err(&pdev->dev,
> > -                               "Failed to enable vmmc regulator: %d\n", ret);
> > -                       goto out_mmc_free;
> > -               }
> > +       ret = mmc_regulator_get_supply(mmc);
> > +       if (ret == -EPROBE_DEFER)
> > +               goto out_mmc_free;
> > +
> > +       ret = regulator_enable(mmc->supply.vmmc);  
> 
> This is wrong, as it may cause the regulator usage count to become
> wrongly balanced.
> 
> Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
> take care of enabling and disabling the regulator depending of the
> requested vdd voltage level.
> 
> > +       if (ret) {
> > +               dev_err(&pdev->dev,
> > +                       "Failed to enable vmmc regulator: %d\n", ret);
> > +               goto out_mmc_free;
> >         }
> >
> >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > --
> > 2.20.1
> >  
> 
> BTW, you didn't really answer my earlier question about the TI WiFi
> chip. Doesn't you need a special clock for WiFi chip as well? How do
> you intend to manage that?

I used an external 32K oscillator (SLOW_CLK) for my wl1271. Other
clocks ware generated on the module.

I had to supply a 'vmmc-supply' in your wl1271 devicetree node,
which will be used to power on/off the wlan module. The supply should
be a (delayed) GPIO controlled 'fixed-regulator' attached to the
wlan_en pin on the module.

1: Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt

Kind regards,

-- 
Robin van der Gracht
Protonic Holland
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag
