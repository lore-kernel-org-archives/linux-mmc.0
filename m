Return-Path: <SRS0=+sp8=A4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C7C433E5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5306C2076A
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 11:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVbzsZEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQL0o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQL0n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 07:26:43 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67BC061755
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2020 04:26:43 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h1so2033226vkn.12
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2020 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E9FxeV8r0Kl53Po7D0HEeofAYDOqosJLkJd0MD2Tk8=;
        b=nVbzsZEbmCTZXaV8MAK2Ht6VC63/rhQuD/TF1ZrBIFHDIw3D90nYg9iaM4c3FusD8g
         At6NQM9+nZBOluA4bvaXZufJJcxv7iaCZab5H258ZRcL/IX9Ko1O+B1rGjlHivBQmeTM
         nutJ2HXsrwg8RL7YCZpmHswJ4ZB/kOm9foPD879qycvpf/VpO/9k61rBIV/6/itIjOwO
         UdT/3bl7gEb+WEcrBYoRN9QJfcZ189r/yq5i4Tck5xBUTzNN1E3yO+rdjRFoYCt6s42X
         XlQ8FvTr8SvWcIgKxRmPZDsW6mCPVHWqtK17shVzIqrl4vFaFOkmoknFMT0NR035EaDZ
         b8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E9FxeV8r0Kl53Po7D0HEeofAYDOqosJLkJd0MD2Tk8=;
        b=ZUMoht1bx7TQ5wWmI0YwLgL2zTD3klcfxRYd8z8IgheAQuhzsbssUzkh5jBctHSGAb
         hIWpEtr+2ynjSp2o1j3cUojXyGbWGt2ierke/enYbgT9yziZj2X1gD/YymYrXvI+Up0p
         oTgiijxaly4w0duaV8ozsnYbpoRQSWL6lcgwEB8cHoQsHunsuh3hv20ZDnlvZkqBjnXn
         x58h8WJvWny0dgtWu61b6jd8DjIO3da57ePmHhkmido99WLYMLTkflHfhvBWw6XE/KDJ
         cfOq/n1SDiBVShfPxkYWSf4o9TEpZHkiIVvNmoUfCoE73M88bHXsjuVoEv11ur4ZwPCA
         nFIA==
X-Gm-Message-State: AOAM531bgGKBWi3FVp6uIMQAaMDgvMuNhUEXiEE/+lKrBxviV5vPrZT1
        o0mWvqxS9lkUoLe824m7OBECmRdq6YzED3N11tAGrQ==
X-Google-Smtp-Source: ABdhPJytvrpEpafyX3EjSmJ2gDHSBAaKDmrCpIzufz5I7b/XMY1p4Jiph99BFWgX0W9GbZg07t6c4gVENm8rT4pAT6o=
X-Received: by 2002:a1f:3f0f:: with SMTP id m15mr6733654vka.53.1594985202239;
 Fri, 17 Jul 2020 04:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110819.28965-1-benchuanggli@gmail.com>
In-Reply-To: <20200710110819.28965-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Jul 2020 13:26:05 +0200
Message-ID: <CAPDyKFrvzZSYWkqD_JgZSCmF8p+Bj7JXfdbZ5D=OsszTPsSDdw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 02/21] mmc: core: UHS-II support, modify power-up sequence
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Jul 2020 at 13:07, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4.20":
> - Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
> - chip_select is not used in UHS-II, used to return to the legacy flow

Thanks for pointing to the spec, but please explain why/what/how for
the change - as this helps me to review.

