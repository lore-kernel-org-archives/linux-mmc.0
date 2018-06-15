From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 6/7] mmc: sunxi: Add runtime_pm support
Date: Fri, 15 Jun 2018 07:45:03 -0700
Message-ID: <CAOi56cX4B=meWmRJz=qvmpxooiWQ+fADRZ4pSd=iimTiWUdRAw@mail.gmail.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <4514368de4ef7b4224be455f2d9e6090b464e819.1523888566.git-series.maxime.ripard@bootlin.com>
 <1caa07d2-17ad-18aa-9216-037c06b36281@arm.com>
 <CAPDyKFqc-+cr64DW0r_2V_vM=r45CuFrx5z4_fYf=sebb5EfQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqc-+cr64DW0r_2V_vM=r45CuFrx5z4_fYf=sebb5EfQg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, maxime.ripard@bootlin.com, =?UTF-8?B?Q2hlbi1ZdSBUc2FpICjolKHpjq7lrocp?= <wens@csie.org>, thomas.petazzoni@bootlin.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 15, 2018 at 1:56 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 14 June 2018 at 16:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > Hi Maxime,
> >
> > On 16/04/18 15:23, Maxime Ripard wrote:
> >> So far, even if our card was not in use, we didn't shut down our MMC
> >> controller, which meant that it was still active and clocking the bus.
> >>
> >> While this obviously means that we could save some power there, it also
> >> creates issues when it comes to EMC control since we'll have a perfect peak
> >> at the card clock rate.
> >>
> >> Let's implement runtime_pm with autosuspend so that we will shut down the
> >> controller when it's not been in use for quite some time.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >>  drivers/mmc/host/sunxi-mmc.c | 48 +++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 48 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> >> index 0165da0d022a..0253deb153a4 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -35,6 +35,7 @@
> >>  #include <linux/of_gpio.h>
> >>  #include <linux/of_platform.h>
> >>  #include <linux/platform_device.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/regulator/consumer.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/scatterlist.h>
> >> @@ -969,6 +970,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> >>       unsigned long flags;
> >>       u32 imask;
> >>
> >> +     if (enable)
> >> +             pm_runtime_get_noresume(host->dev);
> >> +
> >>       spin_lock_irqsave(&host->lock, flags);
> >>
> >>       imask = mmc_readl(host, REG_IMASK);
> >> @@ -981,6 +985,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> >>       }
> >>       mmc_writel(host, REG_IMASK, imask);
> >>       spin_unlock_irqrestore(&host->lock, flags);
> >> +
> >> +     if (!enable)
> >> +             pm_runtime_put_noidle(host->mmc->parent);
> >>  }
> >>
> >>  static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
> >> @@ -1394,6 +1401,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> >>       if (ret)
> >>               goto error_free_dma;
> >>
> >> +     pm_runtime_set_active(&pdev->dev);
> >> +     pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> >> +     pm_runtime_use_autosuspend(&pdev->dev);
> >> +     pm_runtime_enable(&pdev->dev);
> >> +
> >>       ret = mmc_add_host(mmc);
> >>       if (ret)
> >>               goto error_free_dma;
> >> @@ -1414,6 +1426,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
> >>       struct sunxi_mmc_host *host = mmc_priv(mmc);
> >>
> >>       mmc_remove_host(mmc);
> >> +     pm_runtime_force_suspend(&pdev->dev);
> >>       disable_irq(host->irq);
> >>       sunxi_mmc_disable(host);
> >>       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> >> @@ -1422,10 +1435,45 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
> >>       return 0;
> >>  }
> >>
> >> +static int sunxi_mmc_runtime_resume(struct device *dev)
> >> +{
> >> +     struct mmc_host *mmc = dev_get_drvdata(dev);
> >> +     struct sunxi_mmc_host *host = mmc_priv(mmc);
> >> +     int ret;
> >> +
> >> +     ret = sunxi_mmc_enable(host);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     sunxi_mmc_init_host(host);
> >> +     sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
> >> +     sunxi_mmc_set_clk(host, &mmc->ios);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int sunxi_mmc_runtime_suspend(struct device *dev)
> >> +{
> >> +     struct mmc_host *mmc = dev_get_drvdata(dev);
> >> +     struct sunxi_mmc_host *host = mmc_priv(mmc);
> >> +
> >> +     sunxi_mmc_reset_host(host);
> >> +     sunxi_mmc_disable(host);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops sunxi_mmc_pm_ops = {
> >> +     SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
> >> +                        sunxi_mmc_runtime_resume,
> >> +                        NULL)
> >> +};
> >> +
> >>  static struct platform_driver sunxi_mmc_driver = {
> >>       .driver = {
> >>               .name   = "sunxi-mmc",
> >>               .of_match_table = of_match_ptr(sunxi_mmc_of_match),
> >> +             .pm = &sunxi_mmc_pm_ops,
> >>       },
> >>       .probe          = sunxi_mmc_probe,
> >>       .remove         = sunxi_mmc_remove,
> >>
> >
> > This patch has the unfortunate impact of killing my A20 system
> > (cubietruck), as of 9a8e1e8cc2c02c57c4e941651a8481a633506c91:
> >
> > [...]
> > [    3.286649] NET: Registered protocol family 10
> > [    3.291898]  mmcblk0: p1
> > [    3.295297] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
> > [    3.302773] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> > [    3.305787] Segment Routing with IPv6
> > [    3.312225] mip6: Mobile IPv6
> > [    3.316166] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> > [    3.316246] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> > [    3.323721] ip6_gre: GRE over IPv6 tunneling driver
> > [    3.333954] NET: Registered protocol family 17
> > [    3.338837] 9pnet: Installing 9P2000 support
> > [    3.343379] NET: Registered protocol family 37
> > [    3.347885] Key type dns_resolver registered
> > [    3.352214] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> > [    3.352217] openvswitch: Open vSwitch switching datapath
> > [    3.352620] mpls_gso: MPLS GSO support
> > [    3.367001] ThumbEE CPU extension supported.
> >
> > and that's where it stops. No message, just a hard lockup (I suppose
> > that both the CPUs are trying to access some device that is now not
> > clocked).
>
> Seems like a reasonable analyze.
>
> >
> > With a working kernel, I see SATA and the wifi SDIO being probed.
> >
> > Happy to help testing stuff if you have any idea.
>
> In principle I would start with avoiding having the sunxi-mmc driver
> to probe. Or bail out early in probe, whichever is the easiest for
> you.
>
> The point is, if the sunxi-mmc driver doesn't even enable its clock,
> it would be interesting to see if there are other that depends on it.
>
> One could also play with clk_disable_unused(), the
> late_initcall_sync(), which can be turned off with the module
> parameter "clk_ignore_unused".

I added clk_ignore_unused to the kernel command-line, and that didn't
help, so it's not just an init-time clock that's causing the problem.

> Anyway, to hide/fix the problem for now, we could add a call to
> pm_runtime_get_noresume() before the sunxi-driver calls
> pm_runtime_enable().

I tried that and it makes the kernel finish booting, so that smells
definitely like the MMC is disabling a clock when it goes idle that
some other device (or CPU) depends on.

Kevin
