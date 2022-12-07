Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930EFC352A1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiLGMin (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLGMiT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:19 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C1450B7
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:38:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so16263183pgf.7
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYM23FTNqIfOQt2Wc+NWK66hmV39Pj1uNxknfmVEQho=;
        b=BKMiYekt6U/P6SgrYYV4QHdXXhw9KFWVOmx2NYYPcRbmH3XGi2wY4BoeHTLex3/PVn
         wac86bmaxiIZ2ZePogEVA/T81wrfnffe0mc2g2/oIoK0nI3n+y8giKalg7fBcMFyRKGB
         /H/0jsH1HG6qN8FTdCqq0dTXJrRGMrFr8TAmnbtXrLX9pQ2ipN5OCoejmBghlYT/Brz4
         jN6qqSXSfgvtJqp22vWy68TBUBw4k1HVMwtNfxP3LG33+DXF/QfjNysl3FrLezDqTtN6
         b/SFUi7Yyqoc5dhj29aJKQyoT3NnNvaqspYBSNV+vJa+kY3obq0VRk8ivtaNC770/NIQ
         X3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYM23FTNqIfOQt2Wc+NWK66hmV39Pj1uNxknfmVEQho=;
        b=2aUS2vE3EWnv82eH2E/siq1+TXD/3ZXCC3XDYV9WAQ70xRjvBsJLvVONTuL+tKPKob
         HftKDpjnLDjMc8tkgA/y4WehCs+RP4hItzYSjZBbBvhUI8L6SR5c9hc0kPpkC34II++l
         Mc9NNH1xTJOT51oRJtbrLxfiTIqgbou6Ag7y7fprrnPg0ce7nbwGYYwruJPXU4x++VtN
         hpxch3Vm4gHpAhaKGkoh2bnpDIoQk9U2ZGWQcC7giAJs8w0/L399bVzNNRUhQQ8XikLR
         TESZgIO438e0Ft6oidos+tDIC2WzsZ3/QANA3IFkLE9EQaEPCUWvjAi1819pnSdCI4ru
         vvUg==
X-Gm-Message-State: ANoB5pmWiL2QAJmz43HFszLe/mcxMCRFq6uO7ckmxsSmlkD7D9ZEHWns
        2uSuhCZ2GmVF6ONLQwnivs8vchalFRr64JprUQrzqxcrqE9xqg==
X-Google-Smtp-Source: AA0mqf7/76Ca5jC5TY5aBWLKt9s1l+HvKdSlwIVOrCMaztVBuwoSqK/61JSvpjt9aLpKDNO+KPS2zS0lRrbgxrPkb4I=
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id
 h8-20020a654688000000b004777aeea464mr69847980pgr.595.1670416688784; Wed, 07
 Dec 2022 04:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20221202075905.25363-1-andy.tang@nxp.com>
In-Reply-To: <20221202075905.25363-1-andy.tang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:32 +0100
Message-ID: <CAPDyKForCE1VODVt5KAdcZPK0n0Gxw575aow6nDo62yYFX_qUQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock frequency
To:     andy.tang@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Dec 2022 at 08:44, <andy.tang@nxp.com> wrote:
>
> From: Andy Tang <andy.tang@nxp.com>
>
> The highest clock frequency for eMMC HS200 mode on ls1043a
> is 116.7Mhz according to its specification.
> So add the limit to gate the frequency.
>
> Signed-off-by: Andy Tang <andy.tang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: change the author to andy tang
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 00542dd74c07..1fd4ae10862d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -43,6 +43,12 @@ static const struct esdhc_clk_fixup ls1021a_esdhc_clk = {
>         .max_clk[MMC_TIMING_SD_HS] = 46500000,
>  };
>
> +static const struct esdhc_clk_fixup ls1043a_esdhc_clk = {
> +       .sd_dflt_max_clk = 25000000,
> +       .max_clk[MMC_TIMING_UHS_SDR104] = 116700000,
> +       .max_clk[MMC_TIMING_MMC_HS200] = 116700000,
> +};
> +
>  static const struct esdhc_clk_fixup ls1046a_esdhc_clk = {
>         .sd_dflt_max_clk = 25000000,
>         .max_clk[MMC_TIMING_UHS_SDR104] = 167000000,
> @@ -64,6 +70,7 @@ static const struct esdhc_clk_fixup p1010_esdhc_clk = {
>
>  static const struct of_device_id sdhci_esdhc_of_match[] = {
>         { .compatible = "fsl,ls1021a-esdhc", .data = &ls1021a_esdhc_clk},
> +       { .compatible = "fsl,ls1043a-esdhc", .data = &ls1043a_esdhc_clk},
>         { .compatible = "fsl,ls1046a-esdhc", .data = &ls1046a_esdhc_clk},
>         { .compatible = "fsl,ls1012a-esdhc", .data = &ls1012a_esdhc_clk},
>         { .compatible = "fsl,p1010-esdhc",   .data = &p1010_esdhc_clk},
> --
> 2.25.1
>
