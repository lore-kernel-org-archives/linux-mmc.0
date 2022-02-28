Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B423C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiB1Jq6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiB1Jq4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 04:46:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9169CF3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 01:46:17 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C2DBD3F170
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041575;
        bh=kx3KwflhSQCgPfG7GHkNt9DIyHPaoaEcSwFWIFUDpTI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rwdvWQaKfYE0WPA7FVxo1nNoXW7QEg4HBaqb1eTa7MmPwRKXUKzmxQwNIPN/aGHIc
         BVcy++fbcUq9yhspprHBgCK0ctQswXr4mSW9wFdUjU3ptplR+XRPcl5z4pbq61+Rj3
         YrYcB89zF34A4BTALMogn/ZwpDwV2yhGGG/kClG2JMtIlMI7rI7/QLEDyTiNs3aFEp
         0StR5hfsej+fNzTRv3O582QKi4JFhNojP4MFQQsTtjcRNr75IlGwetIR5XWJQNdoaY
         /vavjPAGgc9l3I2DZX8P/nsFhuDoaH7lxzGDhHFhkedkx7XPoOnvqvwvX2BBDrPH/q
         rrkAXOh0poosQ==
Received: by mail-wm1-f71.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so6169236wma.4
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 01:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kx3KwflhSQCgPfG7GHkNt9DIyHPaoaEcSwFWIFUDpTI=;
        b=ljUi2iE0gJczwbKM6rHyXDlrhn5WHBmCaC7I2Gr5oXUkg89kJbpqs3JhxGSyUIzF90
         14IlrDpv646/mR4kY1sz71lkmlnhbfdCytZj+XaRGi0Anbg1OUhlZb7Qytn/Lzc9zXyj
         zvTOZHIv+6PTBqpg83GpvnbI6wHcrsIBLKqpI/+gDwvkWG7Rw8G4STRX9NZyV2yCRPZh
         5TKGt1gF2f3eJPINRxv/geFuP2MFOCWpCCfLEraOtEMMkleaNpm1+h9yuPPhyFvYQFUv
         xf535ZpdUE+7OCz62nxmabMltE/LhmBud7XS/lsqDOcmpd+IKp8NuZM5YhKUu3KCbdWu
         bw1Q==
X-Gm-Message-State: AOAM533x9cgCpXxNvboJCubqi4bUizBvu5s4OIb3BF582+JbF53q0+ub
        U2ekX00/Bh4Zo1b5VsXBmXk/Vy7l14Lqurld4iEy5uRq5Psl62THXxkxEvOOp7BfuZ4XkS6WJ7h
        5NYAxeVvcKkF+jcKfAl+iNjDgXGVurG1OlwsjfQ==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr15225306wro.181.1646041575515;
        Mon, 28 Feb 2022 01:46:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL0JBj8yLIAMajpevQP4oIWnehXfhmFqdOAerH2yff2r6ZgTyrXSY7IhRRUp4jT3ezbYRq9w==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr15225292wro.181.1646041575355;
        Mon, 28 Feb 2022 01:46:15 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n5-20020adffe05000000b001edf8fc0cc3sm9924559wrr.41.2022.02.28.01.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:46:14 -0800 (PST)
Message-ID: <269c748f-e418-8fda-7c50-f15c3e6c604f@canonical.com>
Date:   Mon, 28 Feb 2022 10:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/02/2022 22:23, Lad Prabhakar wrote:
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
