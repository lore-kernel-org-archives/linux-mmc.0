From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Date: Fri, 9 Aug 2019 10:08:43 +0200
Message-ID: <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Eugen.Hristev@microchip.com, Nicolas Ferre <Nicolas.Ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 08, 2019 at 05:23:00PM +0200, Ulf Hansson wrote:
> On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
> >
> > From: Eugen Hristev <eugen.hristev@microchip.com>
> >
> > HS200 is not implemented in the driver, but the controller claims it
> > through caps.
> > Remove it via quirk.
> > Without this quirk, the mmc core will try to enable hs200, which will fail,
> > and the eMMC initialization will fail.
> >
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Should this be applied as a fix and possibly tagged for stable?
> 
> In such case, do you have a specific commit that it fixes?

I think so, I would say:
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Cc: stable@vger.kernel.org #v4.4 and later

It doesn't apply on 4.4 but resolution is trivial.

Regards

Ludovic

> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/sdhci-of-at91.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index 57fe3b2..3a8c6d8 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
> >         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> >         pm_runtime_use_autosuspend(&pdev->dev);
> >
> > +       /* HS200 is broken at this moment */
> > +       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> > +
> >         ret = sdhci_add_host(host);
> >         if (ret)
> >                 goto pm_runtime_disable;
> > --
> > 2.7.4
> >
