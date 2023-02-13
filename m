Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F1C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBMXs4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBMXsv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:48:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DB166E9
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id a23so9154537pga.13
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676332130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMGp5jpDI56FIhgoLwzO01KLRWgFG/thqIKmC+ewf1A=;
        b=DQ2gARKC+AcuFhGsEEWyLEtJbIYjQZu6fz02qaq7o5HGZcUvs8MWTuMw+UuTQ+6yNb
         hcQdZ/vASB85DaAIGTri0H8dujwMo11jgf9DiRPXQU7R1VlNjfxjWjtpJnaK3MESazVB
         lOr5q1vP/QM99/k6v0ymhVidxHQmIx8Pj16CthPTIVT++Lmj/nZ/mGgU/cJbUUzrV8Hu
         b5JRStjxOK1deZvALcUwB3eXNG1Q7FG/FrF544MkQR3+hCDbdWxj6Wwim2ScwuVcvHvv
         zKk1S8zEROYZb9eHNctBYjhxrvOUGzfSVx7vpFbsCiI5YQWM/wS4d2vXBkN4qtvavb7a
         tkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676332130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMGp5jpDI56FIhgoLwzO01KLRWgFG/thqIKmC+ewf1A=;
        b=8ROuh3qQEwiefwSPbZkA+hkWH7i8dhY0pwqijRqcD3N7w9I1B4DfzSjw4qZ7BF73ro
         rQBx7WfI9eOsE25iWtwbxO0gqgFX1iJSkPn9JY53NrgylcuPpQfQ5rtM8LxZ8yWqq/VX
         J6Fnw2tcUcBuTC5Z4dAbi5llw86JfgvMz6e0jyVL6AjZ4AcpvlwJk5TDMrf8XZ/TkHq2
         vvGkfb6KKJGXNz1RvBmvolP9a0jaTg0EiiEjxw9tvOJpqIpPsz+KtkqeWaI0cWNf3Y1S
         8ANNGQDlDAu6hRlS2wXHVBBz5fHl0Sh/Q8aWFLoRG7Xn6V4aZ8BtmzbfCisD9fL1fLaI
         pgwA==
X-Gm-Message-State: AO0yUKXheQ6881Uroq41ySVymGewQAKApoM2UC5pY1PpTpTHoq5ek+Gf
        D9MiRrFmkFouIlu711TUFb0fgbAALb/K5AA3sj7UQN+4OG7Ihw==
X-Google-Smtp-Source: AK7set8V9hjhzOSK7rhKHPbJn3smFBOI2QVV6lFBTEca2/3/LxJDzhigIc+QP4F9IXGKHjuBKsz5axhh1mR/l91nt2I=
X-Received: by 2002:a62:1784:0:b0:5a8:bdd1:6c53 with SMTP id
 126-20020a621784000000b005a8bdd16c53mr59229pfx.9.1676332129756; Mon, 13 Feb
 2023 15:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230129130059.1322858-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230129130059.1322858-1-j.neuschaefer@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:13 +0100
Message-ID: <CAPDyKFqUEPXbRWy7kStGi5vEuM=3=N6VS+o9HTHVTPatYRaYUQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: Improve grammar and fix
 a typo
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 29 Jan 2023 at 14:01, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> This makes the text read a little better.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/D=
ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b423..1c79b68753da0 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -98,7 +98,7 @@ properties:
>        Specify the number of delay cells for override mode.
>        This is used to set the clock delay for DLL(Delay Line) on overrid=
e mode
>        to select a proper data sampling window in case the clock quality =
is not good
> -      due to signal path is too long on the board. Please refer to eSDHC=
/uSDHC
> +      because the signal path is too long on the board. Please refer to =
eSDHC/uSDHC
>        chapter, DLL (Delay Line) section in RM for details.
>      default: 0
>
> @@ -127,7 +127,7 @@ properties:
>        Specify the increasing delay cell steps in tuning procedure.
>        The uSDHC use one delay cell as default increasing step to do tuni=
ng process.
>        This property allows user to change the tuning step to more than o=
ne delay
> -      cells which is useful for some special boards or cards when the de=
fault
> +      cell which is useful for some special boards or cards when the def=
ault
>        tuning step can't find the proper delay window within limited tuni=
ng retries.
>      default: 0
>
> --
> 2.39.0
>
