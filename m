Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BEC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D40A2073D
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfHsEwRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLJXLC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:11:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38717 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLJXLB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 18:11:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so21760957ljh.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rN2x0SJnHk2w82TaE62obIcDd9Ki/RqQuYUtYOw03xs=;
        b=RfHsEwRmytf+b3EDPLAh9NCUhN3IhKmCH3VJBI/kbzMj7LiCRIOrIaZnLOuB/qLGaN
         rXSkRfnSA8JCn1JnXNVxN5VpLTqXNcti8rjzsrIxn1zBOummI1BrzEbZjKHoHhHbxUoJ
         5zl6Wwz4fXasDu8K1BkkutldboWmMns38DvKX7+DE5Lx7Bh2Oq5PxLZDqn/vg5o7O/94
         61bc9fW2utRu92vbV5n8bwwmKYv/ldFH9BarnTEOCIUEWdpU6z92lNJQg3GSO3vTstXg
         /1ZHwL+Y2yGhwkrppLGSmtkC3fYp04ny2NTUagaZoF/G2j5lF+3mY/fXHMdDJMVjMNZs
         LUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rN2x0SJnHk2w82TaE62obIcDd9Ki/RqQuYUtYOw03xs=;
        b=Duu+kfXMQb282ns+3sijGuA1mrjc3Akl+0bEmVr6yoBQTFS8BA4SD1phNR38bLRUNS
         4nRoyH8gwnOq0/pVuAaSyfENcX673XB/rKhLv3oehsO5HYH2/JXS6oOHKDt2DBt+GPob
         YNIjDHx0KBMRqFyDnWkPDM0ZsIz3EoqS+3I8GWQgnVjdw6/fs8hreG6hUlml6ybs1U8s
         GWhe6Ba/xU8+Ff/xJUCMYV6scVfSOuL2atwprCzcWUFInAF4TmYcX48lkVkStrkm3LYY
         l+/mA0SvKFdN9+aUz+hfZQpXnVLeLfGtv2yp25D/Em3OFy410ueUAY6/rg1KQFcfGw0Y
         rPFQ==
X-Gm-Message-State: APjAAAU6F/k9Rd2u9mrUy5CguW2A/R1+qSnKZKHrmugxSUwJLbO/oaP2
        SOm9Zp9ehKhlAYwQoHc9hUI1psm8WKWsc1pOgDpgSg==
X-Google-Smtp-Source: APXvYqwPzlxqBcDrl6ch2I58uil2s6ypi7lbQtZ8sA54iIEPjMnzyc9Jy+pAuZjozmgLzqpvySkwqjrNZAbTnymr9Hg=
X-Received: by 2002:a2e:8544:: with SMTP id u4mr9196695ljj.191.1576019460078;
 Tue, 10 Dec 2019 15:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20191204152749.12652-1-linus.walleij@linaro.org> <CAPDyKFpECpWLCwvyFP7zeAmrOA4VK+NxPhc7jqvpenUKkgjWxQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpECpWLCwvyFP7zeAmrOA4VK+NxPhc7jqvpenUKkgjWxQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:10:47 +0100
Message-ID: <CACRpkdai6FwgwD7+BeF0_ORw4P1hoCv4dvoi_Uhyp21t5qCOjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: Toggle SPI polarity, do not hardcode it
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 10, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 4 Dec 2019 at 16:29, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > The code in mmc_spi_initsequence() tries to send a burst with
> > high chipselect and for this reason hardcodes the device into
> > SPI_CS_HIGH.
> >
> > This is not good because the SPI_CS_HIGH flag indicates
> > logical "asserted" CS not always the physical level. In
> > some cases the signal is inverted in the GPIO library and
> > in that case SPI_CS_HIGH is already set, and enforcing
> > SPI_CS_HIGH again will actually drive it low.
> >
> > Instead of hard-coding this, toggle the polarity so if the
> > default is LOW it goes high to assert chipselect but if it
> > is already high then toggle it low instead.
> >
> > Cc: Phil Elwell <phil@raspberrypi.org>
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Seems like we should add a stable tag, right?

Yeah I agree.

> In any case, I have applied this for next to let it cook for a while, thanks!

Good, thanks!

Yours,
Linus Walleij
