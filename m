Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA0C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388588AbiDUN62 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388514AbiDUN6Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C82BB1B
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 17so5885480lji.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtiiuhQ+uf1bOxSrFQ/mtG2iFVrqXzgGb1Bz4ZKL3lc=;
        b=mguUkcGeDwc2lpf0CnS2qEDAkdNXH0GfqqwxotWWnAiiPRenfCokppkdIq847GGDj+
         V7/AIF2bzXyp7M37/nr7ruAruDvCrQx1DNZ/20nn57hMXvzyNEVPpwjbfiO5IJyOcC/F
         prRS94MMKCXnDtHwQZZq1g34JjUSq9tB7jAFAlO108GoNmJ4usawRQMbfrBAU3m0Uf3u
         +5Jzss2axj6u4zOZSfEBaN6N84xDmHMJvSa3TVIUb+4nxJNjohMuxfu8WAyqKR0vqMZj
         kXi1dQo/9YbVfco4LPMAoFhgU513EM1o3eLJuSFV5X8ml5aklznY/fQaxI4CixL7CY6O
         1CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtiiuhQ+uf1bOxSrFQ/mtG2iFVrqXzgGb1Bz4ZKL3lc=;
        b=qxAA3mRupyYLz8p/SUqu6hzFLbh9RmKADGTihXTERdtYYt68g0gBhkSSdKlG6RBslQ
         TjFTikVcf6R9vI3t2pYbkPxrwVS6ZGsOZOYL9Z8AhMSzZhksZ1mJvT99CVwNnHxjmzRh
         uSyGsV9zcNTU25bt3mD3Ub/GZYq+VBFLB6AtRiZkLXere5pNlUMtRldN+D/m8ExISxfk
         Ddz02bF6XXNRmDANYXGED/2weUV66n6WO16ZjftkAMcLmQiv6jk9xhcs3epoGg1F+6PB
         60qqU+I6d0+A0+yDyyJhYf21h2p8AWZuz7Ort9154RxBSySU6zbprT/cQWwWrz2eIOzT
         q8VA==
X-Gm-Message-State: AOAM533k49kDiuEveLw7XWWcqw0N0oaijpirdChJD3FN+oXL4ZTvLcw+
        13P7gP4TBOu8d/Mt8332MAQ2SYIEwYu1M7m6LO3ttz9L8ig=
X-Google-Smtp-Source: ABdhPJwE9acGnZeEaiwn2RQsXbh1pRjWU4fFb6jByKk1paGqTryrF9P0MXVVYFO4M40JGujrjUHhZHu80AcKpfsXL2M=
X-Received: by 2002:a05:651c:2114:b0:24d:bde3:297 with SMTP id
 a20-20020a05651c211400b0024dbde30297mr11074613ljq.367.1650549331811; Thu, 21
 Apr 2022 06:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220419113516.1827863-1-abel.vesa@nxp.com> <20220419113516.1827863-10-abel.vesa@nxp.com>
In-Reply-To: <20220419113516.1827863-10-abel.vesa@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:55 +0200
Message-ID: <CAPDyKFqmUQrL98m_r2uUEjOgWGGBK79eEJaaVV8dCPZhCXJgSw@mail.gmail.com>
Subject: Re: [PATCH v8 09/13] dt-bindings: mmc: imx-esdhc: Add i.MX8DXL
 compatible string
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Apr 2022 at 13:35, Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add i.MX8DXL compatible string. It also needs "fsl,imx8qm-fec" compatible.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 58447095f000..29339d0196ec 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -54,6 +54,7 @@ properties:
>            - const: fsl,imx8qxp-usdhc
>        - items:
>            - enum:
> +              - fsl,imx8dxl-usdhc
>                - fsl,imx8mm-usdhc
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> --
> 2.34.1
>
