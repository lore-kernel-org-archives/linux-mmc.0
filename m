Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934FCCA47F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 10:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiFGKoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbiFGKoD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 06:44:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E62126C
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 03:44:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w20so6003487lfa.11
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtPoJ12oteBNc0kHoMuvW+v6Ds9Jjp/7GrDvRJFQi1Y=;
        b=rUYTt0nRUcgy2g58Upir6dVsFF4oJe8a+uuLzUV1nk2gTpV0Fq6jaxzgHdC2qrMCxB
         OasoiAeKELkgi9Arq+AyCuBZWThXJYkiQcpLzz9d04wN1TmneEOCjOJrcLOo+Y0StMx+
         hnxikTDEDlwgXlYU+D3193UAxMBJkocF+vwfs1Q3mX3BB0ayDXsdZN9nx5G1BHm4PSBD
         LGGBi5UKB5ITINpRyFRbDGZDDcLKiR6JuMAoiP+GXx1DS8J51u39KCQTVGvUpKbj4YFm
         pddaB97xGFjm75umbdWyHBU5DljCSc9boyzXph7fkA+MIgmpgIB64RF+TubqIAPVv0bg
         /Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtPoJ12oteBNc0kHoMuvW+v6Ds9Jjp/7GrDvRJFQi1Y=;
        b=mjvm89+nNizJqeFw/DFEnc/GGP5OQmg5RUQH4hotTOSZa3WKdpS7BWNHXcQ+8+g6Pz
         kWevkpeJzuBURfC6q8WoCBjLrHc45J/bobO4wihGPkfAO+FtmlwbfJHxmYXULihmqH4O
         laolOSBRpHnsOacPWkmC2AxPvFGtUM3+q5QPYU/M4xYSKL8yZ2Wt9FSW2K9AAX5G6wQk
         ZUxaN8cI8ZTzvezvh40DJpMh8okw6FzxTlgaak8s9vtelXjSvStdlzqa4Ss2lmJoLMbv
         7RzEX9ndq2Nms+hriADQ4AWullgZWtgcTtoneIT+lPAejHHfar5EKM7Y/+8zBQSgI5XF
         TOKA==
X-Gm-Message-State: AOAM533CTM2wKk3b9X2frugFV3mOH0kryAeZVi0Jm5HnGrQYy7AH0rp+
        7Bc9jxFCjJpNS9uoxZwwrbvI70inqzwtNFVe7HZJbw==
X-Google-Smtp-Source: ABdhPJzW7vimXP+fNczdUfWycVJCFAkXKrgixYEB9OIcsz1WOIhvya043//GeBabtgT+NvuzfAhjCWui2uQUwSVUGoo=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr13446489lfp.184.1654598640330; Tue, 07
 Jun 2022 03:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220602132543.596-1-chevron.li@bayhubtech.com>
In-Reply-To: <20220602132543.596-1-chevron.li@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:23 +0200
Message-ID: <CAPDyKFo7FnC_F4biVkBmi7LBaRjkK2UADNFgzdzRmVw79Gr6iw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix card detect issue
 because card detect debouncing isn't done
To:     Chevron Li <chevron.li@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Jun 2022 at 15:26, Chevron Li <chevron.li@bayhubtech.com> wrote:
>
> get_cd result is uncorrect during card detect debouncing
> we need to wait card detect stable before return get_cd result
>
> Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>

Applied for fixes, by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
> change in V1:
> add wait card detect stable logical before return card detect result.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 92c20cb8074a..0d4d343dbb77 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -152,6 +152,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
>
>         if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
>                 sdhci_o2_enable_internal_clock(host);
> +       else
> +               sdhci_o2_wait_card_detect_stable(host);
>
>         return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
>
> base-commit: d1dc87763f406d4e67caf16dbe438a5647692395
> --
> 2.32.0
>
