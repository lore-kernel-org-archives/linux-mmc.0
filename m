Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A11C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 12:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiCOMYx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348235AbiCOMYu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 08:24:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FB643A
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h11so26218314ljb.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRpn9k07AvFRGh0gF6YNXgmPxpnxq7wyCuwbzm66mLY=;
        b=NpcMfLCqOAjT2sSeV2QqGd3mVpMck4r8/tTTwR2NqNCDqUgjj1ku8olci2AYbWVWSM
         7/pwvHGIT4rLhKXrwy9JGibkOvzcmbIBtdsjb73CDUIt15Tv1gKSbdqdj00GESjfXH4v
         Re/lrRPmgkYVNgNBKm3V9vwRYgxGVMxS6fXIANYcBpaUNRxd81mFdoDXuAaZAKxNL7Kr
         tsNlouITyJipc4mN1YQDc06DHWRtdgOskGMbY2Frn6vypqk1p+pAiP0imz2KQA3QbMbe
         xMby9/TNvVxnrvP3GrelxqBxGtR10TmBCHNVA8f+vB8C5+BUbC2KK34tQUgLuprmojc6
         QWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRpn9k07AvFRGh0gF6YNXgmPxpnxq7wyCuwbzm66mLY=;
        b=1ANShxcIXOjZ01wDORg5BYRUbo+QBH3yXbcNYlNgCCsyXfe4IUCl7dM5rnsGCLXL/j
         ho+P/I4B3BJpuug9Ftl7s8xhNuMH4TF0CHBpaIAZTlQAY0Ua3Uzoeyp1pheoGK+zuYnd
         /sBvCWg9ng2SF7YciKK9pxvy1I9z7UYRBVaYR8F/OMuN/Wg89VwL2ZBx8swAwRfypu80
         8aR0/HZYAetV8HrXbwNlAMdnnUpQNEA/xQJucWudt6lUiQc7Og77DnQzvK2fGun+HeJs
         x9NrIERlgCladvECom0E8NdO0ZKgTM12GHdTFfNBBx0GKxgX/18jZmbXF9P0W8DePS4r
         MZ1Q==
X-Gm-Message-State: AOAM531it5zwJNFr/MRuJVdHrn50iQ/v4+Zgamjp+b3UA9lDRp4Vos09
        dVbz9IauNVVqRZZq9P2ECKCJEN7ZM6xsMrzD8RyvKw==
X-Google-Smtp-Source: ABdhPJzu8qPCA6D1kpxXHeMtMO8O3TbgLh0QyLY8oWy5P2UKXJg3HmMXMtdXQRnulGznlGIGslhhvaCuFE5JlYb47eI=
X-Received: by 2002:a2e:890e:0:b0:249:295a:eb40 with SMTP id
 d14-20020a2e890e000000b00249295aeb40mr9371355lji.463.1647347015757; Tue, 15
 Mar 2022 05:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220311103320.3072171-1-abailon@baylibre.com>
In-Reply-To: <20220311103320.3072171-1-abailon@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:59 +0100
Message-ID: <CAPDyKFp4QbaCvOQoK_5rdh4X_iuvvsZ6M-iGiBCNp-VuQ+WChg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Silence delay phase calculation debug log
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Mar 2022 at 11:33, Alexandre Bailon <abailon@baylibre.com> wrote:
>
> The driver prints the following log everytime data is written to RPMB:
> mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]
>
> dev_info is used to print that log but it seems that log is only
> useful for debbuging. Use dev_dbg instead of dev_info.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index d5a9c269d492..05c8b4de46f3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1914,8 +1914,8 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
>                 final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
>         else
>                 final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
> -       dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> -                delay, len_final, final_phase);
> +       dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> +               delay, len_final, final_phase);
>
>         delay_phase.maxlen = len_final;
>         delay_phase.start = start_final;
> --
> 2.34.1
>
