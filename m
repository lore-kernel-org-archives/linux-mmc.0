Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C57C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493832075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8wlut+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAPOkf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:35 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43330 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAPOkf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:35 -0500
Received: by mail-ua1-f66.google.com with SMTP id o42so7689616uad.10
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cbePbMY0pUHn/0uUdGYC7iQCAGICzRsXrmU73cLE5tM=;
        b=u8wlut+RPo0HCpuYv/jzCVIS16BSFgLUOU9sG3hN83RYyNlp2npNN2ia27Aw6wcuSE
         nX+SKGakFWdsI1i90ROQxB/KJr+07vCsBVfsR4oYuU/lAvdpV1uIP/FBh8pfZ0r7/5Bz
         B6/Y1574kKIl2VzrtZ3n7dUgYxdJ9l0dNXEt5W/Th5lVZznSySvZhl73wHhuivMuGKzk
         hThjhwMRVoVqozgxnop/d9ckUrpZh9m8AsOV2eHmPl2HBYhp1lx/utC4pmxqg8a/fwxN
         mX6Fx/CtpidgyNyO0SC90PEfzovi5xrtcSYGrCHTV5Rhta6xy33fyUxLkQDVg+0VKOFm
         3QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cbePbMY0pUHn/0uUdGYC7iQCAGICzRsXrmU73cLE5tM=;
        b=Vrj4HC00w4wskyexJLiSuHr26fMnXwB0QKXMgYLmCdoosNuBj9feBOFPOAEKVCFFaH
         o6BjoCBbgtO4F4KIzjotPCvDPiQ7MniPh/XHMh07DsbhDoV1B8/ymlZwHVy6DOmjEqaO
         J2xlb3tKPLHm3x72m7ddgOAG2QGB4uCRYZzn6woRVy9oBoRqLGS1lGebJaLTjFVCUb04
         8lhGKP7Swfm5KZwF9RKcwcYW9oxx+aFVClgX2szrGxNGfCMNvGtKop3GbfpYN4ZnCIui
         p7/0TMinaVxMAL7zKdzeG5fLcFUgZUz5SqyLqRVRpRH0w/ddH/z/Xo+XFH8sZxgglAIy
         Mg0Q==
X-Gm-Message-State: APjAAAVzo4dj/q0I3oA9r1Emb0/QhZAFW+o1pSOIUmjCqc91eKrld9MY
        HcDFxjKQlNV4cv/KmtHINlttQn4FHZBMoUh/1n5JlQ==
X-Google-Smtp-Source: APXvYqzCv+dct8RZkQzxwh3v5RuXpT9BU0Su7HnyCbFlH/r2yLCIsh2wNsaPV3RjfPqW0HaRmy2Wv3FLNk9JiBQKdSY=
X-Received: by 2002:ab0:740e:: with SMTP id r14mr18187128uap.104.1579185634369;
 Thu, 16 Jan 2020 06:40:34 -0800 (PST)
MIME-Version: 1.0
References: <ffb489519a446caffe7a0a05c4b9372bd52397bb.1579082031.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <ffb489519a446caffe7a0a05c4b9372bd52397bb.1579082031.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:58 +0100
Message-ID: <CAPDyKFqTW3kahiZpc==PTatadj3H-MO6gkddro3aEdThnnLSQg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci: fix minimum clock rate for v3 controller
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Jan 2020 at 10:54, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> For SDHCIv3+ with programmable clock mode, minimal clock frequency is
> still base clock / max(divider). Minimal programmable clock frequency is
> always greater than minimal divided clock frequency. Without this patch,
> SDHCI uses out-of-spec initial frequency when multiplier is big enough:
>
> mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
> [for 480 MHz source clock divided by 1024]
>
> The code in sdhci_calc_clk() already chooses a correct SDCLK clock mode.
>
> Cc: stable@vger.kernel.org
> Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode=
")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  v3: commitmsg/comment rewording
>  v2: extend commitmsg and add comment
> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 96609c961465..24fb6d710de6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3903,11 +3903,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>         if (host->ops->get_min_clock)
>                 mmc->f_min =3D host->ops->get_min_clock(host);
>         else if (host->version >=3D SDHCI_SPEC_300) {
> -               if (host->clk_mul) {
> -                       mmc->f_min =3D (host->max_clk * host->clk_mul) / =
1024;
> +               if (host->clk_mul)
>                         max_clk =3D host->max_clk * host->clk_mul;
> -               } else
> -                       mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC=
_300;
> +               /*
> +                * Divided Clock Mode minimum clock rate is always less t=
han
> +                * Programmable Clock Mode minimum clock rate.
> +                */
> +               mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>         } else
>                 mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>
> --
> 2.20.1
>
