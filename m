Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACDC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhL1Q6d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhL1Q6d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A81C061574
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o12so42703429lfk.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckC4D6OxYQNZrxJDsodzLLAYO9Dq/YB7u3reYi8/dZc=;
        b=UOOcp8coxFaLtMUDq8jgW89WsS2OQYc6gklouvTZTqe3LP9Wv/jJbr/og58dhcoOfI
         UNKsu1D/C1UPC6DSsrVnKER6dWMVHzATCdL8Sj9oVHLgM6F2zrREOylfAKlnW5sRS8G9
         3U1JEjSVwfe4VTWHypvEYTdy1oYX+qN6h1d7EnT/EwDGi1iJwFn/lJtcJ1rvVCKCElCU
         3dWhN2lICjUkoaSVO8bdiPMqUes8kxa3eD+ngGUIUUq4SFJ20CqHX+er03mph/7Qindd
         e3R3mpKTReC7jeQFC/PpqqBqX8nuLytcKICAo2EEUdRANOhCkP+6OSHHd7/tan7MiH3G
         rTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckC4D6OxYQNZrxJDsodzLLAYO9Dq/YB7u3reYi8/dZc=;
        b=xh8/bf4w8W225YZWeEGdyae7cP8YVixZwgFoYcNLyRGNMwzFevQjsvN28gkMvBLQcr
         WLK5vr95mg2vEcbPC0RO5+UC9zvIeYznkxrbEYoNP5mdyeD7Fk+EvuGForh6n6ItpRXp
         z8Yaq/cLe8zCZZ4GnLOYUKMCAoY6YuPfSRkEHtYIQJtPAElh4RZcsd7vFOQUd8IduXfU
         N4ey+YgBMa2VcOkzBR63LXSobwTDAA/CCBBXD9KrfI9v5pAvgn9bwoU2yv+qkssknOow
         /R9HS+H9WIOPQIe8f872ybLrcdbNAaUZC4+Th7K2i3hn3tx8I5uwPZMEPDptzkAX7/ZW
         8zyQ==
X-Gm-Message-State: AOAM530jQ6qpvcwwC3bBzC33K2v23ZHWO7rD+rtCj0LJLaYvHd5TaLHb
        va2JCEPVlURI2lXQX+ULr1A0erfWjuac9x+eOGL7cA==
X-Google-Smtp-Source: ABdhPJzOCVKV3pvP2svNnQS767ugTic009zYxX30mBHWR/S6k6dHyvFB1Bw3wTGrD3Lle6fIqHAJkP6cgjSttsXaVZQ=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr20657079lfb.233.1640710710798;
 Tue, 28 Dec 2021 08:58:30 -0800 (PST)
MIME-Version: 1.0
References: <f642ef4d-6027-eb2e-0257-1c4f13911aed@omp.ru>
In-Reply-To: <f642ef4d-6027-eb2e-0257-1c4f13911aed@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:57:53 +0100
Message-ID: <CAPDyKFqigmT1cgkQ0Dk3KD88YCJuH46q5RVeYiL09oDv0u+fpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: au1xmmc: propagate errors from platform_get_irq()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Dec 2021 at 19:45, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> The driver overrides the error codes returned by platform_get_irq() to
> -ENODEV. Switch to propagating the error codes upstream.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
>
>  drivers/mmc/host/au1xmmc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux/drivers/mmc/host/au1xmmc.c
> ===================================================================
> --- linux.orig/drivers/mmc/host/au1xmmc.c
> +++ linux/drivers/mmc/host/au1xmmc.c
> @@ -969,8 +969,10 @@ static int au1xmmc_probe(struct platform
>         }
>
>         host->irq = platform_get_irq(pdev, 0);
> -       if (host->irq < 0)
> +       if (host->irq < 0) {
> +               ret = host->irq;
>                 goto out3;
> +       }
>
>         mmc->ops = &au1xmmc_ops;
>
