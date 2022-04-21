Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA901C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388335AbiDUN6L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388151AbiDUN6I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EFE1164
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so8868602lfv.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PStz3ucQop5E11FGjYf65GajtpUhiM0dpYLpQyM7blA=;
        b=UTOiTsG0ph37qDpoILfP8MJXsrW3+iDNWbpfDGz27TLA0vUp/p7ZFf2+JKVVLXzLue
         AqB4NG0jjIY+EUBixrFMlDkVV69kOHTDl8vJXnIdj5oXmkqoElVKQx7ix2OM7HkDfPWP
         iA6R1rn25VvPgEihMz1KjqNWCyw7xeQfcz0gFLc7Z+x4jUtRVMmRIBwOcxiAnHbQ4l9s
         8U2w205NziLHBlFe0jKP2cKo7m413/Xhvh3xhfeZEISZjOqTVHNDl7OSHogoYTMjdzCB
         SJQV6LbTP6ywqQ7UmwwRDzLKPtEgtKDPKxoLmOM1mBxyZ6wYfEvvhIp/BrsBtl+XkAys
         LyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PStz3ucQop5E11FGjYf65GajtpUhiM0dpYLpQyM7blA=;
        b=oWtcmXVKvLqQel0q6sWvVB5ZJMTKxgF+lObMa3Q0ldRoo8YJleQGr4W99Gkjamz+wT
         Akpi3okYMAp43g6yOZ0Q7cDAbyUuMoEqL6qr6dhFGU8q2WLw3RRVn1GUc3XpxIHG+uG/
         4brCd3/UP9HI2wEBGfOp2HDk5qG5cjFXurh8HUglzI2bWi1tbccvspxhVg3D3ulakbCH
         bD5DbeYoj0FiWhGa12+n/e5IY2h65uYW/F/UhWL8jmdBo6pzJvZtMhhK/iTUXlMJ5JAj
         MVnfUdZLSoYIB+gh5UMZrQN6ydR5ZKlkhjvilEDfnaNCQpmSpc4gkn3FmaWzR2LbfeR+
         SPaA==
X-Gm-Message-State: AOAM533D1WI1aKW/mBc9oWPXTaqDcfUU7k5M745HsifpIMAhakNcPVC3
        d22nueHqb6SkXZpY1QTie52ic77ZNF+ONKfY/dkEeH9TYGw=
X-Google-Smtp-Source: ABdhPJw9xCC1PzoLhZHuzySoVfQKBsf2+oxVHvfeI9/1IIWWEhAEpYImQnCvctiuQ63v/mdtus4r5GLg+CgZtg6oFAc=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr19708398lfr.233.1650549316101; Thu, 21
 Apr 2022 06:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220416224549.627623-1-linus.walleij@linaro.org>
In-Reply-To: <20220416224549.627623-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:39 +0200
Message-ID: <CAPDyKFo_SLzycgMYytfizkqRcEzYYB4epp1UD6Gp6ZczYB_MKw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Break IRQ status loop when all zero
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 17 Apr 2022 at 00:47, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> We iterate an extra time through the IRQ status handling
> loop despite nothing had fired. Enabling the debug prints:
>
> mmci-pl18x 80005000.mmc: op 01 arg 00000000 flags 000000e1
> mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000001
> mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000000
> mmci-pl18x 80005000.mmc: op 01 arg 40ff8080 flags 000000e1
> mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000001
> mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000000
>
> It is pointless to loop through the function when status
> is zero. Just break the loop if the status is zero.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 45b8608c935c..f3cf3152a397 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1619,6 +1619,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>
>         do {
>                 status = readl(host->base + MMCISTATUS);
> +               if (!status)
> +                       break;
>
>                 if (host->singleirq) {
>                         if (status & host->mask1_reg)
> --
> 2.35.1
>
