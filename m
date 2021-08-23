Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4DC432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB1561042
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhHWBGq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhHWBGq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:06:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C5C061757
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:06:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bt14so33447384ejb.3
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiGtvvH8NkIVd4hqCUiszMleyUhfYfWw1b6ZDZbLUkE=;
        b=uhWvv9wnJvdEuINozK+RdVuTibj+UvYVWqnvk3DidpO+D6vtOAXbizZtIoU+1RzTmr
         neD6qgJ86ggq3V1tinDW/48juLqA91oBDkn/NB65JOJLHe8ghFOwkQ1zgaxlQMH9WODi
         rt9SNazJrbwjf3VFwt6U5hKEGhpmSs7w4dXX8sSJt472vdiwC3vAF5s/p3iinYjxtwBl
         a9cj3j653TZKo2jXSHjebMJ7KoKkwr3MDOz9cwalouCmaCPDQmETbtb4GGf4v7OOCExP
         B2zmwqQPZYp77TN2JzvGf7JzCIuJYxdNvTcTfjBdZOlLi5LS1YiO9oc0f/v1VUpM86FM
         Bj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiGtvvH8NkIVd4hqCUiszMleyUhfYfWw1b6ZDZbLUkE=;
        b=cl3ngVHvo5vABlb7WTS0+NcVq3OcKp1iW0ph9uMFExDTmwspL7KpotlXXpzCM10eHA
         aSHeeS90hxL3+y5H/eue4sz+AO1rKoXeKR2RMGgDUsu6N+w9Mz6M4F+ult4T0fp24iBO
         UdzxvJ9kA1lRRZRqbqciYpo8GPlF29xqM59IuMoUDELRB8v2zAVNnn4/PWxgX6EikLcI
         aFkJnAW9ziWeOaVjpJSqvopYOvxZXHseo0/gC9tzSiDrCjHMMf9ghae9Gy1ld73ypf3G
         3hGZ6nf5E4BTyUMGI0tEkytJa3BJ4GzVjlINgJaljIdKgS77VAkQDK3jEu6JcDxiGkJ+
         4uQA==
X-Gm-Message-State: AOAM5320k3eSpmUSMxldJ5a4Wt0Ev059+YiC8kAP7oHFOs4xtgNxicAv
        vDJX37s4auNXpHoy35OqYIWIK8hbjhjjGHBVtsJBOQ==
X-Google-Smtp-Source: ABdhPJw9eEJEPtVIYbe2803vRNA11NSXlz157yzpl7w09FqgV8tkGsFwFNzMcmgt5u7Zt114aJklS9Z5BHq/3A2TpJA=
X-Received: by 2002:a17:906:2f15:: with SMTP id v21mr21088372eji.444.1629680763004;
 Sun, 22 Aug 2021 18:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
In-Reply-To: <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:05:52 -0700
Message-ID: <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

On Thu, Mar 4, 2021 at 5:38 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Mar 4, 2021 at 10:10 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Thu, Mar 04, 2021 at 09:29:33AM +0100, Linus Walleij wrote:
>
> > > > + * pin:             3            2        |       1            0
> > > > + * bit:         7------6------5------4----|---3------2------1------0
> > > > + *             cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > > > + *                        ssi1            |             ssi0
> > > > + */
> > > > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > > > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> > > > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
> > >
> >
> > > So 2 bits per GPIO line in one register? (Nice doc!)
> >
> > I suppose the first bit is the CS-pin-override flag. So when it's set
> > the output is directly driven by the second bit, otherwise the
> > corresponding DW APB SPI controller drives it. That's how the
> > multiplexing is implemented here.
>
> If these output lines are so tightly coupled to the SPI block
> and will not be used for any other GPO (general purpose output)
> I think it makes more sense to bundle the handling into the
> DW SPI driver, and activate it based on the Elba compatible
> string (if of_is_compatible(...)).
>
> I am a bit cautious because it has happened in the past that
> people repurpose CS lines who were originally for SPI CS
> to all kind of other purposes, such as a power-on LED and
> in that case it needs to be a separate GPIO driver. So the
> author needs to have a good idea about what is a realistic
> use case here.

The gpio pins being used for the Elba SoC SPI CS are dedicated to this
function.  Are you recommending that the code in
drivers/gpio/gpio-elba-spics.c be integrated into
drivers/spi/spi-dw-mmio.c?

Regards,
Brad
