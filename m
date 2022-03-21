Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8202EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Mar 2022 23:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiCUXbE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiCUXay (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2022 19:30:54 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFF103BA8;
        Mon, 21 Mar 2022 16:29:24 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id s207so17878710oie.11;
        Mon, 21 Mar 2022 16:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1eYyatCQZd3YZhjNaHOmfvqTN+inYRTrGVc7sx+pnE0=;
        b=vx9rowa71MxgcnZ81TJjYpYDWCUUzsLwdqVKMb0f7+rF92by4+WaxUO+cGH9aviKqG
         8oNwtvre9PU6sxg6XOnG1sAi8qT2qzsHl6M+EwVnChTDlzigInAncwOSH/iFsg2QQCc3
         RunTUnQbI+eZCXH7Jli0AvYIICYn2QXH+OuILwogC7EHcqiwKRegvvdecTvvUrCCyhOF
         rYKyKuPJw0Mtpq1sr1mFkFOio+l4EmTZfQWOE+LiXduFaxGwdHo+4T6SH4RC8l+DRKW1
         7Z1I4iwA0/mRscIsgARmYM6HCZLIWFbY9zbw1VUXLpGpdHPs4mUBF1cGn6S96NkXuSaf
         EpwQ==
X-Gm-Message-State: AOAM531AzWKbWZZ/l1i8jqjczaAs2C0wOGR6f47fD44d67zs+1hKdmYK
        A4n4YjiokL/yKcAXvYiK4A==
X-Google-Smtp-Source: ABdhPJyL1wG4H9T4Ik1hQtcDoVEUgVmKOxTNyJ47cLWpAoUJUz0YuC27Z4XHCxLH9HKrwTpQSKukJQ==
X-Received: by 2002:aca:59d5:0:b0:2ef:2125:ec15 with SMTP id n204-20020aca59d5000000b002ef2125ec15mr841064oib.4.1647905364052;
        Mon, 21 Mar 2022 16:29:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 4-20020a056870004400b000dabe0c435bsm6809638oaz.7.2022.03.21.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:29:23 -0700 (PDT)
Received: (nullmailer pid 744835 invoked by uid 1000);
        Mon, 21 Mar 2022 23:29:21 -0000
Date:   Mon, 21 Mar 2022 18:29:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <YjkKURNzg8JPbXcg@robh.at.kernel.org>
References: <20220321115133.32121-1-axe.yang@mediatek.com>
 <20220321115133.32121-2-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321115133.32121-2-axe.yang@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 297ada03e3de..f57774535a1d 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -69,12 +69,23 @@ properties:
>        - const: ahb_cg
>  
>    interrupts:
> -    maxItems: 1
> +    description:
> +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> +      interrupt is required and be configured as wakeup source irq.
> +    minItems: 1
> +    maxItems: 2
>  
>    pinctrl-names:
> +    description:
> +      Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
> +      will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are
> +      mandatory in this scenarios.
> +    minItems: 2
>      items:
>        - const: default
>        - const: state_uhs
> +      - const: state_eint
> +      - const: state_dat1
>  
>    pinctrl-0:
>      description:
> @@ -86,6 +97,16 @@ properties:
>        should contain uhs mode pin ctrl.
>      maxItems: 1
>  
> +  pinctrl-2:
> +    description:
> +      should switch dat1 pin to GPIO mode.
> +    maxItems: 1
> +
> +  pinctrl-3:
> +    description:
> +      should switch SDIO dat1 pin from GPIO mode back to SDIO mode.

How is this different than pinctrl-0?

> +    maxItems: 1
> +
>    assigned-clocks:
>      description:
>        PLL of the source clock.
> -- 
> 2.25.1
> 
> 
