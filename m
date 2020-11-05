Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C6C00A89
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 09:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C1C20825
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 09:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qL2v+cFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKEJ5m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgKEJ5k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 04:57:40 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4CC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 01:57:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so956652wmd.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:message-id:date
         :mime-version;
        bh=+TGCsofaUmGr6nzBBKHycjrA1R9jwaok57A4MZa2F4s=;
        b=qL2v+cFyY+xkNZuz62SNoRVKfbb7gAFxwYzWEzvhFokyqCAW5pUpNM8cK/97gxBCWt
         8vjrtf2DfmiobWuHVXfZ5QDWUO3Y8pfBNX/XrTE7TFFiZe8GqFxDha31JZ8G8i1Zg0OS
         RNgjo36tkYcwTb/kcEYd8iZI82+iJrOdLruzhzcrJ/p2stPUiVekKH8gI6xmEjKdJCZ4
         JAkkBJioNpXPUJ4h4+S1l3juH2MUGNSXKkL+17dgUPhPeGsfqLeexUsovnjVxZ2EH/Gd
         itQnODenm3N+cKFm0VkruGfx40I9yh2gufwytLY08l/37xAp6GURsV1xAWNtiq0vLber
         Tg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:message-id:date:mime-version;
        bh=+TGCsofaUmGr6nzBBKHycjrA1R9jwaok57A4MZa2F4s=;
        b=aVpdPwfPlhCseO+NylNMX8UIJVLvsDZQK0tEqQjLmvUJcVrI007+DLtZF8PA+d8Hz5
         qA3UspktSI6jgSLX1SSyBt6TD9ZAnCt2AAXuO6MvTwP4K5aCN7Ivvb5SwYdacvlU7Ix+
         qEC52kvnsp/Q7f87LPEbx6oSAQgPZFHwzGmeSOuZLW/9D3igpwSpbBS36KiqHnrrl/mq
         0PG8MCXym7FjGzNTlH5Zknef9+VNeROKG7+0FoSQ5AriFXr56Ree/OWZ4eSpNK92j4Zh
         B0+az+RpfFnus31xcQ+z4MZl0KIFRq1WLyTizDXOiZ1QW/urIKoTa5cBS0+xuZWm6tM0
         zM1A==
X-Gm-Message-State: AOAM531XFMcv7Jlj/HJhLuOpUnVqPiT/eRdyF+hsGw8oQ0I76sf8YPSS
        gVlUVjZdkkQzL5CTiccJ+cYl/g==
X-Google-Smtp-Source: ABdhPJwBGELixNpYowvhX39sWRrOBjfWBHAiBmfYwVPE7T9/3PTG+y1zLuYgjRuTA/p1a4UY0LDemQ==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr1821947wmd.70.1604570257085;
        Thu, 05 Nov 2020 01:57:37 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id w11sm1936242wmg.36.2020.11.05.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:57:36 -0800 (PST)
References: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Tian Tao <tiantao6@hisilicon.com>, ulf.hansson@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-mx-sdio: replace spin_lock_irqsave by
 spin_lock in hard IRQ
In-reply-to: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
Message-ID: <1j361oazxs.fsf@starbuckisacylon.baylibre.com>
Date:   Thu, 05 Nov 2020 10:57:35 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Tue 03 Nov 2020 at 04:48, Tian Tao <tiantao6@hisilicon.com> wrote:

> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/mmc/host/meson-mx-sdio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 1c5299c..d4a4891 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -418,10 +418,9 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>  {
>  	struct meson_mx_mmc_host *host = (void *) data;
>  	u32 irqs, send;
> -	unsigned long irqflags;
>  	irqreturn_t ret;
>  
> -	spin_lock_irqsave(&host->irq_lock, irqflags);
> +	spin_lock(&host->irq_lock);
>  
>  	irqs = readl(host->base + MESON_MX_SDIO_IRQS);
>  	send = readl(host->base + MESON_MX_SDIO_SEND);
> @@ -434,7 +433,7 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>  	/* finally ACK all pending interrupts */
>  	writel(irqs, host->base + MESON_MX_SDIO_IRQS);
>  
> -	spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +	spin_unlock(&host->irq_lock);
>  
>  	return ret;
>  }

