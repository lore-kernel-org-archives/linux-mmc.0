Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D30C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E276127B
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhHXOfI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:35:08 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44649 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhHXOfH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:35:07 -0400
Received: by mail-ot1-f48.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so38084960otg.11;
        Tue, 24 Aug 2021 07:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjxpAdrXRiBgSjXIV19OMMUSDjglkcpFQ3o1vBWTrBQ=;
        b=VFBvHm6DZgAEZ5CNLfR7mgX0Yg13NnNdUww9d0p58+3TjrpM9QULkuQ/VHzHlxxvsT
         JPlr/yUdaOgHUDwTjKziRZUwX/6MXHG8ohnpYrrBo+z8cM2loqgwae2mzutdyUlYlw//
         XRQtbIIxzQLNO972ly0fRW5c/dpKXIjq4n4DndrBVbMQea3Y+axbAt0Dwbp4I5MclOPs
         QV+RnbB4G5tHRPIMLDMyGZeJ7TInAiGHb/YA2L/RPMtkkHj9bamS/CjiSQVpGfVZDSYl
         fRvreD4UfQdcAnXNMDmT51xG964HahnmC6iXKo0yHHnPEMyA9q0aPrMIMMNlboL9bVQI
         mP4A==
X-Gm-Message-State: AOAM532TMwgxesJsXEXEErKDU3UJ4wz+3BzdFTgAIKyNvMvgFs6s12WH
        YYjBUobaf+4miT0lrQNsMA==
X-Google-Smtp-Source: ABdhPJwuUeEoin7xC064PUAkjPR/fiPbTso7HebfqesbrtSbFz0E3l8nUkrDJS0xNkjYJOC0E639+Q==
X-Received: by 2002:a9d:7a4e:: with SMTP id z14mr18304739otm.366.1629815663246;
        Tue, 24 Aug 2021 07:34:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd27sm1361645oib.43.2021.08.24.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:34:22 -0700 (PDT)
Received: (nullmailer pid 399601 invoked by uid 1000);
        Tue, 24 Aug 2021 14:34:21 -0000
Date:   Tue, 24 Aug 2021 09:34:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Piotr Sroka <piotrs@cadence.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yash Shah <yash.shah@sifive.com>, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/6] dt-bindings: riscv: correct e51 and u54-mc CPU
 bindings
Message-ID: <YSUDbcN3EsMvZOct@robh.at.kernel.org>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Aug 2021 17:44:31 +0200, Krzysztof Kozlowski wrote:
> All existing boards with sifive,e51 and sifive,u54-mc use it on top of
> sifive,rocket0 compatible:
> 
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: cpu@0: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['sifive,e51', 'sifive,rocket0', 'riscv'] is too long
>     Additional items are not allowed ('riscv' was unexpected)
>     Additional items are not allowed ('sifive,rocket0', 'riscv' were unexpected)
>     'riscv' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
