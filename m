Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2FC63707
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjABPHb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjABPHX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:07:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803239B
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z7so13132603pfq.13
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXS7nrJFORzyDPmh7+FGBbOMiQgOyBfpmUbiyI6pu4=;
        b=ksEFKm7Ezybsf9oLGYhGyyq9SUeqw7ldNnAXgJPWsgDlHveaQG2HQ0t8A+azOrymmz
         w6teBZkH4bQoTPToLP4aZAKnPKzAvVw7E5jIvrbL62W5AIInjy4PBUZ6NBTBGrPiuYiV
         RdIFYU66E5/o+VSA+WhPSoh9SkbhX4w7T7UNbaYeuEPVNWifUslWMXmI7oERQrKbcjMv
         PT6oxXLbE3yarjKVJqkY5J8FzFbcAHd8v9ycpR7cWIZ3A1XkBXIPMgT6D/0Vlrgynzjo
         QQMmosORKY+kTsHmdxEc+mGD9mUOw9zi0/cEcif0Zb9Z7vmO8Wfo3/GjL7TAZbmS+Kxe
         LlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEXS7nrJFORzyDPmh7+FGBbOMiQgOyBfpmUbiyI6pu4=;
        b=m2349fJVh/Kr3/BkeblOk6ILwpn6z1gjioVYTjI5y6eEkNb6x1rky9VVHpgcszzUoV
         fVyYeg1Mem/15yOGgh0ejJqO5w4RViIFlcjRmnPZfthB29ZvoEGbb+FWaAKgBznjNgXK
         56rR1UdRsYxPCTchMrNIu4+qcPmgk37xculMzAf0eAVk+BsoX1mpFtci8aJI8C/SSAYi
         sQnC9wdnT7v8zqRwPML9eU63Z5eeN+LduilxkYMC52Lm+cIEJ07tlWeYDHhNyOHFJ5rF
         OmCDnUoQhP5UyIgVq2E6Gu0VYALFSBElIKbWllVOZq2qXLz+LKjCpF9YKrVxkH8vRnHi
         m49w==
X-Gm-Message-State: AFqh2kpJCDBVBCGEq2YMhhAHHTlrfpwkEnR8xCI/Nc42vGB6MTrkBD+V
        eErNkHsjKr9REBe7kFgbQVbzr8ucIA0ycUzbpOtxQg==
X-Google-Smtp-Source: AMrXdXveB6w6ko5UpGztJDmBUhjBlHnkl7XTn0GFtvIltj3YGiKK2OxzvjEJPtgCrP69aZ6NJTh37oya64dSSpnFuxI=
X-Received: by 2002:a63:24c4:0:b0:499:c23c:d65b with SMTP id
 k187-20020a6324c4000000b00499c23cd65bmr1292737pgk.541.1672672042769; Mon, 02
 Jan 2023 07:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20221223030347.17093-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221223030347.17093-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:46 +0100
Message-ID: <CAPDyKFq3f+_8SqupidTqzLmJtDwVaamb-6uWrUN3isivhHZ3PQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: update binding for
 i.MX50 and i.MX7D
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

On Fri, 23 Dec 2022 at 04:02, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX50 eSDHC is compatible with i.MX53. i.MX7D uSDHC is compatible with
> i.MX6SL. So update for them.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b42..546ebcecaf95 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -37,6 +37,12 @@ properties:
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - const: fsl,imx50-esdhc
> +          - const: fsl,imx53-esdhc
> +      - items:
> +          - const: fsl,imx7d-usdhc
> +          - const: fsl,imx6sl-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mq-usdhc
> --
> 2.37.1
>
