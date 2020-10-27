Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE996C55179
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD4324630
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDTzx3wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbgJ0MMM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:12:12 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34467 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1749324AbgJ0MMM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 08:12:12 -0400
Received: by mail-vk1-f194.google.com with SMTP id s144so300530vkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3hdAD2/SfSVH7mLkNbOazbZ1K7Ev/XT9ONQ25TQSDM=;
        b=PDTzx3wAmjvtMIqJLQf55wBX3zV38/E1NKQ5hbF9J37P08tWIczYGfMiDSri4xIg9+
         D9gol1nV6KVYi6Khf2wEMy5sYHrpUr86+CdjE4fqGO/REJGVUHnZUXG5c6vNYAxLrYwy
         3IoFi5UPd8B2S77Jp9ejkSanfGhEY8mCZhKnaNEp285Gp8oHExqo54MoOfC2hGyT7ghA
         lDgQ8iHU5tPmPNjJaCcADMi2qU3OqvBBPliNvYl52SLhS2icaiKPhg5V8e/LmAvonKhX
         x6e9HDTk4W8radGJrKEUVq1y91uAunqgLpmeNau7FcOO19Njbz7l1MaIDoV9Q3NDvpwu
         WMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3hdAD2/SfSVH7mLkNbOazbZ1K7Ev/XT9ONQ25TQSDM=;
        b=H97Zkh4sg7oZt7f/Ln6Yx5AbR2nEvuw9gTA2VaLWwNuNSQcgfpa2YmQDNIUTca/Tmk
         rcSEmJqOzaisDDbWeFnWdWnnBtCkcDxyBRQjUCcjz58q8ds9txN9G/RYbxEUZYESDp46
         gdURoPq4Gvx7WLjjO2AolIbLhOu77dSRAwq6dpChSE3C4QLiuGvLds2VKxaTc0i/l5jx
         AcgP6kw0W72xHYLW6U3F3aRGnX/rNnJyiMGCyRjhwkVCBDXdBhI04MVpIjoJFtferbAU
         Tfdo0ztJq8EZRHRbXdujwwPk5AwuSMJNpIssMrVIOfptInm4OD2oMNjiIe40Oi5X+oZN
         DuNw==
X-Gm-Message-State: AOAM533WbZxaAMcBLQktcxrM0zhUTqQHmrfZnay8Bzl5xw6w/jNPAu9n
        EAMFZMwcHdN4LQmb2pDjXigr1FIFht+T53P7VDIfwA==
X-Google-Smtp-Source: ABdhPJz9LZoiTJhx1SHZvE2wOEztXoNObRC3nyLzZpkAJKjEOp/2NEgP80ioL4M98sMqoh79lv2vrnEnNPppto8YuAU=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr1144150vkk.6.1603800731083;
 Tue, 27 Oct 2020 05:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201023122950.60903-1-fparent@baylibre.com>
In-Reply-To: <20201023122950.60903-1-fparent@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 13:11:34 +0100
Message-ID: <CAPDyKFrMwLeuQoFDgXYo_-T_e2AzfqM-rgp3-SgeuC6Qn6rxMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
To:     Fabien Parent <fparent@baylibre.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Yong Mao, Chaotian Jing

On Fri, 23 Oct 2020 at 14:29, Fabien Parent <fparent@baylibre.com> wrote:
>
> MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
> devices sometimes unstable. Make use of the new property
> recheck_sdio_irq to fix the SDIO stability issues on MT8516.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Maybe this is a common problem, thus I am thinking that potentially we
should enable the workaround for all variants?

I have looped in Yong Mao (who invented the workaround) and Chaotian
Jing, to see if they can advise us how to proceed.

In any case, I think we should add a stable tag and a fixes tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..3dc102eefe49 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>
>  static const struct mtk_mmc_compatible mt8516_compat = {
>         .clk_div_bits = 12,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> --
> 2.28.0
>
