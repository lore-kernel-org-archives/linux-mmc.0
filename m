From: chaotian.jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Wed, 6 May 2015 14:54:59 +0800
Message-ID: <1430895299.15154.9.camel@mhfsdcap03>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Thanks for your review.
I must do a explain of our MMC host:
Source clock is source clock of the MMC bus, MMC host has a divider to
get different bus clock frequency. now the runtime suspend is gating
this clock.

Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
cannot work(all registers readout is zero). and, all registers would be
reset to default value if Hclk is gated/ungated.
At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
was controlled by "Infra module".

And, our MMC host has ability to control the gate/ungate of bus clock
automatically, in MSDC_CFG bit 1, if this bit is set to 0, then "bus
clock is gated to 0 if no command or data is transmitted".
So, if the runtime PM do not control the Source clock, Hclk, then the
runtime PM is needless.

if runtime PM do gate/ungate Hclk, then need do save/restore the
registers meanwhile.

So, how about your suggestion ?
do we still need runtime PM ?
Thx!




On Tue, 2015-05-05 at 14:49 +0200, Ulf Hansson wrote:
> On 28 April 2015 at 11:48, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Add Mediatek MMC driver code
> > Support eMMC/SD/SDIO
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/host/Kconfig  |    8 +
> >  drivers/mmc/host/Makefile |    1 +
> >  drivers/mmc/host/mtk-sd.c | 1416 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1425 insertions(+)
> >  create mode 100644 drivers/mmc/host/mtk-sd.c
> 
> [...]
> 
> > +static void msdc_init_hw(struct msdc_host *host)
> > +{
> > +       u32 val;
> > +       /* Configure to MMC/SD mode */
> > +       sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE, MSDC_SDMMC);
> > +
> > +       /* Reset */
> > +       msdc_reset_hw(host);
> > +
> > +       /* Disable card detection */
> > +       sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
> > +
> > +       /* Disable and clear all interrupts */
> > +       writel(0, host->base + MSDC_INTEN);
> > +       val = readl(host->base + MSDC_INT);
> > +       writel(val, host->base + MSDC_INT);
> > +
> > +       writel(0, host->base + MSDC_PAD_TUNE);
> > +       writel(0, host->base + MSDC_IOCON);
> > +       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 1);
> > +       writel(0x403c004f, host->base + MSDC_PATCH_BIT);
> > +       sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
> > +       writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
> > +       /* Configure to enable SDIO mode.
> > +          it's must otherwise sdio cmd5 failed */
> > +       sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> > +
> > +       /* disable detect SDIO device interrupt function */
> > +       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +
> > +       /* Configure to default data timeout */
> > +       sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > +       msdc_set_buswidth(host, MMC_BUS_WIDTH_1);
> > +
> > +       dev_dbg(host->dev, "init hardware done!");
> > +}
> > +
> > +static void msdc_deinit_hw(struct msdc_host *host)
> > +{
> > +       u32 val;
> > +       /* Disable and clear all interrupts */
> > +       writel(0, host->base + MSDC_INTEN);
> > +
> > +       val = readl(host->base + MSDC_INT);
> > +       writel(val, host->base + MSDC_INT);
> > +
> > +       msdc_gate_clock(host);
> > +
> > +       if (!IS_ERR(host->h_clk))
> > +               clk_disable_unprepare(host->h_clk);
> 
> To make it clear when clocks are managed, I would move all that stuff
> outside this function.
> 
> That would also follow how msdc_init_hw() is coded.
> 
> [...]
> 
> > +static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +       int ret;
> > +       u32 ddr = 0;
> > +
> > +       if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> > +               ios->timing == MMC_TIMING_MMC_DDR52)
> > +               ddr = 1;
> > +
> > +       msdc_set_buswidth(host, ios->bus_width);
> > +
> > +       /* Suspend/Resume will do power off/on */
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_UP:
> > +               msdc_init_hw(host);
> 
> I think you need to move the call to msdc_init_hw() into ->probe().
> 
> See more comments in the ->probe() function.
> 
> > +               if (!IS_ERR(mmc->supply.vmmc)) {
> > +                       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> > +                                       ios->vdd);
> > +                       if (ret) {
> > +                               dev_err(host->dev, "Failed to set vmmc power!\n");
> > +                               return;
> > +                       }
> > +               }
> > +               break;
> > +       case MMC_POWER_ON:
> > +               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> > +                       ret = regulator_enable(mmc->supply.vqmmc);
> > +                       if (ret)
> > +                               dev_err(host->dev, "Failed to set vqmmc power!\n");
> > +                       else
> > +                               host->vqmmc_enabled = true;
> > +               }
> > +               msdc_ungate_clock(host);
> 
> I suggest that clocks that is managed through the clk API, should be
> enabled during ->probe(). Then leave them enabled until the ->remove()
> callback gets invoked.
> 
> In the ->set_ios() callback you should care about the internal
> registers of your controller to enable/disable bus clocks.
> Though, that should be considering of what value the ios->clock has
> and not due MMC_POWER_ON|OFF|UP.
> 
> See more comments in the ->probe() function.
> 
> > +               break;
> > +       case MMC_POWER_OFF:
> > +               if (!IS_ERR(mmc->supply.vmmc))
> > +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +
> > +               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
> > +                       regulator_disable(mmc->supply.vqmmc);
> > +                       host->vqmmc_enabled = false;
> > +               }
> > +               msdc_gate_clock(host);
> 
> Same comment as above and see more comments in the ->probe() function.
> 
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       /* Apply different pinctrl settings for different timing */
> > +       if (timing_is_uhs(ios))
> > +               pinctrl_select_state(host->pinctrl, host->pins_uhs);
> > +       else
> > +               pinctrl_select_state(host->pinctrl, host->pins_default);
> > +
> > +       if (host->mclk != ios->clock || host->ddr != ddr)
> > +               msdc_set_mclk(host, ddr, ios->clock);
> > +}
> > +
> > +static struct mmc_host_ops mt_msdc_ops = {
> > +       .post_req = msdc_post_req,
> > +       .pre_req = msdc_pre_req,
> > +       .request = msdc_ops_request,
> > +       .set_ios = msdc_ops_set_ios,
> > +       .start_signal_voltage_switch = msdc_ops_switch_volt,
> > +};
> > +
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
> 
> I am a bit puzzled over the clock management here and in the
> ->set_ios() callback, as mentioned.
> 
> I would suggest to do clk_prepare_enable() for the "source" clock
> during probe and leave it on, until the ->remove() callbacks is
> invoked.
> 
> Moreover, it's a good idea to invoke msdc_init_hw() during ->probe(),
> since it makes sure the controller is properly initiated at this
> point. You must not rely on the mmc core to invoke your ->set_ios()
> callback with MMC_POWER_OFF to deal with that.
> 
> This should also enable you to manage both "hclk" and "source" clock
> from the runtime PM callbacks, which you add in patch3. Thus it should
> enable you to save more power in the runtime PM suspend state.
> 
> It would also mean that the "sclk_enabled" member in your host struct
> can be removed.
> 
> > +       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +       if (IS_ERR(host->h_clk)) {
> > +               /* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> > +               dev_dbg(&pdev->dev,
> > +                               "Invalied hclk from the device tree!\n");
> > +       } else {
> > +               clk_prepare_enable(host->h_clk);
> > +               dev_dbg(&pdev->dev,
> > +                               "hclk rate: %ld\n", clk_get_rate(host->h_clk));
> > +       }
> > +
> 
> [...]
> 
> Kind regards
> Uffe
