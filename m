Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87932C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKIMeu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKIMeq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:34:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB71788F
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:34:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q9so16559554pfg.5
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1SRVYqSw1BlyTAyOUO2f9GyvglFpWlLdZyegiX8i2LY=;
        b=dxSmSUsBhp39mrZ061eGA6D6c6fiSbuNin5eMh/mkBjQ5eKP1HYDVxdMwBFWoU6PNo
         OPzKJfs9CxBO/3/tZ0+ERFuvyVfx/HEhBECt8DWpzQeiEi7amB7jf1l8lNsx1rzbolQv
         fuJJ51aMO4XcN1sjuoFQB0lROYQ9jDXpplAXAgWR2QhgLK31OVx8wZcwkF42ZXfcNAky
         SG2+fgw79mWb5ss0wC+WzBxugRqzlLRbm40BBCBJykNJn9iKoVm0TJXpeQE+S0SnIv+I
         MTPVSvPpgJPxi7bK8Pa/WAILVdpnP8mkD9zflfoY3UC4BsBRshYDtL0LU/a5UBR5ge8j
         iWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SRVYqSw1BlyTAyOUO2f9GyvglFpWlLdZyegiX8i2LY=;
        b=8PrN77QK6ZCMdHjr/h6lBFHBWlFUj4nMMJWky00EB9UrgVXe+xgsSTqjVyeAmxWQOl
         kcPQUq0NSvwGKAEnS7cScViTRywkjdHheXlmaACZ17c3mk88nDrYuZsUg0HwTfC+EmvL
         pL5ZfmZrbvCYJuQnp2nvY9iUJBKnPiB+f55Ntehgc0fSLhLB7PBoujc3MwnG3mro5n9O
         EELliTutIaX7adiihl9V9wMiWzFfgr5nT+rISheUFWHg5aiFfKMCVjCkttDQJuazY/xE
         MxnJPQQUAgmjJHUOPMixvqs+Ae5+BfhGrHqJK+qbzdZIgsD4QBJ+dDiQoNi3Dr2WwlOz
         q5fA==
X-Gm-Message-State: ACrzQf2mHE5D2ITX5RFP3xE0SbpaS6hTL9pzmU0eAJQjefF6MuUBVQda
        1u5hQYtCh6X688T9lYVRBhdBTzPVpF00pDfYpfSdkQ==
X-Google-Smtp-Source: AMsMyM6ZU5ESHEtxsXXMaDBmFrcveCgizXWWxdQhAFHhVPogn1qvvU/1SmpprSects1Z3ISdUfIsH/Qg9cHrgi95DJo=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr53525795pgk.595.1667997285975; Wed, 09
 Nov 2022 04:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20221108041400.157052-1-jagan@edgeble.ai> <20221108041400.157052-3-jagan@edgeble.ai>
In-Reply-To: <20221108041400.157052-3-jagan@edgeble.ai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:09 +0100
Message-ID: <CAPDyKFqtgSedouQKMkk0YfwjP21fhyJDwBQg8mhfP4nRY0fEhQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] dt-bindings: mmc: rockchip-dw-mshc: Add
 power-domains property
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 05:14, Jagan Teki <jagan@edgeble.ai> wrote:
>
> Document power-domains property in rockchip dw controller.
>
> RV1126 is using eMMC and SDIO power domains but SDMMC is not.
>
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes for v7:
> - new patch
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 95f59a5e3576..c7e14b7dba9e 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -71,6 +71,9 @@ properties:
>        to control the clock phases, "ciu-sample" is required for tuning
>        high speed modes.
>
> +  power-domains:
> +    maxItems: 1
> +
>    rockchip,default-sample-phase:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> --
> 2.25.1
>
