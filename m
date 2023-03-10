Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8465AC6FA99
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 15:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjCJP10 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjCJP1B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 10:27:01 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0310EA9F
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:16:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b20so3832257pfo.6
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ym7VeGrcmmycPzwS4GsVwPl3pR3x6Yw0IFrKSAgC43s=;
        b=aqwcM+8BBXVb0ObGiQTEgd/jjktC8yTATcVdjhuDILuCSzR3KIw8lXhNtaTFGE8UOV
         tD1x/n2TYsRcvqMFeVLawX3NG6vXP93wYg9ZuLLVUULSqEktTm8efjaaKpw5zyPB4s79
         Tb7drBX5X+80CO8XoWuPZWq6jhJzLYDtgn5fdCufdgIWYVo/wlL3XDyIPSFm27sJZUfn
         /yDfoCmgRpwK1JfOT+XFS8/q8BKaG02f+H2SMVyhORuMpI6GtOk07QOwGQTD4o/ORd0H
         f1s8wpmAtXY4Oem3ReNRzdA3x4OpRiSg37mjC2PgGHdWbROhNwoMYl869CWWMMDgya+K
         upIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym7VeGrcmmycPzwS4GsVwPl3pR3x6Yw0IFrKSAgC43s=;
        b=23phcLXc0Bwa2kwsVOB2tsW4oSAseFMVL0MSbiu01fH09DYnzhwlPiMJGZBmdz2wgf
         8Rd6rqxCFJ+u6XB+JTkByUvq+/bhrZsPPaJK3wehxfvfVKbS4YIIJDt4DcpzkhdNPg5Z
         d+uNKcupn4pnCmq0tcP953IGBmks6cD6uoDsrB6f503CQO1YAsMbJ7sDNUDZbubUQW3n
         BXudt2XM/p5aVty8hDa4GGFewlk2fhpL/X+cCTE5xbB0hXCRyhFAHiD76iZ/10W59qbO
         I+1d+CumdJOC9vvkoOV419YPa6nf6ScnQKQJcEEORrwHJ8lbAcX4Suxfz2brlHwFAqmA
         gQXg==
X-Gm-Message-State: AO0yUKXzYhAN393C04b/DXZXhMpwvpDE5XQvm3WvqsdduGr/jPbgduRq
        Hy4QVwbS1sRrmWAsTVTfqqpQNYLUmGjt2eZMSgtxFA==
X-Google-Smtp-Source: AK7set+oIBKQVBleHMih2zz27+dDoWDUn/yZ0r+j2ash04CMNiUj2o6kuDKe2iXpo7GPruxqk5YnLANLsO62p6+M400=
X-Received: by 2002:a05:6a00:2254:b0:5de:ece4:2674 with SMTP id
 i20-20020a056a00225400b005deece42674mr11019194pfu.3.1678461325765; Fri, 10
 Mar 2023 07:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20230310010349.509132-1-anarsoul@gmail.com>
In-Reply-To: <20230310010349.509132-1-anarsoul@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:49 +0100
Message-ID: <CAPDyKFrMG7bWune67gLAUm+OU39HXRZbT48hBe8gBTWkWDkimQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: properly determine max clock on Rockchip
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Mar 2023 at 02:04, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Currently .get_max_clock returns the current clock rate for cclk_emmc
> on rk35xx, thus max clock gets set to whatever bootloader set it to.
>
> In case of u-boot, it is intentionally reset to 50 MHz if it boots
> from eMMC, see mmc_deinit() in u-boot sources. As a result, HS200 and
> HS400 modes are never selected by Linux, because dwcmshc_rk35xx_postinit
> clears appropriate caps if host->mmc->f_max is < 52MHz
>
> cclk_emmc is not a fixed clock on rk35xx, so using
> sdhci_pltfm_clk_get_max_clock is not appropriate here.
>
> Implement rk35xx_get_max_clock that returns actual max clock for cclk_emmc.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index d1490469184b..e68cd87998c8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -126,6 +126,13 @@ static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
>                 return pltfm_host->clock;
>  }
>
> +static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return clk_round_rate(pltfm_host->clk, ULONG_MAX);
> +}
> +
>  static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
>                                      struct mmc_request *mrq)
>  {
> @@ -343,7 +350,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .set_clock              = dwcmshc_rk3568_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> -       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock          = rk35xx_get_max_clock,
>         .reset                  = rk35xx_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
> --
> 2.39.2
>
