Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B457FC388F9
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DF320756
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCdGxiE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgKEM7x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgKEM7u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:50 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C108C0613CF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:50 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id q68so483733uaq.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ogy1F0OZxhfIxCnSobyKyOBL57nC3KTIEKh8oSdo12Y=;
        b=lCdGxiE45E+xLqcXhqfOnyBv5sAJ6fcX8rd45RL5WkLO4LoUzy+R3uDKgfckfmDHTc
         v0PZqlL/2eBRkz8Cj+qydXTCLss6tVvPKTrJY+jP6s0yhRUMElRXMHaWuueeISr39xl2
         QI8NMvSWJzAH7FYQDdHEoyIhWfZxDetbEmN3ZmUAS6yt8MVlFxRaKggtSagTnc6/qNah
         PrvhqYPtaui1rhhbk5fv4RuocM3YiiFOEKHyZ0CXUfquH9kSow0/N5JThKqpAAxgaQ9C
         jxVeunieL1p3jr7T9f/guNEUtgtIR8+jom6805hnxzZsMwPCX6SM+N5HrGfzlAyO7s7L
         CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ogy1F0OZxhfIxCnSobyKyOBL57nC3KTIEKh8oSdo12Y=;
        b=nsbLwXvbp4upn0SP3LsZuS1D+j41WKc+ko4Pa8iaJcNjH65f58BJQFdsx+yzD/B8q/
         T+HbUSbVWx17I4jA/T6d56d4NsUeZsLEXAVCWX/7Ozm0B29oteAxKpOsgvLEOTPSPmlG
         fuRzGEUBCRbQKCK+BZQsK81oBMkNOVtThP2qjoCQriVFLa4MiLL98stvg+8CPM0HpLiN
         X3Z489VS/jz0F4fGczZ9ysP8fZjnxDr+Zc7l6BF0jfagOSWs+MQezht+ZIm2QHyEW0mx
         qymzq+KuasGHPH2OKWXPhWwYYSypiBYtbHDHAJEZIr1XHeY63sxrr6K0jWHVLOzPnoz0
         1BFQ==
X-Gm-Message-State: AOAM531j5tHayHSzZ2HsxxXhu5OIB5AgLPo9hdadjLlAcs2UBW2Y1DgU
        lZKSjjAyaZqKY4dppbnTE4GFIJcfEBLiZBKoO1uMEg==
X-Google-Smtp-Source: ABdhPJygw6lv2K7RzimlR0j9nMogFpDzaeo2sDnSHRJ8tbpbhbUQAIPJLUSINH4E+x6ZU6D9Dds59Yz53akRLcTQxmo=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr844197uaj.104.1604581189602;
 Thu, 05 Nov 2020 04:59:49 -0800 (PST)
MIME-Version: 1.0
References: <1604278337-55624-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1604278337-55624-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:12 +0100
Message-ID: <CAPDyKFrEEB7HFEq787jitvOJmuP_t-DAbr9g_chF3JGWxwE_FA@mail.gmail.com>
Subject: Re: [PATCH] mmc: owl-mmc: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 Nov 2020 at 01:51, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index ccf214a..82d2bad 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -134,10 +134,9 @@ static void owl_mmc_update_reg(void __iomem *reg, unsigned int val, bool state)
>  static irqreturn_t owl_irq_handler(int irq, void *devid)
>  {
>         struct owl_mmc_host *owl_host = devid;
> -       unsigned long flags;
>         u32 state;
>
> -       spin_lock_irqsave(&owl_host->lock, flags);
> +       spin_lock(&owl_host->lock);
>
>         state = readl(owl_host->base + OWL_REG_SD_STATE);
>         if (state & OWL_SD_STATE_TEI) {
> @@ -147,7 +146,7 @@ static irqreturn_t owl_irq_handler(int irq, void *devid)
>                 complete(&owl_host->sdc_complete);
>         }
>
> -       spin_unlock_irqrestore(&owl_host->lock, flags);
> +       spin_unlock(&owl_host->lock);
>
>         return IRQ_HANDLED;
>  }
> --
> 2.7.4
>
