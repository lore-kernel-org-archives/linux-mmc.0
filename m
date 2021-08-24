Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7AC4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C356113A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 13:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhHXNQv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbhHXNQu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 09:16:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1AC061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 06:16:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i28so37598500ljm.7
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydTVZ15OhL0mGtwmOd376yklz9JBnBhbEVNdkVMJ/z0=;
        b=XPM3yRqCi4Jh+kJYR3AfSNeIhcwiK9U57g5ukbYv7PRiIEIm93U8ACJ6oGo1TVceQm
         cQQy5M/fQCBoeWm2+pbY66wVkAJEEj0NrV9EkSkkXKOiStCyaMEXmRgdKxTkZhYx+k1W
         5sU/Ons4G7ErJPycd/6adP7IBvdiKwAzhzQ22oPHRW3Z7w7ShMm9AHexTMKAyxvMQjJk
         gxucXOGQBzsUbAx24Xz2XqZbYWWNAf2+g4YLb+MORNdGezqoDWXqjuYay+wW3y9ynPy4
         hNAqDHbCZejWwlU9SZhJtMAx25yZywqbqLrG77zEMjYCK/CgUOFe54PKGukV5l7yuMe7
         N7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydTVZ15OhL0mGtwmOd376yklz9JBnBhbEVNdkVMJ/z0=;
        b=jb41qCVYxnPCI4feyF2lnb5/dXF1OVSAzclEdRyY/YxMKqsI+4/6m25v4lhjLea2Tm
         LLru9LvjMonnCo0ct4gbanP76XI9bZLlMVS6Ofc8FIsekQn3VmFv8W0WTZLQupF7A9N8
         1ZvndttVMvZ5UEeAyOUjHfwz7WCUnz5rpcUdNiHPwYhqQCKerOP3AdK2hOoBe9nTS3yI
         eK9zV20hszNYDS4W4Hq29K4aTEsPxBUYjjs/ukyH9InrnNiNMXu3JeisXMVa9DI0BOSm
         aP/qx8Yy+y3ZKR6wkabmYjC2a7v38c2zE0H7Ft0kDDjuR3MfiCaAfQRyJrlt2M9ZGKIG
         epfw==
X-Gm-Message-State: AOAM530drBoqKEZ6lhsXbmyNOBHQM4N1QCephJsk46YMcRQyq0to4Byv
        tgq5AmRfn/+4L6Fe6dfcU1F7K5imqnvdSmlZH2/H6g==
X-Google-Smtp-Source: ABdhPJy753AzVXSSiQfqytntQ08HWRbs8vTdlqrvJAwaJjLm66jH8yB6x80jNU5eEaj/WH62hBiYT5ElWXoHzqleFzk=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr30044554ljn.364.1629810964603;
 Tue, 24 Aug 2021 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210816073813.11715-1-Mason.Zhang@mediatek.com>
In-Reply-To: <20210816073813.11715-1-Mason.Zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 15:15:28 +0200
Message-ID: <CAPDyKFpSOcX6End_L0mLRt61s0aS_zT19snM71j9bxgMi1oUuA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: mediatek: fixed clk contrl flow
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 09:39, Mason Zhang <Mason.Zhang@mediatek.com> wrote:
>
> this patch fixed clk contrl flow in set clk rate, no need close clk src,
> gate cg is enough, so no need call clk prepare/unprepare.

No, this isn't the way we should deploy clock support in drivers.

If the driver doesn't need to gate/ungate clocks from atomic context,
the proper thing is to use the slow path APIs, clk_prepare_enable()
and clk_disable_unprepare().

Kind regards
Uffe

>
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..d9835b272c1f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -895,9 +895,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>          * So if want to only gate src_clk, need gate its parent(mux).
>          */
>         if (host->src_clk_cg)
> -               clk_disable_unprepare(host->src_clk_cg);
> +               clk_disable(host->src_clk_cg);
>         else
> -               clk_disable_unprepare(clk_get_parent(host->src_clk));
> +               clk_disable(clk_get_parent(host->src_clk));
>         if (host->dev_comp->clk_div_bits == 8)
>                 sdr_set_field(host->base + MSDC_CFG,
>                               MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> @@ -907,9 +907,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                               MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
>                               (mode << 12) | div);
>         if (host->src_clk_cg)
> -               clk_prepare_enable(host->src_clk_cg);
> +               clk_enable(host->src_clk_cg);
>         else
> -               clk_prepare_enable(clk_get_parent(host->src_clk));
> +               clk_enable(clk_get_parent(host->src_clk));
>
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> --
> 2.18.0
>
