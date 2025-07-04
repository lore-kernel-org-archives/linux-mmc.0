Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174952D8771
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632944; cv=none; b=iD09MJpVJOMOnGQwLCC7bEEt1iEt/nEMthhb8Bt7FqxlrXCacqG1Rr496/QJLz2/pN11n3+cT0qh/D1gFvjRv3us2/5BQfwOfnaTZ/W+G4E1H8qj6dljFzmHWfZPcpGZYP0jBNM1qmWzsPKepuismekzO2OTSFVTFQdyuY41ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632944; c=relaxed/simple;
	bh=YU0ef73nmcHCKwNqWct4EP0klPHD48T2DRmUHMiEjNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIh33Sm63T1PRGCIWGRnX1M9RoxvbfwwkEDNWs1YHT/32cp18gd77/d7m7ZmQNXfOxQ3O+w9V8UoBKBmd4AtX/qOMQwdEGA7kbTBQYTW+XLqtlRAh6HUgsWgmCJEDBEznXsuff99KUO35GsaJJX9Uln+C+iWQgarID5fKz9ue68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QkmySzpK; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkmySzpK"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70a57a8ffc3so7477827b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jul 2025 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751632941; x=1752237741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+xZAgEpXQw9XEMQ8UWSFJQF613D//CkHQJza5cnA1U=;
        b=QkmySzpKjxUhrpVp06QZITdiw07YSlGTTGiUCBa9ey3HZyO8VGhScyhWD/I2Y0AovI
         iBAZdhG5D/Fyi3hKjZ1tzVbs05/VDa2xvSibxkzoS+qYMDhEuTFTGoZtnC2p+Oe32YFs
         OymFvjirlfKZ1YjxEiJhDNb0fxT5fzaoruybJyUfJNGfq+GbBBXN8FtLmpQnTyibk6UN
         oomd0bdld5QLGst7qmWGXApwUuuSCevjOApLMHDJO/0fr74rn1UgRa0oDPX6imwFgmlb
         niJrKpsGKHGBOqsTGButkQMZ+FxsCXSOWkdPJNtYq9yjd3mREoc6UkLOBZ5oG6Ph72+l
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632941; x=1752237741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+xZAgEpXQw9XEMQ8UWSFJQF613D//CkHQJza5cnA1U=;
        b=gRhNmzWMF1QCwpYWJ0Dby6vVe12oGvTMJHB07OWDf6TFMsH+IArB2/bSf64fGgbGXj
         TDCq1F83R4TJ+f0qwyr/n9e7YISGC9N8uuQNk135Dva4ZMTQVbnqUh18dlyyapjmSu2t
         a7ct6nnLYjRkVKOYgi4kfb8SZFsqlx8QK+D+6+wvffuF3nZRrk0QtZJt2+BQFvMBWHyG
         E0fmo8p/o/GV3XdWmQaEmrXd6+Zxe+W4tiqdZRx/uI/QE8pwic8EnMgMnio98sCcHrk5
         n+O4Ud7vLzS28UnObP55Z6DleKROmUqs6LAzmeeluz3QH956tJi9moXRwYP2THOU0sl3
         HwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL0703C8829RPAyLVCL54qWdcO05My1lmmkaAdqe8oLu1Sw+5cHsllOj3YKJGLBFWTUV5uFiJ4RWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIitIuR+9dvn26MKdGhnxKeXpCE3CEzi4Ivu7wXiQ6jlqy9Dt
	jJhCpW9Dfci8VyUP3iO9uKVpeUJBGWH4kRsIXmyIsvCJatq8yx1oCyghF3FGBs/uMH9O/2u2gOd
	0UgD9j2MFkz1CEaao3wsw2aLUT4FxjNVWyugYxFTOvg==
X-Gm-Gg: ASbGncv21Ny2zGT2nmYnLiSYWz6NXsVzy8wRJ7/tdLrGH1/DcVnr/dgEXe88HQrWc7+
	yG8UDcJhovnhO9TplGWyFCVEoV+gjqn8bt7GRua+Hc95lHhLMs6VMoicnwZNUTc0IZEVj5zvp42
	lFzoeygVn/XgXMkIbbR5bVh+Jq1oU2Z/c7ub6Uar1K/tze
