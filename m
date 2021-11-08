Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6924C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C326C619BB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhKHUEd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhKHUEc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 15:04:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA7C061714
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 12:01:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b15so47858946edd.7
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2021 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC7iBqJW1E9TnpQ1uBnuIKH8XymcaerC1Chr1eaKswE=;
        b=MR2b77pFp/RULoljKlfL/ze9zs5V8AoGkmeOg8+PgzqIEv54cJigFrDiwibz/Hr0BL
         5WBc4qstuKm2ba4nG8H1dzRzHc75XZ18ZL9SwUdwnzYRukHTQrMiaUk4m8GDMUmN5biZ
         ZFE/esjMojBXcmoqJUixJU962e8ZfyNCQQ+3pOASDqmC3ChoWDkFREGrBtV90FpIv03v
         aGMWIoxZkKWl7Borb/a1DuG6y3iz/sHW2gJbohrXNUnYedOBAN2Q+dVx33DtopzCE6UN
         yhcAXvbW49/lfVVzk8sUi8ziShDrg8XeFY6Siq1H1zfHFDzIxdCOR3rQn0InQKTQV4zN
         8n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC7iBqJW1E9TnpQ1uBnuIKH8XymcaerC1Chr1eaKswE=;
        b=WmaoDq8mUeOKrEAdUwDUDO3BMfALX1oiIewEuVsG0UfMG6aBf4dQuP+29QdYOqaeHX
         9D+oY6aEALNMS1aSHe++7UwoHHlU4PYrgJ9zmg8GDXG9oXcFnTAR94taOvv2zo1R/FPc
         l4LM3mXu6ECfve0V0Aa1QLF7DLpAQHj4VPJwZbF33GG6jPk3KRWOpuiabl4jPJWVGr1I
         VP+bMesWxS6yCgBu1utukaaPIHh3WnSi7lFRQgcNPFECKXgB3/YBNybzbKd/fqjcME4K
         Dm4G8y778nkXqwAR+Fmro4ZZ/f4Y4Vhk6CLEumKhGAr0r71x1iCzKP2Sk616amvg6kvl
         5Qaw==
X-Gm-Message-State: AOAM531Q84HKhohjjOpZ7wXyzdt3hl6uCFndE7FwRa7t6oDdY27HoPiq
        CKNL5ke0o6eDz/kNAXHAxUI0Tjb9zeAaNNYeyloACg==
X-Google-Smtp-Source: ABdhPJziBcog/9TPjwbG/ZnN+mAUxWZYVP+3hLOcUxtkIOopkTmFCKpeALN2UTcbadopRFqsjTQx7nNu5czXA7KfX7w=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr2295916edc.170.1636401706425;
 Mon, 08 Nov 2021 12:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local> <a20805de16e1196c2ed46dd949473c9a@kernel.org>
 <CAK9rFnxH=DtC9vEJJCXkGEWjvg2E8vHPUcRy9rJpo34Furtmvw@mail.gmail.com>
 <87zgqi96nh.wl-maz@kernel.org> <CAK9rFnz6X3wR6bMPkVicGoqj+prm5OmY3y3B_8Fc+WGJxcVsXA@mail.gmail.com>
 <87lf1ye84p.wl-maz@kernel.org>
In-Reply-To: <87lf1ye84p.wl-maz@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 8 Nov 2021 12:01:35 -0800
Message-ID: <CAK9rFnxYH2V5K8xKLAExJA7CFip8p6shsdDHa4SrnRo5Y9-CJA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Nov 8, 2021 at 11:54 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > The Elba SoC is an embedded chip and not intended as a SBSA-compliant
> > general platform.
>
> This has nothing to do with following a standard. It has to do with
> following the intended use of the architecture. What you have here is
> the system architecture equivalent of trusting userspace to build the
> kernel page tables. It can work in limited cases. But would you want
> to deploy such construct at scale? Probably not.
>
> > In this implementation the ITS is used to provide message-based
> > interrupts for our (potentially large set) of hardware based
> > platform device instances.  Virtualization is not a consideration.
> > We don't have a SMMU.  Interrupt isolation isn't a practical
> > consideration for this product.
>
> Because you have foreseen all use cases for this HW ahead of time, and
> can already tell how SW is going to make use of it? Oh well...
>
> > Propose adding a comment to the dts.
> >
> > +                       /*
> > +                        * Elba SoC implemented a pre-ITS that happened to
> > +                        * be the same implementation as synquacer.
> > +                        */
>
> Which contains zero information. What you really want is: "We have
> decided to ignore the system architecture, good luck".
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

On the contrary, the confusion of using the existing driver match
"socionext,synquacer-pre-its" is answered, why add new code.
Looks like we are deviating from the norm ;-).  I'm not seeing how
this conversation is a productive use of time for a platform in
production.

Thanks,
Brad
