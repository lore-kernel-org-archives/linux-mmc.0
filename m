Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B5C4167D
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJQLdC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJQLcu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:32:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52502FCC
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso10702150pjk.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JOlj8bYWsPP5pFO2e/L3uO1bqgZbmSulQJiNE3IFc4=;
        b=tanG5tP9PXFhE4il2quYlWC20153Alxalmr1lUPDqkstlVNZ151jvnYCrVsO57+/wU
         mAVQU+NkqriIG5vTRbdZJjQtw2CRjaWdmQGXE4UnJxLFSHlsmvAznz6zku9d/hSYII4s
         LcZ+KEDxmdjb8sv4dAppFepbg8JLr/cOXVWUdqbLuoenu3ksogIWYTmkhwFz3q8fYERQ
         HGcngnzRZz7lHHk0e+PSryEzTD8FsPQhh7DBqyg9/wKOdcGXPMyghbAFxZmlbwtTSYIB
         qKzHEqzlEcDt9UGZq01Ai8j2iRW+pX98jGmsi57WFz/JpOr3H0hwnqd7b3fGt5pPAAj6
         Uo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JOlj8bYWsPP5pFO2e/L3uO1bqgZbmSulQJiNE3IFc4=;
        b=J0izrQE4PtfvwcoSZfnUqcUIuoz6Fye+e+J7yvZo7exqnsLdaF4MKEHMPXqZwGqJCv
         Sb45633hMZd2gr1Mak5K4v8vjM1Ad+RPtSMSj2dApAXJ7A0/eW3wbFlmTr2oV0TVVdhz
         L8ch43vW09C6bsX6oxfWPvcWbL7p2Ko6fpoKyG/W5OCT0FUNKsqDNOFLBjINW00LyqYO
         /FaVngjTho2NiGgxy+Wl4M6JvjFsn+M5zOVx5KZBnOEwfKszRbRVfTkQULzA9qrICn00
         /3oIUzPf3GSCTvOde3uW1uaH2eIJfO5lbROwsJw/7UMd+IuVyVYsvH3vvKdFZ1q/pFmB
         Xibw==
X-Gm-Message-State: ACrzQf2CAPXCFk+Zaao7FIExQhvaFOpqkqF4XkT5gxFyqfrndjpypKvE
        l6lE3k7NAKZBIFVL6MbTKXMDPKPJcvphIyoXK4UA1w==
X-Google-Smtp-Source: AMsMyM6DVCCxYbdzUQ9pRy59RBKHhtMdB9NlsZmORWScZ2ZRAGAcMlVaTBDd6xAiy1x88sqPanFTVKPnBuCeEi1FPFI=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr11992118ply.148.1666006368842; Mon, 17
 Oct 2022 04:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221010101138.295332-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221010101138.295332-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:32:11 +0200
Message-ID: <CAPDyKFqDcrr0DY3rcEer2cJcHB-ZcOLP7KO=Srg0gHLdcWWuSg@mail.gmail.com>
Subject: Re: [PATCH] dt-binding: mmc: fsl-imx-esdhc: update i.MX8DXL compatible
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Oct 2022 at 12:10, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8DXL is compatible with i.MX8QXP, so update binding doc.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 29339d0196ec..ea06c1fd0862 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -50,11 +50,11 @@ properties:
>            - const: fsl,imx8mm-usdhc
>        - items:
>            - enum:
> +              - fsl,imx8dxl-usdhc
>                - fsl,imx8qm-usdhc
>            - const: fsl,imx8qxp-usdhc
>        - items:
>            - enum:
> -              - fsl,imx8dxl-usdhc
>                - fsl,imx8mm-usdhc
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> @@ -71,6 +71,7 @@ properties:
>          deprecated: true
>        - items:
>            - enum:
> +              - fsl,imx8dxl-usdhc
>                - fsl,imx8qm-usdhc
>            - const: fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> --
> 2.37.1
>
