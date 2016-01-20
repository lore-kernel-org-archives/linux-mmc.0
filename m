From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Wed, 20 Jan 2016 22:23:51 +0100 (CET)
Message-ID: <892755734.238049.d69bddce-8c03-4cf7-b6d6-f0cbd113f569.open-xchange@email.1und1.de>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
 <569D923D.60306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <569D923D.60306-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


> Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> hat am 19. Januar 2016 um 02:32
> geschrieben:
>
>
> On 01/17/2016 11:59 PM, Stefan Wahren wrote:
> > diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> > index 55bc348..88399eb 100644
> > --- a/drivers/mmc/host/sdhci-iproc.c
> > +++ b/drivers/mmc/host/sdhci-iproc.c
> > @@ -167,7 +167,20 @@ static const struct sdhci_iproc_data iproc_data = {
> > .caps1 = 0x00000064,
> > };
> >
> > +static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
> > + .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
> > + | SDHCI_QUIRK_MISSING_CAPS,
> > + .ops = &sdhci_iproc_ops,
> > +};
> > +
> > +static const struct sdhci_iproc_data bcm2835_data = {
> > + .pdata = &sdhci_bcm2835_pltfm_data,
> > + .caps = SDHCI_CAN_VDD_330,
> > + .caps1 = 0x00000000,
> > +};
> > +
> > static const struct of_device_id sdhci_iproc_of_match[] = {
> > + { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> > { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
> > { }
> > };
> > @@ -180,6 +193,7 @@ static int sdhci_iproc_probe(struct platform_device
> > *pdev)
> > struct sdhci_host *host;
> > struct sdhci_iproc_host *iproc_host;
> > struct sdhci_pltfm_host *pltfm_host;
> > + struct device_node *np = pdev->dev.of_node;
> > int ret;
> >
> > match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
> > @@ -199,8 +213,10 @@ static int sdhci_iproc_probe(struct platform_device
> > *pdev)
> > mmc_of_parse(host->mmc);
> > sdhci_get_of_property(pdev);
> >
> > - /* Enable EMMC 1/8V DDR capable */
> > - host->mmc->caps |= MMC_CAP_1_8V_DDR;
> > + if (of_device_is_compatible(np, "brcm,sdhci-iproc-cygnus")) {
> > + /* Enable EMMC 1/8V DDR capable */
> > + host->mmc->caps |= MMC_CAP_1_8V_DDR;
> > + }
>
> Why don't you use the property in device tree?
> It can be parsed MMC_CAP_1_8V_DDR as property of "mmc-ddr-1_8v".

I agree but i don't have a iProc Cygnus to test it and we need to keep
compatibility to older devicetrees. 

>
> Best Regards,
> Jaehoon Chung
>
> >
> > pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> > if (IS_ERR(pltfm_host->clk)) {
> >
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
