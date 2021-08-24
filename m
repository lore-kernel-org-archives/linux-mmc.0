Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CB7C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B3610C7
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhHXO6A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHXO6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:58:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A7C061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z2so46198489lft.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RZPPDe1ft2kx9MgztR+GjtCIGl7LPXmi8ktho6S+uU=;
        b=Ghwu2kWBjSJBiqg8N6vJD3IuUVWVDccMpSQRy19Mgceo7wvMsLDViUPcewG7cJPJZo
         7rYjrx/zZFUc/KdajhdrkWEq4Qs4xh8//waH9wj/oa4nsNwBcxbux/Iifyn9mfeeUq5V
         u4OpRgj/ebbe9sTdgdx95rEiFE1IdoJhZfvfkyukXXq/0UZOPqAe7eo3Z5FSLxmcW4le
         XITT7dUot7XSOrGNxenm6bxv8jl4nxF7UYqzwEqrYZ18u0lwCxOMyYlZ2ONQq6l8wt7i
         qpdrAIKI1i5Bn7+/GKhz+NrV/RTxiUus+TJLD/FylbN+9c3+P4jPx6hhsm+lwAptT933
         ilLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RZPPDe1ft2kx9MgztR+GjtCIGl7LPXmi8ktho6S+uU=;
        b=XXEM/HOG65B/omo2klUzYsZnsaGdUFdxINepVUaok6OF8Mx0UntIEG8y3NZGMXGODk
         rDtJpbMz8ikUqbtb3HoP9ET457TESr7infNA7RRuYoa4O9n2qh6fSEH8FtQqTvTdcAV3
         tPJcdIUA0b/0ZEtzP0TFPFO3mCHifFs2Aftu19fF/clP5J+Bo7+1wQp17A1q+sh4NFVe
         xIS3dW+0rjRuWECKww5HcxjdaYisvwR0GpMkIsLGejlKM2F+r264CVsRDk+6n9iiK+jF
         UCw5lwsH7PPOEQtBT4x4VgEPMYWYSLZZhzl/zRV3+qiimRyH+h5IQtexHetWixeyxYHY
         88mA==
X-Gm-Message-State: AOAM532AQjrvRLM+AkaQf1Mb5eu47AjRvKEc/9INcVy/FR7Oft6/4/pp
        /l3TN20ncnjYlB5CpdapTAa/A4NtsI6P9GTgBmtp1A==
X-Google-Smtp-Source: ABdhPJyERkV1YDTfEE6Jl5WMP48dumPT7EkdW/YvkrBhsrp4km2CVfhnPKm4gUH7nf1wpbKS7XDqrnqNYNSvk8NHefs=
X-Received: by 2002:a05:6512:3e26:: with SMTP id i38mr30076687lfv.29.1629817034461;
 Tue, 24 Aug 2021 07:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <1629373938-9226-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629373938-9226-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:38 +0200
Message-ID: <CAPDyKFojnR8W4g+8dVQ+i9XPSDpb-vDCrq38ZhnhmkyqyoyTqg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: fsl-imx-esdhc: change the
 pinctrl-names rule
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Aug 2021 at 14:14, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Change the pinctrl-names rule to cover all cases.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index d7c8e5880473..f04728145275 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -124,12 +124,17 @@ properties:
>        - const: per
>
>    pinctrl-names:
> -    minItems: 1
> -    items:
> -      - const: default
> -      - const: state_100mhz
> -      - const: state_200mhz
> -      - const: sleep
> +    oneOf:
> +      - minItems: 3
> +        items:
> +          - const: default
> +          - const: state_100mhz
> +          - const: state_200mhz
> +          - const: sleep
> +      - minItems: 1
> +        items:
> +          - const: default
> +          - const: sleep
>
>  required:
>    - compatible
> --
> 2.17.1
>
