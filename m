Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135AFC88CB2
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Aug 2023 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjHYLqJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbjHYLpg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2023 07:45:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864FC2106
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 04:45:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d77c5414433so824890276.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692963932; x=1693568732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcf02hKF/0IdH3b1tfgEymyLjXbz5lFk9LkSgZ+/VMA=;
        b=NXO+TOtkKX+bmKbXuTm0NUbkfxdku2aPo89ryMUq6iKKoSkZeNcvPAxF/bwzV7Eujg
         u6WF2gihqJ9s2SCDG6vYWQ9kbfporJWKFWZ1QouFO3tOeQlAoSm9lJ82Iuc03a6V/q1F
         NtK//fmUSm9gcKGUZxXwhxksr7YPzQbaBWBOQHfeFqodDOP7/Nr0IPLxY9Fe0oSNBmcr
         HrabKwve6jfC5QWE5nYDd2fztV+PeSf4R2gcaO2E3u4kEyJ6v9lvTu41asp9/vy6oEcT
         VLznEBoC+AGgyzjEhlUbFuyE9feuer683jMNKgerc2uCsoX+uimeVpNR/ymwy33l4mYH
         I2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963932; x=1693568732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcf02hKF/0IdH3b1tfgEymyLjXbz5lFk9LkSgZ+/VMA=;
        b=ShFCmfgefJYeRhZfpQ1j+tzk7oq2GaE/PSteKzHApQUGYnbF9odESQSgc6w6HDFOtp
         3jGrPRDgW47Wq3jJEhH8dGn1Z/Kq2NMVkAo6XZ/cHpPtCVp0j5ih6T6l+/2rAuPbVmdu
         OHLdZGcEx9h3F1qLDO5KAJD7vTV00yAYTBU+wQOMfWSVaGhv2c14ukYs0PdzrurxBBlu
         ObDPtaNvq82LB+MiuV/pJdSMHdEi4mr8tOU+7eU54YCgaTlG6NchVCfNVIO1iMXlJLsn
         cBZ+cYEos0L3OeeXeJg+2dkrPbnw3fsTrub6p1vPLeyUO5klogbNg6vYbGVH3hiDVzIp
         W9hA==
X-Gm-Message-State: AOJu0YwU7q+yo6t4YJZ8zi5K2w2q6ZL+OsT4nbPb0etjwlwaO/jeKVqx
        r8ekHnIIjJXNkPVMk1t3GmwzThrX3t/BthFdxuvLfA==
X-Google-Smtp-Source: AGHT+IGrtKMF8Yp+gEsaJ2A+cL1/buPgbXCYxwk792IJXE1syFo/+NkzfJGbMAyhGaVIo5+B9Tp9iUpkpzem/NxNnX0=
X-Received: by 2002:a25:d0d5:0:b0:d77:ec2f:63b with SMTP id
 h204-20020a25d0d5000000b00d77ec2f063bmr5858906ybg.5.1692963931772; Fri, 25
 Aug 2023 04:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com> <20230825095157.76073-4-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230825095157.76073-4-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 13:45:20 +0200
Message-ID: <CACRpkdahEcKgR9gR7iU0cW_aDTReDYBKdP+5_F+hGcarCjG9gg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 25, 2023 at 11:53=E2=80=AFAM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> The polarity of the card detection gpio is handled by the "cd-inverted"
> property in the device tree. Move this inversion logic to gpiolib to avoi=
d
> reading the gpio raw value.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +       /*
> +        * The Atmel HSMCI has compatible property in the parent node and
> +        * gpio property in a child node
> +        */
> +       if (of_device_is_compatible(np->parent, "atmel,hsmci")) {
> +               np_compat =3D np->parent;
> +               np_propname =3D np;
> +       }
> +#endif

You don't need to use the preprocessor actually, what I did in my
example works:

if (IS_ENABLED()... && of_device_is_compatible()...) {
...
}

If the first expression in the if() clause is constant false, the compiler
will optimize out the entire if()-clause. At least the compilers we care
about.

Yours,
Linus Walleij
