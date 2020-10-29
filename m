Return-Path: <SRS0=xPu9=EE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC7C2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 12:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E454F20782
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 12:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3Nt87l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJ2MJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgJ2MJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2020 08:09:10 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E8C0613D2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 05:09:10 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id u202so643297vkb.4
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OKA9Pgk0ZZ7+DXmqAtn7byrzzqg0DhRt90w2UoAl54=;
        b=p3Nt87l2xN8E/kW1cpinhezE9x7HXKo0TaISvtMl0md3/MASIkPOI4oWfHMDtV2fL8
         HJf8642vtrJwRDG15XPPEhmxdnqKFj1DCvxvW0izscb4zY+MPp/WvvZTLUwkDNI9YTog
         RMbzmKP8cNTp32zafmWVv7TbKNv7p4bZyuZ+QemO5SKdfFmSlt5+kiPbBo+xxxnypH60
         t9nSQ/yHhI6zYAF4FVQiiEOTs4vK48hVWrxgCv3/XszpLqel8WuZDFHQmfkvcEkMHtcl
         AWTYcD6quieQEWNs2sBIikUTjgIQzx/S+gm9fC7VmHV9Sy1HeHWtweWy6MGK4Ldk3KCm
         8w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OKA9Pgk0ZZ7+DXmqAtn7byrzzqg0DhRt90w2UoAl54=;
        b=jaXQUYMBmuMyZ0tX3l70JJADsz18E6NAjy00t/92FahBXMq0W9oR9qYDesesEvOCOq
         b1ynveFxGFQhdEWkM+wn0aAThbNBMj0nFRCBILyU+FLxNeGYUztUSfe1kwEtaMGDg57V
         WbIVqCSAI+u5Ch6fPoATrtc4Qi31XtmGMXaUa8CcmPFR78EKRQnrqYX5wH4LdhSciN3D
         opfOdR5GgcQpJCtiFqQdd2DVR9uz7CRs6OQ/tHcMVx5Aii844ea4Oqq3V7Y5E/KjwX8Y
         54LnSubepW5TEkW5VKUu46gxjVSno9qzUJnWfVq3z++LCSIG/grjXZ36BpVKnNxJHsQx
         0xrg==
X-Gm-Message-State: AOAM531U4SF6sbxtRo3a6qsy14edFhJHEHZNabgo1Ni67Hf97lW7XBuC
        4R94y5dNXN8FUPRKnjkhvpDW7CM8+8yHPc9FxfUjcQ==
X-Google-Smtp-Source: ABdhPJyfh/wov0bgUNVgZKsf5ChZEKE/xeN/ahZVICTxi8+aUGFoAtBQTKr6ElCer1/at22RWmlzu2bKpXFwdKJFUFg=
X-Received: by 2002:a1f:4c07:: with SMTP id z7mr2571896vka.15.1603973349970;
 Thu, 29 Oct 2020 05:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <1603068193-44688-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1603068193-44688-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Oct 2020 13:08:33 +0100
Message-ID: <CAPDyKFpyASJCE8QtKX=R=eVeeT2=adknBZmWo8GVaaLDv8KAXw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     haotian.jing@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.or>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Oct 2020 at 02:42, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745..fb3e419 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1536,13 +1536,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>         struct mmc_host *mmc = mmc_from_priv(host);
>
>         while (true) {
> -               unsigned long flags;
>                 struct mmc_request *mrq;
>                 struct mmc_command *cmd;
>                 struct mmc_data *data;
>                 u32 events, event_mask;
>
> -               spin_lock_irqsave(&host->lock, flags);
> +               spin_lock(&host->lock);
>                 events = readl(host->base + MSDC_INT);
>                 event_mask = readl(host->base + MSDC_INTEN);
>                 if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> @@ -1553,7 +1552,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 mrq = host->mrq;
>                 cmd = host->cmd;
>                 data = host->data;
> -               spin_unlock_irqrestore(&host->lock, flags);
> +               spin_unlock(&host->lock);
>
>                 if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                         sdio_signal_irq(mmc);
> --
> 2.7.4
>
