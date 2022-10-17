Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD2C43219
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJQLdf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJQLdF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:33:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46591E3E6
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:33:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so10189302pgc.5
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KK+EXo53xH3teNZkrCGFVk1lVgEFpbXtxVfs298qg8I=;
        b=HTuAuT+sap6LyXtbF9CDJq/7i56C5laYDIbS8NJe5BA/8qOeb8n3sNwqunDQFR9hFW
         C2/BtSDsHgLdRs9WJC81iXFM0cYxf+DIkFQQ0XqmzBGsD6KxROYIpb67OIHtY6PiRDCO
         lNnLNFJ5ihblBr1VqDFpm80eth60CNzq6xRLEK+syBVKhDJh7YlpPg0j/8JFJaZWlfqt
         kzvtzegfot9Px//p1Ob7kbmI55ywHgz1vBtUBpptNIdH7muH85k5Sx+MLatACXt92xRh
         ineJtNidz1dn+yU+FHFUunXRA9rggp2WMU1jqwDY1avYurHV69Ic5SyjyBBfdCnQUkl2
         MUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK+EXo53xH3teNZkrCGFVk1lVgEFpbXtxVfs298qg8I=;
        b=y7IUYOWAx32atlb/ezTBdXpcthJK4Vp9+WpgzzJNwKLAANi9pefNgpNp/+t43cGkUP
         614ZOTU/5z2mDgSdnVny9H4HoNz0X2Z4mRKOcPp2P5aHlhccQHjHjjL/xEIhXo4ClTUF
         AkXZgP6oAzE/k+aMA+Wuu/6Df37EcZcMVP6JHZSoJbV1OGtNT7PpnWEaRfoAldQQDSus
         4sqP3e06sxTd68C+Ci9TgIMx7n9RRscs+hksMBg01ChiQfMmoYSzw5ou7StyAYZiJgnR
         YYjqghS+nY05n/XncviDXWGPLo+yJC6fnuo0UoUoA2SI3Qj9vDMC5nj8+ExCYq1/DZLP
         VEmQ==
X-Gm-Message-State: ACrzQf1EoESepN0V6tXWSqA5qdZbLKfPtUIUa2cLVLkOrqiIEtuDx4WQ
        9TcjiQf4MzWOQXWgM49sjwuEWC39W4sJyyBGanD/xA==
X-Google-Smtp-Source: AMsMyM5zMeFWy2lKl6Fz9ckb/XeM2zFIV36/AvksTHriobx/KjpX5Gwr1gl4rEOssMIUi1/8xahfsXVC8FrBys9OkjE=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr10687642pgk.595.1666006382483; Mon, 17
 Oct 2022 04:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221013221242.218808-1-marex@denx.de>
In-Reply-To: <20221013221242.218808-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:32:24 +0200
Message-ID: <CAPDyKFoLrxwjjrULD=6+jd4tWSffdmVr1X0z+kByid02tevNQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: arm,pl18x: Document
 interrupt-names is ignored
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Oct 2022 at 00:13, Marek Vasut <marex@denx.de> wrote:
>
> Due to inconsistency of existing DTs regarding the content of this IP
> interrupt-names DT property, document this such that interrupt-names
> is not used by this IP bindings.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: Add deprecated:false to interrupts: description
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1e69a5a42439b..1c96da04f0e53 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -95,7 +95,9 @@ properties:
>        PIO (polled I/O) interrupt and occurs when the FIFO needs to be
>        emptied as part of a bulk read from the card. Some variants have these
>        two interrupts wired into the same line (logic OR) and in that case
> -      only one interrupt may be provided.
> +      only one interrupt may be provided. The interrupt-names property is
> +      not used due to inconsistency of existing DTs regarding its content.
> +    deprecated: false
>      minItems: 1
>      maxItems: 2
>
> --
> 2.35.1
>
