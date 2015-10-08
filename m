From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove MMC_CLKGATE
Date: Thu, 8 Oct 2015 19:35:17 +0200
Message-ID: <CAPDyKFooaDekXEf9uEkU6Wgd2dhS409RK8i_qi3eB5-GVUHVQw@mail.gmail.com>
References: <1443776171-7127-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38426 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbbJHRfT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 13:35:19 -0400
Received: by wiclk2 with SMTP id lk2so35661476wic.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 10:35:17 -0700 (PDT)
In-Reply-To: <1443776171-7127-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

On 2 October 2015 at 10:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> MMC_CLKGATE was once invented to save power by gating the bus clock at
> request inactivity. At that time it served its purpose. The modern way to
> deal with power saving for these scenarios, is by using runtime PM.
>
> Nowadays, several host drivers have deployed runtime PM, but for those
> that haven't and which still cares power saving at request inactivity,
> it's certainly time to deploy runtime PM as it has been around for several
> years now.
>
> To simplify code to mmc core and thus decrease maintenance efforts, this
> patch removes all code related to MMC_CLKGATE.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I have queued this up for next to get some testing in linux-next and
kernelci. Still, it's not too late to provide input to the patch.

Kind regards
Uffe

> ---
>  Documentation/mmc/mmc-dev-attrs.txt |  10 --
>  drivers/mmc/core/Kconfig            |  10 --
>  drivers/mmc/core/core.c             | 139 +++-----------------
>  drivers/mmc/core/core.h             |   3 -
>  drivers/mmc/core/debugfs.c          |   5 -
>  drivers/mmc/core/host.c             | 245 ------------------------------------
>  drivers/mmc/core/mmc.c              |   6 +-
>  drivers/mmc/core/quirks.c           |  18 ---
>  drivers/mmc/core/sd.c               |   2 -
>  drivers/mmc/core/sdio.c             |   7 +-
>  drivers/mmc/core/sdio_irq.c         |  14 +--
>  include/linux/mmc/card.h            |   1 -
>  include/linux/mmc/host.h            |  32 -----
>  13 files changed, 20 insertions(+), 472 deletions(-)
>
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
> index 189bab0..caa5557 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -72,13 +72,3 @@ Note on raw_rpmb_size_mult:
>         "raw_rpmb_size_mult" is a mutliple of 128kB block.
>         RPMB size in byte is calculated by using the following equation:
>         RPMB partition size = 128kB x raw_rpmb_size_mult
> -
> -SD/MMC/SDIO Clock Gating Attribute
> -==================================
> -
> -Read and write access is provided to following attribute.
> -This attribute appears only if CONFIG_MMC_CLKGATE is enabled.
> -
> -       clkgate_delay   Tune the clock gating delay with desired value in milliseconds.
> -
> -echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_delay
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 9ebee72..4c33d76 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -1,13 +1,3 @@
>  #
>  # MMC core configuration
>  #
> -
> -config MMC_CLKGATE
> -       bool "MMC host clock gating"
> -       help
> -         This will attempt to aggressively gate the clock to the MMC card.
> -         This is done to save power due to gating off the logic and bus
> -         noise when the MMC card is not in use. Your host driver has to
> -         support handling this in order for it to be of any use.
> -
> -         If unsure, say N.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 21cda23..1a36b02 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -187,8 +187,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>
>                 if (mrq->done)
>                         mrq->done(mrq);
> -
> -               mmc_host_clk_release(host);
>         }
>  }
>
> @@ -292,7 +290,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>                         mrq->stop->mrq = mrq;
>                 }
>         }
> -       mmc_host_clk_hold(host);
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
>
> @@ -542,11 +539,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
>  static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
>                  bool is_first_req)
>  {
> -       if (host->ops->pre_req) {
> -               mmc_host_clk_hold(host);
> +       if (host->ops->pre_req)
>                 host->ops->pre_req(host, mrq, is_first_req);
> -               mmc_host_clk_release(host);
> -       }
>  }
>
>  /**
> @@ -561,11 +555,8 @@ static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
>  static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
>                          int err)
>  {
> -       if (host->ops->post_req) {
> -               mmc_host_clk_hold(host);
> +       if (host->ops->post_req)
>                 host->ops->post_req(host, mrq, err);
> -               mmc_host_clk_release(host);
> -       }
>  }
>
>  /**
> @@ -850,9 +841,9 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>                 unsigned int timeout_us, limit_us;
>
>                 timeout_us = data->timeout_ns / 1000;
> -               if (mmc_host_clk_rate(card->host))
> +               if (card->host->ios.clock)
>                         timeout_us += data->timeout_clks * 1000 /
> -                               (mmc_host_clk_rate(card->host) / 1000);
> +                               (card->host->ios.clock / 1000);
>
>                 if (data->flags & MMC_DATA_WRITE)
>                         /*
> @@ -1050,8 +1041,6 @@ static inline void mmc_set_ios(struct mmc_host *host)
>                  ios->power_mode, ios->chip_select, ios->vdd,
>                  ios->bus_width, ios->timing);
>
> -       if (ios->clock > 0)
> -               mmc_set_ungated(host);
>         host->ops->set_ios(host, ios);
>  }
>
> @@ -1060,17 +1049,15 @@ static inline void mmc_set_ios(struct mmc_host *host)
>   */
>  void mmc_set_chip_select(struct mmc_host *host, int mode)
>  {
> -       mmc_host_clk_hold(host);
>         host->ios.chip_select = mode;
>         mmc_set_ios(host);
> -       mmc_host_clk_release(host);
>  }
>
>  /*
>   * Sets the host clock to the highest possible frequency that
>   * is below "hz".
>   */
> -static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
> +void mmc_set_clock(struct mmc_host *host, unsigned int hz)
>  {
>         WARN_ON(hz && hz < host->f_min);
>
> @@ -1081,68 +1068,6 @@ static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
>         mmc_set_ios(host);
>  }
>
> -void mmc_set_clock(struct mmc_host *host, unsigned int hz)
> -{
> -       mmc_host_clk_hold(host);
> -       __mmc_set_clock(host, hz);
> -       mmc_host_clk_release(host);
> -}
> -
> -#ifdef CONFIG_MMC_CLKGATE
> -/*
> - * This gates the clock by setting it to 0 Hz.
> - */
> -void mmc_gate_clock(struct mmc_host *host)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       host->clk_old = host->ios.clock;
> -       host->ios.clock = 0;
> -       host->clk_gated = true;
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -       mmc_set_ios(host);
> -}
> -
> -/*
> - * This restores the clock from gating by using the cached
> - * clock value.
> - */
> -void mmc_ungate_clock(struct mmc_host *host)
> -{
> -       /*
> -        * We should previously have gated the clock, so the clock shall
> -        * be 0 here! The clock may however be 0 during initialization,
> -        * when some request operations are performed before setting
> -        * the frequency. When ungate is requested in that situation
> -        * we just ignore the call.
> -        */
> -       if (host->clk_old) {
> -               BUG_ON(host->ios.clock);
> -               /* This call will also set host->clk_gated to false */
> -               __mmc_set_clock(host, host->clk_old);
> -       }
> -}
> -
> -void mmc_set_ungated(struct mmc_host *host)
> -{
> -       unsigned long flags;
> -
> -       /*
> -        * We've been given a new frequency while the clock is gated,
> -        * so make sure we regard this as ungating it.
> -        */
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       host->clk_gated = false;
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -}
> -
> -#else
> -void mmc_set_ungated(struct mmc_host *host)
> -{
> -}
> -#endif
> -
>  int mmc_execute_tuning(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> @@ -1157,9 +1082,7 @@ int mmc_execute_tuning(struct mmc_card *card)
>         else
>                 opcode = MMC_SEND_TUNING_BLOCK;
>
> -       mmc_host_clk_hold(host);
>         err = host->ops->execute_tuning(host, opcode);
> -       mmc_host_clk_release(host);
>
>         if (err)
>                 pr_err("%s: tuning execution failed\n", mmc_hostname(host));
> @@ -1174,10 +1097,8 @@ int mmc_execute_tuning(struct mmc_card *card)
>   */
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
>  {
> -       mmc_host_clk_hold(host);
>         host->ios.bus_mode = mode;
>         mmc_set_ios(host);
> -       mmc_host_clk_release(host);
>  }
>
>  /*
> @@ -1185,10 +1106,8 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
>   */
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>  {
> -       mmc_host_clk_hold(host);
>         host->ios.bus_width = width;
>         mmc_set_ios(host);
> -       mmc_host_clk_release(host);
>  }
>
>  /*
> @@ -1532,11 +1451,8 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>         int old_signal_voltage = host->ios.signal_voltage;
>
>         host->ios.signal_voltage = signal_voltage;
> -       if (host->ops->start_signal_voltage_switch) {
> -               mmc_host_clk_hold(host);
> +       if (host->ops->start_signal_voltage_switch)
>                 err = host->ops->start_signal_voltage_switch(host, &host->ios);
> -               mmc_host_clk_release(host);
> -       }
>
>         if (err)
>                 host->ios.signal_voltage = old_signal_voltage;
> @@ -1570,20 +1486,17 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>                 pr_warn("%s: cannot verify signal voltage switch\n",
>                         mmc_hostname(host));
>
> -       mmc_host_clk_hold(host);
> -
>         cmd.opcode = SD_SWITCH_VOLTAGE;
>         cmd.arg = 0;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>
>         err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
> -               goto err_command;
> +               return err;
> +
> +       if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
> +               return -EIO;
>
> -       if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR)) {
> -               err = -EIO;
> -               goto err_command;
> -       }
>         /*
>          * The card should drive cmd and dat[0:3] low immediately
>          * after the response of cmd11, but wait 1 ms to be sure
> @@ -1632,9 +1545,6 @@ power_cycle:
>                 mmc_power_cycle(host, ocr);
>         }
>
> -err_command:
> -       mmc_host_clk_release(host);
> -
>         return err;
>  }
>
> @@ -1643,10 +1553,8 @@ err_command:
>   */
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing)
>  {
> -       mmc_host_clk_hold(host);
>         host->ios.timing = timing;
>         mmc_set_ios(host);
> -       mmc_host_clk_release(host);
>  }
>
>  /*
> @@ -1654,10 +1562,8 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
>   */
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>  {
> -       mmc_host_clk_hold(host);
>         host->ios.drv_type = drv_type;
>         mmc_set_ios(host);
> -       mmc_host_clk_release(host);
>  }
>
>  int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
> @@ -1665,7 +1571,6 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>  {
>         struct mmc_host *host = card->host;
>         int host_drv_type = SD_DRIVER_TYPE_B;
> -       int drive_strength;
>
>         *drv_type = 0;
>
> @@ -1688,14 +1593,10 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>          * information and let the hardware specific code
>          * return what is possible given the options
>          */
> -       mmc_host_clk_hold(host);
> -       drive_strength = host->ops->select_drive_strength(card, max_dtr,
> -                                                         host_drv_type,
> -                                                         card_drv_type,
> -                                                         drv_type);
> -       mmc_host_clk_release(host);
> -
> -       return drive_strength;
> +       return host->ops->select_drive_strength(card, max_dtr,
> +                                               host_drv_type,
> +                                               card_drv_type,
> +                                               drv_type);
>  }
>
>  /*
> @@ -1714,8 +1615,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>         if (host->ios.power_mode == MMC_POWER_ON)
>                 return;
>
> -       mmc_host_clk_hold(host);
> -
>         mmc_pwrseq_pre_power_on(host);
>
>         host->ios.vdd = fls(ocr) - 1;
> @@ -1749,8 +1648,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>          * time required to reach a stable voltage.
>          */
>         mmc_delay(10);
> -
> -       mmc_host_clk_release(host);
>  }
>
>  void mmc_power_off(struct mmc_host *host)
> @@ -1758,8 +1655,6 @@ void mmc_power_off(struct mmc_host *host)
>         if (host->ios.power_mode == MMC_POWER_OFF)
>                 return;
>
> -       mmc_host_clk_hold(host);
> -
>         mmc_pwrseq_power_off(host);
>
>         host->ios.clock = 0;
> @@ -1775,8 +1670,6 @@ void mmc_power_off(struct mmc_host *host)
>          * can be successfully turned on again.
>          */
>         mmc_delay(1);
> -
> -       mmc_host_clk_release(host);
>  }
>
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr)
> @@ -1992,7 +1885,7 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
>                  */
>                 timeout_clks <<= 1;
>                 timeout_us += (timeout_clks * 1000) /
> -                             (mmc_host_clk_rate(card->host) / 1000);
> +                             (card->host->ios.clock / 1000);
>
>                 erase_timeout = timeout_us / 1000;
>
> @@ -2440,9 +2333,7 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
>  {
>         if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>                 return;
> -       mmc_host_clk_hold(host);
>         host->ops->hw_reset(host);
> -       mmc_host_clk_release(host);
>  }
>
>  int mmc_hw_reset(struct mmc_host *host)
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 1a22a82..09241e5 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -40,9 +40,6 @@ void mmc_init_erase(struct mmc_card *card);
>
>  void mmc_set_chip_select(struct mmc_host *host, int mode);
>  void mmc_set_clock(struct mmc_host *host, unsigned int hz);
> -void mmc_gate_clock(struct mmc_host *host);
> -void mmc_ungate_clock(struct mmc_host *host);
> -void mmc_set_ungated(struct mmc_host *host);
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index f4db93e..154aced 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -255,11 +255,6 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>                         &mmc_clock_fops))
>                 goto err_node;
>
> -#ifdef CONFIG_MMC_CLKGATE
> -       if (!debugfs_create_u32("clk_delay", (S_IRUSR | S_IWUSR),
> -                               root, &host->clk_delay))
> -               goto err_node;
> -#endif
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>         if (fail_request)
>                 setup_fault_attr(&fail_default_attr, fail_request);
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 5466f25..970e690 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -61,246 +61,6 @@ void mmc_unregister_host_class(void)
>         class_unregister(&mmc_host_class);
>  }
>
> -#ifdef CONFIG_MMC_CLKGATE
> -static ssize_t clkgate_delay_show(struct device *dev,
> -               struct device_attribute *attr, char *buf)
> -{
> -       struct mmc_host *host = cls_dev_to_mmc_host(dev);
> -       return snprintf(buf, PAGE_SIZE, "%lu\n", host->clkgate_delay);
> -}
> -
> -static ssize_t clkgate_delay_store(struct device *dev,
> -               struct device_attribute *attr, const char *buf, size_t count)
> -{
> -       struct mmc_host *host = cls_dev_to_mmc_host(dev);
> -       unsigned long flags, value;
> -
> -       if (kstrtoul(buf, 0, &value))
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       host->clkgate_delay = value;
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -       return count;
> -}
> -
> -/*
> - * Enabling clock gating will make the core call out to the host
> - * once up and once down when it performs a request or card operation
> - * intermingled in any fashion. The driver will see this through
> - * set_ios() operations with ios.clock field set to 0 to gate (disable)
> - * the block clock, and to the old frequency to enable it again.
> - */
> -static void mmc_host_clk_gate_delayed(struct mmc_host *host)
> -{
> -       unsigned long tick_ns;
> -       unsigned long freq = host->ios.clock;
> -       unsigned long flags;
> -
> -       if (!freq) {
> -               pr_debug("%s: frequency set to 0 in disable function, "
> -                        "this means the clock is already disabled.\n",
> -                        mmc_hostname(host));
> -               return;
> -       }
> -       /*
> -        * New requests may have appeared while we were scheduling,
> -        * then there is no reason to delay the check before
> -        * clk_disable().
> -        */
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -
> -       /*
> -        * Delay n bus cycles (at least 8 from MMC spec) before attempting
> -        * to disable the MCI block clock. The reference count may have
> -        * gone up again after this delay due to rescheduling!
> -        */
> -       if (!host->clk_requests) {
> -               spin_unlock_irqrestore(&host->clk_lock, flags);
> -               tick_ns = DIV_ROUND_UP(1000000000, freq);
> -               ndelay(host->clk_delay * tick_ns);
> -       } else {
> -               /* New users appeared while waiting for this work */
> -               spin_unlock_irqrestore(&host->clk_lock, flags);
> -               return;
> -       }
> -       mutex_lock(&host->clk_gate_mutex);
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       if (!host->clk_requests) {
> -               spin_unlock_irqrestore(&host->clk_lock, flags);
> -               /* This will set host->ios.clock to 0 */
> -               mmc_gate_clock(host);
> -               spin_lock_irqsave(&host->clk_lock, flags);
> -               pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
> -       }
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -       mutex_unlock(&host->clk_gate_mutex);
> -}
> -
> -/*
> - * Internal work. Work to disable the clock at some later point.
> - */
> -static void mmc_host_clk_gate_work(struct work_struct *work)
> -{
> -       struct mmc_host *host = container_of(work, struct mmc_host,
> -                                             clk_gate_work.work);
> -
> -       mmc_host_clk_gate_delayed(host);
> -}
> -
> -/**
> - *     mmc_host_clk_hold - ungate hardware MCI clocks
> - *     @host: host to ungate.
> - *
> - *     Makes sure the host ios.clock is restored to a non-zero value
> - *     past this call. Increase clock reference count and ungate clock
> - *     if we're the first user.
> - */
> -void mmc_host_clk_hold(struct mmc_host *host)
> -{
> -       unsigned long flags;
> -
> -       /* cancel any clock gating work scheduled by mmc_host_clk_release() */
> -       cancel_delayed_work_sync(&host->clk_gate_work);
> -       mutex_lock(&host->clk_gate_mutex);
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       if (host->clk_gated) {
> -               spin_unlock_irqrestore(&host->clk_lock, flags);
> -               mmc_ungate_clock(host);
> -               spin_lock_irqsave(&host->clk_lock, flags);
> -               pr_debug("%s: ungated MCI clock\n", mmc_hostname(host));
> -       }
> -       host->clk_requests++;
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -       mutex_unlock(&host->clk_gate_mutex);
> -}
> -
> -/**
> - *     mmc_host_may_gate_card - check if this card may be gated
> - *     @card: card to check.
> - */
> -static bool mmc_host_may_gate_card(struct mmc_card *card)
> -{
> -       /* If there is no card we may gate it */
> -       if (!card)
> -               return true;
> -       /*
> -        * Don't gate SDIO cards! These need to be clocked at all times
> -        * since they may be independent systems generating interrupts
> -        * and other events. The clock requests counter from the core will
> -        * go down to zero since the core does not need it, but we will not
> -        * gate the clock, because there is somebody out there that may still
> -        * be using it.
> -        */
> -       return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);
> -}
> -
> -/**
> - *     mmc_host_clk_release - gate off hardware MCI clocks
> - *     @host: host to gate.
> - *
> - *     Calls the host driver with ios.clock set to zero as often as possible
> - *     in order to gate off hardware MCI clocks. Decrease clock reference
> - *     count and schedule disabling of clock.
> - */
> -void mmc_host_clk_release(struct mmc_host *host)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       host->clk_requests--;
> -       if (mmc_host_may_gate_card(host->card) &&
> -           !host->clk_requests)
> -               schedule_delayed_work(&host->clk_gate_work,
> -                                     msecs_to_jiffies(host->clkgate_delay));
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -}
> -
> -/**
> - *     mmc_host_clk_rate - get current clock frequency setting
> - *     @host: host to get the clock frequency for.
> - *
> - *     Returns current clock frequency regardless of gating.
> - */
> -unsigned int mmc_host_clk_rate(struct mmc_host *host)
> -{
> -       unsigned long freq;
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&host->clk_lock, flags);
> -       if (host->clk_gated)
> -               freq = host->clk_old;
> -       else
> -               freq = host->ios.clock;
> -       spin_unlock_irqrestore(&host->clk_lock, flags);
> -       return freq;
> -}
> -
> -/**
> - *     mmc_host_clk_init - set up clock gating code
> - *     @host: host with potential clock to control
> - */
> -static inline void mmc_host_clk_init(struct mmc_host *host)
> -{
> -       host->clk_requests = 0;
> -       /* Hold MCI clock for 8 cycles by default */
> -       host->clk_delay = 8;
> -       /*
> -        * Default clock gating delay is 0ms to avoid wasting power.
> -        * This value can be tuned by writing into sysfs entry.
> -        */
> -       host->clkgate_delay = 0;
> -       host->clk_gated = false;
> -       INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
> -       spin_lock_init(&host->clk_lock);
> -       mutex_init(&host->clk_gate_mutex);
> -}
> -
> -/**
> - *     mmc_host_clk_exit - shut down clock gating code
> - *     @host: host with potential clock to control
> - */
> -static inline void mmc_host_clk_exit(struct mmc_host *host)
> -{
> -       /*
> -        * Wait for any outstanding gate and then make sure we're
> -        * ungated before exiting.
> -        */
> -       if (cancel_delayed_work_sync(&host->clk_gate_work))
> -               mmc_host_clk_gate_delayed(host);
> -       if (host->clk_gated)
> -               mmc_host_clk_hold(host);
> -       /* There should be only one user now */
> -       WARN_ON(host->clk_requests > 1);
> -}
> -
> -static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
> -{
> -       host->clkgate_delay_attr.show = clkgate_delay_show;
> -       host->clkgate_delay_attr.store = clkgate_delay_store;
> -       sysfs_attr_init(&host->clkgate_delay_attr.attr);
> -       host->clkgate_delay_attr.attr.name = "clkgate_delay";
> -       host->clkgate_delay_attr.attr.mode = S_IRUGO | S_IWUSR;
> -       if (device_create_file(&host->class_dev, &host->clkgate_delay_attr))
> -               pr_err("%s: Failed to create clkgate_delay sysfs entry\n",
> -                               mmc_hostname(host));
> -}
> -#else
> -
> -static inline void mmc_host_clk_init(struct mmc_host *host)
> -{
> -}
> -
> -static inline void mmc_host_clk_exit(struct mmc_host *host)
> -{
> -}
> -
> -static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
> -{
> -}
> -
> -#endif
> -
>  void mmc_retune_enable(struct mmc_host *host)
>  {
>         host->can_retune = 1;
> @@ -583,8 +343,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>                 return NULL;
>         }
>
> -       mmc_host_clk_init(host);
> -
>         spin_lock_init(&host->lock);
>         init_waitqueue_head(&host->wq);
>         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> @@ -633,7 +391,6 @@ int mmc_add_host(struct mmc_host *host)
>  #ifdef CONFIG_DEBUG_FS
>         mmc_add_host_debugfs(host);
>  #endif
> -       mmc_host_clk_sysfs_init(host);
>
>         mmc_start_host(host);
>         register_pm_notifier(&host->pm_notify);
> @@ -663,8 +420,6 @@ void mmc_remove_host(struct mmc_host *host)
>         device_del(&host->class_dev);
>
>         led_trigger_unregister_simple(host->led);
> -
> -       mmc_host_clk_exit(host);
>  }
>
>  EXPORT_SYMBOL(mmc_remove_host);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e726903..1b8907f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1932,20 +1932,16 @@ static int mmc_reset(struct mmc_host *host)
>         if (!mmc_can_reset(card))
>                 return -EOPNOTSUPP;
>
> -       mmc_host_clk_hold(host);
>         mmc_set_clock(host, host->f_init);
>
>         host->ops->hw_reset(host);
>
>         /* If the reset has happened, then a status command will fail */
> -       if (!mmc_send_status(card, &status)) {
> -               mmc_host_clk_release(host);
> +       if (!mmc_send_status(card, &status))
>                 return -ENOSYS;
> -       }
>
>         /* Set initial state and call mmc_set_ios */
>         mmc_set_initial_state(host);
> -       mmc_host_clk_release(host);
>
>         return mmc_init_card(host, card->ocr, card);
>  }
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index dd1d1e0..fad660b 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -35,25 +35,7 @@
>  #define SDIO_DEVICE_ID_MARVELL_8797_F0 0x9128
>  #endif
>
> -/*
> - * This hook just adds a quirk for all sdio devices
> - */
> -static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
> -{
> -       if (mmc_card_sdio(card))
> -               card->quirks |= data;
> -}
> -
>  static const struct mmc_fixup mmc_fixup_methods[] = {
> -       /* by default sdio devices are considered CLK_GATING broken */
> -       /* good cards will be whitelisted as they are tested */
> -       SDIO_FIXUP(SDIO_ANY_ID, SDIO_ANY_ID,
> -                  add_quirk_for_sdio_devices,
> -                  MMC_QUIRK_BROKEN_CLK_GATING),
> -
> -       SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
> -                  remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING),
> -
>         SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
>                    add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index e28ebf3..60a18ab 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -784,9 +784,7 @@ static int mmc_sd_get_ro(struct mmc_host *host)
>         if (!host->ops->get_ro)
>                 return -1;
>
> -       mmc_host_clk_hold(host);
>         ro = host->ops->get_ro(host);
> -       mmc_host_clk_release(host);
>
>         return ro;
>  }
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 95bc101..16d838e 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -956,13 +956,10 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         }
>
>         if (!err && host->sdio_irqs) {
> -               if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
> +               if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
> -               } else if (host->caps & MMC_CAP_SDIO_IRQ) {
> -                       mmc_host_clk_hold(host);
> +               else if (host->caps & MMC_CAP_SDIO_IRQ)
>                         host->ops->enable_sdio_irq(host, 1);
> -                       mmc_host_clk_release(host);
> -               }
>         }
>
>         mmc_release_host(host);
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 09cc67d..91bbbfb 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -168,21 +168,15 @@ static int sdio_irq_thread(void *_host)
>                 }
>
>                 set_current_state(TASK_INTERRUPTIBLE);
> -               if (host->caps & MMC_CAP_SDIO_IRQ) {
> -                       mmc_host_clk_hold(host);
> +               if (host->caps & MMC_CAP_SDIO_IRQ)
>                         host->ops->enable_sdio_irq(host, 1);
> -                       mmc_host_clk_release(host);
> -               }
>                 if (!kthread_should_stop())
>                         schedule_timeout(period);
>                 set_current_state(TASK_RUNNING);
>         } while (!kthread_should_stop());
>
> -       if (host->caps & MMC_CAP_SDIO_IRQ) {
> -               mmc_host_clk_hold(host);
> +       if (host->caps & MMC_CAP_SDIO_IRQ)
>                 host->ops->enable_sdio_irq(host, 0);
> -               mmc_host_clk_release(host);
> -       }
>
>         pr_debug("%s: IRQ thread exiting with code %d\n",
>                  mmc_hostname(host), ret);
> @@ -208,9 +202,7 @@ static int sdio_card_irq_get(struct mmc_card *card)
>                                 return err;
>                         }
>                 } else if (host->caps & MMC_CAP_SDIO_IRQ) {
> -                       mmc_host_clk_hold(host);
>                         host->ops->enable_sdio_irq(host, 1);
> -                       mmc_host_clk_release(host);
>                 }
>         }
>
> @@ -229,9 +221,7 @@ static int sdio_card_irq_put(struct mmc_card *card)
>                         atomic_set(&host->sdio_irq_thread_abort, 1);
>                         kthread_stop(host->sdio_irq_thread);
>                 } else if (host->caps & MMC_CAP_SDIO_IRQ) {
> -                       mmc_host_clk_hold(host);
>                         host->ops->enable_sdio_irq(host, 0);
> -                       mmc_host_clk_release(host);
>                 }
>         }
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index fdd0779..eb0151b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -269,7 +269,6 @@ struct mmc_card {
>                                                 /* for byte mode */
>  #define MMC_QUIRK_NONSTD_SDIO  (1<<2)          /* non-standard SDIO card attached */
>                                                 /* (missing CIA registers) */
> -#define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)     /* clock gating the sdio bus will make card fail */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)                /* SDIO card has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD   (1<<5)          /* disconnect CD/DAT[3] resistor */
>  #define MMC_QUIRK_INAND_CMD38  (1<<6)          /* iNAND devices have broken CMD38 */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 83b81fd..cfb3c99 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -292,18 +292,6 @@ struct mmc_host {
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> -#ifdef CONFIG_MMC_CLKGATE
> -       int                     clk_requests;   /* internal reference counter */
> -       unsigned int            clk_delay;      /* number of MCI clk hold cycles */
> -       bool                    clk_gated;      /* clock gated */
> -       struct delayed_work     clk_gate_work; /* delayed clock gate */
> -       unsigned int            clk_old;        /* old clock value cache */
> -       spinlock_t              clk_lock;       /* lock for clk fields */
> -       struct mutex            clk_gate_mutex; /* mutex for clock gating */
> -       struct device_attribute clkgate_delay_attr;
> -       unsigned long           clkgate_delay;
> -#endif
> -
>         /* host specific block data */
>         unsigned int            max_seg_size;   /* see blk_queue_max_segment_size */
>         unsigned short          max_segs;       /* see blk_queue_max_segments */
> @@ -479,26 +467,6 @@ static inline int mmc_host_packed_wr(struct mmc_host *host)
>         return host->caps2 & MMC_CAP2_PACKED_WR;
>  }
>
> -#ifdef CONFIG_MMC_CLKGATE
> -void mmc_host_clk_hold(struct mmc_host *host);
> -void mmc_host_clk_release(struct mmc_host *host);
> -unsigned int mmc_host_clk_rate(struct mmc_host *host);
> -
> -#else
> -static inline void mmc_host_clk_hold(struct mmc_host *host)
> -{
> -}
> -
> -static inline void mmc_host_clk_release(struct mmc_host *host)
> -{
> -}
> -
> -static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
> -{
> -       return host->ios.clock;
> -}
> -#endif
> -
>  static inline int mmc_card_hs(struct mmc_card *card)
>  {
>         return card->host->ios.timing == MMC_TIMING_SD_HS ||
> --
> 1.9.1
>
