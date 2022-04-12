Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775FC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 12:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353181AbiDLMpf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351338AbiDLMpV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 08:45:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B276655
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 05:10:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h14so26697990lfl.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPnzcyNV3A/4UYBzWHKTKf4kIp6tVvkH+WsDEXjDC24=;
        b=lDM2BhUHoH9Y+RgQ9Bejy2VOEq3wZBs2rmgzsGi+vSzCT9TnP/8p3Wpupm7r3FXUdb
         8tJJOEslIMEHSsBsANKpcplIDLfo2t7FROT/4UUxv3JT5Lfof+D9K6xXjn9GZ0IX18I5
         i5wr6Qmz7ObO0Z+1rOwSjltkoXo5eguNJmHBQ0fa0oyubBBMv3A9dg2++8Ec6PZJ0G6g
         y8bArUarnYMM3yVpAzhImHBpfpz9qai/H6kAyrM6mEe2xFj9adjKuacadXwFgwMhFpvV
         SAPoPZa4ThafUqA6nzvJQrfLxbQOIbgW/dCztPJCl6GvdP3vuHEWyLDxZm7vzyMxUnUO
         qV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPnzcyNV3A/4UYBzWHKTKf4kIp6tVvkH+WsDEXjDC24=;
        b=MerF/OdMEzQ+G2zdey/qQHe0tIuoJpSAostt8X2XJjC6+MmCBsxtR+DLC0MUY169ev
         dH4MborL103H7zgD25DeBARkSIbJdEgkTOYi/riAraHZD1YWuyI2jK2owxfkr020H6Zu
         /tRwESD8tCoaYRA5nBqYjXhywYGLiYDPUO5LUSrwp2Tm0cKDnILm/ecdmpkHFtQi7Kua
         51D1pQvmEdVHQoq10rgpmbNt2ztxnrpv8PXkVYBYqFhF0kq105p27vdF1fpr4nUP9yYy
         f9f5Q1EMmdYpxzVZr9RlhuaSNaZnzr7YzQWBpoYRt3db//QTSnOySWxOd5HHwBKNR4W1
         K9cQ==
X-Gm-Message-State: AOAM533UyxtTJRNv05u6gMWil8S/Xxx9IJSaQY3o8KQyA7wThvskrbgw
        HR7zVbYKfiYmTbdp+E998qKsVVk0jUdc592UI4Lhbg==
X-Google-Smtp-Source: ABdhPJw+QK0ioHa/IORYPR20pHaGiyG//MIdGQmMFH88fHxyhrzPKtKt7GOnvFjngT2GteOSQr2B4Jw9WZ+8GibsNMQ=
X-Received: by 2002:ac2:4bcf:0:b0:46b:ae4d:2855 with SMTP id
 o15-20020ac24bcf000000b0046bae4d2855mr4980780lfq.184.1649765396161; Tue, 12
 Apr 2022 05:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220410193544.1745684-1-aford173@gmail.com>
In-Reply-To: <20220410193544.1745684-1-aford173@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 14:09:20 +0200
Message-ID: <CAPDyKFpWMmteaJ3Afz2TD4ba2iE-0vf4VJ_V-kkEE332OzywpQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc@vger.kernel.org, aford@beaconembedded.com,
        haibo.chen@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <Kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 10 Apr 2022 at 21:35, Adam Ford <aford173@gmail.com> wrote:
>
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
>
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
>
> Mark the current state of the fallbacks as deprecated, and add the
> proper fallbacks so in the future, the deprecated combination can be
> removed and prevent any future devices from using the wrong fallback.
>
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> V4:  Mark deprecated items with "deprecated: true" instead of a comment
> V3:  Add support for the interim fallback on imx8mn and imx8mp where
>      they both fallback to imx8mm, but keep the imx7d to prevent any
>      breakage.
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..58447095f000 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,22 +34,46 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mq-usdhc
> +          - const: fsl,imx7d-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx93-usdhc
> +              - fsl,imx8ulp-usdhc
> +          - const: fsl,imx8mm-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mm-usdhc
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> -              - fsl,imx8mq-usdhc
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> +        deprecated: true
>        - items:
>            - enum:
> -              - fsl,imx93-usdhc
> -              - fsl,imx8ulp-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
>            - const: fsl,imx8mm-usdhc
> +          - const: fsl,imx7d-usdhc
> +        deprecated: true
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
> +        deprecated: true
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>
