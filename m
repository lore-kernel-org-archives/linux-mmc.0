Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9528C433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 03:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945AC61490
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 03:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC3D2B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC3D1x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Mar 2021 23:27:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A11C061762
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so22553939ejj.7
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=3iJ6rnxNoJ1aTUrQb8MBityRh32IAoO48UjECVfi4BfI7/zw8eIa5QZsOXEdPj0Ult
         Ty+5a/+z0tH9MGN4pMs0E1CwVUioqhcepi7Lu84N7r0PBy5kF9ickSommc4x+k/a2Q7B
         5E293VfrAtZ/le8pjgcG94Y36E9PUx/WExrGl7fcifPHy0mLzvlaUp7FheK3iZx4EuNi
         xLS+LonWNrdG4ZdbOnJAxJSrspZk93opFaXsRh4zZX/Fj+TzE1GWOpuunFDm3ojdS1fg
         kI34Wh6qDZgX/BJt7lnSbqWQ9Hr7UdJ4czc18A6HG2VK+wbwPnHSNukupFvn+R7FyiIC
         4ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=bLRJGCq851LWS9/SnPOj6VywcgHz9jCbcDmoqJ+jDXfkc6xMTjw1VYzuKIJlee44mc
         hCrzBW2dCeTMUoJGVx5szn9dcHyohLBD4Nc2vFJrSlOvB+EuIiMunyXq+aadcUebGUC1
         4umFkscysBLk4wZgodqhNE1JFGlVhg8snC1dsKCnk35n41XDJyoEVQ023xvifEc4qvS6
         Z72fecsB1rf9AaIsQeWjAxUp+G4nfvNm7NV3iYQA+cc4tfOmbi1qrQV7i9gHSbK2cqKO
         ldWEgIU11T/qb5mOiIdXI1PiZ2RKzZxHP7mv/5j3i0kQXM89cXyNz57uL4nLtxTT6Ft3
         yNTQ==
X-Gm-Message-State: AOAM5323erWF6ZYvkR9vD2eiRdq12WiohiMOvzgE/RTExebghLcLBW74
        sVmYnWxBBoL/81CpK/tOhgldf5Jny9MkC8nKQgs4jw==
X-Google-Smtp-Source: ABdhPJxJVT4ikpn8Ll3+BLlxrg5DXp62plos3RcvXhSBKDJOAEk7g5/fDnEiJIF4vigHrmnSsJ9PwiqWINiWEhcCWS8=
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr30956801ejb.444.1617074870919;
 Mon, 29 Mar 2021 20:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-5-brad@pensando.io>
 <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
In-Reply-To: <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 20:27:40 -0700
Message-ID: <CAK9rFnxO6AUjjihZ3Y+tspUZqCWhNa5BH5EhK2x4mk8FJv0k7w@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] spidev: Add Pensando CPLD compatible
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 29, 2021 at 3:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > Pensando Elba SoC platforms have a SPI connected CPLD
> > for platform management.
>
> And? It's not a good justification to spread the (debugging only)
> spidev interface.
>
> What tool is going to use it? Why can't you have a driver for that in
> the kernel?

The driver is in userspace and we need to instantiate /dev/spi0.N
in the /dev directory.  The CPLD includes a device id and version
id that userspace applications use to differentiate functionality on
different boards.  It wouldn't really be appropriate to use one of
the existing entries.

For example even with high pin count SoCs we are offloading
low speed functionality into the CPLD connected over SPI.  The
elba-asic-common.dtsi file shows a compatible string of
"pensando,cpld-rd1173" which does have a kernel driver we
intend to contribute later if there is interest.  This IP in the CPLD
is readily available from Lattice which provides two I2C Masters
which in our case we use for access to the network port transceivers.
What was missing in the kernel was a bridge driver that exposes
what looks like a standard I2C device to userspace where the
drivers/i2c/busses/i2c-rd1173.c handles the spi transfers to the
Lattice IP in the CPLD.

>
> --
> With Best Regards,
> Andy Shevchenko
