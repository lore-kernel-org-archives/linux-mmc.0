Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C0C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030D0218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/1MFWtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLROCV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:02:21 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42993 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLROCU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id b79so1420762vsd.9
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MqcWC72NUw+7l3vLDUFuLwA4CNEK5ETyQbLNfZ8gAU=;
        b=m/1MFWtJ9qkM4vsp7ohIEThRlvk6ZbPuvXTTO+TzCFT35SkOz9gpZrTkOI4gmh73KG
         i7RhOw4zo0NoUjZ6abErqTwSHcZpSi6gnDYP+SKhD03HNJMMG75qRDdPNmksyojGd2Rc
         jO+udWWP5Ek9Awy7Wmk5iHj80wE4Xj280OTJZHn7JRRYjMmh0XDpjlPP9g4wtQgfDVIv
         7Oo7kL3FqKiIUvGr/4h+J7ZniDo/TdhXH8Yu5A7iMhTJPyUEa2QRQVIYydA+4WbxsdTd
         XSPthcfGdzYAfrDScp8bLX9GH+Y2tx+8vnm7GXHxxzdaWpjPzF2ElmQlnNqx1UiGU9Qk
         BUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MqcWC72NUw+7l3vLDUFuLwA4CNEK5ETyQbLNfZ8gAU=;
        b=FuGJk4cINLw5bbJL2PZTicXfrKidYw8AcYVdR7RGNP3hrUXBvWL9ulRXXshP65Gmbn
         wcybJfW1hukOmJWhec9qqjt9cM1DLBMp5cYDFIQNESAerKRgXkJljCKnxKa7E/CdpLy5
         gxmuSku92akGTODHtYtFpbn2Dx1dHRI7fHpDkLiSUJLrLVK8q6WIhHaz3/ES4u/2e8Il
         IrnqZ2J5vwqMtAn+zaAuD/2T93F6yLT7DZaEd//vwsupUC9hjQGSIgGmIjJVHuqa9Z4J
         wZCeD9EZt8W8qe3nCL7XRh3BUpEVuolzMHHhQuDSrs3lCHaTLdnjxSIwzZ+nF8wQt1BJ
         z5hw==
X-Gm-Message-State: APjAAAUnKmiH/jDuPynPboiD9FO0YMagTIRFPT1DJWC0hwrl1ESwvrVM
        E/7mcWaQuiqlmdRty3dG282BZyVMk3rTnTYOkhflbQ==
X-Google-Smtp-Source: APXvYqwbv5IQL8XJXtfep+5acQSTXE9WY6jnE1UQqvQJm139MKvuv03QqH0bG3ly4Lq7DRnIKxQW2Dt+JMtOBKR7rf4=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr1386372vsf.200.1576677739978;
 Wed, 18 Dec 2019 06:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20191215175120.3290-1-tiny.windzz@gmail.com> <20191215175120.3290-13-tiny.windzz@gmail.com>
In-Reply-To: <20191215175120.3290-13-tiny.windzz@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:43 +0100
Message-ID: <CAPDyKFqeoefkTy7prJ=nKKh4NVdhtHfawxfsEYGyYZd6b3igrA@mail.gmail.com>
Subject: Re: [PATCH 13/13] mmc: au1xmmc: switch to platform_get_irq
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc list (please do that also for any future submissions).

On Sun, 15 Dec 2019 at 18:51, Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
> requesting IRQ's resources, as they can be not ready yet. Using
> platform_get_irq() instead is preferred for getting IRQ even if it
> was not retrieved earlier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Patch 1->13 applied for next, thanks!

Next time, please use a cover-letter when you send a series.

Kind regards
Uffe


> ---
>  drivers/mmc/host/au1xmmc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index bc8aeb47a7b4..8823680ca42c 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -984,12 +984,9 @@ static int au1xmmc_probe(struct platform_device *pdev)
>                 goto out2;
>         }
>
> -       r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!r) {
> -               dev_err(&pdev->dev, "no IRQ defined\n");
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq < 0)
>                 goto out3;
> -       }
> -       host->irq = r->start;
>
>         mmc->ops = &au1xmmc_ops;
>
> --
> 2.17.1
>
