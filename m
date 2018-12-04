From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: Add using external dma
Date: Tue, 4 Dec 2018 11:01:03 +0800
Message-ID: <CAAfSe-vAprG+L7hyrytPYJtqf7Q0zR9-v+=fdCy6XXgCLzPNGQ@mail.gmail.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-3-git-send-email-zhang.chunyan@linaro.org> <8c54a77e-564d-40fc-32fe-eb4cee0181f1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c54a77e-564d-40fc-32fe-eb4cee0181f1@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: faiz_abbas@ti.com
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, kishon@ti.com, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Faiz,

Thanks for the review and test!

On Mon, 3 Dec 2018 at 21:47, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Chunyan,
>
> On 12/11/18 12:56 PM, Chunyan Zhang wrote:
> > sdhci-omap can support both external dma controller via dmaengine framework
> > as well as ADMA which standard SD host controller provides.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-omap.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> > index 88347ce..ccc79f2 100644
> > --- a/drivers/mmc/host/sdhci-omap.c
> > +++ b/drivers/mmc/host/sdhci-omap.c
> > @@ -896,6 +896,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       const struct of_device_id *match;
> >       struct sdhci_omap_data *data;
> >       const struct soc_device_attribute *soc;
> > +     struct resource *regs;
> >
> >       match = of_match_device(omap_sdhci_match, dev);
> >       if (!match)
> > @@ -908,6 +909,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       }
> >       offset = data->offset;
> >
> > +     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!regs)
> > +             return -ENXIO;
> > +
> >       host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
> >                               sizeof(*omap_host));
> >       if (IS_ERR(host)) {
> > @@ -924,6 +929,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       omap_host->timing = MMC_TIMING_LEGACY;
> >       omap_host->flags = data->flags;
> >       host->ioaddr += offset;
> > +     host->mapbase = regs->start;
> >
> >       mmc = host->mmc;
> >       sdhci_get_of_property(pdev);
> > @@ -991,6 +997,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
> >       host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
> >
> > +     sdhci_switch_external_dma(host, true);
>
> You should give the user a choice based on a dt property whether to use
> ADMA or use external DMA. We might still want to use external DMA for
> some platforms and ADMA for other platforms.

With the current patchset, if users want to use external DMA, they
need to add 'dmas' in device tree, like patch 3 shows:
+ dmas = <&sdma 61 &sdma 62>;
+ dma-names = "tx", "rx";
Otherwise, sdhci.c will switch back to use the DMA/PIO integrated in
standard SDHCI.

But I think your suggestion makes sense, will add the below graph in
next version:

+ /* Switch to external DMA only if there is the "dmas" property */
+ if (of_find_property(dev->of_node, "dmas", NULL))
+         sdhci_switch_external_dma(host, true);

Thanks,
Chunyan
