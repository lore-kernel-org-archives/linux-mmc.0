Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA7C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8E6207BB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgEDHPIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEOPCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOPCu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 11:02:50 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58FC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 08:02:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g2so1406307vsb.4
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z80bmdCOaUy0IuTAv6MAjJEqIXKZVI9he/f6Sa92Qhw=;
        b=MgEDHPIkTLkknXlmuTunpKO8ZpHeOLPkX7M0BlbjptYUvZOkRVYNlEviCFxxYJJD8r
         QKfQSn/L+LCN3jSqudpQotgsQiK+scN7OxEKlU4Mo6Slfdy019o2hzVvwNj6JhZUMzPQ
         ZrVSawUj0/SjcxfcIdM7Fapa6eobh0r1EAbVywrlPKIQUbo0I2ZV2ZgvoPo+sMxWBkqO
         Po/qpL7IhWcIFc/oRYrOcEli52ZHuvI9pRqY8jqacRUWNrifSbz+Q8y9w0Smr2liexXp
         HP3TUqUB2culF1Iw7IBIW1Kx61/a2cfD4CGMimSyjjqrxJ9e5EnaqwvofhQ57mOuHr7T
         m9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z80bmdCOaUy0IuTAv6MAjJEqIXKZVI9he/f6Sa92Qhw=;
        b=fXBF1zsbe/JaJkwI26XmPTxnR4zWMSYkRAUiBjOrfnzgpnSEU+nhxk809mSUtj7gHC
         U1PUMxxYt28/hxo0j71Jv8tLgnZbmM8zIhpn6gJ7jeMo1yKQd5n2myWRQ9E+EVQc9+W1
         /MXjUSh0cYOcRqhbihEx3eJtkaxVeeFKbC8NCqMUKf/2ztWaBTNyAXBQbtRkaVroXh88
         +iTM1NSfL7EBX2zJpzxVdZOtxmwOXvpDgFxNEwpcwObT8YY6wTs4qFIk7pXhu+ZBiV9o
         NTd24kkw35/M4E+mNIk+Eq8XLgfLnhnxYxM8MxP97j06Ht91C2+OMvyi4XcAgnYI7M9T
         2BoA==
X-Gm-Message-State: AOAM530nYjJHP6sxFKrhKzVajnE049XFjl0+USFWsNJ0Y5A9kJpDDhb8
        /quZp3eLQVfaEkyoniRZWgUtltlBN7TBclFJvn9snTlyS2w=
X-Google-Smtp-Source: ABdhPJynuhF2lD3tjDNAkcAPzOrN8gRuqOI01TCvqn7tirBMmvXODObuOGr+8Xc35OtUplrHB+nF6dhCFpZb35G3eQU=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr2733279vsd.35.1589554965931;
 Fri, 15 May 2020 08:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140445.15218-1-ulf.hansson@linaro.org>
In-Reply-To: <20200515140445.15218-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 17:02:08 +0200
Message-ID: <CAPDyKFr-7OkMW0UU_M78igBScOXiY784_TkqeHHwmVdZViRw6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 May 2020 at 16:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

Just realized that part of the commit message is missing, explaining
the change. I intend to add this:

To solve the problem, let's make sure tmio_mmc_host_remove() leaves
the device with clocks enabled, but also make sure to disable the
IRQs, as we normally do at ->runtime_suspend().

Also, this is untested, so relying on you guys with the HW at hand.

Kind regards
Uffe

>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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
