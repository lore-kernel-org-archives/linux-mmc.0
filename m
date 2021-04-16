Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94322C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7128C611AF
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 13:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbhDPNOZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbhDPNOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 09:14:24 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF0C061574
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 06:13:58 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id m20so3652099uah.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBWxrzeqmT+fcqxM3CIZlLxZmv01hbyHOX79oGcgBNU=;
        b=bdJmr44iMOBmUSUkDpgxXY3Jty1xvHbjqaqVPUMm9rf8YT8a5vNd7dGU3LjNJD/iSb
         vWumSD8PEjrDXu/vEUsdkZ8C15ZJf3uHZrlA/e2i9NKfeJZjV6wPSwNUzQB90HbbVbXx
         DzvexOCebDj6P+QzYWuiqzob8j4kIIrEF9Wg19RTRaIg3UK71pDM6fM5aR4tFgrrETHU
         uHniyKuQHV9bEpzGIO9Bl3vNKxbyiByErGnH7fXSBJwKDcGFUbi52TFxuv+ztS16J2Ui
         c3GNHwzKU5GcOjkUWLez9gTKEUJf7WHwFtRntt+/zUXp64k5uP6zT4IrZJhdhrEAWJq9
         9JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBWxrzeqmT+fcqxM3CIZlLxZmv01hbyHOX79oGcgBNU=;
        b=GBj4MQk9g8jDiC2WexREKOSlqGeOLwguWYZML0cq4iihrtXFpeN+FfGreeeTR4c0iH
         MWHcfurutePnq1+1HoCTjQRlyf3G3s6MsDNPvtedlwSzyIKyo/v+BZZEbtHV5QGezC31
         PNdBgL1KrocXZOmfKKTzeJOD2+i7DBkpoUTFJbwoGEX2yac6nW+PklwFgjLipPzIttxA
         tmfl+R37bHxdwr0xoGMzw6TvPImKDDI3iOF5o1Idww/+gunJkFf3lmsOUlhqKzWP2Szw
         nUPcpteuk991Y0oc0/Aj6x2ed2KdOZi+1Ys94DQ2kw3heE1wIf1fzfSKZUvf6ka4BbqC
         w/TA==
X-Gm-Message-State: AOAM531tpaT82qQ1ZZIOhglnSbMzZKl2/lXr3dpSpTeDttxaQVW/8JFF
        faCS8UNBJ+GI10NakP1WOxvpuRovJ+AUo4JkYKZ3b+jUh35txw==
X-Google-Smtp-Source: ABdhPJy/1ARqgMcxbv36kBpNiVuJTz8nsWTI3plbA4LGjirAcRyHtrPAViAMFfbbTMmvG6YbZNHCj7ebG0ZClcAki8c=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr5934046uak.19.1618578837741;
 Fri, 16 Apr 2021 06:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <1618539454-182170-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1618539454-182170-1-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Apr 2021 15:13:20 +0200
Message-ID: <CAPDyKFqi8V6WC9Rdtb0hEXpP=aSigq6+P2-+X=O3XpmX-9Tyug@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Just set default sample value for
 legacy mode
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Apr 2021 at 04:17, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> .set_ios() is called from .resume() as well. For SDIO device which sets
> keep-power-in-suspend, nothing should be changed after resuming, as well
> as sample tuning value, since this value is tuned already. So we should
> not overwrite it with the default value.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 753502c..d36991a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -61,7 +61,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         }
>
>         /* Make sure we use phases which we can enumerate with */
> -       if (!IS_ERR(priv->sample_clk))
> +       if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
>                 clk_set_phase(priv->sample_clk, priv->default_sample_phase);
>
>         /*
> --
> 2.7.4
>
>
>
