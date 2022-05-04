Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EAAC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348200AbiEDKlm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348216AbiEDKli (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1359289AA
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so1572972lfa.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDARMy4G2cd5VS1uCmRnExcuGWEn8PIYidOZ1sSpEt8=;
        b=Dq6/1AHWTcx76Scb67aqaZEyyRRwR+DqVn7COUcY6T0yIYsQOhc5LCl2mD5w+Jrj3j
         MTLEuHxGqtU+/ioCnYbGtgdEqsZFV4gfo7gOpwj7Q0BkBzqdqF5jRV0elUA/vQ+RUuaU
         QNs6FpVunmIUoDCk0WN6BCcCBpPEBy5Grft8z1vGkbMfx1nMQ7DEDdWnsDg0S4pVpbJ9
         LG9n/YlDpjPQzUmI6TtN7W8VLw93zVAxtNo1cZu+yQUzWU6xA2x/GTe9H/2FuQR+4IvJ
         bHZWaay7te2IrEoLWcW2ChzQIdhaBRLI+wXaa337NaSBT9VqS0aYSiUQI0T6aM6bp6kM
         Gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDARMy4G2cd5VS1uCmRnExcuGWEn8PIYidOZ1sSpEt8=;
        b=5V+U6vOSEXc+taGUaOvBYiL4qL/V2XlemZER3DAlZGmUEkuwv+oR+5iMXF/KMVJKbF
         pm7TFLZ71scL62OUf4tIFjw1HmmG5wkN5mQt9Pji3po5JTTaUTi13/Y3XPIp3P61f7Gv
         2vFOYNPr0JC7e2fQQWkViCdmz9Y6GD5cC2cd7y55bUOEt40x+elAk1Pvv7CydRkQRgQN
         P13at9BNoYP+NuF+o+BOtEA6+2R84DOM3fD1SjERAbmh7xwZOyS6SzKcbS5iWuVtHbSc
         LcVXtWJdpSHmezfIrqBXyzXL4ZMYNx9GNLh5hZPg7Qy5MHmKoIMKdE4eHhj43Mxbh+8E
         2ESg==
X-Gm-Message-State: AOAM531jLavyDGFZH2zA2oyaj5c2egqj+ua/JGwn+FEsKNvJ5Nr0KNV1
        5QoG1yqSpdiOMqxPoUIq4dL4SYGp841xWQEcrXmYEBFIxaI=
X-Google-Smtp-Source: ABdhPJyx6rIxJZ+N70J7g3+F9p4K6e313kIiWcYcdVMzaZiYPtRtmo5gEVAnOhgZI5SRRoEtrjF2N1fuk0yfFrGAPRQ=
X-Received: by 2002:ac2:4646:0:b0:472:108e:51af with SMTP id
 s6-20020ac24646000000b00472108e51afmr13890479lfo.184.1651660682178; Wed, 04
 May 2022 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220427125557.1608825-1-linus.walleij@linaro.org>
In-Reply-To: <20220427125557.1608825-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:26 +0200
Message-ID: <CAPDyKFo4AeikrkLHd0MbXudydi_k51vBvr4WKzuSfviGAsySWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Remove custom ios handler
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Apr 2022 at 14:58, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The custom boardfile ios handler isn't used anywhere in the
> kernel. Delete it.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c   | 4 ----
>  include/linux/amba/mmci.h | 6 ------
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f3cf3152a397..01159eaf8694 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1748,10 +1748,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         unsigned long flags;
>         int ret;
>
> -       if (host->plat->ios_handler &&
> -               host->plat->ios_handler(mmc_dev(mmc), ios))
> -                       dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
> -
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
>                 if (!IS_ERR(mmc->supply.vmmc))
> diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
> index c92ebc39fc1f..6f96dc2209c0 100644
> --- a/include/linux/amba/mmci.h
> +++ b/include/linux/amba/mmci.h
> @@ -13,17 +13,11 @@
>   * @ocr_mask: available voltages on the 4 pins from the block, this
>   * is ignored if a regulator is used, see the MMC_VDD_* masks in
>   * mmc/host.h
> - * @ios_handler: a callback function to act on specfic ios changes,
> - * used for example to control a levelshifter
> - * mask into a value to be binary (or set some other custom bits
> - * in MMCIPWR) or:ed and written into the MMCIPWR register of the
> - * block.  May also control external power based on the power_mode.
>   * @status: if no GPIO line was given to the block in this function will
>   * be called to determine whether a card is present in the MMC slot or not
>   */
>  struct mmci_platform_data {
>         unsigned int ocr_mask;
> -       int (*ios_handler)(struct device *, struct mmc_ios *);
>         unsigned int (*status)(struct device *);
>  };
>
> --
> 2.35.1
>
