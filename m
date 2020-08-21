Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547FC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E65020738
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZitkLasd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgHUHuf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgHUHue (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 03:50:34 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A9C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 00:50:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so389264vsa.9
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPAumTmI5Wnc/0jLGn8NgNe3A0FwTAd4tw+FclZtfgo=;
        b=ZitkLasd6MehD2FVheJIQ0m8vGeWMvTcTzyOQPnaIjhkGHOUCWYGACog1YhxyyqGY/
         m2xari1bpeHTx/Es/Og8OqCoYy2ucUQgS/WbFrT+zMUmeq6pK0wm76HEpJlR0NsZ/xOW
         Zz8lJR3LnvV4AYXO9H/2wRJe3rjdaCcDr1S1dwzRDjGiEXZqLRWIzVe2lr6EEq09+m6Z
         ybbuZ27CJgHOIa3TA24Bo711+LjM90olxoHhgMZwYPPOdI8iYRiIArX3JOgDeJ8lZNNk
         0MaLC66Z/RDCR75GUz2pvjvHEGjV7sIIkdFrqdbGWVuopMuGHkNiXf5uzOIkhmsgz54L
         DrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPAumTmI5Wnc/0jLGn8NgNe3A0FwTAd4tw+FclZtfgo=;
        b=NnmixoAAwmp4nbR2V/vtG+OheTPFX+2/P00svv0twy4IY1DScEexHaTsdqXZ3cWF+M
         WWVuXT6dNgJviAkl+KCyAMq7lOZScc4NToENA/CAvhaL94cHyXEttYPWMUAMkyCT45g7
         VYJds4HjutnInufNDFrBjkSXAATDPCIjq2mAaImnyHSb+ZRiXAoLraNTdseONNz6bFlq
         qdjLBTzzZ2qhnMvDXGw+0v4e1Demlj7m+ZiP1IEegKLwSafVtA7GOImGTOKcSnYG5HFe
         DHYHSYPSP/9vneKl18WAumc0Jr/lIQMKkjRz/3z20qiAG/VY3lE2iiziMNRCeGD1sOSt
         gw4g==
X-Gm-Message-State: AOAM531Qu6Y+b/K8V6g0b+CRM/0RtPO3cZLorDE0s0H9aLIcCJdFnkB4
        dgKAGE0Vu0J+qA4W2iueQKjDuHVp7eXOjZnBx6p3cA==
X-Google-Smtp-Source: ABdhPJwPOPs4djuAu5rD6fArm3HkIH7OXvYkJ9Ya72B0crf82t9jSLTaRI8+xF8BT4Dz1yWyQwttpP8CXfxcST4hLF8=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr910764vsq.34.1597996231701;
 Fri, 21 Aug 2020 00:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <1596701944-31965-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1596701944-31965-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 09:49:55 +0200
Message-ID: <CAPDyKFpoxoamShoQJThggR7HJAFbi3JcVUEocey88wQyzOYRJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: change to use system_freezable_wq for sdio_irq_work
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Aug 2020 at 10:23, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Change to use system_freezable_wq because it can make sure the queue
> becomes frozen when userspace becomes frozen during system PM.
>
> Find this issue on i.MX7D-sdb board with broadcom sdio wifi.
> When system resume, sometimes this wifi meet the tuning fail issue.
> All tuning command get command timeout error. This is because
> sdio_irq_work on system_wq was executed before the broadcom
> wifi driver resume. Due to broadcom wifi driver set the wifi in
> Sleep sate in system suspend, need to set the wifi to Wake state
> first. So need to make sure wifi driver resume first, then do the
> sdio_irq_work.

Moving to the system_freezable_wq doesn't work. Simply because it's
too early in the system suspend phase to freeze the queue for SDIO
irqs.

I guess you figured that out, so you posted a v2? Moving to review that now..

Kind regards
Uffe

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 26cabd53ddc5..269ae63d09eb 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
>                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> -                       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> +                       queue_delayed_work(system_freezable_wq, &host->sdio_irq_work, 0);
>         }
>
>  out:
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 900871073bd7..9d7ec48bd963 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -132,7 +132,7 @@ void sdio_irq_work(struct work_struct *work)
>  void sdio_signal_irq(struct mmc_host *host)
>  {
>         host->sdio_irq_pending = true;
> -       queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> +       queue_delayed_work(system_freezable_wq, &host->sdio_irq_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
>
> --
> 2.17.1
>
