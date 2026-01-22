Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AA360725
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103230; cv=pass; b=oEFQz6BNTjlt/b6KXymbPaMKYdb+1bh2mtyiDn0I03QMiBDqj7Wwu6dac03KXtbR5hlOPGW7bsV6z94LkrVRC8rdYRc01MY/7ah1DASePCgwreGWeaukeBQt3+Ds7CaJ1fdL0v/FkAWyYODwnMmEiX0248oHmQB3NTTviiE9ePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103230; c=relaxed/simple;
	bh=rBgLROGkyGYznxqWSuRkU5F4AzgyzuGopbrdq+I0uRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGyhoKFcPOZU0ZVqMKwP5H4WrXHnoxnBr+AsXYT5dPTJzzjBiCZwQSaPhJIUaDh3RNXzSvKe9GYUuTwaE9yjUeSKR+b430GZz0p+2JUvnsFYPd/CP93159cOg2hModm2kR0t/SHAZsAM2CkiYPnlZYQbpb/FvFcHCAD9XvKzCvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6M4j1h3; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6M4j1h3"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b834e3d64so1502554e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 09:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769103211; cv=none;
        d=google.com; s=arc-20240605;
        b=PoVNOQHHcjBiwBDmyz3hllF2Fg3Fr0XLu9Zf7n6/Ove+FKKcnVFi9jy3G/5dDqVLZd
         gGPfFIq2y2RdNCvwBMrmB4/Q7q9c7RWnWcScZ3W/K/RMU1gg46HSLsz3f26r+NSzHoWC
         sJlXFtVz9a5Nud9hSUECtlUw8NEC2gao87y1UAPmRRZnBAnQeTdyNGByJaGEJXaUDce3
         tiCdOUQsbgR4/i7VbsFp67qOY/UvUXXZ/etZ1tSUMy3u44syV63kyLgXM8xBffdxsrhd
         I+WT+lto6DbeCv1BUivIdfy3X0u3Wo8HFMeLOfW6voWtFnTnVW/nKQNC/xhB1NHdoC/l
         xeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        fh=p9Q718veRy86CEOdj6KsKMk8g2nKGkp5F9xxh/cLvGw=;
        b=W2qsugW/XW21UmOememwsODxXZQKU5I8SCpwp3Zp1iU8LxvLJ+bHupjQAZfqlyVTCk
         EO9wcPIN0zrnSRfn7bXJeUF0PdAVnD0QPC/v6vpU+MAWdrg8b/liD00LtltLWXiiS7wm
         1inpW+fw9IpBS23RdfIPrFLQUjuOvSfcMRhIx90HwJwfSbilzSEDPLgJJEi+/5IHb5Mx
         KOPQYh+Vg8v6A85hw292bc3s06j+VNYO5uNGC2yORy9zPW5MnUN+OLUPzPfHcLHqo/Tp
         D52T+iWOSYoh2ybxnIEUZwfINO9j6tM4ZvYXM5eDYcoL+Uj//idv3M5I2md9uYeb3hoE
         NxfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769103211; x=1769708011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        b=R6M4j1h3KfxZWWsckpE/6oWW4PCRkxR8EU4RfYw6AJimplHHJZ9zkt8kXc09dBNNhr
         bo6oHb7EzBj7Xk8IaJgszrHG/VrBte6OEVxHi/vMDhdQgvTSudF1/2hmIj0axdx66670
         dZw9Nvu7OYg8R0JOcfA1gqYt+pse7ZgNIBEWGCBtbR4LB6Ly6kJ0sRRuGProlN1acYiN
         lyfAeHQHEnq3hJfA+Q9FtQ7dXhkb/Dr/dFOXL7CvMY4Z91oy/PH+IZXR46KTMU0cNSyT
         bN5MjICeMG7ZemnSWgD0e6teHH3pp7gbnzdupxfUPBeL5hx3m+hvUczAiXBSBPQ3Wxrc
         /OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769103211; x=1769708011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        b=rAUtlbWi4TmqbbaXwbduWA+9P170uW704oz67hNidFZedpZh8rYx5NjrgQJ6wiypAL
         BsOPjW9FwVtYs+BFiCruI+k5VTYsETU5noF0yq40fIWXJywOx149mSUCCOlLEacTSxGU
         5vmbJfqkINs2wZNlpcCQUQGardHlgEpAcStpgjiOZSlJlzzDN7SQYO5CDnvfsW/i0Dcl
         3U8lM+DUk35aZ6UABAhBa05xHVlB/mLNvXEZpSypVakrKZS0xtmstsVeM7fqA2cd1qVV
         /a9CXMN6IgrASyP29wH7Ti2GQAJSxy08qTn0jjzzQ14XNHMTrbyQy5159F0kAONCfOEP
         CFCg==
