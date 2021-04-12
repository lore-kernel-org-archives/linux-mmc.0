Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF9C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5639A61358
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhDLHw4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbhDLHwz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:52:55 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A6C06138D
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:37 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l8so6168570vsj.13
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UryxrO6clAQ+gSWPF8aTxV/VWh5eKXZIooN3CCW0R4g=;
        b=TuDxfi1mXRUdhJSc3QJpNmZ8vGtbRzg8k2p2+0RRPD1K5s7IhlkIIPMOtxtyuAsU7v
         8cR4i98UmepF5NZmKf0d5X1zzczYr2hrXxmZEN7PgkZ5r6+IM+rRLdkNTJFrCfLA0y/x
         COhUHWky1wfHQJJnnSoVq+1he/7ZvJRcKrSdBuf6uLUvZAqqOIOe0FvFRvY9Unj5Ty51
         LSLH2DBMMk/hzPSCgv0ZkmtQY0wnCaok0XPYsAsq+RlxxLVWplIBxyxw2FzYWKoZ5dr8
         ynZ+bforMuTdLnwIbdxZOxMPf2GKeFsl2kwl3iqg4dXrjFYRbE/xGNA+QXwF6OkI3EMH
         YxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UryxrO6clAQ+gSWPF8aTxV/VWh5eKXZIooN3CCW0R4g=;
        b=d5PFAt3wwqovhYAMmcBobUXA6DsXPwP2KCD4YXfQPIG65L+AbrlvB2jucLZEQl2fg3
         xYa5F7GqvhjsLFCsPEfKke+6/2B1ZVLguEF7wazRML87eESgIZWpvAuzaf7zpEyiXQYy
         cAMAc21CHEBRnJY16+FFi6uc31sshY13tYRRURqaBexnlxOaCT+QGV1g2AW4wA8JIwV7
         bHoV1orxI0s53Gam5lou4P9cImiTqZ2Rs6EYqNtMY/d82AfXOctfev6lVytN3nOJHMYJ
         viYSucBiSbvmCzeezjz4eHgX0Gj4+faA1CCTKA7Je2TKhxFCMaKFNaKdl7drAuBRfYPz
         Fuqg==
X-Gm-Message-State: AOAM5323YO+PwxNEnzH2+6RBZu6Pmfb+3sWAIE3tdqARfM6ru1oEGP8U
        RHrAXVREh3zEbMqxWfRjs16D1Cf7LeyP7pXb5GoPzw==
X-Google-Smtp-Source: ABdhPJzWl7Po07WGGfuJIiEPv1l3UTq9CYPhDiXD0mbXnG84E2RBmxoc8zaKS/4Vy8JG/5vNIvERv/uPJgB2vIgM8IE=
X-Received: by 2002:a67:fd48:: with SMTP id g8mr11938720vsr.55.1618213957148;
 Mon, 12 Apr 2021 00:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1617357231-93064-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1617357231-93064-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:00 +0200
Message-ID: <CAPDyKFrptDsdyUoJaSz9F1iYgW_02Kj6ay5X+oFCmJp2Hg=RWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: Remove unused variable 'dma_time' and 'pio_time'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Apr 2021 at 11:53, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
> drivers/mmc/host/moxart-mmc.c:257:7: warning: variable =E2=80=98dma_time=
=E2=80=99 set
> but not used
> drivers/mmc/host/moxart-mmc.c:395:7: warning: variable =E2=80=98pio_time=
=E2=80=99 set
> but not used
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 89bff4e..bde2988 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -257,7 +257,6 @@ static void moxart_dma_complete(void *param)
>  static void moxart_transfer_dma(struct mmc_data *data, struct moxart_hos=
t *host)
>  {
>         u32 len, dir_slave;
> -       long dma_time;
>         struct dma_async_tx_descriptor *desc =3D NULL;
>         struct dma_chan *dma_chan;
>
> @@ -294,8 +293,8 @@ static void moxart_transfer_dma(struct mmc_data *data=
, struct moxart_host *host)
>
>         data->bytes_xfered +=3D host->data_remain;
>
> -       dma_time =3D wait_for_completion_interruptible_timeout(
> -                  &host->dma_complete, host->timeout);
> +       wait_for_completion_interruptible_timeout(&host->dma_complete,
> +                                                 host->timeout);
>
>         dma_unmap_sg(dma_chan->device->dev,
>                      data->sg, data->sg_len,
> @@ -395,7 +394,6 @@ static void moxart_prepare_data(struct moxart_host *h=
ost)
>  static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq=
)
>  {
>         struct moxart_host *host =3D mmc_priv(mmc);
> -       long pio_time;
>         unsigned long flags;
>         u32 status;
>
> @@ -431,8 +429,8 @@ static void moxart_request(struct mmc_host *mmc, stru=
ct mmc_request *mrq)
>                         spin_unlock_irqrestore(&host->lock, flags);
>
>                         /* PIO transfers start from interrupt. */
> -                       pio_time =3D wait_for_completion_interruptible_ti=
meout(
> -                                  &host->pio_complete, host->timeout);
> +                       wait_for_completion_interruptible_timeout(&host->=
pio_complete,
> +                                                                 host->t=
imeout);
>
>                         spin_lock_irqsave(&host->lock, flags);
>                 }
> --
> 1.8.3.1
>
