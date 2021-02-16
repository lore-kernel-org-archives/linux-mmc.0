Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE11C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 08:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C14264D9A
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 08:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBPIeD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Feb 2021 03:34:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:56308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhBPIeC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Feb 2021 03:34:02 -0500
IronPort-SDR: B2XpWqXsYLTXt7XSv9OpK1pR1wVoNv1B3f356zAATQ9qkL7E1bADLa1DW+AdGlwqbClWZMtcht
 2vKMETccEX9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="202023234"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="202023234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 00:33:29 -0800
IronPort-SDR: 1jmIkzGML/HI1HvQJ6C4fEMX5N+iFX7ECfV2CC209LKyxPdZfqIdtTrVr6vbSWj0/71o8hBUju
 UmVKokwNJaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="438842125"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 00:33:27 -0800
Subject: Re: [PATCH 2/2] mmc: core: Drop reference counting of the bus_ops
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20210212131610.236843-1-ulf.hansson@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3dfcc8bb-5249-884b-31d3-ddb6b5b93347@intel.com>
Date:   Tue, 16 Feb 2021 10:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210212131610.236843-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/02/21 3:16 pm, Ulf Hansson wrote:
> When the mmc_rescan work is enabled for execution (host->rescan_disable),
> it's the only instance per mmc host that is allowed to set/clear the
> host->bus_ops pointer.
> 
> Besides the mmc_rescan work, there are a couple of scenarios when the
> host->bus_ops pointer may be accessed. Typically, those can be described as
> as below:
> 
> *)
> Upper mmc driver layers (like the mmc block device driver or an SDIO
> functional driver) needs to execute a host->bus_ops callback. This can be
> considered as safe without having to use some special locking mechanism,
> because they operate on top of the struct mmc_card. As long as there is a
> card to operate upon, the mmc core guarantees that there is a host->bus_ops
> assigned as well. Note that, upper layer mmc drivers are of course
> responsible to clean up from themselves from their ->remove() callbacks,
> otherwise things would fall apart anyways.
> 
> **)
> Via the mmc host instance, we may need to force a removal of an inserted
> mmc card. This happens when a mmc host driver gets unbind, for example. In
> this case, we protect the host->bus_ops pointer from concurrent accesses,
> by disabling the mmc_rescan work upfront (host->rescan_disable). See
> mmc_stop_host() for example.
> 
> This said, it seems like the reference counting of the host->bus_ops
> pointer at some point have become superfluous. As this is an old mechanism
> of the mmc core, it a bit difficult to digest the history of when that
> could have happened. However, let's drop the reference counting to avoid
> unnecessary code-paths and lockings.
> 
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/core.c  | 89 ++--------------------------------------
>  include/linux/mmc/host.h |  2 -
>  2 files changed, 4 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2e41fa598bd6..860995eb548b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1377,63 +1377,13 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>  	mmc_power_up(host, ocr);
>  }
>  
> -/*
> - * Cleanup when the last reference to the bus operator is dropped.
> - */
> -static void __mmc_release_bus(struct mmc_host *host)
> -{
> -	WARN_ON(!host->bus_dead);
> -
> -	host->bus_ops = NULL;
> -}
> -
> -/*
> - * Increase reference count of bus operator
> - */
> -static inline void mmc_bus_get(struct mmc_host *host)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&host->lock, flags);
> -	host->bus_refs++;
> -	spin_unlock_irqrestore(&host->lock, flags);
> -}
> -
> -/*
> - * Decrease reference count of bus operator and free it if
> - * it is the last reference.
> - */
> -static inline void mmc_bus_put(struct mmc_host *host)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&host->lock, flags);
> -	host->bus_refs--;
> -	if ((host->bus_refs == 0) && host->bus_ops)
> -		__mmc_release_bus(host);
> -	spin_unlock_irqrestore(&host->lock, flags);
> -}
> -
>  /*
>   * Assign a mmc bus handler to a host. Only one bus handler may control a
>   * host at any given time.
>   */
>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
>  {
> -	unsigned long flags;
> -
> -	WARN_ON(!host->claimed);
> -
> -	spin_lock_irqsave(&host->lock, flags);
> -
> -	WARN_ON(host->bus_ops);
> -	WARN_ON(host->bus_refs);
> -
>  	host->bus_ops = ops;
> -	host->bus_refs = 1;
> -	host->bus_dead = 0;
> -
> -	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  /*
> @@ -1441,18 +1391,7 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
>   */
>  void mmc_detach_bus(struct mmc_host *host)
>  {
> -	unsigned long flags;
> -
> -	WARN_ON(!host->claimed);
> -	WARN_ON(!host->bus_ops);
> -
> -	spin_lock_irqsave(&host->lock, flags);
> -
> -	host->bus_dead = 1;
> -
> -	spin_unlock_irqrestore(&host->lock, flags);
> -
> -	mmc_bus_put(host);
> +	host->bus_ops = NULL;
>  }
>  
>  void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
> @@ -2244,32 +2183,15 @@ void mmc_rescan(struct work_struct *work)
>  		host->trigger_card_event = false;
>  	}
>  
> -	mmc_bus_get(host);
> -
>  	/* Verify a registered card to be functional, else remove it. */
> -	if (host->bus_ops && !host->bus_dead)
> +	if (host->bus_ops)
>  		host->bus_ops->detect(host);
>  
>  	host->detect_change = 0;
>  
> -	/*
> -	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
> -	 * the card is no longer present.
> -	 */
> -	mmc_bus_put(host);
> -	mmc_bus_get(host);
> -
>  	/* if there still is a card present, stop here */
> -	if (host->bus_ops != NULL) {
> -		mmc_bus_put(host);
> +	if (host->bus_ops != NULL)
>  		goto out;
> -	}
> -
> -	/*
> -	 * Only we can add a new handler, so it's safe to
> -	 * release the lock here.
> -	 */
> -	mmc_bus_put(host);
>  
>  	mmc_claim_host(host);
>  	if (mmc_card_is_removable(host) && host->ops->get_cd &&
> @@ -2332,18 +2254,15 @@ void mmc_stop_host(struct mmc_host *host)
>  	/* clear pm flags now and let card drivers set them as needed */
>  	host->pm_flags = 0;
>  
> -	mmc_bus_get(host);
> -	if (host->bus_ops && !host->bus_dead) {
> +	if (host->bus_ops) {
>  		/* Calling bus_ops->remove() with a claimed host can deadlock */
>  		host->bus_ops->remove(host);
>  		mmc_claim_host(host);
>  		mmc_detach_bus(host);
>  		mmc_power_off(host);
>  		mmc_release_host(host);
> -		mmc_bus_put(host);
>  		return;
>  	}
> -	mmc_bus_put(host);
>  
>  	mmc_claim_host(host);
>  	mmc_power_off(host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 927ba7566617..7b5555c705fd 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -423,7 +423,6 @@ struct mmc_host {
>  	/* group bitfields together to minimize padding */
>  	unsigned int		use_spi_crc:1;
>  	unsigned int		claimed:1;	/* host exclusively claimed */
> -	unsigned int		bus_dead:1;	/* bus has been released */
>  	unsigned int		doing_init_tune:1; /* initial tuning in progress */
>  	unsigned int		can_retune:1;	/* re-tuning can be used */
>  	unsigned int		doing_retune:1;	/* re-tuning in progress */
> @@ -455,7 +454,6 @@ struct mmc_host {
>  	struct mmc_slot		slot;
>  
>  	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
> -	unsigned int		bus_refs;	/* reference counter */
>  
>  	unsigned int		sdio_irqs;
>  	struct task_struct	*sdio_irq_thread;
> 

