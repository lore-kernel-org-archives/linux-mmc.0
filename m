Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F2EC32772
	for <linux-mmc@archiver.kernel.org>; Sun, 21 Aug 2022 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiHUUVh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 21 Aug 2022 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiHUUVg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2022 16:21:36 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4531AF33;
        Sun, 21 Aug 2022 13:21:34 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11c9af8dd3eso10353665fac.10;
        Sun, 21 Aug 2022 13:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=kHR/6wmfR6fjHyTF56Wxh26tOWvFD1gj0BvoOySyPBs=;
        b=AyK/y6TOie4meC28b9u+7gIlG8XUxbqaxvMtTq2WJC/MHuf1riyeEMGb75GatSt6Zf
         O0TkW0kRtZf5CmYkh/rLQr23DBUPd27x0d/HriZ/RQp7eKD35fMTpDYnd41hR6ogZymV
         r5uM6X3gqennRMasZKESsEJmvRH6MZs7hbmKLFyMLrhtPh1ONxauOK3mLpG2NqoP9IDL
         skG9SeL1fnqjjgfZb+A55C4yUFI3Ab7HXQ2EuHyPxumr2BJlPxSLxNRF552w+QP7Lk88
         X7Mn7wtHD06g1YcStaDfDPpjU2Yg9G0dBj1Rt3IMMIsIseTLomcdQUzWP2Hmv8qVe6aZ
         /Vsg==
X-Gm-Message-State: ACgBeo0nmW/AC0RoNfnVbYDMq+lRU/6dZB+7gH+U4i7RgQXU3N4tIWzj
        C0LTxablTtDedFQtpERN9w==
X-Google-Smtp-Source: AA6agR4dNBn7HCgLqySmVeHObrD9TKjx/Hf7tziNj/L0DLNZaljbG2Smhz4+E3PbOq86WWLQXNaLBQ==
X-Received: by 2002:a05:6870:3282:b0:11d:10ad:a85d with SMTP id q2-20020a056870328200b0011d10ada85dmr3090979oac.181.1661113294253;
        Sun, 21 Aug 2022 13:21:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a0568301e6300b00636d6571ff7sm2529660otr.70.2022.08.21.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 13:21:33 -0700 (PDT)
Received: (nullmailer pid 1729154 invoked by uid 1000);
        Sun, 21 Aug 2022 20:21:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        fancer.lancer@gmail.com, krzk@kernel.org, piotrs@cadence.com,
        devicetree@vger.kernel.org, samuel@sholland.org,
        catalin.marinas@arm.com, gsomlo@gmail.com, lee.jones@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        linux-mmc@vger.kernel.org, suravee.suthikulpanit@amd.com,
        gerg@linux-m68k.org, thomas.lendacky@amd.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        p.yadav@ti.com, brijeshkumar.singh@amd.com, blarson@amd.com,
        adrian.hunter@intel.com, p.zabel@pengutronix.de,
        andy.shevchenko@gmail.com, ulf.hansson@linaro.org,
        alcooperx@gmail.com, rdunlap@infradead.org, robh+dt@kernel.org
In-Reply-To: <20220820195750.70861-8-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io> <20220820195750.70861-8-brad@pensando.io>
Subject: Re: [PATCH v6 07/17] dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR Reset Controller bindings
Date:   Sun, 21 Aug 2022 15:21:26 -0500
Message-Id: <1661113286.952331.1729150.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 20 Aug 2022 12:57:40 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document bindings for AMD Pensando Elba SR Reset Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../reset/amd,pensando-elbasr-reset.yaml      | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.example.dtb:0:0: /example-0/spi/spi@0: failed to match any schema with compatible: ['amd,pensando-elbasr']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

