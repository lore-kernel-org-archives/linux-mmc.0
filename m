Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F1C433B4
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1439D61177
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 22:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhECWlz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 May 2021 18:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECWlz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 May 2021 18:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61CC461177;
        Mon,  3 May 2021 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620081661;
        bh=LdKcAT7K/DkFCaR8C88qu25r0RUNHy4L1uLPd9vMTLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMOxt4XTJq8QaONd21MjjLpWV5DQlfdSxxAV2eXl8FbyHRkeJvO56XumU3XpRXF52
         HCr7aVusik/ed/f22iZeKCNMOge1hSJ1T575aWlK43zXUfWcXxieF6EMwaANifIFF3
         MOy8nRIh7V0YNi14Q6o2QnJUMnt1qCU2l9fIn0mL6oxaxjJ0V82WvAgqlsCVnBsW4t
         Vtph0NE+/Hh/ZgQn+qMteKZA8RpusiMn8Ad8w4s/qMvZkjfbO5m4pUCP9CdniQNJHG
         9DkBQCdF9DwlrcLoI/1K3nJKh6vF+PrPB8h77x8YBQhwPRYTHm0vaGhc7jTslAyzWo
         BxzDfLtMt4A5w==
Received: by mail-ed1-f53.google.com with SMTP id g14so8226030edy.6;
        Mon, 03 May 2021 15:41:01 -0700 (PDT)
X-Gm-Message-State: AOAM532dxrh92hkkNBPj1NdRQ3Ryk08EEHatzWOSYbZ1CARXlkKzTWuf
        ATeVNU/wNdnO4RtpjfoHjyFtsdIX3/sds5wuKg==
X-Google-Smtp-Source: ABdhPJyjJlgMbAtLNrpOWXXUCdw8kmlr4Vuzf1SyEuSlHgUsi/v06FB7HcrfsvgPMlZb6Hd+aFb75+cVfhZiRbfIRi8=
X-Received: by 2002:a05:6402:234b:: with SMTP id r11mr22579121eda.137.1620081659993;
 Mon, 03 May 2021 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210430072138.6537-1-jbx6244@gmail.com>
In-Reply-To: <20210430072138.6537-1-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 May 2021 17:40:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnD1t7oRDY5sTi3TjJ0vbFK0tQcVj1qCw_jiOfOQh=mA@mail.gmail.com>
Message-ID: <CAL_JsqKnD1t7oRDY5sTi3TjJ0vbFK0tQcVj1qCw_jiOfOQh=mA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] dt-bindings: mmc: snps,dwcmshc-sdhci: fix rockchip,txclk-tapnum
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
        Jisheng.Zhang@synaptics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 30, 2021 at 2:21 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> A test with the command below gives this error:
> mmc@fe310000: rockchip,txclk-tapnum: missing size tag in [[8]]
>
> With this added to a dts file:
> rockchip,txclk-tapnum = <0x8>;
>
> A look at the driver shows that:
> DLL_TXCLK_TAPNUM_DEFAULT        0x8
>
> Adding the default value to the dts files is not needed.
> Every clock is divided into 32 taps equally and
> the max value is 31.
>
> Fix rockchip,txclk-tapnum property in snps,dwcmshc-sdhci.yaml by
> adding a minimum, maximum and default.
>
> In the driver the function of_property_read_u8() is used,
> but with dtbs_check the notifications only disappear in YAML
> by changing uint8 to uint32.

Did you check what value the driver sees when you put 8 in the dts. I
expect it will be 0 because you are reading the 1st byte in big
endian.

> The driver has no limit check for rockchip,txclk-tapnum.
>
> make ARCH=arm64 dtbs_check
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index e6c9a2f77..f43d8d829 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -48,7 +48,10 @@ properties:
>
>    rockchip,txclk-tapnum:
>      description: Specify the number of delay for tx sampling.
> -    $ref: /schemas/types.yaml#/definitions/uint8
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +    default: 8
>
>
>  required:
> --
> 2.11.0
>
