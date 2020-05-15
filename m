Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426AC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A7920727
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP8qtpxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEOJ0o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOJ0o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 05:26:44 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8378C05BD09
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 02:26:43 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v26so841327vsa.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D86ctkG/EKahVd2mLUr3OwGMC4UoKIQg0Mj9DKIQ2i4=;
        b=SP8qtpxe1vGu5l0t0dYI/NlK+JR4LZ/WP4zIOvl9agVCpr3/CWSLV5fBW6CHg/E3jd
         k2iEm4LEfVPz2am2laMIQYmaq6P0XDvvRbw3u8FC8qQRlau4rLLwK8uT6BS+Dg8rfhzx
         GclBqJA8Fc1soSNWKVXU3Eek5uiuTaE7RBUVtsivUmnQwYOOxd0nu8h2XZRNDxSv7Hrs
         2twhE6y6mV1cxRb9aT18FtXBwEU052lc3I1iiEnCe+0ISDw6F6xHV6IXi2DTruajxG2H
         2A3KaHTMGsQ5aD9hdPrRxUDoshExhv3WFh7C6Mpg2Oz3CPoYZZu/A+gz9Z4ddwU17TPG
         SiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D86ctkG/EKahVd2mLUr3OwGMC4UoKIQg0Mj9DKIQ2i4=;
        b=m+FC22784KbrKKqxSLQjuJ4pXCc/lUy4c06kCMtIeqBEHyHstcXD95xhItwM43NM29
         kCjOfBffhYRxKCDZCUUhJhiJca6VAydlpHJsMSu8hJX2v9u5bR9wrVYY7yqUY1pKDz7Q
         W2mfN0q5VGXnTQgvCnLEPQfKSmqCd+hHJshAhl07l7PH/nClVIaJweS6Qwxu6U5j/flE
         cduUhgAq2bCTEVQbhCCZhsMYO064FCaD8aB2JUC/lVyXmgH0yrP0E/7su4UCMKPVm6oF
         t5vRbZ9LCEkU28Rqv2RgSGRRGpSUwbHgciEpvo3AdVEt9qW0EZhpunH7gXziwsLJK/0C
         +jGw==
X-Gm-Message-State: AOAM533dXV62RQr7M3VGhFW5fsjelO3kQNGZZDkBMuBgZ1heKn+tf5Pp
        0MdOgX3Udsm9WgUpmy/nZRMAOBg0VPADNbfkNRWRfg==
X-Google-Smtp-Source: ABdhPJyD8EeY76xuk/rriWXVKz8C3Ulj9hq3+7nwTuoMOp2npjM347hFAErzP4d1iN6q3xkzKlFo/9/DJIqBklloNtc=
X-Received: by 2002:a67:302:: with SMTP id 2mr1761142vsd.165.1589534802848;
 Fri, 15 May 2020 02:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200513173131.11200-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200513173131.11200-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 11:26:06 +0200
Message-ID: <CAPDyKFpaaVdpv22VO_OS7a2rw67xmD7qXcxUqD_g5CDdqiZiHA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: don't lose RPM savings because of
 manual clk handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Niklas, Geert, Yamada-san,


On Wed, 13 May 2020 at 19:31, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The SDHI driver en-/disabled clocks on its own during probe() and
> remove(). This basically killed all potential RPM power savings. Now, we
> just enable the clocks for a short time when we access registers in
> probe(). We otherwise leave all handling to RPM. That means, we need to
> shift the RPM enabling code in the TMIO core a bit up, so we can access
> registers there, too.

No, this doesn't sound entirely right to me.

However, I do admit that we may need to move the pm_runtime
initialization earlier (perhaps even out of tmio_mmc_core), but for
slightly different reasons. Let me elaborate.

For uniphier-sd, renesas_sdhi_sys_dmac and renesas_sdhi_internal_dmac
- they all have assigned the ->clk_enable|disable() ops. Which means
they have internal clock management (calling clk_prepare|enable()
etc). For tmio_mmc, that's not the case.

On top of this, the device may also have a potential PM domain
attached. If that is the case, the PM domain may or may not have clock
management implemented through genpd's ->start|stop() callbacks.

So, in the end we are going to have to rely on clock enable/prepare
reference counting, as we have to manage the clock(s) at both the
driver and the PM domain level. Taking into account all various
combinations (and that CONFIG_PM may not always be set). I have
started to hack on some patches, but before I share them, let me ask a
few questions.

1. tmio_mmc: - is that used solely with clock management through
genpd? Or has no clock management at all?
2. uniphier-sd: Don't have runtime PM callbacks assigned. It looks
like it doesn't care about runtime PM, but maybe it does through a PM
domain? Can we skip to enable runtime PM for uniphier-sd, no?

Kind regards
Uffe

>
> clk_summary before:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              2        2        0    12480000          0     0  50000
>
> clk_summary after:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              1        1        0    12480000          0     0  50000
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Tested on a Salvator-XS board with R-Car M3-N.
>
>  drivers/mmc/host/renesas_sdhi_core.c |  7 +++----
>  drivers/mmc/host/tmio_mmc_core.c     | 14 +++++++-------
>  2 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index ff72b381a6b3..d581142634f8 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -910,6 +910,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 goto efree;
>
>         ver = sd_ctrl_read16(host, CTL_VERSION);
> +       renesas_sdhi_clk_disable(host);
> +
>         /* GEN2_SDR104 is first known SDHI to use 32bit block count */
>         if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
>                 mmc_data->max_blk_count = U16_MAX;
> @@ -920,7 +922,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>
>         ret = tmio_mmc_host_probe(host);
>         if (ret < 0)
> -               goto edisclk;
> +               goto efree;
>
>         /* Enable tuning iff we have an SCC and a supported mode */
>         if (of_data && of_data->scc_offset &&
> @@ -985,8 +987,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>
>  eirq:
>         tmio_mmc_host_remove(host);
> -edisclk:
> -       renesas_sdhi_clk_disable(host);
>  efree:
>         tmio_mmc_host_free(host);
>
> @@ -999,7 +999,6 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>         struct tmio_mmc_host *host = platform_get_drvdata(pdev);
>
>         tmio_mmc_host_remove(host);
> -       renesas_sdhi_clk_disable(host);
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 9a4ae954553b..6968177dd1cd 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1116,6 +1116,13 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>
>         _host->set_pwr = pdata->set_pwr;
>
> +       dev_pm_domain_start(&pdev->dev);
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +
>         ret = tmio_mmc_init_ocr(_host);
>         if (ret < 0)
>                 return ret;
> @@ -1192,13 +1199,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         /* See if we also get DMA */
>         tmio_mmc_request_dma(_host, pdata);
>
> -       dev_pm_domain_start(&pdev->dev);
> -       pm_runtime_get_noresume(&pdev->dev);
> -       pm_runtime_set_active(&pdev->dev);
> -       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> -       pm_runtime_use_autosuspend(&pdev->dev);
> -       pm_runtime_enable(&pdev->dev);
> -
>         ret = mmc_add_host(mmc);
>         if (ret)
>                 goto remove_host;
> --
> 2.20.1
>
