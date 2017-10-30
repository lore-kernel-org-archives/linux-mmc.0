From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Convert timers to use timer_setup()
Date: Mon, 30 Oct 2017 12:40:45 +0100
Message-ID: <CAPDyKFpyeQS=+9a8_Z0wm9inA1-NyiSH8J2RbjBdePBgSota1g@mail.gmail.com>
References: <20171024150345.GA104061@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:46259 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdJ3Lkr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2017 07:40:47 -0400
Received: by mail-io0-f196.google.com with SMTP id 101so26405135ioj.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Oct 2017 04:40:46 -0700 (PDT)
In-Reply-To: <20171024150345.GA104061@beast>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Jaehoon Chung <jh80.chung@samsung.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Nicolas Pitre <nico@fluxnic.net>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alex Dubov <oakad@yahoo.com>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Tony Olech <tony.olech@elandigitalsystems.com>, Pierre Ossman <pierre@ossman.eu>, Linus Walleij <linus.walleij@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Heiner Kallweit <hkallweit1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Allen <allen.lkml@gmail.com>, linux-mmc@vger

On 24 October 2017 at 17:03, Kees Cook <keescook@chromium.org> wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Bruce Chang <brucechang@via.com.tw>
> Cc: Harald Welte <HaraldWelte@viatech.com>
> Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Allen <allen.lkml@gmail.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, applied for next, however by dropping the changes for dw_mmc.c
because of a conflict.

