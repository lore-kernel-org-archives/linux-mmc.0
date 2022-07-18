Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EC4CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 11:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiGRLjb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiGRLjX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 07:39:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4F1AB
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n18so18825349lfq.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtGhrGM04DEpcddG1EHK6PZkvVttFOlX+DQ19nSSesY=;
        b=BPLF5d3kR5qRtyPOG3rzPDve5kIegiIby3xwe7PfF4kG3c5lM8lXe9Bwgp8JfFW8dT
         QOZzFwSj/y/4EyOkWUhz9YPznGehh52xarwdkbYuFp+ZwWB5HA/zWZp7qDRRgKyKo2UP
         TeYod645dxcZNnODe/mcyJtJtZFa30z9xsNX97L3Z2V2jmxHO/BELUu5GDzGW7mA4Phj
         Pkq9szqMTDHEb5Zpuz50g6l5lDvxdefZ9pOg/7Mha0LTq/H2Y6gai+/E6WdX138185o2
         37O4quScpJ+mJqbNTK8I3DfM6ry9WPB5LVkw8Rv0YKdM5qJLZkgYTAWE7M638SbULY+t
         bIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtGhrGM04DEpcddG1EHK6PZkvVttFOlX+DQ19nSSesY=;
        b=zh82vtZWdx1w9+qWuJgPQQ65guTFqZhF0mpkH9FFqPb7KFgzniFy62xhlHAQLlL0Rh
         QFLPmx3KcmsSQ10q8CvQo5yVmGiKfySjz4gOV2mH7CdK9aAHCozdNfij6W0u+AjV1uA8
         Dqa7YR1RIRyBp6pRusQIjEWquMIdIUOZTMekKTW5m0tjDi3GIHNHDzYVKJc5YqofnbX5
         MtU5AqRju4+hd9qMJ/wQuiXkHP+K1c5EkQ1ZPKkWyqE3V8ONm8bJjLKDG1AeK+DepG4H
         Qb1pE6to/hs9iy4dxGcYPu+ToMIfnhx1iPapzQFdIBtgpKJztGPpwQ2x/xXzTMhNkWhe
         h3Tw==
X-Gm-Message-State: AJIora9KlJNwd8hrqARioasagz1hoe2ymu/MqYGcJ2R+HdDI86B7sdpv
        NqMVNkgaciYNAasHKKsQcFTMjfrLCT6SszsqhkXUvA==
X-Google-Smtp-Source: AGRyM1vqcqmFgwN1ErpO19yQ5+UG1bvQtqrFSw0vLzgYREoGbY0aARU6mv4w256A98MAraZc0XwppDbTGU41tSj0yL0=
X-Received: by 2002:a05:6512:c0a:b0:489:cf39:d750 with SMTP id
 z10-20020a0565120c0a00b00489cf39d750mr15882107lfu.233.1658144361871; Mon, 18
 Jul 2022 04:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220714174132.18541-1-kdasu.kdev@gmail.com>
In-Reply-To: <20220714174132.18541-1-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:38:45 +0200
Message-ID: <CAPDyKFq-8vksy+qNKRCj+6q3RDtDmoACfM7usxG1AE_BG3NHxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM resume
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jul 2022 at 19:42, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> Use clk_get_rate for base_clk on resume before setting new rate.
> This change ensures that the clock api returns current rate
> and sets the clock to the desired rate and honors CLK_GET_NO_CACHE
> attribute used by clock api.
>
> Fixes: 97904a59855c (mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0)
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 28e9cf995c41..aff36a933ebe 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -406,7 +406,14 @@ static int sdhci_brcmstb_resume(struct device *dev)
>         ret = sdhci_pltfm_resume(dev);
>         if (!ret && priv->base_freq_hz) {
>                 ret = clk_prepare_enable(priv->base_clk);
> -               if (!ret)
> +               /*
> +                * Note: using clk_get_rate() below as clk_get_rate()
> +                * honors CLK_GET_RATE_NOCACHE attribute, but clk_set_rate()
> +                * may do implicit get_rate() calls that do not honor
> +                * CLK_GET_RATE_NOCACHE.
> +                */
> +               if (!ret &&
> +                   (clk_get_rate(priv->base_clk) != priv->base_freq_hz))
>                         ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>         }
>
> --
> 2.17.1
>
