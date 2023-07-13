Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F68EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGMLGh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjGMLGd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:06:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB1273B
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so523899276.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246380; x=1691838380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiV/7q29Lz9ovivX2FWAx1Ldp08v14j+trL88mxoLRY=;
        b=eHuodEMDmc0gaOLGxz4ZOl2QDUjscsSR534Yb0lsjWkR+iDaGKmcW504dn05tzvAjx
         1yz4d5P/2M+6vgpGuNhuApckUlcmKYeE3f1/lU1wNBBnn58JW5MniNKq5Z/dRKuYaEgR
         MA5xl2XLjoVlTuurE4+ycjzM5DO6556A+sVkde3usYGkl+JnZwJYRsHzxbI1NoG+pgd0
         a3KeCvwvYTkQoOzQAc5KAe7VvTb7jqrEaxPixzse8rw3QIl2IVD+oi4gqdVV5ihaHu4p
         wTfflQTZZd4gb/zcdeUUWlkA6KrsMxQ4FJOWZIknrqw79Xe16SUChZkpfheZoAS7wiib
         jvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246380; x=1691838380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiV/7q29Lz9ovivX2FWAx1Ldp08v14j+trL88mxoLRY=;
        b=CRZ5sTf945sqE2XPHHmtuj1u8Y/DjkMsJUY0/tPNA0rBcx3IDcZv+vSkJ/+iJsfRkb
         CqwJ3F7mHdTlkmAkE9lnCtzwQWdQ1Iq0vXCiEgPx8fdFBm/B/4Sy/Gyzx/SbJJb+lsU3
         55UwWWEmhOVa4FyCQBHHWLfF77/Kaz8Abk2P8IMsoaGJAhKwQdbIuuoXTmI1dnJdXKgS
         8LYoohs5X5Tj+S55z+EFBKBKYvjAfUEs6rvG/T+z8qLDsag8dX/+ci8sg8dYH0/9K0sh
         JQ2Uja7t4kWAbbZ9jG4ImzeM54mxr3NNDBoQNcN0uk65ovNC33ehVWxPq6MKZuz9fTzL
         xGHA==
X-Gm-Message-State: ABy/qLaKQ9UOyDUpx/MsmHhEc5lEVPi9W0qtGMCk8x80/kPI6INfCwSX
        k4M4NfqAUHEzSE6zOX3at2HTDsZ7Y0uMU/dWM8mRaQ==
X-Google-Smtp-Source: APBJJlGvdFT1I5LlLlSZ1vXvHoB35pTHYRo+rkqezmhzn+Qzriqe/07gvMGjawbihGymi4kllx31OgEP5eBDfTAEQME=
X-Received: by 2002:a25:8550:0:b0:ca7:aad7:3091 with SMTP id
 f16-20020a258550000000b00ca7aad73091mr918328ybn.27.1689246380252; Thu, 13 Jul
 2023 04:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184318.551317-1-linux@fw-web.de> <20230629184318.551317-2-linux@fw-web.de>
In-Reply-To: <20230629184318.551317-2-linux@fw-web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:44 +0200
Message-ID: <CAPDyKFrvQWUQuT_SX=hArY9TP61naN0gzaZ+8qo6PnOMntn9gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: drop assigned-clocks/clock-parents
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Jun 2023 at 20:43, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> MT7986 has 2 clock-parents and these properties are not needed in driver
> binding. So drop them completely.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
> - drop assigned-clock* completely based on discussion with Krzysztof in v1
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 46eefdd19a2c..3fffa467e4e1 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -91,16 +91,6 @@ properties:
>        should switch dat1 pin to GPIO mode.
>      maxItems: 1
>
> -  assigned-clocks:
> -    description:
> -      PLL of the source clock.
> -    maxItems: 1
> -
> -  assigned-clock-parents:
> -    description:
> -      parent of source clock, used for HS400 mode to get 400Mhz source clock.
> -    maxItems: 1
> -
>    hs400-ds-delay:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --
> 2.34.1
>
