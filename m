Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A9C38A2B
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A5621D94
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRZ4C/5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgDQL3y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730324AbgDQL3y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 07:29:54 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0779C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:53 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u12so511210uau.10
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOtnGCLOffRDjVQMAjSBuDIal+6fxqleA+W9Lw8x8/E=;
        b=CRZ4C/5jBGneL6ClhbdFF+/HtdSsizkg6ef8Ox/V2AGNQnjrGIK4FeCOjj28UGvJ/S
         3aFy4TCzpaZOHvin5b2xrUK+d/TKahUBz8BI1vQO9BmxeQWNwoCiEZ+clMMf7c5HM6hX
         5Ea/lxWVWzJmgR38iZhstXVKU3VSpmyUj3tPmOW4LTaKHI3k4oUPFfqM2qQQYKPDxn7l
         UjWavC5QhIpU505x5jjhiytQvwh6fGubk4din+aCyTWVN7Z7BY/k4kT/MY0pfB5F1+r6
         rZYk44om5G/O1VCEFb4KYfktODc36ozM5iVSLFxkAMOoOMAm4HQiyLatuuR21BRh5nUa
         baDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOtnGCLOffRDjVQMAjSBuDIal+6fxqleA+W9Lw8x8/E=;
        b=lD0hEz1sjK60elJzbH35oXeW7etA+/mKXqqXMkuFZUraIg/6K5Gh1JXqlLE7Z5AoO6
         31DyL/J1BGARfAmau6Qos0NSlDOjc02ynpCmmJbd3uar2QHVfxJy/8ttS5RK0mw0ER7G
         IW+IwTMR9/db7/bAhtjPeZHhERlvn7Caaa0WTeJ05tYeEmJcssglEHhp1RFwWA02Vivs
         /Ko5HOt+g166sMVEtDdrpIfbogdCab4sZkFaeGqQVg7fEnkbPdWEZEYdXWbi+9xeYj7c
         R0rbzxCt07IgO9OnNYXjS5LoQCV/H5iIeLPbrqCsJ6McneFoT53uz73hlTEvFRMHxaAO
         jogA==
X-Gm-Message-State: AGi0PuY5EIFJQrPZ8ERiY/NyGzAscxV8UCfAGDc1cFGLksplXXjGWFrL
        tsbxgOPUK3OyymLoOhzxpg6E3312y9+YMmOtUb5/dHlJ
X-Google-Smtp-Source: APiQypIq0pieNQfBvZCTfE7jFsOwqVd/+UrCeGcrx0khrWM1vo1vvMa59vVW+Ztb5TBHvez6OFVUpNDtjIohLWJrzAU=
X-Received: by 2002:ab0:2ea:: with SMTP id 97mr1890385uah.129.1587122993064;
 Fri, 17 Apr 2020 04:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <1586941255-9237-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1586941255-9237-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:29:17 +0200
Message-ID: <CAPDyKFqyHmYgWEC1yD-beHdAQ3xCijr=DPHPHNdhBBpFwCp1=Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: add spin lock for sdhci_set_default_irqs in sdhci_init
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Apr 2020 at 11:09, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> When use one SDIO wifi which enable the runtime PM feature on i.MX6SX,
> we meet system hang. This hang happened during the usdhc runtime resume,
> in sdhci_init(), when call the sdhci_set_default_irqs. One interrupt
> (SDHCI_INT_CARD_INT) triggered just after the host->ier update and before
> the write of register SDHCI_SIGNAL_ENABLE. So in sdhci_irq, it will skip
> the call of sdio_signal_irq() because current host->ier do not set the
> SDHCI_INT_CARD_INT. So this SDIO wifi interrupt always keep triggered,
> let the system stuck in irq handle, can't response any other thread.
>
> This patch add spin lock for the sdhci_set_default_irqs to fix this issue.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..79b6324a500c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -317,6 +317,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>         struct mmc_host *mmc = host->mmc;
> +       unsigned long flags;
>
>         if (soft)
>                 sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> @@ -326,7 +327,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>         if (host->v4_mode)
>                 sdhci_do_enable_v4_mode(host);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         sdhci_set_default_irqs(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         host->cqe_on = false;
>
> --
> 2.17.1
>
