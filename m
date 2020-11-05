Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C05C388F9
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA14A2087D
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juZNn7AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgKEM73 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgKEM73 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:29 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346BC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:28 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id u7so694915vsq.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GWKHgj2S/6eiUDyBrO4Blx873nzdq4gGQ2ur5hE7TU=;
        b=juZNn7ATLUh5c/FjYPZJLxum7iwsn3BLLjFdy0vPProXAYp5OZ/XJODQv9JeVjNYQ3
         OGRbmlqSg/An1FaYfaQDufnVN72C4chiT9bK0jo5PHuf4gGZpSmRLl4cZwBgI5HBa40T
         gTXuRN/Cv3vNBHUvmWiInC6nuKoRpIVYIH8sLNRGaamBARkKkH4ClXtPzV4uEiF8gMNK
         eGoCgJs/r5D8tbJm+2R7uyKJ2XArdAYeFGwRKtxNgMO+lbYzk21vwwsgB4nMNP/xkEus
         SeeDvrh8j8/I6aCxgnIlziLZpN1B+sP6XwCyycHzw33ZxITqCHxx6YV5uCk8QeXfSfSb
         lT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GWKHgj2S/6eiUDyBrO4Blx873nzdq4gGQ2ur5hE7TU=;
        b=fNFZbkjS7wx3FnZK10qy/5CKxvupj4O4eqPy8sl3O5G8y0EWpFlptRSORYKMfJscvA
         bJaTQtgfaec/fx9Qoh8urqxHAIf8PYf0qO7NO9S4vnOMv3ysfrbbTAgQEFJ6Fb2QmwO8
         SQm5PLVuXiJKskgtgh2zglT+HFsd9Qgey5k20f3kRcbYzgPeJkgmugUT4SWOoQwrxdGz
         U+qhXWJqtdRqOVLZBcEitaNlLGDm3/OdLGu5jiCRGWbsfWJ8bEh34SBxO18t7ZM9N36u
         7aYVGl2jW8WgRyUhQL5UCmw6MW2B2VKQQsJy/gBBzL8St0QYJQzkCVUDTzYagZn8rqCM
         IICw==
X-Gm-Message-State: AOAM533NdBRduCuio3Qv87+DWj4/yoEqXEqDnBnl5vz3XUqivXdiiUEN
        XrZy5J4btkUVyHifmXifHyghcxbTae/poojlYF41UBzk47k=
X-Google-Smtp-Source: ABdhPJyMwTWKilMqZGi52xOIAd8ZsWEZy7lOBF0o7c9eTLak0soL/b6Rad+HnRO7r/6qiMCZdyQ9I7y/yfjXo2S1SoQ=
X-Received: by 2002:a67:3256:: with SMTP id y83mr1116160vsy.48.1604581167927;
 Thu, 05 Nov 2020 04:59:27 -0800 (PST)
MIME-Version: 1.0
References: <1604021319-31338-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1604021319-31338-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:58:51 +0100
Message-ID: <CAPDyKFrsyUHAuHKZ3JbprK5aCOogRcYzaUJ2z4Wg1+AthDUrHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Oct 2020 at 02:28, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index f25079b..89bff4e 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -465,9 +465,8 @@ static irqreturn_t moxart_irq(int irq, void *devid)
>  {
>         struct moxart_host *host = (struct moxart_host *)devid;
>         u32 status;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&host->lock, flags);
> +       spin_lock(&host->lock);
>
>         status = readl(host->base + REG_STATUS);
>         if (status & CARD_CHANGE) {
> @@ -484,7 +483,7 @@ static irqreturn_t moxart_irq(int irq, void *devid)
>         if (status & (FIFO_ORUN | FIFO_URUN) && host->mrq)
>                 moxart_transfer_pio(host);
>
> -       spin_unlock_irqrestore(&host->lock, flags);
> +       spin_unlock(&host->lock);
>
>         return IRQ_HANDLED;
>  }
> --
> 2.7.4
>
