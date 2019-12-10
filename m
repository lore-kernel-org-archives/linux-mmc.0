Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A8BC2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BCE2077B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bsr530Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLJJwU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:52:20 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42218 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJJwU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:52:20 -0500
Received: by mail-vk1-f193.google.com with SMTP id u123so5383423vkb.9
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5qrPSpMH9kYcCHhd4vcNsQAXKGsi2GWn3voKA1UcIU=;
        b=Bsr530Ds9RR7OnrfepvBKHI1ZuAU27LqH5fz+tmCa0f+bwYgzsjYLRHghQLlvj++D2
         e4byzHZR5S65DTcVaJSNquWjuXxn5AOlRP9Cz6zL1NZRCRSyEND4qfCxQiwKOeHY7jgp
         YMUByo3To9g/oBBxqO+YwMqZnLiGAaQ9wuWIe3Tdy8SbjcTc01AeRbEWLyT+6x4PFM9Q
         0aAab+UNMml8m3DvOlA8lo9M9Gn+uw7xKwxysHK+ImR8IRUK/lcIvcPmAVqVbRD93KBl
         ghnSMoAYtvv57wUjsKe7iCBPgG/Ypkh+OMwn9anwcuetLLgxq31woSQ3xiWZvqMAVlUs
         I2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5qrPSpMH9kYcCHhd4vcNsQAXKGsi2GWn3voKA1UcIU=;
        b=lql+A99OmyyFc6rQaJHOIE1uRnMr2JgpIkmnUL+xQ5MFIcATZBdsmTef0sx5q/Pkq3
         0kjIeU1Fq8gg39Wnyxistn006pROxECwPdemegVh/8UM66Zq/gdHxVRJAN9ORS15yG+i
         oBO63HgoYNBQz1g+kj8gTdYNa4cZ+thwH12VrfyNXNgGg0QFg8J8RiibEsoiIj7FGSHL
         yE+tTHnY4ShY2o4aUOf1jj1tyF+o/T6GhQCxV1r4bBby4hhZ7qnHaToOmiwnifTulg7j
         LMkffQXM4uUXUxzdx1ismxZAYREAfrSEA+cQTQJufkdMxyaIpO0GLt8U1Y3PL32b/Ab7
         +oAQ==
X-Gm-Message-State: APjAAAXhvjUu0n0K89SCFqKrF8FBctMd+Ctpl3E8NeVxNRGSD2kGnSGh
        YiF3GX9/4MBVzND2jVTVG1m+U3da+cqKP9MIPcjiGg==
X-Google-Smtp-Source: APXvYqwMIyYSZ/6xd9tGeFm66CB+MLk55qt3XKWF3bgPCBTbvwZf/d7dwVdxPWTkVMuYa+XD0utnhDOgAM9dVAcHyqQ=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr8356089vka.59.1575971539446;
 Tue, 10 Dec 2019 01:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20191204152749.12652-1-linus.walleij@linaro.org>
In-Reply-To: <20191204152749.12652-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:51:43 +0100
Message-ID: <CAPDyKFpECpWLCwvyFP7zeAmrOA4VK+NxPhc7jqvpenUKkgjWxQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: Toggle SPI polarity, do not hardcode it
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Dec 2019 at 16:29, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The code in mmc_spi_initsequence() tries to send a burst with
> high chipselect and for this reason hardcodes the device into
> SPI_CS_HIGH.
>
> This is not good because the SPI_CS_HIGH flag indicates
> logical "asserted" CS not always the physical level. In
> some cases the signal is inverted in the GPIO library and
> in that case SPI_CS_HIGH is already set, and enforcing
> SPI_CS_HIGH again will actually drive it low.
>
> Instead of hard-coding this, toggle the polarity so if the
> default is LOW it goes high to assert chipselect but if it
> is already high then toggle it low instead.
>
> Cc: Phil Elwell <phil@raspberrypi.org>
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Seems like we should add a stable tag, right?

In any case, I have applied this for next to let it cook for a while, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mmc_spi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 74c6cfbf9172..1f02f54f09c0 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1134,17 +1134,22 @@ static void mmc_spi_initsequence(struct mmc_spi_host *host)
>          * SPI protocol.  Another is that when chipselect is released while
>          * the card returns BUSY status, the clock must issue several cycles
>          * with chipselect high before the card will stop driving its output.
> +        *
> +        * SPI_CS_HIGH means "asserted" here. In some cases like when using
> +        * GPIOs for chip select, SPI_CS_HIGH is set but this will be logically
> +        * inverted by gpiolib, so if we want to ascertain to drive it high
> +        * we should toggle the default with an XOR as we do here.
>          */
> -       host->spi->mode |= SPI_CS_HIGH;
> +       host->spi->mode ^= SPI_CS_HIGH;
>         if (spi_setup(host->spi) != 0) {
>                 /* Just warn; most cards work without it. */
>                 dev_warn(&host->spi->dev,
>                                 "can't change chip-select polarity\n");
> -               host->spi->mode &= ~SPI_CS_HIGH;
> +               host->spi->mode ^= SPI_CS_HIGH;
>         } else {
>                 mmc_spi_readbytes(host, 18);
>
> -               host->spi->mode &= ~SPI_CS_HIGH;
> +               host->spi->mode ^= SPI_CS_HIGH;
>                 if (spi_setup(host->spi) != 0) {
>                         /* Wot, we can't get the same setup we had before? */
>                         dev_err(&host->spi->dev,
> --
> 2.23.0
>
