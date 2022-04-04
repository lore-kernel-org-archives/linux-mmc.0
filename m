Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5429C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 11:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiDDLzP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiDDLzO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 07:55:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8053DA4D
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 04:53:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by7so12616285ljb.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2022 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cH63uFF/Ds1PEA6ozfC7BG7nBZMAO+T4zLJM201iPAU=;
        b=Vb3JWaftR14TP7vFCrUeuNLqUrkQRhDhOR2ONnrnawUZnlzWIbVeLhdZAkmM3yHOTY
         HwXu4+n04GaRsEH5JmTZxOz2GS0ROvch3cWLcMzMEeI4IQJ5+vLjoY9fbXEFjZ9imkde
         kTxuqLAKOKZVExMc5yjQTx0GDPfj7Ieo4KFRQ/+rjDrI8UZbqnhYkn8e1nFJP/FPLOb4
         mAjd5DexAimAj9LjuntcuWC5gohPM2PrKMoedYOpEteXlpmNSlVHbfzphSwpK09RbaJ6
         QIHV1HhbHQAIL/AGpzi7yj/Teh7p/s8czzi1KFOmQYI/cI2qiwzwQCEUKy5BhobkaVam
         aOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cH63uFF/Ds1PEA6ozfC7BG7nBZMAO+T4zLJM201iPAU=;
        b=FTjOosrY0m+jAoclXCKjRhteRPhnvi2g34OFcw4uOJsBU3LC+CXSg2kBXG2aAnakb6
         ouI2CDToQnYIf822n6Z2gxleE03SHL9EG9qNotu9gLhS0ZqxdP+JmZS+MUMI2giQ6aCx
         tTGhbyq4vuHMKoOgc/eyvKtvsEKkyeJbO+LmfzDhbyEXR6OG5UASajq7Od4/lqZguqUa
         ukzuqgD+sasOWriS2VGFV6TJXtcRdH0g/zCNXjT+NQ6NuNN5oHrW7qgIOy0N8D+13hjN
         y5sOmGgtvlD7E9mS55MMf5NUMbzFKqj1N9JXN4VRZpOpgqdLFmN2UPHlzh3/gMaxOapJ
         75zQ==
X-Gm-Message-State: AOAM530dCdGGkBHfZot4/X8FrSW/nDFxJrnfMGYAnVNuYIQhOPZTvjk7
        4hXQ7LkxgdNeUQGNh1Vy/VWMtkN9kXRA185Vg7MUrg==
X-Google-Smtp-Source: ABdhPJwgYOaICwLby8+H+Or0dATz+UGCTrspiEEt5enDgmadKYp7daAzZ5RbOoamWWpXqD7G3NhOHPCnOa6uDmSPcmM=
X-Received: by 2002:a2e:b012:0:b0:249:8061:8486 with SMTP id
 y18-20020a2eb012000000b0024980618486mr20852079ljk.463.1649073197201; Mon, 04
 Apr 2022 04:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220404100508.3209-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220404100508.3209-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 13:52:41 +0200
Message-ID: <CAPDyKFpTbaA4e0r+vAM_H3dQSjee1GKPrrwmrM-Sp3eDJUBaOg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: special 4tap settings only apply to HS400
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Apr 2022 at 12:05, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Previous documentation was vague, so we included SDR104 for slow SDnH
> clock settings. It turns out now, that it is only needed for HS400.
>
> Fixes: bb6d3fa98a41 ("clk: renesas: rcar-gen3: Switch to new SD clock handling")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Chages since v1:
> * fixed typo in the commit message (Shimoda-san)
> * added review tag
>
>  drivers/mmc/host/renesas_sdhi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fe63548d816d..89d21231ec5f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -142,9 +142,9 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
>                 return clk_get_rate(priv->clk);
>
>         if (priv->clkh) {
> +               /* HS400 with 4TAP needs different clock settings */
>                 bool use_4tap = priv->quirks && priv->quirks->hs400_4taps;
> -               bool need_slow_clkh = (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104) ||
> -                                     (host->mmc->ios.timing == MMC_TIMING_MMC_HS400);
> +               bool need_slow_clkh = host->mmc->ios.timing == MMC_TIMING_MMC_HS400;
>                 clkh_shift = use_4tap && need_slow_clkh ? 1 : 2;
>                 ref_clk = priv->clkh;
>         }
> --
> 2.30.2
>
