Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AFFC6377B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207ED60FE9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhGUTZw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhGUTZv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 15:25:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849DC061575;
        Wed, 21 Jul 2021 13:06:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so551855pjz.3;
        Wed, 21 Jul 2021 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AaS5KY/bo1OIoNKCjxhZJGyqFcDDWuLo00WRrLsa/Y=;
        b=Mg3/Rj5afIxOy+l05SmTRU7jEajYS0jZmYJdGL4IuakOsiEyy/ILv3wOdeEfSRjdhz
         jujfRnMRvlonm31+5pgem11mGp6yLoJeNMCArJg1A9eRI0l/G3+8Rk1QhfTlWTvcTxAA
         onCPNG/YGfZuvvHJMEpFxezxdQZw8IMX7SrqhLW9F8VjxObascjceXgqYGegTdpw0SSf
         rQ97XSeV7+MNOEsB86GqMndm65lbCm+JD0WvMQ7IsQgepf3hop3TLJY1Op3b1n6lLIym
         FYainSqflnnHCOe1Do2kiJ/LJCXW2yGkPlDEO5OUsDXOe/zcd6MNDorjd+dlI0ciSe9k
         ZhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AaS5KY/bo1OIoNKCjxhZJGyqFcDDWuLo00WRrLsa/Y=;
        b=F/c1suw2h8utEW5x+JC5cI5SdiH1R2K6yMCTz/LnDPCSrlxo81QVBOxqRehnJKN4Yz
         QyvfPkXL0O0L7DuXA9fUKwLMWHkYZ0lzW9sa1Ef/Sue4ZcFMoTtUMmuUTKQK/wTeM5bn
         sH5q7vBouVU1LlbYJwmlsGs58NE8T7R20zpvRHOmaQaCwpqzoc6GiMK7vARcs46aWcUa
         LVJlyJoIrRrKXmpNqrZwqFQtlWJe5oiBeu/4HiN+4yyVYvRVPvvG5niTSK0O0vzX1WOJ
         Bt0cjWKa3c1CsifSBvHn2NY7iP59qXdGl7LD2TeXdV/MKUnjPeJT/+KkhMgMdlYVPRls
         mIsQ==
X-Gm-Message-State: AOAM532jGJSPpVZgWwFEh6B4KSNrjRiU6yycpEchqBj6nyCwJFSjQRJW
        VZBoH1l5o+rIkrvudQKV943Vagm4woV+c++BHrs=
X-Google-Smtp-Source: ABdhPJzbp8o/mdExhTOAtvDecgv14SGtgQwIBCFnzz8vuEb5lFWK7wToC21bZAGt4lm7WFsyFsXzwjl2xuRxOf9/UWk=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr37865362pgm.74.1626897986596;
 Wed, 21 Jul 2021 13:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
 <mvmlf5z66l9.fsf@suse.de> <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
 <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com> <87lf5zo34l.fsf@igel.home>
In-Reply-To: <87lf5zo34l.fsf@igel.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jul 2021 23:05:50 +0300
Message-ID: <CAHp75VcWfqZLGv9N9k6bUhJ3zyDS=y_L93BcbsbRO=Gsu---Pg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
To:     Andreas Schwab <schwab@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 10:53 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Jul 21 2021, Andy Shevchenko wrote:
>
> > I have counted 89 device drivers in the kernel that have OF ID table without
> > SPI ID table. I'm wondering if all of them need to be fixed.
>
> How does a SPI ID table look like?

Plenty examples [1], like [2].

[1]: https://elixir.bootlin.com/linux/latest/A/ident/spi_device_id
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/tiny/mi0283qt.c#L174

-- 
With Best Regards,
Andy Shevchenko
