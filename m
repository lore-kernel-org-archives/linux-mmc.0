Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB85C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiEDKl0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348181AbiEDKlY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F11286F2
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:37:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 16so1095172lju.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb0NSe8ARzC5SmuUEMfvtdIbDeahcHfl+QMHR8M0UQk=;
        b=GZhSotbCyj7bjcQg3PRN5d5i3LNDLOHkeiEebj/4ACqHtK1YLDFsRK/0IrTHnfceOy
         UluKNPmhbjw9UWDe43i9hxj2A4wVNksLYrr0zgBRav0mWNt+O2TKGxOn39dduRc7hww+
         5IU4ZhRYef0ywjjxFhBviwDj1IhQ/Nlc9V0YgCTRVNC2ObNe9YAxdNsieXO9KNQ3Xn8b
         VrPx1e1Zk7/x4vnxDXFSvWv9wjxu51vfy8OhkXN4uzac4E34FHOJKbE4GhWrNkMTmO/t
         mGyVZzFppdwPpbLeK03k3r0Eai14LTxLKjON1JLWRun+EEVT4Uc4/FB7XksuWfvM/MEH
         5vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb0NSe8ARzC5SmuUEMfvtdIbDeahcHfl+QMHR8M0UQk=;
        b=wc9021WgW/381mSiRBcWFG6x6J6dlBGf5EpWH7EQ3Yruhpql6FG0MjgrLov1/t3e6N
         jjjOVXmwvOiNO/uPSFa3OyJu4hoP2Diw1JMl4fw11A8k58OyO/zcGkJF/T24KZkRDSEV
         xlkg37iA2nynYb0YwiTI7euYcNBCPGCefioX5qRWNzjNE3XmBlfi7H8oonVVcDkv+i6c
         D9fPw11BV1uvJNs7TSk3yEkBkiTu5/Rgnv1fZgbDdXhJ29v/k95VGJlPBOsnh/WqE7dT
         8nRx7Q4od6NRfHs53y6G00GIdjQMV6JTMrBckyT2RcFeofO3DTgzMfEw2Kwv5zy+UuTN
         Qojw==
X-Gm-Message-State: AOAM531hkMhgWqLXq0Tfet2dhrzlLgzYbqqwhzB9SSs15aQOnQMTWIEb
        6FzjSmzbATgGAA4244ODdBCFzJLumQJdXD2+vMnUTg==
X-Google-Smtp-Source: ABdhPJy3RP8ApTLWFeuOxSaDmP+bk9p4uPaAGqlNoJA31itRj3U0AHz4xNk4wOpq4ed3AV5juy2VAtEjHIHTWQOiNls=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr11878078ljb.273.1651660666042; Wed, 04
 May 2022 03:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-8-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-8-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:09 +0200
Message-ID: <CAPDyKFpCa6xqQfpBj9e8E92_WyK_tEESgSMuRm9_CNRuMgFbQw@mail.gmail.com>
Subject: Re: [PATCHv1 07/19] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Apr 2022 at 19:09, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add compatible value for the Rockchip rk3588 dwcmshc controller.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied for next, thanks!

Note that, I am expecting a new version of the other mmc patches that
is a part of the series.

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f300ced4cdf3..71f8e726d641 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-dwcmshc
> +      - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
>
>    reg:
> --
> 2.35.1
>
