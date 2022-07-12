Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B29C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiGLLKS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiGLLKH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:10:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F6AF77F
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q7so9432078lji.12
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMuN1KvNnz4BrVBB6d4HU6Nw1zknFBEn1R9EsX26fOI=;
        b=EZ7gyJOTdwlzvO8Ud7ZQaaE0wdpw1ZCfxNqpBIgLrqrSfyNNXt231FpeLQ6vIRrM3q
         Nx7BYZvoDFTzLKUKtWo7ceBCyGzGViDd/m9tiypUfdu5rZW8X8wf0vRf+o8AIwd8StDg
         +G6D3sk1d32JGPB74vtWu/wtYa2+JyWP6FGz0S4Zfw4XJIj/bCXCSfdVJq9m9pGaV6Kf
         /Seh0uoA+w+9HzCqm2EdhPpzUg7ULigyxtwxlblkak6CrzQJp5ecToSnW2Ys5yu+HC09
         GcmQncpF9tHLOYQ1iQHewcStGvCwpAKxGXlRyt53gjuvmc5YQYSvwWupqlqZoTl5gOTN
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMuN1KvNnz4BrVBB6d4HU6Nw1zknFBEn1R9EsX26fOI=;
        b=OIQbLieOabGdJqQSLbIWNDO10U4z9RMYSUha5eCUF/c0q3hjMMTybbzG7O8DZnLKtb
         Te/weauWmmgXgbknNKJo/CgGsKrFRZBnrGompr4kapdsNQxURNFZHbW8bpQaa/MYSXPo
         9CWFUxgzGKIhaZPhN5xKVofjTfwa0cBJPDJKWjcRcKlQpw/DKHKxoSWDIRAI/RM7pD/G
         8jb0ELG5punAc2EV3hgt/n+UEEQOeNLmCyNbSDESbNTT2qSkpgC8w73TMWyj+V4fbfi6
         7ejlMag5VKbZH14oooZyIK4UPa3U5Xn008EmrRl4L4xaNjpRJCXpJTVRQcYCPghGkqzC
         rmbg==
X-Gm-Message-State: AJIora9ITjOP8KaEJzkBu8Kq1Fy72sbROUb3a0tTT5dSVEOge6XhjkEk
        XWmc3B/fCn9NNaYF1jlmE0sMs8uNCu0ZGhQrDXgymA==
X-Google-Smtp-Source: AGRyM1tIos9QwKkgJYgpyZPvWLGIscBdiV8ILrU+9gdWja+2sPZX0TL6Tt0r70dYd57E4qWcz1aDZxfoQQ4vgEsj0y8=
X-Received: by 2002:a2e:7019:0:b0:25d:4598:c827 with SMTP id
 l25-20020a2e7019000000b0025d4598c827mr13176731ljc.367.1657624203026; Tue, 12
 Jul 2022 04:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220630090926.15061-1-eugen.hristev@microchip.com>
In-Reply-To: <20220630090926.15061-1-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:26 +0200
Message-ID: <CAPDyKFo9fOYzS0Mugk2bf05-PanHhcdwMqG_PXPdVSr7A-rXmA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Karl Olsen <karl@micro-technic.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 30 Jun 2022 at 11:09, Eugen Hristev <eugen.hristev@microchip.com> wrote:
>
> In set_uhs_signaling, the DDR bit is being set by fully writing the MC1R
> register.
> This can lead to accidental erase of certain bits in this register.
> Avoid this by doing a read-modify-write operation.
>
> Fixes: d0918764c17b ("mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Tested-by: Karl Olsen <karl@micro-technic.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 10fb4cb2c731..cd0134580a90 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -100,8 +100,13 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
>                                          unsigned int timing)
>  {
> -       if (timing == MMC_TIMING_MMC_DDR52)
> -               sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
> +       u8 mc1r;
> +
> +       if (timing == MMC_TIMING_MMC_DDR52) {
> +               mc1r = sdhci_readb(host, SDMMC_MC1R);
> +               mc1r |= SDMMC_MC1R_DDR;
> +               sdhci_writeb(host, mc1r, SDMMC_MC1R);
> +       }
>         sdhci_set_uhs_signaling(host, timing);
>  }
>
> --
> 2.25.1
>