X-Google-Smtp-Source: AGHT+IHVarmgypubI34h2UIg76kDJVX9+UIk/GkNQ2pUyErEVTAjeVmdTLsTkNExVJpadxTXUnrEKH8TbIhSpPzSGNM=
X-Received: by 2002:a05:690c:4b90:b0:70e:2c7f:2edd with SMTP id
 00721157ae682-71668bf0c54mr27659387b3.9.1751632940793; Fri, 04 Jul 2025
 05:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616102917.1677116-1-o.rempel@pengutronix.de> <20250616102917.1677116-2-o.rempel@pengutronix.de>
In-Reply-To: <20250616102917.1677116-2-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Jul 2025 14:41:44 +0200
X-Gm-Features: Ac12FXwW92izlWIC45OsAgH-R3gV8ZKwX1tkCnI4QJZXvaNcOq0gtdvhdR0VT1g
Message-ID: <CAPDyKFrce5O9sAxTaqWaV_b9pCvPuaqus+YCtRdYrP54EWajBg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: core: Add infrastructure for undervoltage handling
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 12:29, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Implement the core infrastructure to allow MMC bus types to handle
> REGULATOR_EVENT_UNDER_VOLTAGE events from power regulators. This is
> primarily aimed at allowing devices like eMMC to perform an emergency
> shutdown to prevent data corruption when a power failure is imminent.
>
> This patch introduces:
> - A new 'handle_undervoltage' function pointer to 'struct mmc_bus_ops'.
>   Bus drivers (e.g., for eMMC) can implement this to define their
>   emergency procedures.
> - A workqueue ('uv_work') in 'struct mmc_supply' to handle the event
>   asynchronously in a high-priority context.
> - A new function 'mmc_handle_undervoltage()' which is called from the
>   workqueue. It stops the host queue to prevent races with card removal,
>   checks for the bus op, and invokes the handler.
> - Functions to register and unregister the regulator notifier, intended
>   to be called by bus drivers like 'mmc_attach_mmc' when a compatible
>   card is detected.
>
> The notifier is only registered for the main 'vmmc' supply, as
> undervoltage
> handling for 'vqmmc' or 'vqmmc2' is not required at this time.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks a lot better, thanks!

Although, I think there are some additional simplifications that can
be made, please have a look below.

