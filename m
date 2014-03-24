From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 6/9] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Mon, 24 Mar 2014 17:34:33 +0100
Message-ID: <CALtMJECAPzvyWKUZ7qo-6Wo8LvB0QRps777mh7CNZ3JktGSFjw@mail.gmail.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
	<1395418658-2375-1-git-send-email-balajitk@ti.com>
	<1395418658-2375-7-git-send-email-balajitk@ti.com>
	<CAPDyKFqzDS0CX60BVcFx1+kJR840qkyEU6CtATkZSEd8F2z26w@mail.gmail.com>
	<CALtMJECaQrGhMmJjK+tvce3iSEGMUx==pOmMECU-smy=0fyZ3Q@mail.gmail.com>
	<CAPDyKFqy-W5tiBirWUdkq3vHVpjeQ8Hr4KdP34X9CW7_c9Zuaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:62721 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaCXQee (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Mar 2014 12:34:34 -0400
In-Reply-To: <CAPDyKFqy-W5tiBirWUdkq3vHVpjeQ8Hr4KdP34X9CW7_c9Zuaw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>

2014-03-24 17:02 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 24 March 2014 15:59, Andreas Fenkart <afenkart@gmail.com> wrote:
>> Hi,
>>
>> 2014-03-24 13:43 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>> On 21 March 2014 17:17, Balaji T K <balajitk@ti.com> wrote:
>>>> From: Andreas Fenkart <afenkart@gmail.com>
>>>>
>>>> There have been various patches floating around for enabling
>>>> the SDIO IRQ for hsmmc, but none of them ever got merged.
>>>>
>>>> Probably the reason for not merging the SDIO interrupt patches
>>>> has been the lack of wake-up path for SDIO on some omaps that
>>>> has also needed remuxing the SDIO DAT1 line to a GPIO making
>>>> the patches complex.
>>>>
>>>> This patch adds the minimal SDIO IRQ support to hsmmc for
>>>> omaps that do have the wake-up path. For those omaps, the
>>>> DAT1 line need to have the wake-up enable bit set, and the
>>>> wake-up interrupt is the same as for the MMC controller.
>>>>
>>>> This patch has been tested on am3730 es1.2 with mwifiex
>>>> connected to MMC3 with mwifiex waking to Ethernet traffic
>>>> from off-idle mode. Note that for omaps that do not have
>>>> the SDIO wake-up path, this patch will not work for idle
>>>> modes and further patches for remuxing DAT1 to GPIO are
>>>> needed.
>>>>
>>>> Based on earlier patches [1][2] by David Vrabel
>>>> <david.vrabel@csr.com>, Steve Sakoman <steve@sakoman.com>
>>>> and Andreas Fenkart <afenkart@gmail.com> with the SDIO IRQ
>>>> handing improved following how sdhci.c is doing it.
>>>>
>>>> For now, only support SDIO interrupt if we are booted with
>>>> a separate wake-irq configued via device tree. This is
>>>> because omaps need the wake-irq for idle states, and some
>>>> omaps need special quirks. And we don't want to add new
>>>> legacy mux platform init code callbacks any longer as we
>>>> are moving to DT based booting anyways.
>>>>
>>>> To use it, you need to specify the wake-irq using the
>>>> interrupts-extended property.
>>>>
>>>> [1] http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux.git;a=commitdiff_plain;h=010810d22f6f49ac03da4ba384969432e0320453
>>>> [2] http://comments.gmane.org/gmane.linux.kernel.mmc/20446
>>>>
>>>> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>> ---
>>>>  drivers/mmc/host/omap_hsmmc.c          |  207 ++++++++++++++++++++++++++++++--
>>>>  include/linux/platform_data/mmc-omap.h |    1 +
>>>>  2 files changed, 196 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>>> index 38a75bc..0275e0a 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -29,6 +29,7 @@
>>>>  #include <linux/timer.h>
>>>>  #include <linux/clk.h>
>>>>  #include <linux/of.h>
>>>> +#include <linux/of_irq.h>
>>>>  #include <linux/of_gpio.h>
>>>>  #include <linux/of_device.h>
>>>>  #include <linux/omap-dma.h>
>>>> @@ -36,6 +37,7 @@
>>>>  #include <linux/mmc/core.h>
>>>>  #include <linux/mmc/mmc.h>
>>>>  #include <linux/io.h>
>>>> +#include <linux/irq.h>
>>>>  #include <linux/gpio.h>
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/pinctrl/consumer.h>
>>>> @@ -106,6 +108,7 @@
>>>>  #define TC_EN                  (1 << 1)
>>>>  #define BWR_EN                 (1 << 4)
>>>>  #define BRR_EN                 (1 << 5)
>>>> +#define CIRQ_EN                        (1 << 8)
>>>>  #define ERR_EN                 (1 << 15)
>>>>  #define CTO_EN                 (1 << 16)
>>>>  #define CCRC_EN                        (1 << 17)
>>>> @@ -140,7 +143,6 @@
>>>>  #define VDD_3V0                        3000000         /* 300000 uV */
>>>>  #define VDD_165_195            (ffs(MMC_VDD_165_195) - 1)
>>>>
>>>> -#define AUTO_CMD23             (1 << 1)        /* Auto CMD23 support */
>>>>  /*
>>>>   * One controller can have multiple slots, like on some omap boards using
>>>>   * omap.c controller driver. Luckily this is not currently done on any known
>>>> @@ -194,6 +196,7 @@ struct omap_hsmmc_host {
>>>>         u32                     sysctl;
>>>>         u32                     capa;
>>>>         int                     irq;
>>>> +       int                     wake_irq;
>>>>         int                     use_dma, dma_ch;
>>>>         struct dma_chan         *tx_chan;
>>>>         struct dma_chan         *rx_chan;
>>>> @@ -206,6 +209,11 @@ struct omap_hsmmc_host {
>>>>         int                     req_in_progress;
>>>>         unsigned long           clk_rate;
>>>>         unsigned int            flags;
>>>> +#define HSMMC_RUNTIME_SUSPENDED (1 << 0)
>>>> +#define AUTO_CMD23             (1 << 1)        /* Auto CMD23 support */
>>
>> merge conflict here? I do not use HSMMC_RUNTIME_SUSPEND anymore
>> and of course, neither do I define AUTO_CMD23. :-)
>>
>>>> +#define HSMMC_SWAKEUP_QUIRK    (1 << 2)
>>>> +#define HSMMC_SDIO_IRQ_ENABLED (1 << 3)        /* SDIO irq enabled */
>>>> +#define HSMMC_WAKE_IRQ_ENABLED (1 << 4)
>>>>         struct omap_hsmmc_next  next_data;
>>>>         struct  omap_mmc_platform_data  *pdata;
>>>>  };
>>>> @@ -510,27 +518,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
>>>>  static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>>>>                                   struct mmc_command *cmd)
>>>>  {
>>>> -       unsigned int irq_mask;
>>>> +       u32 irq_mask = INT_EN_MASK;
>>>> +       unsigned long flags;
>>>>
>>>>         if (host->use_dma)
>>>> -               irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
>>>> -       else
>>>> -               irq_mask = INT_EN_MASK;
>>>> +               irq_mask &= ~(BRR_EN | BWR_EN);
>>>>
>>>>         /* Disable timeout for erases */
>>>>         if (cmd->opcode == MMC_ERASE)
>>>>                 irq_mask &= ~DTO_EN;
>>>>
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>>         OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>>         OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>>>> +
>>>> +       /* latch pending CIRQ, but don't signal MMC core */
>>>> +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
>>>> +               irq_mask |= CIRQ_EN;
>>>>         OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>>  }
>>>>
>>>>  static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>>>>  {
>>>> -       OMAP_HSMMC_WRITE(host->base, ISE, 0);
>>>> -       OMAP_HSMMC_WRITE(host->base, IE, 0);
>>>> +       u32 irq_mask = 0;
>>>> +       unsigned long flags;
>>>> +
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>> +       /* no transfer running but need to keep cirq if enabled */
>>>> +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
>>>> +               irq_mask |= CIRQ_EN;
>>>> +       OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>>>> +       OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>>>>         OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>>  }
>>>>
>>>>  /* Calculate divisor for the given clock frequency */
>>>> @@ -1117,8 +1138,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>>>>         int status;
>>>>
>>>>         status = OMAP_HSMMC_READ(host->base, STAT);
>>>> -       while (status & INT_EN_MASK && host->req_in_progress) {
>>>> -               omap_hsmmc_do_irq(host, status);
>>>> +       while (status & (INT_EN_MASK | CIRQ_EN)) {
>>>> +               if (host->req_in_progress)
>>>> +                       omap_hsmmc_do_irq(host, status);
>>>> +
>>>> +               if (status & CIRQ_EN)
>>>> +                       mmc_signal_sdio_irq(host->mmc);
>>>>
>>>>                 /* Flush posted write */
>>>>                 status = OMAP_HSMMC_READ(host->base, STAT);
>>>> @@ -1127,6 +1152,24 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>>>>         return IRQ_HANDLED;
>>>>  }
>>>>
>>>> +static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
>>>> +{
>>>> +       struct omap_hsmmc_host *host = dev_id;
>>>> +       unsigned long flags;
>>>> +
>>>> +       /* cirq is level triggered, disable to avoid infinite loop */
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>> +       if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
>>>> +               disable_irq_nosync(host->wake_irq);
>>>> +               host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
>>>> +       }
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>> +
>>>> +       pm_request_resume(host->dev); /* no use counter */
>>>> +
>>>> +       return IRQ_HANDLED;
>>>> +}
>>>> +
>>>>  static void set_sd_bus_power(struct omap_hsmmc_host *host)
>>>>  {
>>>>         unsigned long i;
>>>> @@ -1638,6 +1681,81 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>>>                 mmc_slot(host).init_card(card);
>>>>  }
>>>>
>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>> +{
>>>> +       struct omap_hsmmc_host *host = mmc_priv(mmc);
>>>> +       u32 irq_mask;
>>>> +       unsigned long flags;
>>>> +

/from here/

>>>> +       if (enable)
>>>> +               pm_runtime_get_sync(host->dev);
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>> +       if (host->flags & HSMMC_RUNTIME_SUSPENDED)
>>>> +               goto out;

/till here/

This looks like a very old version of my patch, where did you got this
from? Could it be that you have some local merge conflict? See also my
comment above about the the AUTO_CMD23 comment.
Pls start over with the original patch of this series

>>>
>>> This seems wrong to me.
>>>
>>> What if the host is suspended (runtime PM wise) and you want to
>>> disable SDIO irq.
>>> Won't SDIO irq be kept enabled in this case?
>>
>> Whenever you enter this function the module is not suspended,
>> mind that register accesses will fail without fclk. So before entering here,
>> there must have been a  pm_runtime_resume somewhere.
>
> That is not correct I believe! You may very well have "disabled" host,
> since there nobody that have claimed it, once you get an SDIO irq to
> handle.
>
> Additionally, if your statement stands, why do you need the
> pm_runtime_get_sync when we are about to enable SDIO irq?
>
>
>>
>>>
>>>> +
>>>> +       irq_mask = OMAP_HSMMC_READ(host->base, ISE);
>>>> +       if (enable) {
>>>> +               host->flags |= HSMMC_SDIO_IRQ_ENABLED;
>>>> +               irq_mask |= CIRQ_EN;
>>>> +       } else {
>>>> +               host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
>>>> +               irq_mask &= ~CIRQ_EN;
>>>> +       }
>>>> +       OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>>>> +
>>>> +       /*
>>>> +        * if enable, piggy back detection on current request
>>>> +        * but always disable immediately
>>>> +        */
>>>> +       if (!host->req_in_progress || !enable)
>>>> +               OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>>>> +
>>>> +       /* flush posted write */
>>>> +       OMAP_HSMMC_READ(host->base, IE);
>>>> +
>>>> +out:
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>> +       if (enable) {
>>>> +               pm_runtime_mark_last_busy(host->dev);
>>>> +               pm_runtime_put_autosuspend(host->dev);
>>>> +       }
>>>> +}
>>>> +
>>>> +static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>>>> +{
>>>> +       struct mmc_host *mmc = host->mmc;
>>>> +       int ret;
>>>> +
>>>> +       /*
>>>> +        * For omaps with wake-up path, wakeirq will be irq from pinctrl and
>>>> +        * for other omaps, wakeirq will be from GPIO (dat line remuxed to
>>>> +        * gpio). wakeirq is needed to detect sdio irq in runtime suspend state
>>>> +        * with functional clock disabled.
>>>> +        */
>>>> +       if (!host->dev->of_node || !host->wake_irq)
>>>> +               return -ENODEV;
>>>> +
>>>> +       /* Prevent auto-enabling of IRQ */
>>>> +       irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
>>>> +       ret = request_irq(host->wake_irq, omap_hsmmc_wake_irq,
>>>> +                         IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>>>> +                         mmc_hostname(mmc), host);
>>>> +       if (ret) {
>>>> +               dev_err(mmc_dev(host->mmc),
>>>> +                       "Unable to request wake IRQ\n");
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Some omaps don't have wake-up path from deeper idle states
>>>> +        * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
>>>> +        */
>>>> +       if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING)
>>>> +               host->flags |= HSMMC_SWAKEUP_QUIRK;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>>>>  {
>>>>         u32 hctl, capa, value;
>>>> @@ -1690,7 +1808,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>>>>         .get_cd = omap_hsmmc_get_cd,
>>>>         .get_ro = omap_hsmmc_get_ro,
>>>>         .init_card = omap_hsmmc_init_card,
>>>> -       /* NYET -- enable_sdio_irq */
>>>> +       .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DEBUG_FS
>>>> @@ -1761,6 +1879,11 @@ static const struct omap_mmc_of_data omap4_mmc_of_data = {
>>>>         .reg_offset = 0x100,
>>>>  };
>>>>
>>>> +static struct omap_mmc_of_data am33xx_mmc_of_data = {
>>>> +       .reg_offset = 0x100,
>>>> +       .controller_flags = OMAP_HSMMC_SWAKEUP_MISSING,
>>>> +};
>>>> +
>>>>  static const struct of_device_id omap_mmc_of_match[] = {
>>>>         {
>>>>                 .compatible = "ti,omap2-hsmmc",
>>>> @@ -1776,6 +1899,10 @@ static const struct of_device_id omap_mmc_of_match[] = {
>>>>                 .compatible = "ti,omap4-hsmmc",
>>>>                 .data = &omap4_mmc_of_data,
>>>>         },
>>>> +       {
>>>> +               .compatible = "ti,am33xx-hsmmc",
>>>> +               .data = &am33xx_mmc_of_data,
>>>> +       },
>>>>         {},
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>>>> @@ -1837,6 +1964,7 @@ static inline struct omap_mmc_platform_data
>>>>  {
>>>>         return ERR_PTR(-EINVAL);
>>>>  }
>>>> +#define omap_mmc_of_match      NULL
>>>>  #endif
>>>>
>>>>  static int omap_hsmmc_probe(struct platform_device *pdev)
>>>> @@ -1912,6 +2040,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>>>
>>>>         platform_set_drvdata(pdev, host);
>>>>
>>>> +       if (pdev->dev.of_node)
>>>> +               host->wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
>>>> +
>>>>         mmc->ops        = &omap_hsmmc_ops;
>>>>
>>>>         mmc->f_min = OMAP_MMC_MIN_CLOCK;
>>>> @@ -2065,6 +2196,18 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>>>                 dev_warn(&pdev->dev,
>>>>                         "pins are not configured from the driver\n");
>>>>
>>>> +       /*
>>>> +        * For now, only support SDIO interrupt if we have a separate
>>>> +        * wake-up interrupt configured from device tree. This is because
>>>> +        * the wake-up interrupt is needed for idle state and some
>>>> +        * platforms need special quirks. And we don't want to add new
>>>> +        * legacy mux platform init code callbacks any longer as we
>>>> +        * are moving to DT based booting anyways.
>>>> +        */
>>>> +       ret = omap_hsmmc_configure_wake_irq(host);
>>>> +       if (!ret)
>>>> +               mmc->caps |= MMC_CAP_SDIO_IRQ;
>>>> +
>>>>         omap_hsmmc_protect_card(host);
>>>>
>>>>         mmc_add_host(mmc);
>>>> @@ -2089,12 +2232,16 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>>>
>>>>  err_slot_name:
>>>>         mmc_remove_host(mmc);
>>>> +       if (host->wake_irq)
>>>> +               free_irq(host->wake_irq, host);
>>>>  err_irq_cd:
>>>>         if (host->use_reg)
>>>>                 omap_hsmmc_reg_put(host);
>>>>  err_reg:
>>>>         if (host->pdata->cleanup)
>>>>                 host->pdata->cleanup(&pdev->dev);
>>>> +       if (host->wake_irq)
>>>> +               free_irq(host->wake_irq, host);
>>>>  err_irq:
>>>>         if (host->tx_chan)
>>>>                 dma_release_channel(host->tx_chan);
>>>> @@ -2174,6 +2321,9 @@ static int omap_hsmmc_suspend(struct device *dev)
>>>>                                 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>>>>         }
>>>>
>>>> +       if (host->wake_irq && !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
>>>> +               disable_irq(host->wake_irq);
>>>> +
>>>>         if (host->dbclk)
>>>>                 clk_disable_unprepare(host->dbclk);
>>>>
>>>> @@ -2199,6 +2349,9 @@ static int omap_hsmmc_resume(struct device *dev)
>>>>
>>>>         omap_hsmmc_protect_card(host);
>>>>
>>>> +       if (host->wake_irq & !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
>>>> +               enable_irq(host->wake_irq);
>>>> +
>>>>         pm_runtime_mark_last_busy(host->dev);
>>>>         pm_runtime_put_autosuspend(host->dev);
>>>>         return 0;
>>>> @@ -2214,23 +2367,53 @@ static int omap_hsmmc_resume(struct device *dev)
>>>>  static int omap_hsmmc_runtime_suspend(struct device *dev)
>>>>  {
>>>>         struct omap_hsmmc_host *host;
>>>> +       int ret = 0;
>>>> +       unsigned long flags;
>>>>
>>>>         host = platform_get_drvdata(to_platform_device(dev));
>>>>         omap_hsmmc_context_save(host);
>>>>         dev_dbg(dev, "disabled\n");
>>>>
>>>> -       return 0;
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>> +       host->flags |= HSMMC_RUNTIME_SUSPENDED;
>>>> +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED) {
>>>> +               OMAP_HSMMC_WRITE(host->base, ISE, 0);
>>>> +               OMAP_HSMMC_WRITE(host->base, IE, 0);
>>>> +               OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>> +               if (host->wake_irq && !(host->flags & HSMMC_WAKE_IRQ_ENABLED)) {
>>>> +                       enable_irq(host->wake_irq);
>>>> +                       host->flags |= HSMMC_WAKE_IRQ_ENABLED;
>>>> +               }
>>>> +       }
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>
>>> This seems like code you need to execute during system suspend as
>>> well? How will you else make sure the wakeup irq is fetched in this
>>> scenario?
>>>
>>> Maybe, you have a work around for this problem in the omap power domain?
>>
>> I just added printks in resume and pm_runtime_resume, and did a
>> suspend/resume cycle:
>>
>> [   42.853308] net eth0: initializing cpsw version 1.12 (0)
>> [   42.937224] net eth0: phy found : id is : 0x4dd076
>> [   42.957608] omap_hsmmc_resume
>> [   43.067149] PM: resume of devices complete after 218.241 msecs
>> [   43.085387] PM: Sending message for resetting M3 state machine
>> [   43.092981] Restarting tasks ... done.
>> [   43.177550] omap_hsmmc_runtime_resume
>> [   46.937556] libphy: 4a101000.mdio:04 - Link is Up - 100/Full
>> root@stream800:~#
>>
>> So it seems, pm_runtime_resume is triggered by system resume.
>
> It seems that sometime _after_ system resume has completed, your
> device will be runtime resumed. That not surprising, that will happen
> sooner or later anyway.
>
> But, the question is if device will be properly resumed to fetch the
> SDIO irq, when it's triggered as wakeup.
>
>>
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>> +
>>>> +       return ret;
>>>>  }
>>>>
>>>>  static int omap_hsmmc_runtime_resume(struct device *dev)
>>>>  {
>>>>         struct omap_hsmmc_host *host;
>>>> +       int ret = 0;
>>>> +       unsigned long flags;
>>>>
>>>>         host = platform_get_drvdata(to_platform_device(dev));
>>>>         omap_hsmmc_context_restore(host);
>>>>         dev_dbg(dev, "enabled\n");
>>>>
>>>> -       return 0;
>>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>>> +       host->flags &= ~HSMMC_RUNTIME_SUSPENDED;
>>>> +       if (host->flags & HSMMC_SDIO_IRQ_ENABLED) {
>>>> +               if (host->wake_irq && (host->flags & HSMMC_WAKE_IRQ_ENABLED)) {
>>>> +                       disable_irq_nosync(host->wake_irq);
>>>> +                       host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
>>>> +               }
>>>> +
>>>> +               OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>> +               OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
>>>> +               OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
>>>> +       }
>>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>>> +       return ret;
>>>>  }
>>>>
>>>>  static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>>>> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
>>>> index 2bf1b30..51e70cf 100644
>>>> --- a/include/linux/platform_data/mmc-omap.h
>>>> +++ b/include/linux/platform_data/mmc-omap.h
>>>> @@ -28,6 +28,7 @@
>>>>   */
>>>>  #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT          BIT(0)
>>>>  #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ      BIT(1)
>>>> +#define OMAP_HSMMC_SWAKEUP_MISSING             BIT(2)
>>>>
>>>>  struct mmc_card;
>>>>
>>>> --
>>>> 1.7.5.4
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
