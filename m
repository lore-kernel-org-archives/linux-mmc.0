Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A59C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C0E20671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbbh8Cky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETLft (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 07:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETLfs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 07:35:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5FC061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:48 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v26so1630076vsa.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjZpd2OyP3/DG/bwHYXGcfoDq3jvJSc8WefeWSigZAc=;
        b=hbbh8Cky+JidrFvefQyVIslvtd7v7NWRDLBDntY0T4b9x9591cMm16hisgX8GrKvLZ
         W+Cm6JynZdNrKjySmXj17nZDjy2FxW0qQ3YleAm9GTkmbmpIRnZCFLJhQaUbApD5HUol
         RAGYg+/4MCkH/7saeGZEdy8RhdTrCfv4Kd9rY/P3AW0KDI4JlcMj7M71U+Q8grxYGzgJ
         NFOyv3Vk4wtSQHMs3S0Ufkd+N7Q8LfVITncZyGqzwOfyNc5FbZNkMn3FV3IN2U0nDA32
         A/Tj5fvJ8i1XTzJFzdgcrq1/K2r9yNeym25nZPyfyDi7tl2xbDxBD1NBT4X0Ja3HzP3G
         hzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjZpd2OyP3/DG/bwHYXGcfoDq3jvJSc8WefeWSigZAc=;
        b=bvPpHS58sLZGaEYbm0Dr3nfETXK6jDVbXuB2vJPOgZqbcIGAAf4sEP+h94IxHZSs8p
         l97Wo7uYPjHL3p4587S/QW1+56ZGdyIL6ZdN96NZuilwriakgOum3jWaKhtpfsh2Sefx
         A1QIocEZ17f83zsffOxgR1NJQEsRRBWONU71eD1YNOkGv5ST7yvkQtEKTHzegoLqKyz8
         9j+atNR4DSxQUcoLIeQB9IrNVUw1McTexQdSXVJ4d+izLLN9+PR8tJVFVHRCcl/kxVvI
         JBMltWDna6ITJDaNWKZHJJqNDfzKdKBwUuejn2YkA3AC2R0SLGk8sxWV1vamO0DpXZRK
         eEuw==
X-Gm-Message-State: AOAM5329tz3krTEL5OjTTAg3uCRqpA22Va52e2wLDodmSJkz+xHAFN8Z
        3neVsYy3a3cG2DmoT3OJvjgOnPRKacN7lKici6zS0FnsoCU=
X-Google-Smtp-Source: ABdhPJxwkd22ItiHHv1hqksWlLjDmxXGAyMsEEH7Q5cen6gSiyZr8Xm6sDHCAohWfqMvPs/lVehkERJbZBFSnSJV97Y=
X-Received: by 2002:a05:6102:5d6:: with SMTP id v22mr2682057vsf.191.1589974546111;
 Wed, 20 May 2020 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152434.6867-1-ulf.hansson@linaro.org>
In-Reply-To: <20200519152434.6867-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 13:35:09 +0200
Message-ID: <CAPDyKFqDtemDwd=xYbvDXvMhtxmgaS+AX+cjh2MKnM=Ot24JfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 17:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Before calling tmio_mmc_host_probe(), the caller is required to enable
> clocks for its device, as to make it accessible when reading/writing
> registers during probe.
>
> Therefore, the responsibility to disable these clocks, in the error path of
> ->probe() and during ->remove(), is better managed outside
> tmio_mmc_host_remove(). As a matter of fact, callers of
> tmio_mmc_host_remove() already expects this to be the behaviour.
>
> However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> disable the clock via runtime PM, which leads to clock enable/disable
> imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
> disable the same clocks.
>
> To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> device with clocks enabled, but also make sure to disable the IRQs, as we
> normally do at ->runtime_suspend().
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next and by adding a stable tag.

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index f31afd1c2671..ba301fb7656b 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1231,12 +1231,14 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>         cancel_work_sync(&host->done);
>         cancel_delayed_work_sync(&host->delayed_reset_work);
>         tmio_mmc_release_dma(host);
> +       tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
>
> -       pm_runtime_dont_use_autosuspend(&pdev->dev);
>         if (host->native_hotplug)
>                 pm_runtime_put_noidle(&pdev->dev);
> -       pm_runtime_put_sync(&pdev->dev);
> +
>         pm_runtime_disable(&pdev->dev);
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>
> --
> 2.20.1
>
