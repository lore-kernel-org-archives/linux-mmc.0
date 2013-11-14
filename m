From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Thu, 14 Nov 2013 10:09:03 +0100
Message-ID: <CALtMJED37AaHQPVyVsJ8yXs8P9kQmPKqS41sz=hsR6Onj0NzmA@mail.gmail.com>
References: <1384200405-8402-1-git-send-email-afenkart@gmail.com>
	<1384200405-8402-2-git-send-email-afenkart@gmail.com>
	<528263DE.2030001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <528263DE.2030001@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2013/11/12 Balaji T K <balajitk@ti.com>:
> On Tuesday 12 November 2013 01:36 AM, Andreas Fenkart wrote:
>>
>> For now, only support SDIO interrupt if we are booted with
>> DT. This is because some platforms need special quirks. And
>> we don't want to add new legacy mux platform init code
>> callbacks any longer as we are moving to DT based booting
>> anyways.
>>
>> Broken hardware, missing the swakueup line, should fallback
>> to polling, by setting 'ti,quirk-swakup-missing' in the
>> device tree. Otherwise pending SDIO IRQ are not detected
>> while in suspend. This affects am33xx processors.
>>
>> For the DT-Binding portion:
>> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
>> Acked-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>> ---
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   18 ++++
>>   drivers/mmc/host/omap_hsmmc.c                      |   86
>> ++++++++++++++++++--
>>   2 files changed, 95 insertions(+), 9 deletions(-)
>>
>
>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +       struct omap_hsmmc_host *host = mmc_priv(mmc);
>> +       u32 irq_mask;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->irq_lock, flags);
>> +
>
> Hi Andreas,
>
> Thanks for the patch,
> You don't check for runtime pm status here before read/write to HSMMC
> registers,
> can you please explain ?


The fclk  must be running when you end up here.
- sdio_irq_thread calls mmc_claim_host which calls pm_runtime_get in turn.
- upper level drivers (e.g. wifi) call mmc_claim_host before interacting with
  the host.
- in interrupt context, fclk must be on otherwise irq detection wouldn't work.

FYI:
In a previous patch for am335x with swakeup line missing, this function was
called from gpio irq context directly. There it could have happened that the
fclk was not running and your register accesses caused a SIGBUS.
With this version of the patch the gpio irg handler only wakes up the the host
with pm_request_resume. Actual sdio irq processing is done in a 2nd interrupt
triggered by mmc host itself. This models the behaviour, when your chip has
the swakeup line.
Assuming SDIO irq while in pm_suspend is rare followed by burst of SDIO
irqs. Then the additional delay of the 2nd interrupt would vanish in
the measuring
noise. Hence I chose this solution because it's simpler and less error prone.

>
>
>> +       irq_mask = OMAP_HSMMC_READ(host->base, ISE);
>> +       if (enable) {
>> +               host->flags |= HSMMC_SDIO_IRQ_ENABLED;
>> +               irq_mask |= CIRQ_EN;
>> +       } else {
>> +               host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
>> +               irq_mask &= ~CIRQ_EN;
>> +       }
>> +       OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>> +
>> +       /*
>> +        * if enable, piggy back detection on current request
>> +        * but always disable immediately
>> +        */
>> +       if (!host->req_in_progress || !enable)
>> +               OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>> +
>> +       /* flush posted write */
>> +       OMAP_HSMMC_READ(host->base, IE);
>> +
>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>> +}
>> +
>>   static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>>   {
>>         u32 hctl, capa, value;
>> @@ -1635,7 +1687,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>>         .get_cd = omap_hsmmc_get_cd,
>>         .get_ro = omap_hsmmc_get_ro,
>>         .init_card = omap_hsmmc_init_card,
>> -       /* NYET -- enable_sdio_irq */
>> +       .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>   };
>>
>>   #ifdef CONFIG_DEBUG_FS
>> @@ -2021,6 +2073,22 @@ static int omap_hsmmc_probe(struct platform_device
>> *pdev)
>>                 dev_warn(&pdev->dev,
>>                         "pins are not configured from the driver\n");
>>
>> +       /*
>> +        * For now, only support SDIO interrupt if we are booted with
>> +        * DT. This is because some platforms need special quirks. And
>> +        * we don't want to add new legacy mux platform init code
>> +        * callbacks any longer as we are moving to DT based booting
>> +        * anyways.
>> +        */
>> +       if (pdev->dev.of_node) {
>> +               mmc->caps |= MMC_CAP_SDIO_IRQ;
>> +               if (of_find_property(host->dev->of_node,
>> +                                    "ti,quirk-swakeup-missing", NULL)) {
>> +                       /* no wakeup from deeper power states, use polling
>> */
>> +                       mmc->caps &= ~MMC_CAP_SDIO_IRQ;
>> +               }
>> +       }
>> +
>>         omap_hsmmc_protect_card(host);
>>
>>         mmc_add_host(mmc);
>>
>
