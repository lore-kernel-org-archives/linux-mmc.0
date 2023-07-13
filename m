Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402EC0015E
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjGMLHW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjGMLHU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:07:20 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3E2686
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5776312eaddso4779127b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246437; x=1691838437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aU2GriijjzpEa6tm+ZpH1Tad+2lfsOtGEsi/JQ6xwY0=;
        b=gkgcpdceytYo7p7HvQANAKnCmKyJhZZ/fait6wzqHSO5H7XATa3VaRtyxQOPjmwZlV
         g3iCt5Q6M7DUgu5DPDscAxai45NzAeMzKtyMvHgb8fkPBYSUFUKkX+yFkpMEmQFiaJob
         As206AiDRAovCWXxSqJsZpsrApOsxngEtbTve2nO56mQji3YsgFYfs3vfysekVdFOleQ
         HpskSqetodx6MSL31Qbd5uQjw6U9AWoeF+CyJi49Mj0mM5w0jN5zLeqYOwdQQjX8avkH
         //lVznzUStGDxtLlNz5OXlODuZoN95gpMfgY2s/BRGBudXKJOCuq3A6ag3SavCZGrr4+
         Y1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246437; x=1691838437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU2GriijjzpEa6tm+ZpH1Tad+2lfsOtGEsi/JQ6xwY0=;
        b=j2TEoP4oXOQgjhS5wDcTRzdysKvykCsGNXYknEEoOvb+VToPScKbzFEa7iLlRQ1j+A
         VWd5FGsbDtOncjLOIlXanqfwyXfN4gtVmDxDIKJXlz65PIntIurnUdrj6F0soCs9Jwql
         JrvgB6sXiracD2xhQqHBOkQuG3G5TqyHa+sQ+SRTIxBXAyRswMtFupVcjbo/Q3sq+0oA
         2ib/gA8ldtD8egGaryUzWP1OyNnR7Tkobdpm3QMCn+YvpJZUs4YBJwhhVXepwVOr1y90
         Ph2U0NSvyjUsKgR9x2nQ0ove2xiaaqNsiytoRdapdp4laiPhTY8CE4V5cLGdKKbHWef8
         BidQ==
X-Gm-Message-State: ABy/qLarMZt9o2P2eK6NUhHM07Cj/C8/x72bji0tNKjYzvRdpVITWTci
        uKY3cz9+2rdw3dMikF2lGhJHfwBoQE958EI1+an+EA==
X-Google-Smtp-Source: APBJJlEYv523i6IhLoA0BGSmqLFwtWWmWviDwi2Uj2rSfLPtf+V73TVLV4Eo2s3Fl3srNgCVPZJ+QcODzQ1EvGwi38A=
X-Received: by 2002:a81:92d3:0:b0:581:2887:22be with SMTP id
 j202-20020a8192d3000000b00581288722bemr1578894ywg.37.1689246436829; Thu, 13
 Jul 2023 04:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230712140116.18718-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712140116.18718-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:41 +0200
Message-ID: <CAPDyKFotzk8wi-a6zpQ4Qm_Cgv_i9bYw1jni+AUoFw4wPry7Gw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: remove outdated indentation
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Jul 2023 at 16:01, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Using tabs to make a structure initialization more readable is not
> considered helpful. Remove the final appearance from this driver.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> My eyes always stumble over this...
>
>  drivers/mmc/host/renesas_sdhi_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 2d5ef9c37d76..10dbdb4abc93 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -983,12 +983,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>
>         }
>
> -       host->write16_hook      = renesas_sdhi_write16_hook;
> -       host->clk_enable        = renesas_sdhi_clk_enable;
> -       host->clk_disable       = renesas_sdhi_clk_disable;
> -       host->set_clock         = renesas_sdhi_set_clock;
> -       host->multi_io_quirk    = renesas_sdhi_multi_io_quirk;
> -       host->dma_ops           = dma_ops;
> +       host->write16_hook = renesas_sdhi_write16_hook;
> +       host->clk_enable = renesas_sdhi_clk_enable;
> +       host->clk_disable = renesas_sdhi_clk_disable;
> +       host->set_clock = renesas_sdhi_set_clock;
> +       host->multi_io_quirk = renesas_sdhi_multi_io_quirk;
> +       host->dma_ops = dma_ops;
>
>         if (sdhi_has_quirk(priv, hs400_disabled))
>                 host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> --
> 2.30.2
>
