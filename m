Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5AC0044D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 11:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6220658
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 11:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWzWCPRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgCPLr6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:47:58 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44465 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgCPLr5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 07:47:57 -0400
Received: by mail-vk1-f195.google.com with SMTP id s194so4750613vkb.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2020 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpPj3BYKLx5Ky/dvjcuZk1wdfRpXvFq2BQJKd9cCG1w=;
        b=cWzWCPRWtJy37DgXc5qiVV+KZXj1AeMoMsWnIV929LQWBr/B+sDeIuLyW5LedsKplY
         W+0dQdisBB20ETBRpVYeeSZkbygJmSWcF/TctcYHZhlgFSGIj0oKwHUWo0gpPusb5NTv
         JlsctpxTnnwuFjf/x22BMEiBdTiHX88+GWoHsEbMDCzlNCBvmZoxzXq53lAXlbzvEDpg
         yjznEPy2XyV1Fxo4Dhtn4hfuHcVQgM04EU3GNVOnjPMWyedFiAoVVh90WxQzoK+ey/TL
         MKtqFlFd99akE5K+fOsJroa+GCSk+AqOlhydaKXLKAHjtRRe47xOGJV+4x2S+PiXeS5b
         Mtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpPj3BYKLx5Ky/dvjcuZk1wdfRpXvFq2BQJKd9cCG1w=;
        b=LmgudAqS1gQ/WAPOpy+oz36G5DeohYWW7vRxQ6LIu42cNokvARyF5Y1n8W9y6fZ+cI
         EL5vzaEma9Wbj/8bK/NUMNCJtkbAnCjA2ZpEZxSpk6iWK26GroC4qdFSiKYCwnvbNDRB
         5mr5cHIEd4zqyi+auKteRJRG9TatCyDuPvnTExXsQLDu+bdjYjKlAWtpnMQwp+KsQDux
         e+Ue4qcer4775YmaRG1/5pvEsa5YJhgZWFjKKpbU6bSSq/S8RWhtcbEFgRSctgR4MPlC
         lr/HYiaGJxdjdaHJcXzKTbDYC8b04qNa8Or1rOBjyFPZYu+O3+WIhDQ/PGHtVe3zP0/C
         q2WQ==
X-Gm-Message-State: ANhLgQ0LitTNBphdqIS4sVD8vGd2OpAOernpYZkZiS9A4iu17GP2/6gj
        1KUQvIJfqIbZfTY8yha8+qHYoL/W86rulETxO0yi4g==
X-Google-Smtp-Source: ADFU+vvgqyni06ahkDhiLtXkJ72hSL8k5M3n/XQ16rfn94HMCYFHGiVADjh7WtIqj2xsHulIrPasdYh1Ygr0ywT167s=
X-Received: by 2002:a1f:b695:: with SMTP id g143mr16577058vkf.59.1584359276875;
 Mon, 16 Mar 2020 04:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583307441.git.baolin.wang7@gmail.com> <b6c0c003d887bf7c272c493212f4f89d28097ad4.1583307441.git.baolin.wang7@gmail.com>
In-Reply-To: <b6c0c003d887bf7c272c493212f4f89d28097ad4.1583307441.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Mar 2020 12:47:20 +0100
Message-ID: <CAPDyKFoKzBPNFkG=4OenZ_7ZVgqfhhEDRxsSbu6cJOSgCPPL1Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/3] mmc: host: sdhci-sprd: Implement the
 request_atomic() API
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Mar 2020 at 08:42, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Implement the request_atomic() API for nonremovable cards, that means
> we can submit next request in the irq hard handler context to reduce
> latency.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 2ab42c5..bddf0f3 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -426,6 +426,27 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         sdhci_request(mmc, mrq);
>  }
>
> +static void sdhci_sprd_request_atomic(struct mmc_host *mmc,
> +                                     struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +
> +       host->flags |= sprd_host->flags & SDHCI_AUTO_CMD23;
> +
> +       /*
> +        * From version 4.10 onward, ARGUMENT2 register is also as 32-bit
> +        * block count register which doesn't support stuff bits of
> +        * CMD23 argument on Spreadtrum's sd host controller.
> +        */
> +       if (host->version >= SDHCI_SPEC_410 &&
> +           mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
> +           (host->flags & SDHCI_AUTO_CMD23))
> +               host->flags &= ~SDHCI_AUTO_CMD23;

Looks like the above code is a copy of what is done in
sdhci_sprd_request(). Perhaps add a helper function that deals with
this to avoid open coding?

> +
> +       sdhci_request_atomic(mmc, mrq);
> +}
> +
>  static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -561,6 +582,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         if (ret)
>                 goto pltfm_free;
>
> +       if (!mmc_card_is_removable(host->mmc))
> +               host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
> +       else
> +               host->always_defer_done = true;
> +
>         sprd_host = TO_SPRD_HOST(host);
>         sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
>
> @@ -654,8 +680,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_cleanup_host;
>
> -       host->always_defer_done = true;
> -
>         ret = __sdhci_add_host(host);
>         if (ret)
>                 goto err_cleanup_host;
> --
> 1.9.1
>

Kind regards
Uffe
