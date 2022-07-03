Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AA6C43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiGCVF5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGCVF4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 17:05:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61C5F7E
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 14:05:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so10763438wrd.8
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M2WNab/3Dmg4ZgDzZWodPWwNs9gK2nW7vivk0r35wg=;
        b=qkSJKlPM/Y+LP4AwHgAjRaQiCcGYdC5drro3uQPRSPtk2lJGe0mWE3TYmYgDXofy6O
         RNnl1A+8+J77swOghtW+B3e9CUyvJgPwLpJmSwzgALWMG9T8HHSjjL71iG92T2mLIYU8
         7ChIrMCAMpMz8DhryJZz/+181IDb7DNnzBU+vBD6Jww3kENaAoLYki+F8Qbru8E5MVWd
         C0hi23ubPm95i5QR22d0F/e5BVraMdxQW5d0UisWNWWZIIIGpGJ9cZ+j4LnFi1qA74PQ
         z0IeEKAXgoXSxvKikqOfQQmpB9Xzbu2XqVU0D3n8kvsccMyucXrvMVrLjdf2DSm1OCJ3
         MmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M2WNab/3Dmg4ZgDzZWodPWwNs9gK2nW7vivk0r35wg=;
        b=nPM8Q/pa4PI/+xM4Adq8w5sBBiJZ6rtyL+OVVzSvojrX+It55bP0kuDL8rafS7uYdI
         /p7+PFCWWYgTeiWb5vi/w90+9TWxXgriHZsT+5lTFVL3rrm2ygE6sqodzFEbnCtXK5hX
         P5HsxXkv5Hlwh4BRY8nfHulBrFytu4IYuR5v2DOP4cZWkTe7bFJrti7E9kdMTIA06i2g
         Flgyzq7DKz7/RY9jfK+NznrstzNyZceNuwHJGcKQuLEnIWeu7hEimSnrKK6+B7Sj1HIR
         VOMFiR7KaM/t97HnfOSWp4WeZZBcJiHbCgjb6sGzN2/FQpTA1Bf/gX23L6NH4gEv+zwc
         lUhA==
X-Gm-Message-State: AJIora9qmJdH/Gurt3sAZaskYo2FHh3UlTHKa4jFIlZut8mGpOMt6Odf
        8lxUMMP2zjATeOhGGwWxS9uQMRYZGKHEC7q9SpW5Lw==
X-Google-Smtp-Source: AGRyM1sqRXh7+fnSdDsSPaBVeh45gia04bWxnifN90eaCRsZKfzusUMTYq9RvqMbWslUsPnHiRwkLPmZ93VF6ubeX9Y=
X-Received: by 2002:a05:6000:2a2:b0:21d:1e00:c198 with SMTP id
 l2-20020a05600002a200b0021d1e00c198mr23164612wry.520.1656882351066; Sun, 03
 Jul 2022 14:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-12-brad@pensando.io>
 <20220614084849.oodxh6cthysga5iq@ti.com>
In-Reply-To: <20220614084849.oodxh6cthysga5iq@ti.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:05:40 -0700
Message-ID: <CAK9rFnzUGrdahqKM8DDx9Xo-v4Tqs086XSUoHf6wS2fbqK2OHQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD
 Pensando Elba SoC
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, alcooperx@gmail.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        p.zabel@pengutronix.de, piotrs@cadence.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>, will@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pratyush,

On Tue, Jun 14, 2022 at 1:49 AM Pratyush Yadav <p.yadav@ti.com> wrote:

> This is needed for TI's SoCs as well. APB and AHB accesses are
> independent of each other on the interconnect and can be racy. I wrote a
> couple patches [0][1] to fix this on TI's fork. I never got around to
> sending them upstream. It would be great if you can pick those up. They
> fix the race in all paths, not just indirect write.
>
> I would also prefer if we do this unconditionally. I don't think it has
> much downside even on platforms that do not strictly need this.
>
> [0] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=027f03a8512086e5ef05dc4e4ff53b2628848f95
> [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=4c367e58bab7d3f9c470c3778441f73546f20398

Let's get Elba specific support in first and then in a separate patch
go for the unconditional.  An extra op for devices for which its not
currently done will result in questions I can't answer.

Regards,
Brad
