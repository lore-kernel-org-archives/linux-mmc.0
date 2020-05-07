Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78190C38A2A
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9B208E4
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st0dcCb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGJ3w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEGJ3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 05:29:51 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8ABC03C1A6
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 02:29:50 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so1320009vke.4
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDi3h98mQHCtREHS90wezcyoS3twXkQG1OpaJtTR05E=;
        b=st0dcCb/GQYY2YzJ505z0YNbJa0O2n9TD/OBObEDwuO91e5Dqud7HBZ1Of4ZDhoV+0
         lIxgMlmG62LkJSvLmXNmoJHl1jA6vWNvMxRTftDCA3t8hwi462pIxtVJ0L1zbtoEUb+A
         gXcTn6kJSsXxoWcSV/SQW/z2/RcZKhq/7QopyXPV6grYDsiEhT3SMr5reMRIvx+sgc+n
         O7ihWY2o7HxZiiO1TJv/ZTWFLbN1RYBnNPxYsGtbuvh7VzKFiH4kXFtIxsmQidWImbfr
         5cxjx+JliMqvCpAd9cMFhphvVJdUAFr0BrM46Ux7UTROSQk62YrwoLkwwBfPupREPdMc
         sTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDi3h98mQHCtREHS90wezcyoS3twXkQG1OpaJtTR05E=;
        b=NOmlxmIGdKgzlHMBPnLdHWDu/4a++OKiW6hw1rpIyZbvMeBQiRiRX8X1/KAVfqScmR
         C8uE8fCZP1jogBsJr7xlgD3/rsVwU+JAanxkyECYdBjLijkF0nSpca0mgp2ldsGmbmYS
         RTjrYafyLC/tiYrlFbhscl6+F3WsFZGc5Vnt7fHNz3OgMPLwOQg6/BfW5oUq+xET6pji
         i4SVzhX7OORG9MCz/Eca0jsvMg6D+ODfO24UFU0nXm9TkPA7SCbXo0AxdYvX7Lv0zvRK
         fYVRgLxxyl0gNJRHV2WUFax0ZRevB5AikZN/2dbc5ByfeIoIHd76gMAGkNnOlt//ABgD
         PGdg==
X-Gm-Message-State: AGi0PuYWxYKeSuRfEVVi8nkCSQJVWRYEvEJzSI06ruGR+Wo98rCpvUNb
        4XgSRybAi02yrsM5DrBslEEC7ws92jb2jo8xMbIPRQ==
X-Google-Smtp-Source: APiQypKzFsKczdnWmdHQPnQ/h/SiYxQvsKKkhjZlHf0YbkAdYsLFFbQCIl2a1NGtqXQJsnmCxojtIUrNwBPLgVGo12Q=
X-Received: by 2002:a1f:31cf:: with SMTP id x198mr10672278vkx.101.1588843789884;
 Thu, 07 May 2020 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <1588794695-27852-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588794695-27852-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588794695-27852-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 May 2020 11:29:13 +0200
Message-ID: <CAPDyKFrP_W0xAESF+pN9-=Jw8FWbRWEPnZwtMijbSvYjrTYxZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: mmc: renesas,mmcif: Document r8a7742
 DT bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 May 2020 at 21:51, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Add support for r8a7742 SoC. Renesas RZ/G1H (R8A7742) MMCIF is identical
> to the R-Car Gen2 family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
> * Updated interrupts table to include r8a7742
> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index c064af5838aa..291532ac0446 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
>         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> +       - "renesas,mmcif-r8a7742" for the MMCIF found in r8a7742 SoCs
>         - "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
>         - "renesas,mmcif-r8a7744" for the MMCIF found in r8a7744 SoCs
>         - "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
> @@ -24,8 +25,8 @@ Required properties:
>  - interrupts: Some SoCs have only 1 shared interrupt, while others have either
>    2 or 3 individual interrupts (error, int, card detect). Below is the number
>    of interrupts for each SoC:
> -    1: r8a73a4, r8a7743, r8a7744, r8a7745, r8a7778, r8a7790, r8a7791, r8a7793,
> -       r8a7794
> +    1: r8a73a4, r8a7742, r8a7743, r8a7744, r8a7745, r8a7778, r8a7790, r8a7791,
> +       r8a7793, r8a7794
>      2: r8a7740, sh73a0
>      3: r7s72100
>
> --
> 2.17.1
>
