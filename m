Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2032CC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A361154
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhJSLCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbhJSLCT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2021 07:02:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7302C061749
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 04:00:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l5so5308875lja.13
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhcLUKrBImGGMRzyP+CFlqIv6hjPWjO7YEI4Yb6th7U=;
        b=UQqUDWO7ROvKv8Hqj1mQPLsjfINQXF5hgyQWNGLAXZQfGfyIAqTOWdpbSJrSJ9KQjK
         PzPRnyl9V8HVgePK1MBIrboKiaIyurVF9GDoB7H9S3GJahabMPdksDeaJeNmTk42JXVg
         fOgoeKfE9AKDTCdHWUZRsR2CE+r1WIDkcS2ZwldA2lM0S03FPh1OqtGx+PfaPnZEFFd6
         msGE5e5VHdVwFpdeMqfBJxe7kgV+OdpNWbvWmoqmICD3falTtCIqq5rBlfvb4XcyYzna
         PIQNHYlMoHBPUik/e93ltso4J/ktCDg/rlWrYwFvF2kC77bolDKAftaiS9eXuxVJ5gPN
         75Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhcLUKrBImGGMRzyP+CFlqIv6hjPWjO7YEI4Yb6th7U=;
        b=bQaaBUBzVai3TUKtGiSNS+R4wVL1CFvRtEBbHAm9tCY2RzyvlvKj4ue+OesWujybYn
         lZSA8sBRuWkl3uowG0Np1rPV5H3CYX5TqhbiA+p5A0xvqsFNoxNQzJ2pktSrFAPlf41C
         AZRmj1eY14VmOj1PVAkHr23YrvvOApDeBYTYBNtrR2VghZouSTNTbZL5RtGtwOy84Ac4
         BYqWQ/ta3+NOxZ3sFX40l+p2TG7FPHmEKdrylKZEgn0B+6GucZm8yKKr2lgt6+NCChlR
         BGFEuxVNvSq5OIBZQpQWvVONqtH+uXVm0E8+LG9x1eVl36L/BUF2lmLkOKZ2E7DgTH3K
         LphA==
X-Gm-Message-State: AOAM530TaA4rfs/GUtQkTlGzATJhHlXHBDVtpeQ3yXi9r4s/Geo7Hn1E
        kIu3J7JJksmN2wJb41//zYPEbNqpV6ATuPGBhIqLxg==
X-Google-Smtp-Source: ABdhPJzf1bPQYIrC4YDjG6//d+l2gXH03slc1jpLFuj+Q/lrN6n4AuzYGHLbd0c4sMy+tFuYicdEVimuqX1tyqVpcrk=
X-Received: by 2002:a2e:874d:: with SMTP id q13mr6133764ljj.16.1634641204614;
 Tue, 19 Oct 2021 04:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <1634263236-6111-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1634263236-6111-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 12:59:28 +0200
Message-ID: <CAPDyKFrJVZ99=edvKPwqEMSWz6vhGtRa4ig8pjjQg7mnqOjZ9g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: clear the buffer_read_ready to
 reset standard tuning circuit
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Oct 2021 at 04:25, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> To reset standard tuning circuit completely, after clear ESDHC_MIX_CTRL_EXE_TUNE,
> also need to clear bit buffer_read_ready, this operation will finally clear the
> USDHC IP internal logic flag execute_tuning_with_clr_buf, make sure the following
> normal data transfer will not be impacted by standard tuning logic used before.
>
> Find this issue when do quick SD card insert/remove stress test. During standard
> tuning prodedure, if remove SD card, USDHC standard tuning logic can't clear the
> internal flag execute_tuning_with_clr_buf. Next time when insert SD card, all
> data related commands can't get any data related interrupts, include data transfer
> complete interrupt, data timeout interrupt, data CRC interrupt, data end bit interrupt.
> Always trigger software timeout issue. Even reset the USDHC through bits in register
> SYS_CTRL (0x2C, bit28 reset tuning, bit26 reset data, bit 25 reset command, bit 24
> reset all) can't recover this. From the user's point of view, USDHC stuck, SD can't
> be recognized any more.
>
> Fixes: d9370424c948 ("mmc: sdhci-esdhc-imx: reset tuning circuit when power on mmc card")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f18d169bc8ff..e658f0174242 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1187,6 +1187,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         u32 ctrl;
> +       int ret;
>
>         /* Reset the tuning circuit */
>         if (esdhc_is_usdhc(imx_data)) {
> @@ -1199,7 +1200,22 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>                 } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>                         ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>                         ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +                       ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>                         writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> +                       /* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
> +                       ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
> +                               ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
> +                       if (ret == -ETIMEDOUT)
> +                               dev_warn(mmc_dev(host->mmc),
> +                                "Warning! clear execute tuning bit failed\n");
> +                       /*
> +                        * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
> +                        * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
> +                        * will finally make sure the normal data transfer logic correct.
> +                        */
> +                       ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
> +                       ctrl |= SDHCI_INT_DATA_AVAIL;
> +                       writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
>                 }
>         }
>  }
> --
> 2.17.1
>
