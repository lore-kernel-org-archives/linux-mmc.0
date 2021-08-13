Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6728DC432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C72F610CD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 09:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbhHMJ0j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbhHMJ0j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2021 05:26:39 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279ADC061756
        for <linux-mmc@vger.kernel.org>; Fri, 13 Aug 2021 02:26:13 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id x21so4188277uau.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Aug 2021 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ut6mQd4Zn9yzwllPVKXtSuUtUiVHIvJ1CKJTi2g3fHk=;
        b=xrR6K6FT4jZSZ0Z40ctP0aYRruc7VrWJ6tXDc/AYyI8gk8dab9TG7LySXaXvJA480G
         A7XYRUtb01g9bw3rLW/GbNz4ve6+0A6fi0he+LvumLdMMLhSBttfRpJan/C7Wx85mPdA
         GFpwEIgyeWUvii691DnWOx+csYhhnBLlughsGGR7S5KHrrp/l9fUt+hzGrfL9fSElhO3
         dzutqhrMIlFxFWR+iYheBWr792Bf1uJvR4AUSh4O9bOLcRHx2JT8egrkmqmFqxmQZ/CY
         OAmR9I/nZ19aScgD3pSB2aroS2A9319RnQ8bElCYJb//Uj4vdMvABgk/MZSuE8v8Jzfp
         4nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ut6mQd4Zn9yzwllPVKXtSuUtUiVHIvJ1CKJTi2g3fHk=;
        b=Jo/KnUWM9kuIp2s0jSl4dRkgING7qfmA8s9Mc2ALIfLGGBfAiuETS1AtiJfhAEvzgu
         ZfTeFZ6tmH59tll1JqnIdxzNUH6nniAAtlv5qjp7H66nXky5kQcpsKOog0RteIsmr3QT
         12MgLxCq9Rs2DklekMmR5NoCwVeSC2MzLTN+qwor8AD4xZSL7kQWP3BFpi1zxNoUH+4o
         s5myk7V6jI5PB5fPr5P96vnIWDz8Pv4OzqPpmt9PPSF2KfsykJnEBoJE9JYPG1RabGIx
         7PQzdOC459CgL1A8PQREuiL/iwMuFVOhFuaMq+7LVKYoPyiD6fvkZR95FjBYN2lWk8SS
         Nl8Q==
X-Gm-Message-State: AOAM532u7837tny/SKdHv370LCyieChpidJkgVLPA711hOlHUxI3o7Hc
        YTcK/LxpP/tZcZhnc2a8sW2tSqHBjnq+DJCQwJPMfQ==
X-Google-Smtp-Source: ABdhPJx25DWjmqd+MWDtXUH0y/qqJGrZSC0lJgb1dBHYHl7f1g2GaLQaJqtVbaIHQ/4BBgEwhlqyxPty2qZhJ0Zlhik=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr638332uaf.129.1628846772216;
 Fri, 13 Aug 2021 02:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210812145056.11916-1-marten.lindahl@axis.com>
In-Reply-To: <20210812145056.11916-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Aug 2021 11:25:35 +0200
Message-ID: <CAPDyKFqp=savCgoUTRYbMG106zSkGshX9OiwAXMxb4VsPKUXsg@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: Implement card_busy function
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>, kernel <kernel@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Aug 2021 at 16:51, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
>
> When switching card voltage to UHS voltage the mmc framework tries to
> check that the card is driving pins CMD, and DAT[0-3] low before the
> switch is made. Drivers that does not implement the card_busy function
> will manage to do the switch anyway, but the framework will print a
> warning about not being able to verify the voltage signal.
>
> Implement card_busy function. Renesas host interface only exposes pins
> DAT[0] and DAT[3] for reading the busy state, which is why only these
> two pins are checked.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index b9b79b1089a0..e400a646e675 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -77,6 +77,7 @@
>  #define USDHI6_SD_INFO1_WP             BIT(7)
>  #define USDHI6_SD_INFO1_D3_CARD_OUT    BIT(8)
>  #define USDHI6_SD_INFO1_D3_CARD_IN     BIT(9)
> +#define USDHI6_SD_INFO1_SDDAT3         BIT(10)
>
>  #define USDHI6_SD_INFO2_CMD_ERR                BIT(0)
>  #define USDHI6_SD_INFO2_CRC_ERR                BIT(1)
> @@ -1186,6 +1187,21 @@ static int usdhi6_sig_volt_switch(struct mmc_host =
*mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> +static int usdhi6_card_busy(struct mmc_host *mmc)
> +{
> +       struct usdhi6_host *host =3D mmc_priv(mmc);
> +       u32 info1 =3D usdhi6_read(host, USDHI6_SD_INFO1);
> +       u32 info2 =3D usdhi6_read(host, USDHI6_SD_INFO2);
> +
> +       /* Check if the SD bus is processing a command */

Hmm, this sounds a bit confusing to me. Don't you want to say
something like "the clock logic is enabled".

The point is, from the mmc core point of view, ->card_busy() is called
to poll for busy completion *after* a command has been processed.

> +       if (!(info2 & USDHI6_SD_INFO2_SCLKDIVEN))
> +               return 0;
> +
> +       /* Card is busy if it is pulling dat[0] & dat[3] low */
> +       return !(info2 & USDHI6_SD_INFO2_SDDAT0 ||
> +                info1 & USDHI6_SD_INFO1_SDDAT3);

In fact, it's sufficient to monitor any one of the DATA lines to check
for busy for the UHS-I switch, according to the SD spec.

However, since we are using ->card_busy() to monitor also other busy
signal scenarios, like for some commands with R1B responses that
assert only DAT0 to signal busy (at least according to specs), I think
it's better to monitor solely DAT0 here.

I realize that the comment for the ->card_busy() callback in
include/linux/mmc/host.h needs to be updated to clarify this as well.

> +}
> +
>  static const struct mmc_host_ops usdhi6_ops =3D {
>         .request        =3D usdhi6_request,
>         .set_ios        =3D usdhi6_set_ios,
> @@ -1193,6 +1209,7 @@ static const struct mmc_host_ops usdhi6_ops =3D {
>         .get_ro         =3D usdhi6_get_ro,
>         .enable_sdio_irq =3D usdhi6_enable_sdio_irq,
>         .start_signal_voltage_switch =3D usdhi6_sig_volt_switch,
> +       .card_busy =3D usdhi6_card_busy,
>  };
>
>  /*                     State machine handlers                          *=
/
> --
> 2.20.1
>

Kind regards
Uffe