I am going to stop commenting on each patch's commit message, beyond
this patch - as it seems the same comment applies to more patches.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/core/core.c      | 62 ++++++++++++++++++++++++------------
>  drivers/mmc/core/regulator.c | 14 ++++++++
>  2 files changed, 56 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8d2b808e9b58..85c83c82ad0c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1315,33 +1315,51 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>         if (host->ios.power_mode == MMC_POWER_ON)
>                 return;
>
> -       mmc_pwrseq_pre_power_on(host);
> +       if (host->flags & MMC_UHS2_SUPPORT) {
> +               /* TODO: handle 'ocr' parameter */
> +               host->ios.vdd = fls(host->ocr_avail) - 1;
> +               host->ios.vdd2 = fls(host->ocr_avail_uhs2) - 1;
> +               if (mmc_host_is_spi(host))
> +                       host->ios.chip_select = MMC_CS_HIGH;
> +               else
> +                       host->ios.chip_select = MMC_CS_DONTCARE;
> +               host->ios.timing = MMC_TIMING_UHS2;

If I understand correctly, the intent is to always try to initialize
the UHS-II interface/phy if that is supported. That doesn't seem
correct to me. What about if the SD card doesn't support UHS-II, then
we should use the legacy SD interface instead right?

Or perhaps the MMC_UHS2_SUPPORT bit becomes cleared somewhere in the
error path when first trying to initialize an UHS-II card, from
subsequent changes?

So, assuming that is the intent then, I am still not sure about this approach.

What about if we instead always start with legacy SD initialization?
When we have read the OCR register, via mmc_send_app_op_cond(), we can
check if the card supports UHS-II by looking at the UHS-II Card Status
(bit 29).

If it turns out that the card supports UHS-II and the host does as
well, then we do a mmc_power_off() to completely reset the
card/host/phy. Then we can call into a UHS-II specific path, that
tries to power on and initialize things according to the UHS-II spec.

In this way, we are going to prioritize initialization of legacy SD
cards to remain quick, as we won't try to use UHS-II unless the card
supports it. Moreover, I get the impression that we can keep the
existing code more as is - and instead introduce UHS-II specifics in a
separate path. This also also for UHS-II specific optimizations, I
think.

> +       } else {
> +               mmc_pwrseq_pre_power_on(host);
>
> -       host->ios.vdd = fls(ocr) - 1;
> -       host->ios.power_mode = MMC_POWER_UP;
> -       /* Set initial state and call mmc_set_ios */
> -       mmc_set_initial_state(host);
> +               host->ios.vdd = fls(ocr) - 1;
> +               host->ios.power_mode = MMC_POWER_UP;
> +               /* Set initial state and call mmc_set_ios */
> +               mmc_set_initial_state(host);
>
> -       mmc_set_initial_signal_voltage(host);
> +               mmc_set_initial_signal_voltage(host);
>
> -       /*
> -        * This delay should be sufficient to allow the power supply
> -        * to reach the minimum voltage.
> -        */
> -       mmc_delay(host->ios.power_delay_ms);
> -
> -       mmc_pwrseq_post_power_on(host);
> +               /*
> +                * This delay should be sufficient to allow the power supply
> +                * to reach the minimum voltage.
> +                */
> +               mmc_delay(host->ios.power_delay_ms);
>
> +               mmc_pwrseq_post_power_on(host);
> +       }
>         host->ios.clock = host->f_init;
> -
>         host->ios.power_mode = MMC_POWER_ON;
> +
>         mmc_set_ios(host);
>
> -       /*
> -        * This delay must be at least 74 clock sizes, or 1 ms, or the
> -        * time required to reach a stable voltage.
> -        */
> -       mmc_delay(host->ios.power_delay_ms);
> +       if (host->flags & MMC_UHS2_SUPPORT)
> +               /*
> +                * This delay should be sufficient to allow the power supply
> +                * to reach the minimum voltage.
> +                */
> +               /*  TODO: avoid an immediate value */
> +               mmc_delay(10);
> +       else
> +               /*
> +                * This delay must be at least 74 clock sizes, or 1 ms, or the
> +                * time required to reach a stable voltage.
> +                */
> +               mmc_delay(host->ios.power_delay_ms);
>  }
>
>  void mmc_power_off(struct mmc_host *host)
> @@ -2307,7 +2325,11 @@ void mmc_start_host(struct mmc_host *host)
>
>         if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
>                 mmc_claim_host(host);
> -               mmc_power_up(host, host->ocr_avail);
> +
> +               /* Power up here will make UHS2 init ugly. */
> +               if (!(host->caps & MMC_CAP_UHS2))
> +                       mmc_power_up(host, host->ocr_avail);
> +

According to my suggestions, then this would not be needed.

>                 mmc_release_host(host);
>         }
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 96b1d15045d6..05556225d9ac 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -247,6 +247,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>
>         mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
>         mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
> +       mmc->supply.vmmc2 = devm_regulator_get_optional(dev, "vmmc2");

Please move the regulator thingy here into a separate patch. Please
make sure corresponding header file, adding the vmmc2 to it is part of
that change as well.

>
>         if (IS_ERR(mmc->supply.vmmc)) {
>                 if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
> @@ -266,6 +267,19 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>                 dev_dbg(dev, "No vqmmc regulator found\n");
>         }
>
> +       if (IS_ERR(mmc->supply.vmmc2)) {
> +               if (PTR_ERR(mmc->supply.vmmc2) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_dbg(dev, "No vmmc2 regulator found\n");
> +       } else {
> +               ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
> +               if (ret > 0)
> +                       mmc->ocr_avail_uhs2 = ret;
> +               else
> +                       dev_warn(dev, "Failed getting UHS2 OCR mask: %d\n",
> +                                ret);
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> --
> 2.27.0
>

Kind regards
Uffe
