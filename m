From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Disable SDIO interrupts while suspended
 to fix suspend/resume
Date: Mon, 29 Apr 2019 13:46:59 -0700
Message-ID: <CABXOdTexTjmmDjAeZZ2aBNDrn7=YwOrcPGRiFSMfS631wuBgRA@mail.gmail.com>
References: <20190429204040.18725-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429204040.18725-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kalle Valo <kvalo@codeaurora.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, linux-wireless@vger.kernel.org, Sonny Rao <sonnyrao@chromium.org>, Emil Renner Berthing <emil.renner.berthing@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Ryan Case <ryandcase@chromium.org>, "# v4 . 10+" <stable@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 29, 2019 at 1:41 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Processing SDIO interrupts while dw_mmc is suspended (or partly
> suspended) seems like a bad idea.  We really don't want to be
> processing them until we've gotten ourselves fully powered up.
>
> You might be wondering how it's even possible to become suspended when
> an SDIO interrupt is active.  As can be seen in
> dw_mci_enable_sdio_irq(), we explicitly keep dw_mmc out of runtime
> suspend when the SDIO interrupt is enabled.  ...but even though we
> stop normal runtime suspend transitions when SDIO interrupts are
> enabled, the dw_mci_runtime_suspend() can still get called for a full
> system suspend.
>
> Let's handle all this by explicitly masking SDIO interrupts in the
> suspend call and unmasking them later in the resume call.  To do this
> cleanly I'll keep track of whether the client requested that SDIO
> interrupts be enabled so that we can reliably restore them regardless
> of whether we're masking them for one reason or another.
>
> It should be noted that if dw_mci_enable_sdio_irq() is never called
> (for instance, if we don't have an SDIO card plugged in) that
> "client_sdio_enb" will always be false.  In those cases this patch
> adds a tiny bit of overhead to suspend/resume (a spinlock and a
> read/write of INTMASK) but other than that is a no-op.  The
> SDMMC_INT_SDIO bit should always be clear and clearing it again won't
> hurt.
>
> Without this fix it can be seen that rk3288-veyron Chromebooks with
> Marvell WiFi would sometimes fail to resume WiFi even after picking my
> recent mwifiex patch [1].  Specifically you'd see messages like this:
>   mwifiex_sdio mmc1:0001:1: Firmware wakeup failed
>   mwifiex_sdio mmc1:0001:1: PREP_CMD: FW in reset state
>
> ...and tracing through the resume code in the failing cases showed
> that we were processing a SDIO interrupt really early in the resume
> call.
>
> NOTE: downstream in Chrome OS 3.14 and 3.18 kernels (both of which
> support the Marvell SDIO WiFi card) we had a patch ("CHROMIUM: sdio:
> Defer SDIO interrupt handling until after resume") [2].  Presumably
> this is the same problem that was solved by that patch.
>
> [1] https://lkml.kernel.org/r/20190404040106.40519-1-dianders@chromium.org
> [2] https://crrev.com/c/230765
>
> Cc: <stable@vger.kernel.org> # 4.14.x
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> I didn't put any "Fixes" tag here, but presumably this could be
> backported to whichever kernels folks found it useful for.  I have at
> least confirmed that kernels v4.14 and v4.19 (as well as v5.1-rc2)
> show the problem.  It is very easy to pick this to v4.19 and it
> definitely fixes the problem there.
>
> I haven't spent the time to pick this to 4.14 myself, but presumably
> it wouldn't be too hard to backport this as far as v4.13 since that
> contains commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs").  Prior to that it might
> make sense for anyone experiencing this problem to just pick the old
> CHROMIUM patch to fix them.
>
> Changes in v2:
> - Suggested 4.14+ in the stable tag (Sasha-bot)
> - Extra note that this is a noop on non-SDIO (Shawn / Emil)
> - Make boolean logic cleaner as per https://crrev.com/c/1586207/1
> - Hopefully clear comments as per https://crrev.com/c/1586207/1
>
>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h |  3 +++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 80dc2fd6576c..480067b87a94 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1664,7 +1664,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>         }
>  }
>
> -static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
> +static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, bool enb,
> +                                    bool client_requested)
>  {
>         struct dw_mci *host = slot->host;
>         unsigned long irqflags;
> @@ -1672,6 +1673,20 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
>
>         spin_lock_irqsave(&host->irq_lock, irqflags);
>
> +       /*
> +        * If we're being called directly from dw_mci_enable_sdio_irq()
> +        * (which means that the client driver actually wants to enable or
> +        * disable interrupts) then save the request.  Otherwise this
> +        * wasn't directly requested by the client and we should logically
> +        * AND it with the client request since we want to disable if
> +        * _either_ the client disabled OR we have some other reason to
> +        * disable temporarily.
> +        */
> +       if (client_requested)
> +               host->client_sdio_enb = enb;
> +       else
> +               enb &= host->client_sdio_enb;
> +
>         /* Enable/disable Slot Specific SDIO interrupt */
>         int_mask = mci_readl(host, INTMASK);
>         if (enb)
> @@ -1688,7 +1703,7 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         struct dw_mci *host = slot->host;
>
> -       __dw_mci_enable_sdio_irq(slot, enb);
> +       __dw_mci_enable_sdio_irq(slot, enb, true);
>
>         /* Avoid runtime suspending the device when SDIO IRQ is enabled */
>         if (enb)
> @@ -1701,7 +1716,7 @@ static void dw_mci_ack_sdio_irq(struct mmc_host *mmc)
>  {
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>
> -       __dw_mci_enable_sdio_irq(slot, 1);
> +       __dw_mci_enable_sdio_irq(slot, true, false);
>  }
>
>  static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> @@ -2734,7 +2749,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
>                         mci_writel(host, RINTSTS,
>                                    SDMMC_INT_SDIO(slot->sdio_id));
> -                       __dw_mci_enable_sdio_irq(slot, 0);
> +                       __dw_mci_enable_sdio_irq(slot, false, false);
>                         sdio_signal_irq(slot->mmc);
>                 }
>
> @@ -3424,6 +3439,8 @@ int dw_mci_runtime_suspend(struct device *dev)
>  {
>         struct dw_mci *host = dev_get_drvdata(dev);
>
> +       __dw_mci_enable_sdio_irq(host->slot, false, false);
> +
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
>
> @@ -3490,6 +3507,8 @@ int dw_mci_runtime_resume(struct device *dev)
>         /* Now that slots are all setup, we can enable card detect */
>         dw_mci_enable_cd(host);
>
> +       __dw_mci_enable_sdio_irq(host->slot, true, false);
> +
>         return 0;
>
>  err:
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 46e9f8ec5398..dfbace0f5043 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -127,6 +127,7 @@ struct dw_mci_dma_slave {
>   * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
>   * @cto_timer: Timer for broken command transfer over scheme.
>   * @dto_timer: Timer for broken data transfer over scheme.
> + * @client_sdio_enb: The value last passed to enable_sdio_irq.
>   *
>   * Locking
>   * =======
> @@ -234,6 +235,8 @@ struct dw_mci {
>         struct timer_list       cmd11_timer;
>         struct timer_list       cto_timer;
>         struct timer_list       dto_timer;
> +
> +       bool                    client_sdio_enb;
>  };
>
>  /* DMA ops for Internal/External DMAC interface */
> --
> 2.21.0.593.g511ec345e18-goog
>
