Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDEC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jul 2022 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGDGlz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Jul 2022 02:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiGDGly (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2022 02:41:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA012AEB
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 23:41:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i18so14096560lfu.8
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/xTCR3bPZhCA5sareIciLVpBb/bwWDoIGGe6Kd1Xv+w=;
        b=hgQHadGcMhoSH3Ca+juWM9mdx+9fCV75IphGlK+HJdtR/i4gx0B7DBiSaWAmruJgky
         D5xJhDtEImx0KCaWYul6S2UI0l56gLyu/L2gfxXpYyyLViA0B+BzCqsOb5LdW7yYxgRY
         zomyA/I6drlF9k3MnBfvnwDBxzhIVjqjRO/XpFuMZw3SfDzT/E9ae45pUSaVnnMeaQXX
         h1608xxX8865Hs5cUomfWii/90I/TKFVtzHZ7K4NCjn2m0G/NSVvh5eqOAthC8KKoqCj
         fAnkRgUlcScDN/VdI3HAbv8MD3ewJPL/5lcQOzqfbHsr/Xc36HS9JGw7ymJLRwY5TuKl
         +/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/xTCR3bPZhCA5sareIciLVpBb/bwWDoIGGe6Kd1Xv+w=;
        b=LnGOEYsHqjkTEWahOW7IXnNwYRhP6kE4lyPOPg0z21z9+N84bLuPvQPWNVnsZczYwC
         RKxTwV8aV+qSbweLZBrQpD7jG8bh9/ec26OQoiiHYpD+hy7HXp72w3w5V59+QY5Mcmvb
         9J6roumwnJFJjYqk0iEWtXqISrTIO3fhFUjB7yjjDRElyfWWkYvOPnQdbkvDofChmXSQ
         jN5tl37adVq/AsLw4TGrlWIMUOQCRP9Yp8v78dD//wZNGq06J3ol6dw4nfneLJIoOG5A
         ARmTn9EIklK3P8HmWFuGVRgMTdLbiRyPu81I9F7eKW8T0j3jReptjWzDc6fMqHFZ3gx6
         vWMQ==
X-Gm-Message-State: AJIora88Z4BoAhSy7KDvAOrB4pUS1zAZYHRKV+gKdBke+2ia51Q7NnYg
        Vh3sz+2OhpXjG0N/p5EV68dmVA==
X-Google-Smtp-Source: AGRyM1sSTc5DqVbACUPJW4eop8W1a9JW3DaH/3CvqzBZHFAkvYeJJp4gMOetKPepfi26QwqTyXrr/g==
X-Received: by 2002:a05:6512:3085:b0:481:182e:a06c with SMTP id z5-20020a056512308500b00481182ea06cmr17866385lfd.374.1656916910911;
        Sun, 03 Jul 2022 23:41:50 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b0047fa02cd96csm4994687lfo.162.2022.07.03.23.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 23:41:50 -0700 (PDT)
Message-ID: <db82fe69-8caf-f142-0714-ff73ea6f65ec@linaro.org>
Date:   Mon, 4 Jul 2022 08:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-8-brad@pensando.io>
 <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org>
 <CAK9rFnyRgj26MaurS_u83wnzgmq+18=UdZT_FLLZc3jnWD4uFQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9rFnyRgj26MaurS_u83wnzgmq+18=UdZT_FLLZc3jnWD4uFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04/07/2022 01:50, Brad Larson wrote:
>> Missing file:
>> ls: cannot access 'include/dt-bindings/reset/amd,pensando-elba-reset.h':
>> No such file or directory
>>
>>
>> Send complete bindings, not parts of it. Did you test it? I am pretty
>> sure that this did not happen. :(
> 
> Its in patch v5-0015 with the driver

Header is part of bindings, not driver.

>.  I'll check this, the correct
> approach should be put all binding changes as individual patches up
> front or there are exceptions for new driver.
> 
> $ cat v5-0015-reset-elbasr-Add-AMD-Pensando-Elba-SR-Reset-Contr.patch
> | grep diff
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
> diff --git a/include/dt-bindings/reset/amd,pensando-elba-reset.h
> b/include/dt-bindings/reset/amd,pensando-elba-reset.h
> 
> Yes, tested it with the following and no warnings or errors
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/amd,pensando.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> 
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/amd,pensando.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

So how this test could pass if there is no header file included in the
example here? Are you sure you tested each commit separately (like it
will be included in the kernel)?

Best regards,
Krzysztof
