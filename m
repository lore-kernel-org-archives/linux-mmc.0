Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97850C2BB85
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F6320784
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpdc6/7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894813AbgDOIlC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894812AbgDOIk7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 04:40:59 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B17C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:40:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p28so1699638vsg.13
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omiGcsbKasYfX0xBbG+LJDV61G+OkCUsHwRpvQU4/dA=;
        b=rpdc6/7iEbpudnJRWnzdPPfcNHEK7QaAySAG1RrxtTnHM3yN1LVdB53uR7mf6PeZCZ
         0zgVtIIaclIrrokiRmDuNQI+VexcnktXC/gps9oyw0rm75pS5hlIEIHhuuVNqrYIdy85
         J5wZz9Dy3pBh01Hu6KRzpmbvYADvMRLVf8mSiBUYdSbUOarsim7a1ciJMthY4cR8hnri
         UpsmLnXwNNv1zFy/fYTXy0qmZ0+8MZ1Q6MYCZnUcKQT5nXRmaOu0sYe3NzzKCMG9Q0zI
         zTtke6lX+TXtkQNZDCzjSqjAN9r2bvGHwH5bY0FLtIoZrBKR0FG8U/FuiLfTj2dmLah9
         Es6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omiGcsbKasYfX0xBbG+LJDV61G+OkCUsHwRpvQU4/dA=;
        b=JU/RZluPdEtHELXWpjwBtcfw4Cpp/lTntp9gv2hwOgG8/SJczj3WyK8cUdmcj6DEUY
         kdxhxrYRO8VGs/6x4j3lbCNkMWFghK5dVVi8LfUn7zpYClL/0d/3zQYZG+pkSoIU34Sv
         ih+VHzRINftJywTEiFmCa/9xoMP70FMqbNKTB/Q8s8L74ughBi8+p+DUup61J0Tj7Jk3
         tRjei7QSwolCVOqrUjGaQqUQ4Iph19jrnxNs2oeef9tI1OBYy4Q/NtFXDH9DiTwOatr6
         zpHeJYTpXJDbat+5S8bulBcW8/zVKHsl288OwZxy88viUjzWw8olsoBfzsxi+Jrh+xC/
         A/Vg==
X-Gm-Message-State: AGi0PuY+GykDr6c3hHz+MLCN30eZ/q0sdJo9wOPeh7DggJVncDUIxw+x
        S3MyABp4oRN+v3TXPNEVgiUyJSxIECIEERDjJTkcYQ==
X-Google-Smtp-Source: APiQypKcS0T2Z05H58zalH1qbLVM4cPc7n1LTo5L/Z7jjHdRiPL0qSstLEaPV0uMvhkoKpRXznncsD8/tMqeuTb7mGE=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr3508054vsm.165.1586940058296;
 Wed, 15 Apr 2020 01:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200401195722.208157-1-marex@denx.de> <20200401195722.208157-2-marex@denx.de>
In-Reply-To: <20200401195722.208157-2-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 10:40:22 +0200
Message-ID: <CAPDyKFohHXW+5G9PTjXdvFevbx6JDOUue9+6+Ck9na36B0sH5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: Return 1 from mmc_set_signal_voltage() if switch skipped
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
>
> Adjust mmc_set_signal_voltage() to return 1 if the voltage switch was
> skipped because the regulator voltage was already correct. This allows
> drivers to detect such condition and possibly skip various voltage
> switching extras.

This change to the code isn't about mmc_set_signal_voltage(), but
about mmc_regulator_set_voltage_if_supported(). Please update the
changelog to reflect this.

Moreover, as a part of $subject patch, you also need to adopt
mmc_regulator_set_vqmmc() to cope with the new behaviour of
mmc_regulator_set_voltage_if_supported().

>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-mmc@vger.kernel.org

If possible, please drop all these, as I don't think we need them as
references part of the patch. Of course, it's easier for you to keep
them, I can also drop it while applying.

> ---
>  drivers/mmc/core/regulator.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index b6febbcf8978..2805ea8a070e 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -136,6 +136,8 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
>                                                   int min_uV, int target_uV,
>                                                   int max_uV)
>  {
> +       int curr_voltage;

Nitpick: To be consistent with other variable names, maybe current_uV
is a better name.

> +
>         /*
>          * Check if supported first to avoid errors since we may try several
>          * signal levels during power up and don't want to show errors.
> @@ -143,6 +145,14 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
>         if (!regulator_is_supported_voltage(regulator, min_uV, max_uV))
>                 return -EINVAL;
>
> +       /*
> +        * The voltage is already set, no need to switch.
> +        * Return 1 to indicate that no switch happened.
> +        */
> +       curr_voltage = regulator_get_voltage(regulator);
> +       if (curr_voltage == target_uV)
> +               return 1;
> +
>         return regulator_set_voltage_triplet(regulator, min_uV, target_uV,
>                                              max_uV);
>  }
> --
> 2.25.1
>

Kind regards
Uffe
