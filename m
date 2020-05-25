Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E538C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BF4207FB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdGsAmBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgEYIsZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389277AbgEYIsY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:48:24 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66952C05BD43
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:24 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e7so9549666vsm.6
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgoGKBAveUpNLnIgQcx75kKaH5k5+uJlCEKBpDn1ehg=;
        b=tdGsAmBcL08JRMs+nYm8YpHBTOpij3fZk+r9MXovn+wfyDMMbkBpQlOFfdPsB3W1n1
         +eTZplU85wrUMVjRqEzqZr3rMJ4Ix6HfL28ktBCWfFBDgFTF8iwHQTO51kAPJnRzwWwU
         q6g0X9H989G9DPhSRJ7ZX1PNDShY/2DUxSQbtENhrPGjI4tfhhplwNskUt3Yed/f4k1B
         g5OD0XtBtM8gtLo8wmjyidjxzrEzhun+enD1dv6A75BbCmLIKkC+NqIr7jg0FQINxvzC
         MkwzQsUygNX9Pt7OmsLVoKzoVQN9pgRkRpv/+iLeODFQjBBMT41z8O6j7wsuF+V1m7Wu
         QuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgoGKBAveUpNLnIgQcx75kKaH5k5+uJlCEKBpDn1ehg=;
        b=Yrzst7hHCK5C1J81iCdOw4CMDoho+Js7+dsE0QOd/4PSfqFUyxz03WSCmniF0jIegP
         J8SrdTgCC9afwDr2MtFsimfCqjcQlO9zkQL1bWBjq3RM0Df58I4peKQgddxQy7Wj6u7u
         G8MbtdEGxd/tT2S2MoebJjDX23sG26AqLGKQIw8BOZAY+mHE9Mx2tGYgKEk3BiSkBwZV
         Kkq7YEihBpEhMcgoRUrorquatXC6m5ZUhuGHF57u6F3KUmQiz0iAGZQ6xk+ufZArRLcj
         RhkjEbp/cnehwiU30GC7eI3GMOY4VMdena0/r9J4q5yjnaRy+1/k+yenb8/aIyc6oEJS
         YcwA==
X-Gm-Message-State: AOAM533nk1VRt/UdWrro73ODPr9tEh7DhlF5NyX6xgxlDT0dCSn+mZ67
        Id8LsMHQUlJoaXXOCQ3k3vKvnQMZmscwmuHSt/LrQA==
X-Google-Smtp-Source: ABdhPJz/2B30euWiWchhGIeeUoF37uMCLF0YLBKETXSYWThkUgvYPD7ALh48YAC5IyTjWbETQujZNpRuwz2LoyiuuRE=
X-Received: by 2002:a67:690e:: with SMTP id e14mr18180245vsc.34.1590396503592;
 Mon, 25 May 2020 01:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:47:47 +0200
Message-ID: <CAPDyKFoV93OdjfuupYgFDegqBVjJpTnSeR3s8WOUaUmM19S4EA@mail.gmail.com>
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 May 2020 at 22:09, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> When auto calibration timeouts, calibration is disabled and fail-safe
> drive strength values are programmed based on the signal voltage.
>
> Different fail-safe drive strength values based on voltage are
> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
>
> So, this patch avoids reading these properties from the device tree
> for SoCs not using pad controls and the warning of missing properties
> will not show up on these SoC platforms.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next and by fixing the misspelled "properies", thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 3e2c510..141b49b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_down_1v8 = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
> +                       "nvidia,pad-autocal-pull-up-offset-sdr104",
> +                       &autocal->pull_up_sdr104);
> +       if (err)
> +               autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> +
> +       err = device_property_read_u32(host->mmc->parent,
> +                       "nvidia,pad-autocal-pull-down-offset-sdr104",
> +                       &autocal->pull_down_sdr104);
> +       if (err)
> +               autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> +
> +       err = device_property_read_u32(host->mmc->parent,
> +                       "nvidia,pad-autocal-pull-up-offset-hs400",
> +                       &autocal->pull_up_hs400);
> +       if (err)
> +               autocal->pull_up_hs400 = autocal->pull_up_1v8;
> +
> +       err = device_property_read_u32(host->mmc->parent,
> +                       "nvidia,pad-autocal-pull-down-offset-hs400",
> +                       &autocal->pull_down_hs400);
> +       if (err)
> +               autocal->pull_down_hs400 = autocal->pull_down_1v8;
> +
> +       /*
> +        * Different fail-safe drive strength values based on the signaling
> +        * voltage are applicable for SoCs supporting 3V3 and 1V8 pad controls.
> +        * So, avoid reading below device tree properies for SoCs that don't
> +        * have NVQUIRK_NEEDS_PAD_CONTROL.
> +        */
> +       if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
> +               return;
> +
> +       err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>                         &autocal->pull_up_3v3_timeout);
>         if (err) {
> @@ -647,30 +680,6 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                                 mmc_hostname(host->mmc));
>                 autocal->pull_down_1v8_timeout = 0;
>         }
> -
> -       err = device_property_read_u32(host->mmc->parent,
> -                       "nvidia,pad-autocal-pull-up-offset-sdr104",
> -                       &autocal->pull_up_sdr104);
> -       if (err)
> -               autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> -
> -       err = device_property_read_u32(host->mmc->parent,
> -                       "nvidia,pad-autocal-pull-down-offset-sdr104",
> -                       &autocal->pull_down_sdr104);
> -       if (err)
> -               autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> -
> -       err = device_property_read_u32(host->mmc->parent,
> -                       "nvidia,pad-autocal-pull-up-offset-hs400",
> -                       &autocal->pull_up_hs400);
> -       if (err)
> -               autocal->pull_up_hs400 = autocal->pull_up_1v8;
> -
> -       err = device_property_read_u32(host->mmc->parent,
> -                       "nvidia,pad-autocal-pull-down-offset-hs400",
> -                       &autocal->pull_down_hs400);
> -       if (err)
> -               autocal->pull_down_hs400 = autocal->pull_down_1v8;
>  }
>
>  static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> --
> 2.7.4
>
