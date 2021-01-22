Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D163FC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C7C235F7
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhAVJrj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbhAVJqt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 04:46:49 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72216C061794
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:45:28 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a16so1629393uad.9
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8znVvt11Gf6tz3j7rgBydA6WYzetqabHTGjXGWf8sQ=;
        b=fKAf9df3B+5Q3xvUV9EPDSzL5dugIci2p8+8LlVDaw3lkiPXV7VFmtQCAMWAuYyxBP
         cpAIz4u0oafAzp6RAuSraf6NJRnWl9sD1szlojI4MXAzSHhLZlcZ5kVTRfhFUyrg9yGY
         sx5TuiT9W/2S7qm98exNKvTdJRL9WFxZ0OGpjbzQnj2qMz4oaO4xmppDWpTeoaUNQZom
         NqEqUneW8wKJCL+9UiGAShuZjn9eJCsi6mvfBf5jy0OqK7f9+nTOGs/gHmP+Y1K2q6ER
         EPNsH8yOIe1I590YlqNSl2BcarrkG7pYYAChgJIRtD9nQvOS7wwwig+vJQFekotnXFxJ
         WXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8znVvt11Gf6tz3j7rgBydA6WYzetqabHTGjXGWf8sQ=;
        b=WE1It+miAMUDsoUTY5Cr71mInbnkei4Mr4n9ddpB6Up/zZWNfojf4W9GRvf8LlNYnQ
         CjukUqVxjA6KKGC2VSwTw5tWAvy7JtSGwRx+402uvZE9mH/X9G0p/WwTMjOQgrsD3XA7
         S8gakQHSjRWgXowBvpfz4gz92HA2tZwYU/3q90C24WuTPzh9sgUivRL0Nq9rHRfe7VMY
         ZV09c1HHjyG50j45J+aKrHUI9vF+N5DQCYL/+xe67apAt7t4xdTUKcjt8c1jo1O8zveG
         2RsbAqKYo7PVD89l7YvOpoz0YYL5ELv2tc2YW5t2ZXVEhaVVNXKIP+tSHNAnkFFbXX0A
         Va1w==
X-Gm-Message-State: AOAM531iFheTidarcTIgM4aUO8x1RHvMj3PqO03qRHPxsrKw1D+/W86A
        bWAG5tylKXHMzhouenVpnCpqv4nOKnbH4DyknmXPcg==
X-Google-Smtp-Source: ABdhPJxtzw1pzaWNMbHu+VHRXn6WXmioeGbrfQKrhYo5lZJ2VN+DOFrw1lf7f5j6UO/jggyepGcyVcZi+kSqr6Zw76U=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2569551uah.104.1611308727664;
 Fri, 22 Jan 2021 01:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:44:51 +0100
Message-ID: <CAPDyKFq+byoyYW8GGnSx1GsbBx8Sci8Dqo2AAuapTyUmEHm_HQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Assign boolean values to a bool variable
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Jan 2021 at 08:39, Jiapeng Zhong
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/mmc/host/atmel-mci.c:2436:2-34: WARNING: Assignment
> of 0/1 to bool variable.
>
> ./drivers/mmc/host/atmel-mci.c:2425:2-20: WARNING: Assignment
> of 0/1 to bool variable.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 444bd3a..6324120 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2401,45 +2401,45 @@ static void atmci_get_cap(struct atmel_mci *host)
>         dev_info(&host->pdev->dev,
>                         "version: 0x%x\n", version);
>
> -       host->caps.has_dma_conf_reg = 0;
> -       host->caps.has_pdc = 1;
> -       host->caps.has_cfg_reg = 0;
> -       host->caps.has_cstor_reg = 0;
> -       host->caps.has_highspeed = 0;
> -       host->caps.has_rwproof = 0;
> -       host->caps.has_odd_clk_div = 0;
> -       host->caps.has_bad_data_ordering = 1;
> -       host->caps.need_reset_after_xfer = 1;
> -       host->caps.need_blksz_mul_4 = 1;
> -       host->caps.need_notbusy_for_read_ops = 0;
> +       host->caps.has_dma_conf_reg = false;
> +       host->caps.has_pdc = true;
> +       host->caps.has_cfg_reg = false;
> +       host->caps.has_cstor_reg = false;
> +       host->caps.has_highspeed = false;
> +       host->caps.has_rwproof = false;
> +       host->caps.has_odd_clk_div = false;
> +       host->caps.has_bad_data_ordering = true;
> +       host->caps.need_reset_after_xfer = true;
> +       host->caps.need_blksz_mul_4 = true;
> +       host->caps.need_notbusy_for_read_ops = false;
>
>         /* keep only major version number */
>         switch (version & 0xf00) {
>         case 0x600:
>         case 0x500:
> -               host->caps.has_odd_clk_div = 1;
> +               host->caps.has_odd_clk_div = true;
>                 fallthrough;
>         case 0x400:
>         case 0x300:
> -               host->caps.has_dma_conf_reg = 1;
> -               host->caps.has_pdc = 0;
> -               host->caps.has_cfg_reg = 1;
> -               host->caps.has_cstor_reg = 1;
> -               host->caps.has_highspeed = 1;
> +               host->caps.has_dma_conf_reg = true;
> +               host->caps.has_pdc = false;
> +               host->caps.has_cfg_reg = true;
> +               host->caps.has_cstor_reg = true;
> +               host->caps.has_highspeed = true;
>                 fallthrough;
>         case 0x200:
> -               host->caps.has_rwproof = 1;
> -               host->caps.need_blksz_mul_4 = 0;
> -               host->caps.need_notbusy_for_read_ops = 1;
> +               host->caps.has_rwproof = true;
> +               host->caps.need_blksz_mul_4 = false;
> +               host->caps.need_notbusy_for_read_ops = true;
>                 fallthrough;
>         case 0x100:
> -               host->caps.has_bad_data_ordering = 0;
> -               host->caps.need_reset_after_xfer = 0;
> +               host->caps.has_bad_data_ordering = false;
> +               host->caps.need_reset_after_xfer = false;
>                 fallthrough;
>         case 0x0:
>                 break;
>         default:
> -               host->caps.has_pdc = 0;
> +               host->caps.has_pdc = false;
>                 dev_warn(&host->pdev->dev,
>                                 "Unmanaged mci version, set minimum capabilities\n");
>                 break;
> --
> 1.8.3.1
>