> ---
> changes v6:
> - Rewrite commit message to be more technical per reviewer feedback.
> - Address race conditions by using __mmc_stop_host() instead of only
>   claiming the host in the undervoltage handler.
> - Move notifier registration from mmc_regulator_get_supply() to the end of
>   a successful card initialization in mmc_attach_mmc(), ensuring it only
>   runs for capable cards.
> - Centralize notifier unregistration in mmc_remove_card() to correctly
>   handle all card removal and error paths.
> - Add 'undervoltage_notify_registered' flag to struct mmc_host to
>   reliably track the notifier state.
> - Consolidate multiple notifier callbacks into a single, generic handler.
> - Remove premature notifier support for vqmmc and vqmmc2 regulators.
> - Move INIT_WORK() for the undervoltage workqueue to mmc_alloc_host().
> changes v3:
> - filter supported cards at early stage
> - add locking in mmc_handle_regulator_event()
> - claim/release host in mmc_handle_undervoltage()
>
> Background & Decision at LPC24:
>
> This solution was proposed and refined during LPC24 in the talk
> "Graceful Under Pressure: Prioritizing Shutdown to Protect Your Data in
> Embedded Systems," which aimed to address how Linux should handle power
> fluctuations in embedded devices to prevent data corruption or storage
> damage.
>
> At the time, multiple possible solutions were considered:
> 1. Triggering a system-wide suspend or shutdown: when undervoltage is
>    detected, with device-specific prioritization to ensure critical
>    components shut down first.
>    - This approach was disliked by Greg Kroah-Hartman, as it introduced
>      complexity and was not suitable for all use cases.
>
> 2. Notifying relevant devices through the regulator framework: to allow
>    graceful per-device handling.
>    - This approach was agreed upon as the most acceptable by participants
>      in the discussion, including Greg Kroah-Hartman, Mark Brown,
>      and Rafael J. Wysocki.
>    - This patch implements that decision by integrating undervoltage
>      handling into the MMC subsystem.
> ---
>  drivers/mmc/core/bus.c       |  5 +++
>  drivers/mmc/core/core.c      | 33 +++++++++++++++
>  drivers/mmc/core/core.h      |  2 +
>  drivers/mmc/core/host.c      |  3 ++
>  drivers/mmc/core/mmc.c       |  6 +++
>  drivers/mmc/core/regulator.c | 82 ++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h     | 10 +++++
>  7 files changed, 141 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 1cf64e0952fb..aa3454cb0702 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -394,6 +394,11 @@ void mmc_remove_card(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>
> +       if (host->undervoltage_notify_registered) {

I don't think we need a new parameter here
(undervoltage_notify_registered). Instead we should register the
notifier in mmc_add_card() and after the point where
mmc_card_set_present() gets called. In this way, we can instead rely
on mmc_card_present() a few lines below, to understand when
unregistering the notifier should be done.

> +               mmc_regulator_unregister_undervoltage_notifier(host);
> +               host->undervoltage_notify_registered = false;
> +       }
> +
>         mmc_remove_card_debugfs(card);
>
>         if (mmc_card_present(card)) {
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a0e2dce70434..0b000246481c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1399,6 +1399,39 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>         mmc_power_up(host, ocr);
>  }
>
> +/**
> + * mmc_handle_undervoltage - Handle an undervoltage event on the MMC bus
> + * @host: The MMC host that detected the undervoltage condition
> + *
> + * This function is called when an undervoltage event is detected on one of
> + * the MMC regulators.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +       int ret;
> +
> +       /* Stop the host to prevent races with card removal */
> +       __mmc_stop_host(host);
> +
> +       mmc_claim_host(host);

If we instead register the notifier in mmc_add_card() and after the
point where mmc_card_set_present() gets called, we don't need to
claim/release the host here. Instead that is better dealt with from
the actual ->bus_ops() callback.

More precisely, the bus_ops can't be removed as we have stopped the
host. Since we are also unregistering the notifier in
mmc_remove_card() and canceling the work, this is also prevented from
being racy during the host-removal.

> +
> +       if (!host->bus_ops || !host->bus_ops->handle_undervoltage) {
> +               mmc_release_host(host);
> +               return 0;
> +       }
> +
> +       dev_warn(mmc_dev(host), "%s: Undervoltage detected, initiating emergency stop\n",
> +                mmc_hostname(host));
> +
> +       ret = host->bus_ops->handle_undervoltage(host);
> +
> +       mmc_release_host(host);
> +
> +       return ret;
> +}
> +
>  /*
>   * Assign a mmc bus handler to a host. Only one bus handler may control a
>   * host at any given time.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 622085cd766f..31e5918f6e95 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -31,6 +31,7 @@ struct mmc_bus_ops {
>         int (*sw_reset)(struct mmc_host *);
>         bool (*cache_enabled)(struct mmc_host *);
>         int (*flush_cache)(struct mmc_host *);
> +       int (*handle_undervoltage)(struct mmc_host *host);
>  };
>
>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
> @@ -59,6 +60,7 @@ void mmc_power_off(struct mmc_host *host);
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr);
>  void mmc_set_initial_state(struct mmc_host *host);
>  u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +int mmc_handle_undervoltage(struct mmc_host *host);
>
>  static inline void mmc_delay(unsigned int ms)
>  {
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f14671ea5716..6fd07318c139 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -564,6 +564,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
>         timer_setup(&host->retune_timer, mmc_retune_timer, 0);
>
> +       INIT_WORK(&host->supply.uv_work, mmc_undervoltage_workfn);
> +       host->undervoltage_notify_registered = false;
> +
>         /*
>          * By default, hosts do not support SGIO or large requests.
>          * They have to set these according to their abilities.
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..5689ab6eefe1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2370,6 +2370,12 @@ int mmc_attach_mmc(struct mmc_host *host)
>                 goto remove_card;
>
>         mmc_claim_host(host);
> +
> +       if (host->card->ext_csd.power_off_notification == EXT_CSD_POWER_ON) {
> +               mmc_regulator_register_undervoltage_notifier(host);
> +               host->undervoltage_notify_registered = true;
> +       }
> +

As stated above, let's do this in mmc_add_card() instead. In then
becomes up to the ->bus_ops() callback to decide what to do, if
anything at all, depending what type of card it is.

>         return 0;
>
>  remove_card:
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 3dae2e9b7978..85c318fd98fa 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -7,6 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/log2.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
>
>  #include <linux/mmc/host.h>
>
> @@ -262,6 +263,87 @@ static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
>
>  #endif /* CONFIG_REGULATOR */
>
> +/* To be called from a high-priority workqueue */
> +void mmc_undervoltage_workfn(struct work_struct *work)
> +{
> +       struct mmc_supply *supply;
> +       struct mmc_host *host;
> +
> +       supply = container_of(work, struct mmc_supply, uv_work);
> +       host = container_of(supply, struct mmc_host, supply);
> +
> +       mmc_handle_undervoltage(host);
> +}
> +EXPORT_SYMBOL_GPL(mmc_undervoltage_workfn);

