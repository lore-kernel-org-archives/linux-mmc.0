Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3064EC433EF
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGCWGW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiGCWGV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 18:06:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00E2BCE
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 15:06:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so4470648wme.0
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GB0rPcTuyggFQkhdOXa3MFwri39w7WiRZTZosC3+8Ng=;
        b=ubTvbNAH5s9i9b2BdIA5DNIveZqIBluECh3vBwr2R4xs+kFmy8Qu2mvZRtAy81NnnH
         OYwWdGC4bzoQvSz4wi0DCboNFX/8xqwCjVmBvRFSd8l8lJ2uZBYqwYYWMv9wrKhxk2aY
         EbLPuypxAONB3TQfIlHgsr681wqfKAVxWK+ovKxM2/iW637jkKwbwEnBwBB8vlAqD/xN
         3Nh2NrgstHy8Sda/cc7JgNwH7ipQrQhIhy7I+RP9/QUVcOA5pCcwCgzdTpWEKpgMfNFH
         eTYNWL5KDwx3jiFKeCzAioB/okjQdD8xGMZ0S9fycXd/tvoaX11fHSe2nyMfr5oW0n0g
         qCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GB0rPcTuyggFQkhdOXa3MFwri39w7WiRZTZosC3+8Ng=;
        b=eZggpFmw5sJFC9YQcq5S8ra5vPSX3YiiG3vrZANn+7nkdOtEqnce1IHqCa6cVj0ukE
         2CNpptRAG82cB0anUXEyeTwYSvwMU3dVYGdTyTuw7muVf6Qh6aMMuERJBSxr2wm08kts
         2M1NTBykoX4JvABFDWyjqwE8mTg9KRCJFa/3w3akr28DX1qh/iV/rV5cO8pKXRmPEW37
         W8oYG19Lmg58XTgAeOaDtoYiYDvH4H3JGCq7R0ey80Qlxds/N/vNIwgZGVpGrJLICPWb
         C16TTA7rJxSmjFcr2G3sK5OBKBY9iU/3VZWJMworZ46m2aoHJoFvxH+C2xfbP0Hr0wBL
         +S6A==
X-Gm-Message-State: AJIora94ClM5VEX74iQ+v2/+1bIPzAQH+EmDluRmJD8E+tSuciRXUvLb
        b4sLOUnH7qw5OKibfJEN7rFDCNpiTsVcfhHPhGIhiQ==
X-Google-Smtp-Source: AGRyM1v3HVAIU+LZ5TyTPDTD5tjgC2sVLrvdGctHfUt3z3T56rx2wbD/vOO4qu5hXM0Cqmm8wahz56yjVRjLFRwzjbs=
X-Received: by 2002:a1c:6a04:0:b0:3a0:4ddc:9a4b with SMTP id
 f4-20020a1c6a04000000b003a04ddc9a4bmr27166927wmc.78.1656885978612; Sun, 03
 Jul 2022 15:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-16-brad@pensando.io>
 <CAHp75Vfrgw4sf7itQ-RVjNTNOrO95YeU9ugZc9sbBUYrpda5eg@mail.gmail.com>
In-Reply-To: <CAHp75Vfrgw4sf7itQ-RVjNTNOrO95YeU9ugZc9sbBUYrpda5eg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 15:06:07 -0700
Message-ID: <CAK9rFnwPd+qhSaMp5eGdGq-UnfY-D8_kYYvbHaZU=pUtBMuaNg@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Andy,

On Tue, Jun 14, 2022 at 4:47 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
> >
> > From: Brad Larson <blarson@amd.com>
> >
> > This patch adds the reset controller functionality for the
> > AMD Pensando Elba System Resource Chip.
>
> ...
>
> > +#include <linux/mfd/pensando-elbasr.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/regmap.h>
> > +#include <linux/err.h>
>
> > +#include <linux/of.h>
>
> There is no user of this header. But there are missed ones, such as
> mod_devicetable.h.
>
> Keep them ordered to easily find such issues.

Removed of.h and added mod_devicetable.h.

> ...
> > +       ret = devm_reset_controller_register(&pdev->dev, &elbar->rcdev);
> > +
> > +       return ret;
>
> It is simply `return devm_...(...);`. Looking through your patches I
> can tell that you may easily drop LoCs by 10%. Please do so in the
> next version.

Changed to return devm...(...)

> ...
>
> > +static const struct of_device_id elba_reset_dt_match[] = {
> > +       { .compatible = "amd,pensando-elbasr-reset", },
> > +       { /* sentinel */ },
>
> No comma.

Removed comma

Regards,
Brad
