Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E3C43461
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFA061139
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhDOMDp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhDOMDm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:42 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA717C061756
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:18 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 66so12018571vsk.9
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7FyRm6KTh0gv7RS+KVljQwTi9U7GSgFTjsqKhiSYho=;
        b=u4BXlDTSkhAFUxP6lywlt+Uph749BIKvbHzo77NvGE+HtpqEVITziZuryPkXUP7e9r
         i+vJKSWlIvpOkxGq0UqYnd918+P40lzahM3ar2jAADB3TxoGrcJCqCh+ailKsrAWBDAj
         ZToQJ6Z/8U1Gc2cjgMpZ4j0K/GmbeSo8m0e3oQIqbtbIIZaYUKILNniMUadUHBCgxZIo
         fFslpguYYMxci6UDmUkz1U+9nsFS7e+ml2puaj1C0ghZTYeupN4McX4mAVjUVogV8TCL
         LSxQJdpKu0h2Uti+LvsRpK7rl1oqylMCiiyDeasP/TSk8up630cHGf3tq0c3EZkbkasg
         SkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7FyRm6KTh0gv7RS+KVljQwTi9U7GSgFTjsqKhiSYho=;
        b=YvIZ0c5klc90vAhYayEmVwFNJdfockhROsHDPrIG0sD8yaL+5nyE9KUW4+MS1pPWaq
         1QV/Pm2suolLY/uZDkh/dJGP7OERhzIz70RQqM6oYp/CsnFCSYmnA4mKRdBKPyMwkPaL
         CvIEOL4ytXhs9AQ9lVbiExAylu85gsClKaaAgGz7Hx3rbwIDpa1FROrnhfjHn1rtSdt0
         fUXvmaqZWPCi0MkhT//YCHTq75a8x1+wSQKTzI0VFwnK3QVFqnfNLwyYFD9q3VFSsxMW
         dJvXffAUmIM4bBCrtTu082Rt0+FGGTJHuiGhVYNQrCS1q5xmOzZPlhCQdECNhDS7omYq
         6vUg==
X-Gm-Message-State: AOAM531pA9gKshkO+htVMK3ez86n/0BLeVl/eOToAB82rV1WwShWoG8f
        MxGwSpIXjcB/vGnzcEijH3zPKdT4xML8RLc1BS2wTCkcpa8Zeg==
X-Google-Smtp-Source: ABdhPJyNBl0/0s9Rk+OtPg0hzWn0atudTxxXg+zYQy29wV6Vs9TraG28QbEcxP+4avcC7bb2ETD9emPAZJoPBJ9fPgw=
X-Received: by 2002:a67:fd48:: with SMTP id g8mr1539289vsr.55.1618488197944;
 Thu, 15 Apr 2021 05:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210413083137.11171-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210413083137.11171-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:40 +0200
Message-ID: <CAPDyKFqZtg+hPf74_oQ0ugEsS3yRzbAQbpnirsVr4jOKMXo2gg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: always restore irq register
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Apr 2021 at 10:31, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Currently, only SDHI on R-Car Gen2+ reinitializes the irq register
> during reset but it should be done on all instances. We can move it from
> the SDHI driver to the TMIO core, because we now have the
> 'sd_irq_mask_all' variable which carries the proper value to use. That
> also means we can remove the initialization from tmio_mmc_probe()
> because it calls tmio_mmc_reset(), too. We only move that
> tmio_mmc_reset() call there a little to ensure 'sd_irq_mask_all' is
> properly set.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
>
> * use direct register write to initialize irq register instead of
>   masking bits. Also initialize the cache variable directly.
>
>  drivers/mmc/host/renesas_sdhi_core.c |  2 --
>  drivers/mmc/host/tmio_mmc_core.c     | 11 ++++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d36181b6f687..635bf31a6735 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -588,8 +588,6 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
>                 renesas_sdhi_scc_reset(host, priv);
>         }
>
> -       sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_ALL_RCAR2);
> -
>         if (sd_ctrl_read16(host, CTL_VERSION) >= SDHI_VER_GEN3_SD) {
>                 val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
>                 val |= CARD_OPT_EXTOP;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 0c474d78b186..7dfc26f48c18 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -192,6 +192,9 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
>         if (host->reset)
>                 host->reset(host);
>
> +       sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
> +       host->sdcard_irq_mask = host->sdcard_irq_mask_all;
> +
>         tmio_mmc_set_bus_width(host, host->mmc->ios.bus_width);
>
>         if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> @@ -1176,13 +1179,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         if (pdata->flags & TMIO_MMC_SDIO_IRQ)
>                 _host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>
> -       _host->set_clock(_host, 0);
> -       tmio_mmc_reset(_host);
> -
> -       _host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
>         if (!_host->sdcard_irq_mask_all)
>                 _host->sdcard_irq_mask_all = TMIO_MASK_ALL;
> -       tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
> +
> +       _host->set_clock(_host, 0);
> +       tmio_mmc_reset(_host);
>
>         if (_host->native_hotplug)
>                 tmio_mmc_enable_mmc_irqs(_host,
> --
> 2.30.0
>