No need to EXPORT the symbol, it's used from the same module.

> +
> +static int mmc_handle_regulator_event(struct notifier_block *nb,
> +                                     unsigned long event, void *data)
> +{
> +       struct mmc_supply *supply = container_of(nb, struct mmc_supply,
> +                                                vmmc_nb);
> +       struct mmc_host *host = container_of(supply, struct mmc_host, supply);
> +       unsigned long flags;
> +
> +       switch (event) {
> +       case REGULATOR_EVENT_UNDER_VOLTAGE:
> +               spin_lock_irqsave(&host->lock, flags);
> +               if (host->undervoltage) {

So the regulator core is firing these notifications over and over again?

Sure, we can deal with this internally for mmc for now, but ideally we
don't want the regulator core to spam us with notifications, right?

> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       return NOTIFY_OK;
> +               }
> +
> +               host->undervoltage = true;
> +               spin_unlock_irqrestore(&host->lock, flags);
> +
> +               queue_work(system_highpri_wq, &host->supply.uv_work);
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +/**
> + * mmc_regulator_register_undervoltage_notifier - Register for undervoltage
> + *                                               events
> + * @host: MMC host
> + *
> + * To be called by a bus driver when a card supporting graceful shutdown
> + * is attached.
> + */
> +void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host)
> +{
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(host->supply.vmmc))
> +               return;
> +
> +       host->supply.vmmc_nb.notifier_call = mmc_handle_regulator_event;
> +       ret = regulator_register_notifier(host->supply.vmmc,
> +                                         &host->supply.vmmc_nb);
> +       if (ret)
> +               dev_warn(mmc_dev(host), "Failed to register vmmc notifier: %d\n", ret);
> +}
> +EXPORT_SYMBOL_GPL(mmc_regulator_register_undervoltage_notifier);

No need to EXPORT the symbol, it's used from the same module.

> +
> +/**
> + * mmc_regulator_unregister_undervoltage_notifier - Unregister undervoltage
> + *                                                 notifier
> + * @host: MMC host
> + */
> +void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host)
> +{
> +       if (IS_ERR_OR_NULL(host->supply.vmmc))
> +               return;
> +
> +       regulator_unregister_notifier(host->supply.vmmc, &host->supply.vmmc_nb);
> +
> +       /* Ensure any pending work is flushed before the card is removed */
> +       cancel_work_sync(&host->supply.uv_work);
> +}
> +EXPORT_SYMBOL_GPL(mmc_regulator_unregister_undervoltage_notifier);

No need to EXPORT the symbol, it's used from the same module.

> +
>  /**
>   * mmc_regulator_get_supply - try to get VMMC and VQMMC regulators for a host
>   * @mmc: the host to regulate
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..9b7bb4b7150c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
>  #include <linux/debugfs.h>
> +#include <linux/workqueue.h>
>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/card.h>
> @@ -342,6 +343,9 @@ struct mmc_supply {
>         struct regulator *vmmc;         /* Card power supply */
>         struct regulator *vqmmc;        /* Optional Vccq supply */
>         struct regulator *vqmmc2;       /* Optional supply for phy */
> +
> +       struct notifier_block vmmc_nb;  /* Notifier for vmmc */
> +       struct work_struct uv_work;     /* Undervoltage work */
>  };
>
>  struct mmc_ctx {
> @@ -493,6 +497,9 @@ struct mmc_host {
>         unsigned int            retune_crc_disable:1; /* don't trigger retune upon crc */
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
> +       unsigned int            undervoltage:1;  /* Undervoltage state */
> +       /* Undervoltage notifier is registered */
> +       unsigned int            undervoltage_notify_registered:1;
>
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
> @@ -659,6 +666,9 @@ static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>  int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
>  void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
> +void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
> +void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
> +void mmc_undervoltage_workfn(struct work_struct *work);
>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
>  {
> --
> 2.39.5
>

Kind regards
Uffe
