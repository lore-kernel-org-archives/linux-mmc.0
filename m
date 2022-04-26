Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79CC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 13:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244715AbiDZN6v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiDZN6s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 09:58:48 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6915F39C
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7ca2ce255so83550497b3.7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vnAxl9/6m01Rp7k898UysKn+D7uwIp07j9FOdL8K08=;
        b=tKoudsGaU3jACLFNweKVC1FxDvCj1EKUnpHd1WVFMlq2ZJqDHrIccJNy2IpQmvfGNE
         nWzuTY2RIX7HeRb6Ew9wEQ3jVbRHnFiYIBeE+IUdpoRtPK3UR+OP4SfcKMr56nugmsDA
         T5FmzucJMSZpZhSG118zaEhcrFdeyLQJSBz0yZkif12Hzc17tf+utn7rJtjJm3rU8am9
         qqfzL3ARG+RI4RPjuIfjMn5PzGBZQ1u3c8wIzZQcQJwVhuvgDi6nWOWRkOOCgWGr2atp
         aNUm3TVZs2iTHbzxFAiDIyenddPgISE3lMOORLLtWlLJyp7hW4isLItOD/G96HFMu5lg
         /zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vnAxl9/6m01Rp7k898UysKn+D7uwIp07j9FOdL8K08=;
        b=cNJxXrohEmgmXld1lUF2oy1kYg+nTfNMsRMR8VWEh403LdS68yKV48RnKamWTmtkpp
         /AJoEvjVwv9jP1KcuMJBbvS2B+IHSFca3gzZrjjjaoLKBkGQvxHqJPvYyhchMlORAgPC
         nmGEoRgx1gnuvgPDkNoeFho5jnexd3vdc7qOwo9mKbBkEl/9EaQinFHh0B0eTPTrccGG
         ENLrFCHbWXwf1C0Tzf9oQd+2ph3r1DCGV1ckULhz0ZyLj9ak4TE/cAkL728fo1ozTuUA
         /VpVKdp7R/7qihU3dI/fLenjVYUlTSrPbOzeLF7DcydSmd+JwzXg9GBjdWHw/Em8fO6Q
         L2PA==
X-Gm-Message-State: AOAM533F1jBhhI38KI4WUgrzdSoIfluA6xdGu1SFnN41xwr2n8Jc0+kk
        NnvKu9FyJUYLFoNtz7fclVIhjh3I52jSYKk+9JvOdQ==
X-Google-Smtp-Source: ABdhPJwXP4TdwcxWnUNBNkwDbTV3dLBtvpt2L3DjaLE74Wt1O6h1Rzd9M2lvWXt7y67o8B8B3IM+kwYDJXvx3UbsQoM=
X-Received: by 2002:a81:998e:0:b0:2f4:e2a0:f30f with SMTP id
 q136-20020a81998e000000b002f4e2a0f30fmr21422325ywg.376.1650981340479; Tue, 26
 Apr 2022 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-2-huobean@gmail.com>
In-Reply-To: <20220423221623.1074556-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:55:03 +0200
Message-ID: <CAPDyKFqHVxqz8ZSJYeZkjyLxEiCk-xpPuqOj69AkeJ=ZUYgvow@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-omap: Use of_device_get_match_data() helper
To:     Bean Huo <huobean@gmail.com>
Cc:     adrian.hunter@intel.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 24 Apr 2022 at 00:16, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Only the device data is needed, not the entire struct of_device_id.
> Use of_device_get_match_data() instead of open coding of_match_device().
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 64e27c2821f9..86e867ffbb10 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1219,16 +1219,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_omap_host *omap_host;
>         struct mmc_host *mmc;
> -       const struct of_device_id *match;
> -       struct sdhci_omap_data *data;
> +       const struct sdhci_omap_data *data;
>         const struct soc_device_attribute *soc;
>         struct resource *regs;
>
> -       match = of_match_device(omap_sdhci_match, dev);
> -       if (!match)
> -               return -EINVAL;
> -
> -       data = (struct sdhci_omap_data *)match->data;
> +       data = of_device_get_match_data(&pdev->dev);
>         if (!data) {
>                 dev_err(dev, "no sdhci omap data\n");
>                 return -EINVAL;
> --
> 2.34.1
>
