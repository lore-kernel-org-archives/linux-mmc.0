Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1AC28D13
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiHVLJr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiHVLJV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 07:09:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA615717
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 04:08:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x25so10222685ljm.5
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oYwdzPKKw9ZsUN52LbCsFYOCZJG8rJFCpgzANnHe1Co=;
        b=UL/OMuIEw0GTQCPeuEcBn7pYCaoSpBh56ZPplY3u0OaKsN+bPm2JngNM9qG6DmHLHj
         dSgRKmlzRE0VmppC6A6b7JU2mOL27pf1LwCbUni27LcwgHD92uCfpQ9gMl8EUMad1nTJ
         FBicXfXCFWjw5P+MbyEmwirjEmWVj/kmCiZZ74N3fOVPSEzLi595YqkxMaJ+sjJV7m7K
         BRKXQeEhsp+mz/gRxc9s28MAJN0wojpYXH5RXiNUuufDUdOtctGzQiBOY0VSGeFO+uMR
         N8yidJd9mjWNm8AgCCAm/TRhPAhdCVv72mvwMF+Jo08NxfcvRAC9j9BaAf1W5h1zfJJ/
         9UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oYwdzPKKw9ZsUN52LbCsFYOCZJG8rJFCpgzANnHe1Co=;
        b=jv+Sv02eNWY3kUVWrE33Fbop6Hx1FzS/kPJTPkb+SkSkNomspk10OEuWtPnZr7ECUn
         aRH9ycJ8CiK4cL4k02x0AnEpn4lHrcNv/pw8fS/ysTLWYy5jLCBylUAgOql/sYaxZSF6
         MLMF63bM83NTK6AfgLi0QAQIT0aqupxA/9B0FsgOCg6QJpiwWIMPWJzahy9TXwVv8J66
         V5GUITnqGsfI3zKZwy6rmOiLx+qetzTbI43c4F0vy+/TfeBHRhQOacgKB52nferWj8hL
         xCvBDCjul0E1nhhZZiacsafmrukmJwThpFSerQkiM9p/XAGrQsSrtuuN6jHNg4YPuTAX
         i6+w==
X-Gm-Message-State: ACgBeo3hj7pOc1GkhFOyCkAUUyyd2fvJR9tsOUz5xLv7v9gN4ynaWbkh
        KTninEIZxujYMGSaL7C+nmDr/1AWRdkadz+3J27zMAAQaUA=
X-Google-Smtp-Source: AA6agR5MBojqskyb2yl7D59trdpoumQMJtL4HpEWUfWiIXI0GTghNHwmLydxk9qAt7MGDWer562NU1NxbCHZEy5z0MA=
X-Received: by 2002:a2e:b746:0:b0:261:cc50:35cf with SMTP id
 k6-20020a2eb746000000b00261cc5035cfmr1629281ljo.4.1661166528934; Mon, 22 Aug
 2022 04:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <13d8200a-e2a8-d907-38ce-a16fc5ce14aa@gmail.com>
In-Reply-To: <13d8200a-e2a8-d907-38ce-a16fc5ce14aa@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Aug 2022 13:08:12 +0200
Message-ID: <CAPDyKFqus+8VOfnfGr_FGrUMbtK18FZP-isiZ9Q5sD1fJF5KMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Switch to basic workqueue API for sdio_irq_work
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 19 Aug 2022 at 23:26, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> The delay parameter isn't set by any user, therefore simplify the code
> and switch to the basic workqueue API w/o delay support. This also
> reduces the size of struct mmc_host.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c     | 2 +-
>  drivers/mmc/core/sdio.c     | 4 ++--
>  drivers/mmc/core/sdio_irq.c | 4 ++--
>  include/linux/mmc/host.h    | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0fd91f749..b89dca1f1 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -565,7 +565,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         spin_lock_init(&host->lock);
>         init_waitqueue_head(&host->wq);
>         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> -       INIT_DELAYED_WORK(&host->sdio_irq_work, sdio_irq_work);
> +       INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
>         timer_setup(&host->retune_timer, mmc_retune_timer, 0);
>
>         /*
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 0b682a31c..f64b9ac76 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1043,7 +1043,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>
>         /* Prevent processing of SDIO IRQs in suspended state. */
>         mmc_card_set_suspended(host->card);
> -       cancel_delayed_work_sync(&host->sdio_irq_work);
> +       cancel_work_sync(&host->sdio_irq_work);
>
>         mmc_claim_host(host);
>
> @@ -1103,7 +1103,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
>                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> -                       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> +                       schedule_work(&host->sdio_irq_work);
>         }
>
>  out:
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 4b1f7c966..2b24bdf38 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -124,7 +124,7 @@ static void sdio_run_irqs(struct mmc_host *host)
>  void sdio_irq_work(struct work_struct *work)
>  {
>         struct mmc_host *host =
> -               container_of(work, struct mmc_host, sdio_irq_work.work);
> +               container_of(work, struct mmc_host, sdio_irq_work);
>
>         sdio_run_irqs(host);
>  }
> @@ -132,7 +132,7 @@ void sdio_irq_work(struct work_struct *work)
>  void sdio_signal_irq(struct mmc_host *host)
>  {
>         host->sdio_irq_pending = true;
> -       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> +       schedule_work(&host->sdio_irq_work);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index eb8bc5b9b..8fdd3cf97 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -476,7 +476,7 @@ struct mmc_host {
>
>         unsigned int            sdio_irqs;
>         struct task_struct      *sdio_irq_thread;
> -       struct delayed_work     sdio_irq_work;
> +       struct work_struct      sdio_irq_work;
>         bool                    sdio_irq_pending;
>         atomic_t                sdio_irq_thread_abort;
>
> --
> 2.37.2
>
