Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F4C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Apr 2022 11:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiDMLPg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiDMLPg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2022 07:15:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E8749686
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 04:13:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m8so1738173ljc.7
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRAUyZI9+fggPAn2ifhmUv51jDI2Be/bBOEVsTNON4o=;
        b=Eg03Xj9KnGYWFqsITGgMLvlAta+OjJ+Kdc0jsTIJZHIMoxKrHAj0G6ATuDoOdRnSDE
         sYQ+U+S8N7MTdzI1t4Ue1L0+uLDDl+utQCVoSeGkLLKcHFin/5KKSTQoFPzrqjJ83FB8
         XPGCuWNw7XUTPmJrSWhBULLWTDEj3blT+rPO/uBNJEiKgR/CwPCJWWcxkSKglEBzWbx6
         I6eLtmS391po11EOiUonODZzTZfLHY44dy7KiOaQ/iQduyUr5ctlS6hY/3HRovVPXtJr
         hhk1oWvUPNBQKhznCsg6zphvplJsKFwTpiYEeUwRym4ib8W3Cdeh9myXW9A2VqJCmcwk
         7wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRAUyZI9+fggPAn2ifhmUv51jDI2Be/bBOEVsTNON4o=;
        b=M749JmXnWYtgrK39tU4vG2ANm+blWbv+dTLyljLk05p3ieK+wUq5YfKRu4VTF5LC3V
         Q9Tyeq3wCwCdaJxKLfdiD//R1kGKr+4DCg0F/jwm6tbxKZxJEBGBc4J10TLx1hUQpjTx
         RTIFxWK8sw6no/KsxIKYJjFca4YfjqeFMaZyCuUSKpc/vG7KvN/fOwmObaBA106a35ES
         R8z1qaieLvngMb5r/tTKDn7ddc/GsRo/7eQkpSFagjHFtfpJBAoVciKLcoGYWapt7GDe
         acbOhpeYRCc+3u+9wE4N97bZ7aGjmOtdquMwPW998qAh0FR/KU3TiVAleN6xwbRH/iCh
         LhjA==
X-Gm-Message-State: AOAM530Nv0fbM0JAFiPQo4fj2r44CKNamcdr3mhrMsEzR6gyhN3lPpb7
        T/sjA/yaBkmyIEqdPfATwohVHF+DPIEtHzuAvTcHOq0yD2/Icg==
X-Google-Smtp-Source: ABdhPJx0MrDHqWYWV8+DR3rKCbs0HkQFQYqA7XT80X697feIiWRrx8ezhHZ7QQBlv1pShlTQeBlbNg3QfaA/HVpR0ww=
X-Received: by 2002:a2e:a26f:0:b0:24b:5f6c:7899 with SMTP id
 k15-20020a2ea26f000000b0024b5f6c7899mr10367471ljm.4.1649848393260; Wed, 13
 Apr 2022 04:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220413080446.1308828-1-wu-yan@tcl.com>
In-Reply-To: <20220413080446.1308828-1-wu-yan@tcl.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Apr 2022 13:12:36 +0200
Message-ID: <CAPDyKFoODtEU6SACMX1WOtqYTUKssWN88Ge2PrLz4RDhez43sQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: avoid livelock in mmc_sd_detect
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     linux-mmc@vger.kernel.org, tang.ding@tcl.com, mingbo.feng@tcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Apr 2022 at 10:07, Rokudo Yan <wu-yan@tcl.com> wrote:
>
> There is a potential livelock when mmc_sd_detect is invoked by
> pm_suspend, as below:
>
> [thread do suspend]
> state_store
>  -pm_suspend
>   -__pm_notifier_call_chain
>    -mmc_pm_notify
>     -cancel_delayed_work_sync(&host->detect)
>      -__cancel_work_timer
>       -__flush_work
>        -wait_for_completion
>        wait for detect work current running to complete
>
> [kworker run detect work]
> process_one_work
>  -mmc_rescan
>   -mmc_sd_detect
>    -mmc_get_card
>     -__mmc_claim_host
>      -schedule
>      wait for current host claimer release
>
> [kworker dispatch io (current host claimer)]
> process_one_work
>  -blk_mq_run_work_fn
>   -__blk_mq_run_hw_queue
>    -blk_mq_sched_dispatch_requests
>     -blk_mq_do_dispatch_sched
>      -blk_mq_dispatch_rq_list
>       -mmc_mq_queue_rq
>        -mmc_get_card -- claim mmc host if inflight=1 (the first io)
>                         and only release when all ios complete
>        -mmc_blk_mq_issue_rq
>
> if there are continous io requests in the system to keep queue busy
> (inflight !=0 all the time), the supsend process will blocked and
> hang the system.
>
> This issue can reproduced by steps below:
> 1. prepare 1 SD card
> 2. run fio to keep the card io busy
>   fio --size=1m --bs=32k --ioengine=libaio --iodepth=64 \
>     --direct=1 --rw=read --time_based --runtime=60000 \
>     --name=test --filename=<path under sd card>
> 3. suspend the system (echo mem > /sys/power/state)
> 4. resume the system
> 5. suspend the system again & device hang
>
> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>

I believe you are running some vendor/old kernel, because I think this
problem has been fixed.

You may have a look at commit 17a17bf50612 ("mmc: core: Fix hanging on
I/O during system suspend for removable cards")

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 8 ++++++++
>  drivers/mmc/core/sd.c    | 2 ++
>  include/linux/mmc/host.h | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index c69b2d9df6f1..f00fc45a4fd5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -241,6 +241,14 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 return BLK_STS_IOERR;
>         }
>
> +       /*
> +        * requeue the io if sd detect is on-going to avoid livelock
> +        * when mmc_sd_detect is invoked by pm_suspend and there are
> +        * continous io requests simultaneously.
> +        */
> +       if (host->doing_sd_detect)
> +               return BLK_STS_RESOURCE;
> +
>         issue_type = mmc_issue_type(mq, req);
>
>         spin_lock_irq(&mq->lock);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 68df6b2f49cc..460ea6ab9aba 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1594,6 +1594,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>  {
>         int err;
>
> +       host->doing_sd_detect = true;
>         mmc_get_card(host->card, NULL);
>
>         /*
> @@ -1611,6 +1612,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>                 mmc_power_off(host);
>                 mmc_release_host(host);
>         }
> +       host->doing_sd_detect = false;
>  }
>
>  static int sd_can_poweroff_notify(struct mmc_card *card)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7afb57cab00b..4abfc5d7ef20 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -501,6 +501,9 @@ struct mmc_host {
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
>
> +       /* indicate SD detect on-going */
> +       bool                    doing_sd_detect;
> +
>         unsigned long           private[] ____cacheline_aligned;
>  };
>
> --
> 2.25.1
>
