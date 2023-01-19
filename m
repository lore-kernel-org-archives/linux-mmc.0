Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA36C38142
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 07:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjASHzo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 02:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASHzW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 02:55:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74366CF9
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:55:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z5so978557wrt.6
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gM43wEQLgXc7iYxlKYVQgdYDwnmNZU4JQnPczIwLon0=;
        b=b1Fti4g4AZ3rT8+wj4E65RWVasV1mrej5WSG3JVfKfDJaclS2crmi5UdeyUsmRyxzs
         xt8fyw37xlUNvXJhB4CYaIYcHeAk9RU16jlI7l6PVoKvbPZj/ZXTcv22PUZu/wbyWs14
         +rYei8blicJoHMCzcuIM/wBFHS6KGsduhwv5Fr5/5oYOD68jjcm1LFA4P3TiUuPsIRA/
         lT14DzhIalGmN3ysc+fmT2qyi4OWzv0eoS7IcpRM4MhP+dn/dVA42iddninp0t0wj9tS
         ckyHYFn5LuU06y/3QehDAZGilE/dBGPgyCsM1RG2oldbAVCawe42kR9SV1gdtOPVewK9
         LmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gM43wEQLgXc7iYxlKYVQgdYDwnmNZU4JQnPczIwLon0=;
        b=PvKKDKPhIdp5637MxsWnfVbOJGk+WFcaizxgLTnvtQoBbAi10PxuZiMLfgugxMnuWt
         VwNJYil8Z3pHar3FEewW8JlqGvLYCT70vqwEpnUhlKCt4DgY1rcoBc7oFPcByIWX9PNj
         UgQIt4KciNX4IZzYA/fiW+nHiael7lZxHGKPHJqjV8PEwHPPNCJCl7Wh1Bm4wHomKRRw
         TztXXtRPJu6IrK9XtGv2oga7URJe8My9tv3ZxLkuokK9B7tvqp5zVMc5ZqfhWOApmNSu
         qm6rTGoCvCwQ/1kmmyTL68e5L7U+ThGDdK8bebeON70iF65wR+snjjWj3tc2JZ+HbVQL
         gCdg==
X-Gm-Message-State: AFqh2kpZ4MOQOtnAoDXzW3IOPZZ6+B8xa+TewJESMLmJ1Xnr8q+DsOUB
        CYhFZCYvShPaqNaES9c9/y5J844Q2780fxFi
X-Google-Smtp-Source: AMrXdXtxCzddJ784bjC/VjJEHalhartMsYDOY/IU1u1dY5HMLigZ7vzIiVT5kTDWKNUIyxY/beaRZw==
X-Received: by 2002:a5d:4e50:0:b0:2bc:6b8e:2a55 with SMTP id r16-20020a5d4e50000000b002bc6b8e2a55mr4044903wrt.27.1674114915701;
        Wed, 18 Jan 2023 23:55:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d678d000000b002bbe8686d6fsm33445715wru.117.2023.01.18.23.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:55:15 -0800 (PST)
Message-ID: <322383a5-5c2b-a1e0-d14c-6c038085301d@linaro.org>
Date:   Thu, 19 Jan 2023 08:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-5-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119035136.21603-5-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/01/2023 04:51, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> Changes since v6:
> - Define property amd,pensando-elba-syscon
> - Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi
> 
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d33b72fabc5d..96b072835de0 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,18 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-spi
> +    then:
> +      properties:
> +        amd,pensando-elba-syscon:
> +          $ref: /schemas/types.yaml#/definitions/phandle-array
> +          description: AMD Pensando Elba SoC system controller

And nothing here - neither in commit msg nor here - explains why do you
need it and what is it for.

Define properties in top level "properties:" and here only allow (:
true) or disallow (: false) them.

> +      required:
> +        - amd,pensando-elba-syscon
>  
>  properties:
>    compatible:
> @@ -63,6 +75,8 @@ properties:
>          const: intel,keembay-ssi
>        - description: Intel Thunder Bay SPI Controller
>          const: intel,thunderbay-ssi
> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi
>        - description: Baikal-T1 SPI Controller
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller

Best regards,
Krzysztof

