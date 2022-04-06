Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EFC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiDFQzR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiDFQzE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 12:55:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B45137F5B
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 07:56:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g24so3566470lja.7
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjZsIlWat2l9xa0WL8zf0EcIa39YnrACHBR8m9uiowg=;
        b=i0VWJ/CcY+PT4qCa51i9Z/+RQM6wM31bqZg7yGxOdPFdaSyaELt34pNi7DWyXMf3AG
         WXD83h28rJeK4EgMYuCCuD5fe9jF6KH4rWQpVj/3cUs4yrnNKZDAWubfWr75miD376WI
         oBdQRhew6e05nFOa8K00j19JHU8L+Eph8x0o9K43NhkHmp4iaN9mwWstTLsaAKXwDjJK
         kO8xIEUNFf47dleu2O3HEAEFrP9TIsD8IWDfZIt3BO7SioHh5JuZgTLBCczkRk07n8B0
         Vt+ZutQNBKu3fDmi4scBVQIYfWSGcR/chLdoAMMUOWkB1tsw7fFYmkQeojnOWvDJNySk
         TCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjZsIlWat2l9xa0WL8zf0EcIa39YnrACHBR8m9uiowg=;
        b=mbKVsYRk43IuM3D3YUwgttwNv/l2OQmXFfwmboqCJ3GkckElr9ni92oHfb7ePcs6Ru
         xnS1zEE3/GzsugJYy5ppcxl8KdxvaNloTW9zq4UObUQH43k7+smpzom+Y9lvmeB4bhfH
         rxG/oLV/y2veFz7djLdypuUJGAs6paJwjxWaipkDJikk/9iqOKoU9SeZyFgtD7asyFoK
         RaI0KQVt9mGERes4ARV/hA1qn2uktUMNg8RahY8ANSyeFvqaXmYlscb8bIlHxoAkGHmb
         d+AGguWe7v9GKpfVR7w4jfIWVziDy+a3kVNw4j691okdvKarmQJlYFOWJliziejIbxAe
         BY/g==
X-Gm-Message-State: AOAM531Km+pcF/fxwIkY5t4OPAiVRO0iu/0vmoj2Z+Y/lraPa6MN21Nv
        N7Nq4xrevLhXwClnsNQoqpCGDYnYkL3H2PYDdHM7Rw==
X-Google-Smtp-Source: ABdhPJy47PzYbVHxRygS9k3I7UM424f+F/oaYXHLgaJQLSEiHC0Rd1l8oyZGSl9sentgHmXai/d7/1qGj5x8MjT/lCQ=
X-Received: by 2002:a2e:9048:0:b0:249:78bb:375e with SMTP id
 n8-20020a2e9048000000b0024978bb375emr5601838ljg.229.1649256962784; Wed, 06
 Apr 2022 07:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220330094532.21721-1-tinghan.shen@mediatek.com> <20220330094532.21721-2-tinghan.shen@mediatek.com>
In-Reply-To: <20220330094532.21721-2-tinghan.shen@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:25 +0200
Message-ID: <CAPDyKFoVrDMwteeBc-xTzD3HAe4wsG361mXs2fmHZpQSv662bQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Mar 2022 at 11:46, Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> MediaTek has a new version of mmc IP since mt8183. Some IO registers
> are moved to top to improve hardware design and named as "host top
> registers".
>
> Add host top register in the reg binding description for mt8183 and
> successors.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 297ada03e3de..2a2e9fa8c188 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,10 @@ properties:
>            - const: mediatek,mt8183-mmc
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: base register (required).
> +      - description: top base register (required for MT8183).
>
>    clocks:
>      description:
> @@ -168,6 +171,16 @@ required:
>    - vmmc-supply
>    - vqmmc-supply
>
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: mediatek,mt8183-mmc
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.18.0
>