X-Gm-Message-State: AOJu0Yw03ynWU4/CWbUzFqfw9aqFC7lR69g7qHkuUJsQTLoklsCgbh9a
	625XvN+URD3zQhr+TrVASEVNStSr9+ih1YIbTz8ceIfEtQmTmxfq48dEx5E9dQBtWRTyXAAVww1
	wmh87Zwy2AGH1AkwMAPdtQG6so9mJYuh//u0YS1hQ2A==
X-Gm-Gg: AZuq6aL0aOK6OryVzMipwN+QScas2R9Y/Wxj2UTNGE2DzwR2nZv1y1y5zSVVHWMPj9T
	hx/peFe2nkDp3JB4LQEnX7rj8PlbjlV0WjaITcdtICv0kWZLo7pPZhdNrc2i8mCxoaybLSyl8o7
	botDtgGOQ3NEJW3u9i5MOC5CPwSyjf9mWSzbhqxGJtY9VKFTRU+kho2PYeOKS8GXxWp0HgI4NAO
	XyV6i9fZKzy/bmzOoSf+IysjuYQG5073RMlEp6LuPeWJ9/YYN19x4wC1PO5zqXe5K1s3lv3
X-Received: by 2002:a05:6512:3504:b0:59d:d679:2a6d with SMTP id
 2adb3069b0e04-59de4916eeemr34747e87.23.1769103211187; Thu, 22 Jan 2026
 09:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214648.168365-1-pgeng@nvidia.com>
In-Reply-To: <20260115214648.168365-1-pgeng@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 18:32:55 +0100
X-Gm-Features: AZwV_Qgym-tguzdbKVLzMRHcvH4LFPmeb3zCUxWdfkYYh9QZZgSZ7Dgv9E0urcE
Message-ID: <CAPDyKFqYgOOJdT-0oxCyrfCjW8SuORX3+tXq1D09Qj1jYDOKpw@mail.gmail.com>
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
To: Penghe Geng <pgeng@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Adrian

On Thu, 15 Jan 2026 at 22:46, Penghe Geng <pgeng@nvidia.com> wrote:
>
> The host->claimed flag shares a bitfield storage word with several
> retune flags (retune_now, retune_paused, can_retune, doing_retune,
> doing_init_tune). Updating those flags without host->lock can RMW the
> shared word and clear claimed, triggering spurious
> WARN_ON(!host->claimed).
>
> Serialize all retune bitfield updates with host->lock. Provide lockless
> __mmc_retune_* helpers so callers that already hold host->lock can
> avoid deadlocks while public wrappers serialize updates. Also protect
> doing_init_tune and the CQE retune_now assignment with host->lock.
>
> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>

