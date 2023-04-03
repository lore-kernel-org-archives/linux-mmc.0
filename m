Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B62C77B60
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDCMhl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjDCMhk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 08:37:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1883
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 05:37:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z83so34551930ybb.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Apr 2023 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680525459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyEzNjODUF0EMEwKR3BoiHKcKfk7fD3xoSv4d3W2u5c=;
        b=RI9kx2Qyn5Tkt66uOxL/BVxqYIXdLMg+u9Wyy8PZYWxpRNyTnhKpQC0SuydgUHv9UG
         /CvLd6a+pycq/HgJvGmlh3AeSWu9iBKz1pByMx/SKscum26IvOSVU30QWQwi9Rmj8CgM
         V7zc5z2+5/YlHX4CwF+TgxrvSmX41e4xZhdbeiFqCxkN78k2WpOd7NXGqqLrCObamLyU
         S2X7+5skM76FEqWmXFAHDTyH2yeJFJbd2IWlGJAc6YFO1RFt5HLV/5WQBoGUrr6cmgYs
         T9riVWUviYu62qGAZIJUtHv7UpytVKmM9gH/uVUdv46iWJT/e5Abz871escBoSbNwkKC
         mfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyEzNjODUF0EMEwKR3BoiHKcKfk7fD3xoSv4d3W2u5c=;
        b=AXU9sSza6N8JhrGhwoVVLlEhf3KCWFUmxl9UvaSBWABh+u+D4KxhlRlqlRC5RJjvv9
         0QgKx2+St5zgcoLn0VSa/EBmYXOlDTW9ZIGme7yc/phucZUZeUeUkRJ2TQ+qcfq4bHoY
         SPxtDvo7j8B1R4uxgKbn92QnaHHHoVwI2/rD5avScQ/jOwR4DB+aJeIlvPL1fYkegqT5
         0vlObJWHnRwLOf2np2hSWRTJJqvwWIu+IFj/pRBHawo+akcWMd/09tqZiRWTMOW3/2z5
         gaSb/CMD2SrBpfTMjmMOAzKWjftgsZGUWG9ePaJaddHyIxiTt3eIlFlJ8IcKEBhzgaut
         rkZg==
X-Gm-Message-State: AAQBX9dw6jSAQ77UgQlMdnrcDh+zzzTam75GjcrtJkREJmoGRNOUcBqr
        7LRAwaP3DMCjH6plH+zfZpCFZO3DTAbeVru17Wn6IQ==
X-Google-Smtp-Source: AKy350aUMZOkAO/yuOaW4hyECahwaHSCVDgAQ+x4o/yvMb2omtowEEWvK3Hbp4gEXOg4cbegKispbPEvBbOHZlP5mGs=
X-Received: by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr19072022ybt.3.1680525458952; Mon, 03
 Apr 2023 05:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230328060740.1984239-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230328060740.1984239-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Apr 2023 14:37:03 +0200
Message-ID: <CAPDyKFpeiHunqfBB0BgSmG2NH7d6V3sfMw=d=dWz6wd4GmYZyg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: ref sdhci-common.yaml
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

On Tue, 28 Mar 2023 at 08:02, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Since the esdhc controller is sdhci compatible, the fsl-imx-esdhc.yaml
> should ref sdhci-common.yaml to use 'sdhci-caps-mask' property.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7f721fbfb009..fbfd822b9270 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Shawn Guo <shawnguo@kernel.org>
>
>  allOf:
> -  - $ref: mmc-controller.yaml
> +  - $ref: sdhci-common.yaml#
>
>  description: |
>    The Enhanced Secure Digital Host Controller on Freescale i.MX family
> --
> 2.37.1
>
