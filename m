From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Thu, 11 Jun 2015 09:36:32 +0800
Message-ID: <1433986592.14592.5.camel@mhfsdcap03>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
 <1433903088-14407-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq=iHcsAXxQa0J0QEeG0c9LgpxaPUdo8KGL7NtbX6_eMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFq=iHcsAXxQa0J0QEeG0c9LgpxaPUdo8KGL7NtbX6_eMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bin Zhang =?UTF-8?Q?=28=E7=AB=A0=E6=96=8C=29?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kern>
List-Id: linux-mmc@vger.kernel.org

Dear Ulf,

Thanks, please see my comment:

On Wed, 2015-06-10 at 13:53 +0200, Ulf Hansson wrote:
> [...]
> 
> > +static int msdc_drv_probe(struct platform_device *pdev)
> > +{
> > +       struct mmc_host *mmc;
> > +       struct msdc_host *host;
> > +       struct resource *res;
> > +       int ret;
> > +
> > +       if (!pdev->dev.of_node) {
> > +               dev_err(&pdev->dev, "No DT found\n");
> > +               return -EINVAL;
> > +       }
> > +       /* Allocate MMC host for this device */
> > +       mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
> > +       if (!mmc)
> > +               return -ENOMEM;
> > +
> > +       host = mmc_priv(mmc);
> > +       ret = mmc_of_parse(mmc);
> > +       if (ret)
> > +               goto host_free;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       host->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(host->base)) {
> > +               ret = PTR_ERR(host->base);
> > +               goto host_free;
> > +       }
> > +
> > +       ret = mmc_regulator_get_supply(mmc);
> > +       if (ret == -EPROBE_DEFER)
> > +               goto host_free;
> > +
> > +       host->src_clk = devm_clk_get(&pdev->dev, "source");
> > +       if (IS_ERR(host->src_clk)) {
> > +               ret = PTR_ERR(host->src_clk);
> > +               goto host_free;
> > +       }
> > +
> > +       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +       if (IS_ERR(host->h_clk)) {
> > +               /* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> > +               dev_dbg(&pdev->dev,
> > +                               "Invalid hclk from the device tree!\n");
> > +       }
> > +
> > +       host->irq = platform_get_irq(pdev, 0);
> > +       if (host->irq < 0) {
> > +               ret = -EINVAL;
> > +               goto host_free;
> > +       }
> > +
> > +       host->pinctrl = devm_pinctrl_get(&pdev->dev);
> > +       if (IS_ERR(host->pinctrl)) {
> > +               ret = PTR_ERR(host->pinctrl);
> > +               dev_err(&pdev->dev, "Cannot find pinctrl!\n");
> > +               goto host_free;
> > +       }
> > +
> > +       host->pins_default = pinctrl_lookup_state(host->pinctrl, "default");
> > +       if (IS_ERR(host->pins_default)) {
> > +               ret = PTR_ERR(host->pins_default);
> > +               dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
> > +               goto host_free;
> > +       }
> > +
> > +       host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
> > +       if (IS_ERR(host->pins_uhs)) {
> > +               ret = PTR_ERR(host->pins_uhs);
> > +               dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
> > +               goto host_free;
> > +       }
> > +
> > +       host->dev = &pdev->dev;
> > +       host->mmc = mmc;
> > +       host->hclk = clk_get_rate(host->src_clk);
> 
> This looks odd. The clock rate for the source clock is assigned as the
> speed of hclk!? Why?
> Yes, the name is odd, here the host->hclk is indicate the source clock frequency, but not the HCLK frequency.
I will modify the name to host->src_clk_freq at next revision.
> > +       /* Set host parameters to mmc */
> > +       mmc->ops = &mt_msdc_ops;
> > +       mmc->f_min = host->hclk / (4 * 255);
> > +
> > +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> > +       /* MMC core transfer sizes tunable parameters */
> > +       mmc->max_segs = MAX_BD_NUM;
> > +       mmc->max_seg_size = BDMA_DESC_BUFLEN;
> > +       mmc->max_blk_size = 2048;
> > +       mmc->max_req_size = 512 * 1024;
> > +       mmc->max_blk_count = mmc->max_req_size / 512;
> > +       host->dma_mask = DMA_BIT_MASK(32);
> > +       mmc_dev(mmc)->dma_mask = &host->dma_mask;
> > +
> > +       host->timeout_clks = 3 * 1048576;
> > +       host->dma.gpd = dma_alloc_coherent(&pdev->dev,
> > +                               sizeof(struct mt_gpdma_desc),
> > +                               &host->dma.gpd_addr, GFP_KERNEL);
> > +       host->dma.bd = dma_alloc_coherent(&pdev->dev,
> > +                               MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> > +                               &host->dma.bd_addr, GFP_KERNEL);
> > +       if (!host->dma.gpd || !host->dma.bd) {
> > +               ret = -ENOMEM;
> > +               goto release_mem;
> > +       }
> > +       msdc_init_gpd_bd(host, &host->dma);
> > +       INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> > +       spin_lock_init(&host->lock);
> > +
> > +       platform_set_drvdata(pdev, mmc);
> > +       msdc_ungate_clock(host);
> > +       msdc_init_hw(host);
> > +
> > +       ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> > +               IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> > +       if (ret)
> > +               goto release;
> > +
> > +       ret = mmc_add_host(mmc);
> > +       if (ret)
> > +               goto release;
> > +
> > +       return 0;
> > +
> > +release:
> > +       platform_set_drvdata(pdev, NULL);
> > +       msdc_deinit_hw(host);
> > +       msdc_gate_clock(host);
> > +release_mem:
> > +       if (host->dma.gpd)
> > +               dma_free_coherent(&pdev->dev,
> > +                       sizeof(struct mt_gpdma_desc),
> > +                       host->dma.gpd, host->dma.gpd_addr);
> > +       if (host->dma.bd)
> > +               dma_free_coherent(&pdev->dev,
> > +                       MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> > +                       host->dma.bd, host->dma.bd_addr);
> > +host_free:
> > +       mmc_free_host(mmc);
> > +
> > +       return ret;
> > +}
> 
> [...]
> 
> Kind regards
> Uffe
