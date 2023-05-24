Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C355C7EE2E
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 13:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEXNLV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjEXNLU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 09:11:20 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45845B0
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:19 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-561afe72a73so14170117b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933878; x=1687525878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MvZGpV39H6LWTzsLCijgX3+057w1b33nSMugKocz4KY=;
        b=RsvzRBXyg2HzzC8gG/xUrb3Dcbh95QtFJlZpWi84s1DTAD4gjXpoYWLi+17/llgvbf
         HI7yORJ0R55Nldwipx8Wm6J7sBRt6mrIHuXA1LuG+r5EvowNzPEqJXT1FQH/+GutYWo8
         Q7Hxu2TjrDn3gDyqBzedoEuNCNPvHx9ndrVCgweSn1Li5ysK49zalz/MpKS0vElza29t
         dKVbq13lqTLptPwl/a3lefmYJUtRiZwl9+qEncUDBcN02oMz//XsTZX5Jmet5v5v5uNh
         JxZYwwsjFmnt1Gx1/stRgiBlzbd8NbUvXDVJ2OAjiHgNAegX53HAaQeCuluAG4D1tPiw
         w0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933878; x=1687525878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvZGpV39H6LWTzsLCijgX3+057w1b33nSMugKocz4KY=;
        b=lQclf8UuW9CgxBYQdPdIF0Pyl+6oyS/r3n3lt2MpzRhvjIMkdzPfyCBO3aAgTEu8jF
         hQNbEIbqSomPOCjk6IoHQINnEclvUU+f9sr/QBzo2IUZhxAD9rDsSRLXEY5ZyJsxwuER
         sNBrTADH53ky7sgcFPSW16MtY8nJJA/1FecgpemYVhEXXF8m/CB9bGb3YpHATl+hGWeK
         qyrvmMXHM/6ET+fkQYXGoGbMiEAaPo7LAImBW1aZX3YhwcK1QDNIExOS/8xwvBXZS4IY
         Ws9jnYtsw0SYFJAg6Ewuzg1PIau4wPdF2HQi/ZwlV+hXHEkeyIJY/Xtb6GQtPL0Luwbj
         CQBQ==
X-Gm-Message-State: AC+VfDwVTPvwPw8DORakEXpaBAc7Wlv/AT+lY/0YHjbD5NuinKh0rRE+
        Rwqxw39Y1qSJnxX5jwD5adJhtIr2zXB8ZPpVqMuXCQ==
X-Google-Smtp-Source: ACHHUZ7Mrhuw8pccSbQf9WGKebUOBDZeHw5kYpBk2mDjue1to21G1j5Hluqsi4/jn4RAAvknTppQxiz6JmxokHmHIf0=
X-Received: by 2002:a81:7405:0:b0:564:c4db:6329 with SMTP id
 p5-20020a817405000000b00564c4db6329mr15659384ywc.11.1684933878470; Wed, 24
 May 2023 06:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
In-Reply-To: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:42 +0200
Message-ID: <CAPDyKFpj2BNEUTWeFZLWL-VDze9Ravw1SDEM=Zhe-v2Ov2udhA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Avoid cast to incompatible function type
To:     Simon Horman <horms@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 May 2023 at 14:39, Simon Horman <horms@kernel.org> wrote:
>
> Rather than casting mmc_free_host to an incompatible function type,
> provide a trivial wrapper with the correct signature for the use-case.
>
> Reported by clang-16 with W=1:
>
>  .../meson-mx-sdhc-mmc.c:791:38: error: cast from 'void (*)(struct mmc_host *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>          ret = devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  ./include/linux/device.h:265:38: note: expanded from macro 'devm_add_action_or_reset'
>          __devm_add_action_or_reset(release, action, data, #action)
>                                             ^~~~~~
>
> The same approach is taken in litex_mmc.c with the function
> litex_mmc_free_host_wrapper(). There may be scope for consolidation.
>
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index da85c2f2acb8..97168cdfa8e9 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -776,6 +776,11 @@ static void meson_mx_sdhc_init_hw(struct mmc_host *mmc)
>         regmap_write(host->regmap, MESON_SDHC_ISTA, MESON_SDHC_ISTA_ALL_IRQS);
>  }
>
> +static void meason_mx_mmc_free_host(void *data)
> +{
> +       mmc_free_host(data);
> +}
> +
>  static int meson_mx_sdhc_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -788,8 +793,7 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
>         if (!mmc)
>                 return -ENOMEM;
>
> -       ret = devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
> -                                      mmc);
> +       ret = devm_add_action_or_reset(dev, meason_mx_mmc_free_host, mmc);
>         if (ret) {
>                 dev_err(dev, "Failed to register mmc_free_host action\n");
>                 return ret;
>
