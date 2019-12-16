Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F91C43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6920725
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 12:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8JTE77L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLPMJu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:09:50 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34243 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfLPMJu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 07:09:50 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so3954970vsf.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2019 04:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9c+fnPnsRk6SiwgsZ0toGXW5TY3Q9XMVKo/pWnhpN4=;
        b=I8JTE77LApKuanmaH0xzwtdhHr20SXpZBPmkEIAFYk/2eHJuPDF6GVzbW3M643slCU
         u0gjtPxzvU5WKwwicP25cpSVQ/BPjvlZGTUbTYXS/AzL7MFYi54tu0cSmQpVlpfD+eaE
         zwxyj3XFRcYX3ld6Vv+OklL3dXKFbA4M+FCCrxfLrmXVQUqjh5xIdLlPX/2hs2C6/k9C
         m8+2rDeH7Eh7zPhvOTCJQVseej+Vk2v7KZE8jxO/1lQkMyYMqw2xf0V940dqd2egYquI
         M3y3HALux4STziCbll12ARmjtn0YpTB+pdVY3XgZmEjVXCixIgmxq6FN/WielbvACzln
         DHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9c+fnPnsRk6SiwgsZ0toGXW5TY3Q9XMVKo/pWnhpN4=;
        b=ODp9ig+/boQ8QRrKjEc4c4mwNJWYPuadUnHHJxbneaPIcdCRuF6ZZKBrCm/0oh1FZH
         YaHV62kn16k7lRBvJTjntNb4wL5E+ex+O0WqNwB15gQr+cJ76htPhTRytBovwd6k9RGx
         GXa1UDm2QX9Kgth+Q3wl7nX/ZqIziLRf8iLThMVU3BRszIO6BGU6DLID67wfLmLVjsMI
         kNKyTyVtoc44Yhuwe0JOCYDwzCXIuy2ekZika/VhXqlNFfcg+ofodYMDY62ZAcTl3kj5
         48SUrDizmIUauW42bXyh3e63KbhDOax4i6U1o5MU+M2iEli3yoDxOn16o4LQAT8pHSVM
         4IaA==
X-Gm-Message-State: APjAAAUty96SmKlp6rHgvX9l4OcWjNvjj7fDqDB8VuGzz2BJXqrkKYKa
        Wc2fMH2wo6GGHIXRd4ynXTkVuPQZVngK0fJ/uAhvXQ==
X-Google-Smtp-Source: APXvYqxF/1PC0JPvjLVA8Zwq8Uxye2doG5S83wznVhgfLyPeqKtQ62N89D/SnrRKbX2GGDQyjNSSt24Lw0p5ZrjG2Xo=
X-Received: by 2002:a67:f499:: with SMTP id o25mr20031111vsn.165.1576498189601;
 Mon, 16 Dec 2019 04:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20191204152749.12652-1-linus.walleij@linaro.org>
 <CAPDyKFpECpWLCwvyFP7zeAmrOA4VK+NxPhc7jqvpenUKkgjWxQ@mail.gmail.com> <CACRpkdai6FwgwD7+BeF0_ORw4P1hoCv4dvoi_Uhyp21t5qCOjw@mail.gmail.com>
In-Reply-To: <CACRpkdai6FwgwD7+BeF0_ORw4P1hoCv4dvoi_Uhyp21t5qCOjw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Dec 2019 13:09:12 +0100
Message-ID: <CAPDyKFotLu_SxpKEPBWgPjrR0+57Ou6VRL=egPGvJVMSr4vCGw@mail.gmail.com>
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

On Wed, 11 Dec 2019 at 00:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Dec 10, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 4 Dec 2019 at 16:29, Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > The code in mmc_spi_initsequence() tries to send a burst with
> > > high chipselect and for this reason hardcodes the device into
> > > SPI_CS_HIGH.
> > >
> > > This is not good because the SPI_CS_HIGH flag indicates
> > > logical "asserted" CS not always the physical level. In
> > > some cases the signal is inverted in the GPIO library and
> > > in that case SPI_CS_HIGH is already set, and enforcing
> > > SPI_CS_HIGH again will actually drive it low.
> > >
> > > Instead of hard-coding this, toggle the polarity so if the
> > > default is LOW it goes high to assert chipselect but if it
> > > is already high then toggle it low instead.
> > >
> > > Cc: Phil Elwell <phil@raspberrypi.org>
> > > Reported-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Seems like we should add a stable tag, right?
>
> Yeah I agree.

Alright. I have amended the patch to add the tag.

Kind regards
Uffe