Thanks for the patch! I have looped in Adrian to get his opinion on this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
>  drivers/mmc/core/mmc.c   |  6 ++++
>  drivers/mmc/core/queue.c |  3 ++
>  include/linux/mmc/host.h |  4 +++
>  5 files changed, 94 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95dbfd9cf..0b6b4a31f629 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
>   */
>  void mmc_retune_enable(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         host->can_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>         if (host->retune_period)
>                 mod_timer(&host->retune_timer,
>                           jiffies + host->retune_period * HZ);
> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
>   */
>  void mmc_retune_pause(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (!host->retune_paused) {
>                 host->retune_paused = 1;
> -               mmc_retune_hold(host);
> +               __mmc_retune_hold(host);
>         }
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>  EXPORT_SYMBOL(mmc_retune_pause);
>
>  void mmc_retune_unpause(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +       bool released;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->retune_paused) {
>                 host->retune_paused = 0;
> -               mmc_retune_release(host);
> +               released = __mmc_retune_release(host);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               if (!released)
> +                       WARN_ON(1);
> +       } else {
> +               spin_unlock_irqrestore(&host->lock, flags);
>         }
>  }
>  EXPORT_SYMBOL(mmc_retune_unpause);
> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
>   */
>  void mmc_retune_disable(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
>         mmc_retune_unpause(host);
> +       spin_lock_irqsave(&host->lock, flags);
>         host->can_retune = 0;
> +       spin_unlock_irqrestore(&host->lock, flags);
>         timer_delete_sync(&host->retune_timer);
>         mmc_retune_clear(host);
>  }
> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
>
>  void mmc_retune_hold(struct mmc_host *host)
>  {
> -       if (!host->hold_retune)
> -               host->retune_now = 1;
> -       host->hold_retune += 1;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __mmc_retune_hold(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  void mmc_retune_release(struct mmc_host *host)
>  {
> -       if (host->hold_retune)
> -               host->hold_retune -= 1;
> -       else
> +       unsigned long flags;
> +       bool released;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       released = __mmc_retune_release(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +       if (!released)
>                 WARN_ON(1);
>  }
>  EXPORT_SYMBOL(mmc_retune_release);
> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
>  {
>         bool return_to_hs400 = false;
>         int err;
> +       unsigned long flags;
>
> -       if (host->retune_now)
> -               host->retune_now = 0;
> -       else
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (!host->retune_now) {
> +               spin_unlock_irqrestore(&host->lock, flags);
>                 return 0;
> +       }
> +       host->retune_now = 0;
>
> -       if (!host->need_retune || host->doing_retune || !host->card)
> +       if (!host->need_retune || host->doing_retune || !host->card) {
> +               spin_unlock_irqrestore(&host->lock, flags);
>                 return 0;
> +       }
>
>         host->need_retune = 0;
> -
>         host->doing_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         if (host->ios.timing == MMC_TIMING_MMC_HS400) {
>                 err = mmc_hs400_to_hs200(host->card);
> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
>         if (return_to_hs400)
>                 err = mmc_hs200_to_hs400(host->card);
>  out:
> +       spin_lock_irqsave(&host->lock, flags);
>         host->doing_retune = 0;
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         return err;
>  }
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 5941d68ff989..07e4f427fe15 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
>  void mmc_retune_pause(struct mmc_host *host);
>  void mmc_retune_unpause(struct mmc_host *host);
>
> -static inline void mmc_retune_clear(struct mmc_host *host)
> +static inline void __mmc_retune_clear(struct mmc_host *host)
>  {
>         host->retune_now = 0;
>         host->need_retune = 0;
>  }
>
> +static inline void mmc_retune_clear(struct mmc_host *host)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __mmc_retune_clear(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static inline void __mmc_retune_hold(struct mmc_host *host)
> +{
> +       if (!host->hold_retune)
> +               host->retune_now = 1;
> +       host->hold_retune += 1;
> +}
> +
> +static inline bool __mmc_retune_release(struct mmc_host *host)
> +{
> +       if (host->hold_retune) {
> +               host->hold_retune -= 1;
> +               return true;
> +       }
> +       return false;
> +}
> +
>  static inline void mmc_retune_hold_now(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         host->retune_now = 0;
>         host->hold_retune += 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline void mmc_retune_recheck(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->hold_retune <= 1)
>                 host->retune_now = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7c86efb1044a..114febd15f08 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 goto free_card;
>
>         if (mmc_card_hs200(card)) {
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->doing_init_tune = 1;
> +               spin_unlock_irqrestore(&host->lock, flags);
>
>                 err = mmc_hs200_tuning(card);
>                 if (!err)
>                         err = mmc_select_hs400(card);
>
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->doing_init_tune = 0;
> +               spin_unlock_irqrestore(&host->lock, flags);
>
>                 if (err)
>                         goto free_card;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..5e38759c87f5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>         enum mmc_issue_type issue_type;
>         enum mmc_issued issued;
>         bool get_card, cqe_retune_ok;
> +       unsigned long flags;
>         blk_status_t ret;
>
>         if (mmc_card_removed(mq->card)) {
> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 mmc_get_card(card, &mq->ctx);
>
>         if (host->cqe_enabled) {
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->retune_now = host->need_retune && cqe_retune_ok &&
>                                    !host->hold_retune;
> +               spin_unlock_irqrestore(&host->lock, flags);
>         }
>
>         blk_mq_start_request(req);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..e7bddbafd1da 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
>
>  static inline void mmc_retune_needed(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->can_retune)
>                 host->need_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline bool mmc_can_retune(struct mmc_host *host)
> --
> 2.43.0
>
