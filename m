Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4932C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 22:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBMWq5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWq4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 17:46:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751BA1D91C
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 14:46:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gd1so2580019pjb.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xdXRfHEDGntt40H+VdxuizcsjhlHh6IS8DIu7IMqkPQ=;
        b=teM0pzFNXuxZL7/IIDdcrpJN2zHDcNg0CyyEYj09tYD0oXnooQPE9BtUoclB235Uev
         E8iYi/QFIu9yh//coMovktbA2mQdKtAWr8Wv4Xp6T7sdDCSo945CK7esGV7au0pyEJ4V
         H+VIif6k9FsxtS/W4e+RxwcxVEiSQKNuevda5K5ymmiBawvybMXzRPP2VyHtOj+INJ39
         1n1txqSqgbwWo7hTht8Dw8Xwn1TlC40YVfbU5/rF0JQGimtlBUHJpbwvlSpZag08vlX9
         gCH4eq7z6Vs7q9gHF3VaktZA5VaMJrsdK0UkRGmc6L51MozC2zE6WH3deugGx92qZiuF
         z2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdXRfHEDGntt40H+VdxuizcsjhlHh6IS8DIu7IMqkPQ=;
        b=ZxQtRCJ2Q/ZRi580uPTPCyx7yXt3OL4Ksfmrn9szkcDoXPwUpFvvbg7H7v6R2e/tJT
         nCj2EqYiNE9KM7+yvL99vrL8Tu8QH5v/Pamli7BzO9t8UgvEYxJxUsSopqrXhA5wLU+F
         AmsSisbM4B4OX74hOoD+xCo8YfYtwXELyP4yRRt7Su6DxDT5NBM8buQtqh1gxzNCxYwI
         3ZFKnOq7TVDwhvYDhaP+4mQfB1ZfbFEntOOrI5gJGAbadgR59r/3/I9f3WJGQqtPcDwR
         afG6VzT8lfsgPzcGKo4dLroOqS02m2tqQycQ6SDt2Xzy8PUOMyjQOz5OgoMKbqlsrk/h
         XeUA==
X-Gm-Message-State: AO0yUKUwCmXC0FZL/aOiz2zTjs4HkLhT1mHLE/jcurGpAXruLKVF4ehA
        MpwrwVc6/GP64FTFYHAX//gtYgzXSIwvbt1DxGj7Gw==
X-Google-Smtp-Source: AK7set+ectIf3t2eHRbZ0c2BZGDirXyixYrhn/GRyG79rlWwYnxZJQPHori5JNfGyK5LJHJvmLTyoXJ8SsofeLjKH+A=
X-Received: by 2002:a17:903:2341:b0:19a:9ba6:6526 with SMTP id
 c1-20020a170903234100b0019a9ba66526mr165001plh.2.1676328414898; Mon, 13 Feb
 2023 14:46:54 -0800 (PST)
MIME-Version: 1.0
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com> <a0f895b3-f895-f256-1274-a61571264617@gmail.com>
In-Reply-To: <a0f895b3-f895-f256-1274-a61571264617@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Feb 2023 23:46:18 +0100
Message-ID: <CAPDyKFoeeof8G=AY4Z_CE4di4xUu8L9JT3UDYtPW6UVyTg1L=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: support platform interrupt as card detect interrupt
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 Jan 2023 at 00:10, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
> due to the design of gpio / interrupt controller. Therefore provide an
> option to specify the cd interrupt e.g. by device tree. The host
> controller can store the interrupt in cd_irq for use by
> mmc_gpiod_request_cd_irq().
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  include/linux/mmc/host.h     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index dd2a4b6ab..69c22a997 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -99,7 +99,7 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
>          * IRQ number is already used by another unit and cannot be shared.
>          */
>         if (!(host->caps & MMC_CAP_NEEDS_POLL))
> -               irq = gpiod_to_irq(ctx->cd_gpio);
> +               irq = host->cd_irq > 0 ? host->cd_irq : gpiod_to_irq(ctx->cd_gpio);
>
>         if (irq >= 0) {
>                 if (!ctx->cd_gpio_isr)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8fdd3cf97..e998e919e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -470,6 +470,7 @@ struct mmc_host {
>
>         struct delayed_work     detect;
>         int                     detect_change;  /* card detect flag */
> +       int                     cd_irq;         /* for use by mmc_gpiod_request_cd_irq */

Rather than putting this in the struct mmc_host, I would prefer to
keep it more internal to the mmc core/slot code.

That said, what do you think of moving this into the struct mmc_gpio
instead? Of course, that also means that we need to add new slot gpio
helper that users can call to set the corresponding value for the
cd_irq.

Would that be okay to you?

>         struct mmc_slot         slot;
>
>         const struct mmc_bus_ops *bus_ops;      /* current bus driver */

Kind regards
Uffe
