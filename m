From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 8/8] mmc: sunxi: Add runtime_pm support
Date: Thu, 15 Mar 2018 11:24:36 +0100
Message-ID: <CAPDyKFpzi2fbSHPUaJRnBmb7YLCzwD0fTFStXgY1eB136m2gEw@mail.gmail.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <052c21c000f64c28fd6b64c4db11e4b706bebf79.1520520655.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFoJ0KftG1VxzdM97ubFJ25M+X0EjgOPc6HxewgyZMPipg@mail.gmail.com>
 <20180315100411.iqcnwqws623ws6yn@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180315100411.iqcnwqws623ws6yn@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 15 March 2018 at 11:04, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi Ulf,
>
> On Thu, Mar 15, 2018 at 10:30:54AM +0100, Ulf Hansson wrote:
>> On 8 March 2018 at 15:52, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > So far, even if our card was not in use, we didn't shut down our main
>> > clock, which meant that it was still output on the MMC bus.
>> >
>> > While this obviously means that we could save some power there, it also
>> > created issues when it comes with EMC control since we'll have a perfect
>> > peak at the card clock rate.
>> >
>> > Let's implement runtime_pm with autosuspend so that we will shut down the
>> > clock when it's not been in use for quite some time.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>> > ---
>> >  drivers/mmc/host/sunxi-mmc.c | 46 +++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 46 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> > index f6374066081b..0f98a5fcaade 100644
>> > --- a/drivers/mmc/host/sunxi-mmc.c
>> > +++ b/drivers/mmc/host/sunxi-mmc.c
>> > @@ -35,6 +35,7 @@
>> >  #include <linux/of_gpio.h>
>> >  #include <linux/of_platform.h>
>> >  #include <linux/platform_device.h>
>> > +#include <linux/pm_runtime.h>
>> >  #include <linux/regulator/consumer.h>
>> >  #include <linux/reset.h>
>> >  #include <linux/scatterlist.h>
>> > @@ -973,6 +974,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> >         unsigned long flags;
>> >         u32 imask;
>> >
>> > +       if (enable)
>> > +               pm_runtime_get_noresume(host->dev);
>> > +
>> >         spin_lock_irqsave(&host->lock, flags);
>> >
>> >         imask = mmc_readl(host, REG_IMASK);
>> > @@ -985,6 +989,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> >         }
>> >         mmc_writel(host, REG_IMASK, imask);
>> >         spin_unlock_irqrestore(&host->lock, flags);
>> > +
>> > +       if (!enable)
>> > +               pm_runtime_put_noidle(host->mmc->parent);
>> >  }
>> >
>> >  static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
>> > @@ -1398,6 +1405,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>> >         if (ret)
>> >                 goto error_free_dma;
>> >
>> > +       pm_runtime_set_active(&pdev->dev);
>> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>> > +       pm_runtime_use_autosuspend(&pdev->dev);
>> > +       pm_runtime_enable(&pdev->dev);
>> > +
>> >         ret = mmc_add_host(mmc);
>> >         if (ret)
>> >                 goto error_free_dma;
>> > @@ -1418,6 +1430,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>> >         struct sunxi_mmc_host *host = mmc_priv(mmc);
>> >
>> >         mmc_remove_host(mmc);
>> > +       pm_runtime_force_suspend(&pdev->dev);
>> >         disable_irq(host->irq);
>> >         sunxi_mmc_disable(host);
>> >         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>> > @@ -1426,10 +1439,43 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>> >         return 0;
>> >  }
>> >
>> > +static int sunxi_mmc_runtime_resume(struct device *dev)
>> > +{
>> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
>> > +       struct sunxi_mmc_host *host = mmc_priv(mmc);
>> > +       int ret;
>> > +
>> > +       ret = sunxi_mmc_enable(host);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       sunxi_mmc_power_up(mmc, &mmc->ios);
>>
>> Instead of doing power up, you may need restore some ios settings,
>> such as the clock rate for example.
>>
>> You may also need to restore some registers in sunxi device, in case
>> it's possible that the controller loses context at runtime suspend.
>
> The thing I was precisely trying to avoid was this :)
>
> I could save and restore registers when the MMC controller is put into
> suspend, but that's pretty much exactly the same sequence than what is
> done in the MMC_POWER_UP sequence in .set_ios.

Well, there may be some overlap.

>
> So it just felt cleaner to just do the power_up sequence at resume
> time. It avoids having to maintain the list of registers to save and
> restore, and it involves less code overall.

I understand.

>
> It suprised me a bit that the core will not call .set_ios with
> MMC_POWER_UP at resume by itself, but I guess there's a good reason
> for that :)

It does that when it runtime PM manages the mmc/sd/sdio card, don't
confuse that with the mmc host. That's because it needs to follow the
(e)MMC/SD/SDIO spec, which don't allows you to just cut the power to
card without first informing (sending commands) the card about it.

Kind regards
Uffe
