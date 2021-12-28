Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10972C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhL1Qua (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhL1Qua (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:50:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD786C06173E
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:50:29 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h21so19653348ljh.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unr2+C9UDbW8T46co3NWa5j1UiNVxrIVSFTa7beJaDM=;
        b=fLI6TYfuxVERwX4QlAsMWHBtyazhhH7HpDqq9l4sB6hNxx2u7vr5Z5bpc1yVLhLM3M
         XzDfksVXzwTQw90OgEc73IIoz2MNlE1guDww3adKA+YxtMEa1Fog0MgGkp6N/NCtlYHI
         ZfJrNLzbW6cFlmsToTU1g//oDp6i0lhWalO3xbae/YE8/3pcIGPv8g5OVMmbM85CiYmq
         XRbJ/c8cyuj266fkDhv/3DcHxCjqaR8QmYICqY5CRauBA9PzG0HjulM4w7HscZ8biyE+
         gRa2x5rlCIm9en6C0K33b3jpB5NYc//MKG2a559PFyANzF69LEB1Pstx2QF+PurfBbrR
         QEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unr2+C9UDbW8T46co3NWa5j1UiNVxrIVSFTa7beJaDM=;
        b=7u1zHNXr0nMB4LsaLbErmkEG5fFgv2qZfzVXzKHBMxtikx29W14pGY3NXMXDgo0WY+
         U9n1dq4FOJAPCGvSe99uGlzAty4x8oJ2R4g11MV8tc3yCvQOl3bDUySTl0OUkRrTWtuc
         1SIyaNWsUdkFoM/WwnLI8sNgivy0hWABVytJIkvc/FFskRvTxle3wp+BVXZ40A3Zt+rh
         zMECgqhkqbTf8wgJOtsiJmvEr0QBA6QDAMD48kZ4NRqhQIZ4qjh9142cgxEzzon3GeKK
         8JmXfhiDT+tlqqoyd87w89+iCw9IFxeYGPHCZTmr2fWxdcF2W+RAZwKOhtzvTOwsaCJ/
         GJmg==
X-Gm-Message-State: AOAM532C1rjEubD9AtUC1JKZPi+vSYEfje1RBCORKhUHZ9DJDWQa0oK5
        MbxK5eAClDB4RKZH2Qn+vHMHT9ek3uvMIfP0yx96zw==
X-Google-Smtp-Source: ABdhPJwBEuUtMUcZbhEl6kB9GQpPMWkdQ9Cdp5mJhjpHwFTiHW16NBqMZQmm0WuwLvxUjdamhhD+3VQLz0Sej64yIww=
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr14737336ljc.273.1640710227978;
 Tue, 28 Dec 2021 08:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20211222030634.33816-1-michael@allwinnertech.com>
In-Reply-To: <20211222030634.33816-1-michael@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:49:51 +0100
Message-ID: <CAPDyKFoNuWX76Haq0MfvukbHR8mMq0rX7qC+o_ZhEAxAwwpBbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc:sunxi-mmc:add support on discrete device power supply
To:     Michael Wu <michael@allwinnertech.com>
Cc:     mripard@kernel.org, wens@csie.org, samuel@sholland.org,
        andre.przywara@arm.com, jernej.skrabec@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Dec 2021 at 04:07, Michael Wu <michael@allwinnertech.com> wrote:
>
> Because some platform has no regulator, only use discrete devices
> to supply power,For this situation, to use sd/mmc card, we add ocr manually
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2702736a1c57..afeefead6501 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1300,6 +1300,14 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         if (ret)
>                 return ret;
>
> +       /**
> +        * Some platforms has no regulator. Discrete devices are used instead.
> +        * To support sd/mmc card, we need to add ocr manually.
> +        */
> +       if (!host->mmc->ocr_avail)
> +               host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +

Rather than doing this, I suggest you hook up a fixed vmmc regulator in the DTS.

Nevertheless, it seems reasonable to check that the ocr_avail gets set
up correctly. And if it doesn't, perhaps we should print a warning and
return an error code.

> +
>         host->reg_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(host->reg_base))
>                 return PTR_ERR(host->reg_base);

Kind regards
Uffe