Can you please post a new patch, but then only for dw_mmc?

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c     | 13 ++++++-------
>  drivers/mmc/host/dw_mmc.c        | 21 +++++++++------------
>  drivers/mmc/host/jz4740_mmc.c    |  7 +++----
>  drivers/mmc/host/meson-mx-sdio.c |  7 +++----
>  drivers/mmc/host/mvsdio.c        |  6 +++---
>  drivers/mmc/host/mxcmmc.c        |  7 +++----
>  drivers/mmc/host/omap.c          | 20 +++++++++-----------
>  drivers/mmc/host/sdhci.c         | 13 ++++++-------
>  drivers/mmc/host/tifm_sd.c       |  6 +++---
>  drivers/mmc/host/via-sdmmc.c     |  6 +++---
>  drivers/mmc/host/vub300.c        | 17 +++++++++--------
>  drivers/mmc/host/wbsd.c          |  7 +++----
>  12 files changed, 60 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0a0ebf3a096d..e55f3932d580 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -732,11 +732,11 @@ static inline unsigned int atmci_convert_chksize(struct atmel_mci *host,
>                 return 0;
>  }
>
> -static void atmci_timeout_timer(unsigned long data)
> +static void atmci_timeout_timer(struct timer_list *t)
>  {
>         struct atmel_mci *host;
>
> -       host = (struct atmel_mci *)data;
> +       host = from_timer(host, t, timer);
>
>         dev_dbg(&host->pdev->dev, "software timeout\n");
>
> @@ -1661,9 +1661,9 @@ static void atmci_command_complete(struct atmel_mci *host,
>                 cmd->error = 0;
>  }
>
> -static void atmci_detect_change(unsigned long data)
> +static void atmci_detect_change(struct timer_list *t)
>  {
> -       struct atmel_mci_slot   *slot = (struct atmel_mci_slot *)data;
> +       struct atmel_mci_slot   *slot = from_timer(slot, t, detect_timer);
>         bool                    present;
>         bool                    present_old;
>
> @@ -2349,8 +2349,7 @@ static int atmci_init_slot(struct atmel_mci *host,
>         if (gpio_is_valid(slot->detect_pin)) {
>                 int ret;
>
> -               setup_timer(&slot->detect_timer, atmci_detect_change,
> -                               (unsigned long)slot);
> +               timer_setup(&slot->detect_timer, atmci_detect_change, 0);
>
>                 ret = request_irq(gpio_to_irq(slot->detect_pin),
>                                 atmci_detect_interrupt,
> @@ -2563,7 +2562,7 @@ static int atmci_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       setup_timer(&host->timer, atmci_timeout_timer, (unsigned long)host);
> +       timer_setup(&host->timer, atmci_timeout_timer, 0);
>
>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 45289c5e0295..539a33d0e3bd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2921,9 +2921,9 @@ static void dw_mci_init_dma(struct dw_mci *host)
>         host->use_dma = TRANS_MODE_PIO;
>  }
>
> -static void dw_mci_cmd11_timer(unsigned long arg)
> +static void dw_mci_cmd11_timer(struct timer_list *t)
>  {
> -       struct dw_mci *host = (struct dw_mci *)arg;
> +       struct dw_mci *host = from_timer(host, t, cmd11_timer);
>
>         if (host->state != STATE_SENDING_CMD11) {
>                 dev_warn(host->dev, "Unexpected CMD11 timeout\n");
> @@ -2935,9 +2935,9 @@ static void dw_mci_cmd11_timer(unsigned long arg)
>         tasklet_schedule(&host->tasklet);
>  }
>
> -static void dw_mci_cto_timer(unsigned long arg)
> +static void dw_mci_cto_timer(struct timer_list *t)
>  {
> -       struct dw_mci *host = (struct dw_mci *)arg;
> +       struct dw_mci *host = from_timer(host, t, cto_timer);
>
>         switch (host->state) {
>         case STATE_SENDING_CMD11:
> @@ -2959,9 +2959,9 @@ static void dw_mci_cto_timer(unsigned long arg)
>         }
>  }
>
> -static void dw_mci_dto_timer(unsigned long arg)
> +static void dw_mci_dto_timer(struct timer_list *t)
>  {
> -       struct dw_mci *host = (struct dw_mci *)arg;
> +       struct dw_mci *host = from_timer(host, t, dto_timer);
>
>         switch (host->state) {
>         case STATE_SENDING_DATA:
> @@ -3127,14 +3127,11 @@ int dw_mci_probe(struct dw_mci *host)
>                 }
>         }
>
> -       setup_timer(&host->cmd11_timer,
> -                   dw_mci_cmd11_timer, (unsigned long)host);
> +       timer_setup(&host->cmd11_timer, dw_mci_cmd11_timer, 0);
>
> -       setup_timer(&host->cto_timer,
> -                   dw_mci_cto_timer, (unsigned long)host);
> +       timer_setup(&host->cto_timer, dw_mci_cto_timer, 0);
>
> -       setup_timer(&host->dto_timer,
> -                   dw_mci_dto_timer, (unsigned long)host);
> +       timer_setup(&host->dto_timer, dw_mci_dto_timer, 0);
>
>         spin_lock_init(&host->lock);
>         spin_lock_init(&host->irq_lock);
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 7db8c7a8d38d..712e08d9a45e 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -586,9 +586,9 @@ static bool jz4740_mmc_read_data(struct jz4740_mmc_host *host,
>         return true;
>  }
>
> -static void jz4740_mmc_timeout(unsigned long data)
> +static void jz4740_mmc_timeout(struct timer_list *t)
>  {
> -       struct jz4740_mmc_host *host = (struct jz4740_mmc_host *)data;
> +       struct jz4740_mmc_host *host = from_timer(host, t, timeout_timer);
>
>         if (!test_and_clear_bit(0, &host->waiting))
>                 return;
> @@ -1036,8 +1036,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>
>         jz4740_mmc_reset(host);
>         jz4740_mmc_clock_disable(host);
> -       setup_timer(&host->timeout_timer, jz4740_mmc_timeout,
> -                       (unsigned long)host);
> +       timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
>
>         host->use_dma = true;
>         if (host->use_dma && jz4740_mmc_acquire_dma_channels(host) != 0)
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 19b499bbe691..f48b266e3ca1 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -474,9 +474,9 @@ static irqreturn_t meson_mx_mmc_irq_thread(int irq, void *irq_data)
>         return IRQ_HANDLED;
>  }
>
> -static void meson_mx_mmc_timeout(unsigned long arg)
> +static void meson_mx_mmc_timeout(struct timer_list *t)
>  {
> -       struct meson_mx_mmc_host *host = (void *) arg;
> +       struct meson_mx_mmc_host *host = from_timer(host, t, cmd_timeout);
>         unsigned long irqflags;
>         u32 irqc;
>
> @@ -652,8 +652,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>         host->controller_dev = &pdev->dev;
>
>         spin_lock_init(&host->irq_lock);
> -       setup_timer(&host->cmd_timeout, meson_mx_mmc_timeout,
> -                   (unsigned long)host);
> +       timer_setup(&host->cmd_timeout, meson_mx_mmc_timeout, 0);
>
>         platform_set_drvdata(pdev, host);
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 58d74b8d6c79..210247b3d11a 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -508,9 +508,9 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>         return IRQ_NONE;
>  }
>
> -static void mvsd_timeout_timer(unsigned long data)
> +static void mvsd_timeout_timer(struct timer_list *t)
>  {
> -       struct mvsd_host *host = (struct mvsd_host *)data;
> +       struct mvsd_host *host = from_timer(host, t, timer);
>         void __iomem *iobase = host->base;
>         struct mmc_request *mrq;
>         unsigned long flags;
> @@ -776,7 +776,7 @@ static int mvsd_probe(struct platform_device *pdev)
>                 goto out;
>         }
>
> -       setup_timer(&host->timer, mvsd_timeout_timer, (unsigned long)host);
> +       timer_setup(&host->timer, mvsd_timeout_timer, 0);
>         platform_set_drvdata(pdev, mmc);
>         ret = mmc_add_host(mmc);
>         if (ret)
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 328484b96620..1f624a000cad 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -963,10 +963,9 @@ static bool filter(struct dma_chan *chan, void *param)
>         return true;
>  }
>
> -static void mxcmci_watchdog(unsigned long data)
> +static void mxcmci_watchdog(struct timer_list *t)
>  {
> -       struct mmc_host *mmc = (struct mmc_host *)data;
> -       struct mxcmci_host *host = mmc_priv(mmc);
> +       struct mxcmci_host *host = from_timer(host, t, watchdog);
>         struct mmc_request *req = host->req;
>         unsigned int stat = mxcmci_readl(host, MMC_REG_STATUS);
>
> @@ -1165,7 +1164,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>                         goto out_free_dma;
>         }
>
> -       setup_timer(&host->watchdog, &mxcmci_watchdog, (unsigned long)mmc);
> +       timer_setup(&host->watchdog, mxcmci_watchdog, 0);
>
>         mmc_add_host(mmc);
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index bd49f34d7654..adf32682f27a 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -625,9 +625,9 @@ static void mmc_omap_abort_command(struct work_struct *work)
>  }
>
>  static void
> -mmc_omap_cmd_timer(unsigned long data)
> +mmc_omap_cmd_timer(struct timer_list *t)
>  {
> -       struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> +       struct mmc_omap_host *host = from_timer(host, t, cmd_abort_timer);
>         unsigned long flags;
>
>         spin_lock_irqsave(&host->slot_lock, flags);
> @@ -654,9 +654,9 @@ mmc_omap_sg_to_buf(struct mmc_omap_host *host)
>  }
>
>  static void
> -mmc_omap_clk_timer(unsigned long data)
> +mmc_omap_clk_timer(struct timer_list *t)
>  {
> -       struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> +       struct mmc_omap_host *host = from_timer(host, t, clk_timer);
>
>         mmc_omap_fclk_enable(host, 0);
>  }
> @@ -874,9 +874,9 @@ void omap_mmc_notify_cover_event(struct device *dev, int num, int is_closed)
>         tasklet_hi_schedule(&slot->cover_tasklet);
>  }
>
> -static void mmc_omap_cover_timer(unsigned long arg)
> +static void mmc_omap_cover_timer(struct timer_list *t)
>  {
> -       struct mmc_omap_slot *slot = (struct mmc_omap_slot *) arg;
> +       struct mmc_omap_slot *slot = from_timer(slot, t, cover_timer);
>         tasklet_schedule(&slot->cover_tasklet);
>  }
>
> @@ -1264,8 +1264,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>         mmc->max_seg_size = mmc->max_req_size;
>
>         if (slot->pdata->get_cover_state != NULL) {
> -               setup_timer(&slot->cover_timer, mmc_omap_cover_timer,
> -                           (unsigned long)slot);
> +               timer_setup(&slot->cover_timer, mmc_omap_cover_timer, 0);
>                 tasklet_init(&slot->cover_tasklet, mmc_omap_cover_handler,
>                              (unsigned long)slot);
>         }
> @@ -1352,11 +1351,10 @@ static int mmc_omap_probe(struct platform_device *pdev)
>         INIT_WORK(&host->send_stop_work, mmc_omap_send_stop_work);
>
>         INIT_WORK(&host->cmd_abort_work, mmc_omap_abort_command);
> -       setup_timer(&host->cmd_abort_timer, mmc_omap_cmd_timer,
> -                   (unsigned long) host);
> +       timer_setup(&host->cmd_abort_timer, mmc_omap_cmd_timer, 0);
>
>         spin_lock_init(&host->clk_lock);
> -       setup_timer(&host->clk_timer, mmc_omap_clk_timer, (unsigned long) host);
> +       timer_setup(&host->clk_timer, mmc_omap_clk_timer, 0);
>
>         spin_lock_init(&host->dma_lock);
>         spin_lock_init(&host->slot_lock);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0d5fcca18c9e..536f2d529a3e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2407,12 +2407,12 @@ static void sdhci_tasklet_finish(unsigned long param)
>                 ;
>  }
>
> -static void sdhci_timeout_timer(unsigned long data)
> +static void sdhci_timeout_timer(struct timer_list *t)
>  {
>         struct sdhci_host *host;
>         unsigned long flags;
>
> -       host = (struct sdhci_host*)data;
> +       host = from_timer(host, t, timer);
>
>         spin_lock_irqsave(&host->lock, flags);
>
> @@ -2429,12 +2429,12 @@ static void sdhci_timeout_timer(unsigned long data)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static void sdhci_timeout_data_timer(unsigned long data)
> +static void sdhci_timeout_data_timer(struct timer_list *t)
>  {
>         struct sdhci_host *host;
>         unsigned long flags;
>
> -       host = (struct sdhci_host *)data;
> +       host = from_timer(host, t, data_timer);
>
>         spin_lock_irqsave(&host->lock, flags);
>
> @@ -3749,9 +3749,8 @@ int __sdhci_add_host(struct sdhci_host *host)
>         tasklet_init(&host->finish_tasklet,
>                 sdhci_tasklet_finish, (unsigned long)host);
>
> -       setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
> -       setup_timer(&host->data_timer, sdhci_timeout_data_timer,
> -                   (unsigned long)host);
> +       timer_setup(&host->timer, sdhci_timeout_timer, 0);
> +       timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
>
>         init_waitqueue_head(&host->buf_ready_int);
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index 93c4b40df90a..a3d8380ab480 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -783,9 +783,9 @@ static void tifm_sd_end_cmd(unsigned long data)
>         mmc_request_done(mmc, mrq);
>  }
>
> -static void tifm_sd_abort(unsigned long data)
> +static void tifm_sd_abort(struct timer_list *t)
>  {
> -       struct tifm_sd *host = (struct tifm_sd*)data;
> +       struct tifm_sd *host = from_timer(host, t, timer);
>
>         pr_err("%s : card failed to respond for a long period of time "
>                "(%x, %x)\n",
> @@ -968,7 +968,7 @@ static int tifm_sd_probe(struct tifm_dev *sock)
>
>         tasklet_init(&host->finish_tasklet, tifm_sd_end_cmd,
>                      (unsigned long)host);
> -       setup_timer(&host->timer, tifm_sd_abort, (unsigned long)host);
> +       timer_setup(&host->timer, tifm_sd_abort, 0);
>
>         mmc->ops = &tifm_sd_ops;
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index a8c97b6e59dc..32c4211506fc 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -932,12 +932,12 @@ static irqreturn_t via_sdc_isr(int irq, void *dev_id)
>         return result;
>  }
>
> -static void via_sdc_timeout(unsigned long ulongdata)
> +static void via_sdc_timeout(struct timer_list *t)
>  {
>         struct via_crdr_mmc_host *sdhost;
>         unsigned long flags;
>
> -       sdhost = (struct via_crdr_mmc_host *)ulongdata;
> +       sdhost = from_timer(sdhost, t, timer);
>
>         spin_lock_irqsave(&sdhost->lock, flags);
>
> @@ -1036,7 +1036,7 @@ static void via_init_mmc_host(struct via_crdr_mmc_host *host)
>         u32 lenreg;
>         u32 status;
>
> -       setup_timer(&host->timer, via_sdc_timeout, (unsigned long)host);
> +       timer_setup(&host->timer, via_sdc_timeout, 0);
>
>         spin_lock_init(&host->lock);
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index c1a169843f99..e6091528aca3 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -741,9 +741,10 @@ static void vub300_deadwork_thread(struct work_struct *work)
>         kref_put(&vub300->kref, vub300_delete);
>  }
>
> -static void vub300_inactivity_timer_expired(unsigned long data)
> +static void vub300_inactivity_timer_expired(struct timer_list *t)
>  {                              /* softirq */
> -       struct vub300_mmc_host *vub300 = (struct vub300_mmc_host *)data;
> +       struct vub300_mmc_host *vub300 = from_timer(vub300, t,
> +                                                   inactivity_timer);
>         if (!vub300->interface) {
>                 kref_put(&vub300->kref, vub300_delete);
>         } else if (vub300->cmd) {
> @@ -1180,9 +1181,10 @@ static void send_command(struct vub300_mmc_host *vub300)
>   * timer callback runs in atomic mode
>   *       so it cannot call usb_kill_urb()
>   */
> -static void vub300_sg_timed_out(unsigned long data)
> +static void vub300_sg_timed_out(struct timer_list *t)
>  {
> -       struct vub300_mmc_host *vub300 = (struct vub300_mmc_host *)data;
> +       struct vub300_mmc_host *vub300 = from_timer(vub300, t,
> +                                                   sg_transfer_timer);
>         vub300->usb_timed_out = 1;
>         usb_sg_cancel(&vub300->sg_request);
>         usb_unlink_urb(vub300->command_out_urb);
> @@ -2323,11 +2325,10 @@ static int vub300_probe(struct usb_interface *interface,
>         INIT_WORK(&vub300->cmndwork, vub300_cmndwork_thread);
>         INIT_WORK(&vub300->deadwork, vub300_deadwork_thread);
>         kref_init(&vub300->kref);
> -       setup_timer(&vub300->sg_transfer_timer, vub300_sg_timed_out,
> -                   (unsigned long)vub300);
> +       timer_setup(&vub300->sg_transfer_timer, vub300_sg_timed_out, 0);
>         kref_get(&vub300->kref);
> -       setup_timer(&vub300->inactivity_timer,
> -                   vub300_inactivity_timer_expired, (unsigned long)vub300);
> +       timer_setup(&vub300->inactivity_timer,
> +                   vub300_inactivity_timer_expired, 0);
>         vub300->inactivity_timer.expires = jiffies + HZ;
>         add_timer(&vub300->inactivity_timer);
>         if (vub300->card_present)
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 499852d8f706..f4233576153b 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -956,9 +956,9 @@ static const struct mmc_host_ops wbsd_ops = {
>   * Helper function to reset detection ignore
>   */
>
> -static void wbsd_reset_ignore(unsigned long data)
> +static void wbsd_reset_ignore(struct timer_list *t)
>  {
> -       struct wbsd_host *host = (struct wbsd_host *)data;
> +       struct wbsd_host *host = from_timer(host, t, ignore_timer);
>
>         BUG_ON(host == NULL);
>
> @@ -1224,8 +1224,7 @@ static int wbsd_alloc_mmc(struct device *dev)
>         /*
>          * Set up timers
>          */
> -       setup_timer(&host->ignore_timer, wbsd_reset_ignore,
> -                   (unsigned long)host);
> +       timer_setup(&host->ignore_timer, wbsd_reset_ignore, 0);
>
>         /*
>          * Maximum number of segments. Worst case is one sector per segment
> --
> 2.7.4
>
>
> --
> Kees Cook
> Pixel Security
