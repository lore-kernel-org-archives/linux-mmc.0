Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C2C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B39233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhAML0Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbhAML0P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:15 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBEEC061795
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:35 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 17so577749uaq.4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHNibYYv7+qauL9LhD11ieYINhm5TZijHvflmi3bdH8=;
        b=hjy9k4R9ib4o2u7huC6bJ4lkeKLmB5Jew27fl8oeht5CUxAHsdsDeX2NC80qjL2S4l
         gUlB2R0cXo48ZpGaZSqf+Nq0T1o1mb3SeO41fRs9jqR9HWibjshnrbKYLefbE83c7MDQ
         I1zL9EIADhWBePrPHpCjCXE5+TP460bRnb0XslavBr3yM5QMPdfVQ7NCff46cSC+5FfN
         pbcfygXb1TuDvKwzV9kAu2rFDU2zrR8YwIO+qKS0iVkF31zaaleaf4h3Nh4HO9j/i4WM
         DOX2QZUAnHpvITzauHmRa+sEPGHlh2tXz+LVGlzaep4dPPz/vSvdq07+/AjwhGcl0RFP
         GUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHNibYYv7+qauL9LhD11ieYINhm5TZijHvflmi3bdH8=;
        b=jZKA82ZBNicdbiO3O92Ko04t/xBe+yOvP1PZegxmL4JsZiIzhzI46B6OLFpmcmKB4m
         tBJ9fuRBUTfs4PW5JW0ZqjUc3kjaLcf+8yYwsKV2dDFfCMeBrAiiP+RsMqK2pMYNZl4w
         mtcmAoUqd6xCCGi8pXYLSPme4fRClabtd6F0YP1ObIXvhwWL/4ox/kpZJR5HPD0ZIwOk
         wDVWSrnaqUgkeAyh3+puyPkJRyvDdhPZzmtz9ICo6wrQmnTo3SvVQwrvk3zBOdKxtECe
         RuRCRNhVnv7H2pVC8i1w484eyyBA9T3xs7ubV9HzxxexlFmOhBhzVONHtZzjfTrbwfoo
         cNvg==
X-Gm-Message-State: AOAM531NjIIGm/jnOQ3eU/ZhwRVQ5Ab/tOUfXcn6aCi6cZqvWCVdUlIG
        Rl4Of+mH2iXQMixHnt5w2smXwUgTWKPkfXLL5bf12Q==
X-Google-Smtp-Source: ABdhPJwUr2j4zp44dH9qlqnjT+owu7a82g6S5ZhcB/Pq1jwX7B9mRAq7ji6Gxk1aDp66Ptf1Q1GmlXXxd4uR+rQmYzw=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr1278622uam.19.1610537134500;
 Wed, 13 Jan 2021 03:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20201218071611.12276-1-chaotian.jing@mediatek.com>
In-Reply-To: <20201218071611.12276-1-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:24:57 +0100
Message-ID: <CAPDyKFpFKNgTkPJuOM=xOo1pnWmjxh=rD+rdZYu6nwYNWvxz+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix race condition between
 msdc_request_timeout and irq
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Dec 2020 at 08:16, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> when get request SW timeout, if CMD/DAT xfer done irq coming right now,
> then there is race between the msdc_request_timeout work and irq handler,
> and the host->cmd and host->data may set to NULL in irq handler. also,
> current flow ensure that only one path can go to msdc_request_done(), so
> no need check the return value of cancel_delayed_work().
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index de09c6347524..898ed1b023df 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1127,13 +1127,13 @@ static void msdc_track_cmd_data(struct msdc_host *host,
>  static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>  {
>         unsigned long flags;
> -       bool ret;
>
> -       ret = cancel_delayed_work(&host->req_timeout);
> -       if (!ret) {
> -               /* delay work already running */
> -               return;
> -       }
> +       /*
> +        * No need check the return value of cancel_delayed_work, as only ONE
> +        * path will go here!
> +        */
> +       cancel_delayed_work(&host->req_timeout);
> +
>         spin_lock_irqsave(&host->lock, flags);
>         host->mrq = NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1155,7 +1155,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>         bool done = false;
>         bool sbc_error;
>         unsigned long flags;
> -       u32 *rsp = cmd->resp;
> +       u32 *rsp;
>
>         if (mrq->sbc && cmd == mrq->cmd &&
>             (events & (MSDC_INT_ACMDRDY | MSDC_INT_ACMDCRCERR
> @@ -1176,6 +1176,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>
>         if (done)
>                 return true;
> +       rsp = cmd->resp;
>
>         sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
>
> @@ -1363,7 +1364,7 @@ static void msdc_data_xfer_next(struct msdc_host *host,
>  static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 struct mmc_request *mrq, struct mmc_data *data)
>  {
> -       struct mmc_command *stop = data->stop;
> +       struct mmc_command *stop;
>         unsigned long flags;
>         bool done;
>         unsigned int check_data = events &
> @@ -1379,6 +1380,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>
>         if (done)
>                 return true;
> +       stop = data->stop;
>
>         if (check_data || (stop && stop->error)) {
>                 dev_dbg(host->dev, "DMA status: 0x%8X\n",
> --
> 2.18.0
>
