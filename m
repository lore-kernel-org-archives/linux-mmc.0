Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF096C55ABD
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8353620781
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsreJSV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKJM0m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKJM0m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 07:26:42 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A65C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:42 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m184so2669689vkb.9
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gsnklr3mYZvBcAXWrQJZvljO/2f2xo3pLHWaomWfKM=;
        b=AsreJSV5v2zViOmWEF5BArd1fuqP1AHcftElNgRdDEhKheqMyX+7CjEaNTVKlG7dSr
         F0OWpyQkcM32nEJbiSC0zKvOAe4ICSU5qBw0u/tunZe/W50wSQtzZdMW4psl48Vd1Vtz
         3jdLPN5kPtI30oaQtIKB9JzRK7scZUONYgRqPd7tkAYgQCvqp69/Q33ydZJkA47ctevM
         6rGHhBFq4lnkoCjbwoCwZ/jWYCgkAjbDMCvc+Nv3zoJnJBNmIC2Asdl+QjqLe8eHPwWI
         Nsc4MnkA9wXM5XM5HFCOXl29o1nVTGCLjGkRe5RB+eHtxvYlj5gE5dr49VQx0Treg5Z7
         ROjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gsnklr3mYZvBcAXWrQJZvljO/2f2xo3pLHWaomWfKM=;
        b=ipPI3W3buAps69fv2zTUB3uxgRxpCsWtwaVClBbViFPS98BVZ51hz0KsheDRY7hD7V
         UMFGyQRn07wgGdcrKk9jh5e6Pg9Ori1MFagbF8GaMQjlAsnrqMJk8rqkDCbVTqKa4iS2
         gwTH3/Kx4rT05tOUBsgafwglbiY62cgO95XoAKSFzQF5DEH8sO0QL0Vtr72Zbv6GobBL
         Bryc+05KBDmxovZiyI9o0KTjL89U0poCt9wV5C4/ADywuWo/csP7/+4i/7amCxZkJ3r9
         cMPdCO6m6plxh62g9kkgWrhPC7g6tQgij2QopqW5hesrInxam4KiURNIQC6ha/D5bXem
         9svg==
X-Gm-Message-State: AOAM532KbiIdtETzglJ3FONJ+fL0e6YlLxuXZfFrTV7kWid4nZ9CjEBt
        rKV6Yj8anhVO39GPBXcLTP8gjL1LgzxN0qyHJcC95ZEbRaQytA==
X-Google-Smtp-Source: ABdhPJzB9kvz6yueidsObBUdc09/7o92ArCp7CRCelWNrrBQmYUm/QnuqC58IiY1wIcUcV/RUs0ijAgYt83DMK6Yz7k=
X-Received: by 2002:a05:6122:10eb:: with SMTP id m11mr10060860vko.8.1605011201227;
 Tue, 10 Nov 2020 04:26:41 -0800 (PST)
MIME-Version: 1.0
References: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:26:04 +0100
Message-ID: <CAPDyKFpX9T6aKUmnVNLoo5+CW7h7HHGixT0wefDpV3CMyOJKTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Nov 2020 at 02:56, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 43c5795..a524443 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2617,7 +2617,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>         struct dw_mci *host = dev_id;
>         u32 pending;
>         struct dw_mci_slot *slot = host->slot;
> -       unsigned long irqflags;
>
>         pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>
> @@ -2632,15 +2631,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                          * Hold the lock; we know cmd11_timer can't be kicked
>                          * off after the lock is released, so safe to delete.
>                          */
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>                         dw_mci_cmd_interrupt(host, pending);
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>
>                         del_timer(&host->cmd11_timer);
>                 }
>
>                 if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         del_timer(&host->cto_timer);
>                         mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> @@ -2648,7 +2647,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                         smp_wmb(); /* drain writebuffer */
>                         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> @@ -2661,7 +2660,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & SDMMC_INT_DATA_OVER) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         del_timer(&host->dto_timer);
>
> @@ -2676,7 +2675,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                         set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>                         tasklet_schedule(&host->tasklet);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & SDMMC_INT_RXDR) {
> @@ -2692,12 +2691,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & SDMMC_INT_CMD_DONE) {
> -                       spin_lock_irqsave(&host->irq_lock, irqflags);
> +                       spin_lock(&host->irq_lock);
>
>                         mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
>                         dw_mci_cmd_interrupt(host, pending);
>
> -                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +                       spin_unlock(&host->irq_lock);
>                 }
>
>                 if (pending & SDMMC_INT_CD) {
> --
> 2.7.4
>
