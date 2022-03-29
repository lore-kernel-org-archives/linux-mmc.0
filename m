Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47DC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiC2Ukf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2Uke (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 16:40:34 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F949F00;
        Tue, 29 Mar 2022 13:38:48 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id j83so20213876oih.6;
        Tue, 29 Mar 2022 13:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4TtgqB+qx7XVjHzfNHtzxULilxnRMCv4wkN1Lk/S1ms=;
        b=mIVt5XRF+JiSH2GOfs26FcIig2Vz8WO88Yje9GQC67Bms+O6apqFPrubFQtSFD5Uru
         +/tOy3TAuUPTz3h8te9GVQCt40Ep4OnlwDtSRgDLKYheUaqRgyZc8RhDrVyfjPaGQuGd
         1FqFRp/1TyjMn77Kw+tFV6wVO7+ZaiixZBMhVm2nhgmp9A0Zl6VhPpqazdg1Fa+F1NGP
         z2hSlUWd/orn3ejJ0EWBpBh4V0heXe2LO8W6QK+9VmtvTai2uku/qwXr0xLJ5LZfum4N
         4Xtof7F4gNp1zdmc6Ru1BxMJrSrQvKbx4wU59tGqVf25cQvl9QiSheTJTngQei+QdV76
         pcig==
X-Gm-Message-State: AOAM532VhZlHr4ufV+X64KU5vpEx8y8xiq1q5NtYbWa0E64eQ7XU2YbY
        NmZ28n8KFmDIACKCrca+rg==
X-Google-Smtp-Source: ABdhPJwQ4FlupI7A/BX1ZpZC7myqHedGwWuamCYndsUFew8tbRsRgZX1033348l40PCDg2B778mnZg==
X-Received: by 2002:aca:2418:0:b0:2ee:f7da:795f with SMTP id n24-20020aca2418000000b002eef7da795fmr499152oic.276.1648586327975;
        Tue, 29 Mar 2022 13:38:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm8295009oab.35.2022.03.29.13.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:38:47 -0700 (PDT)
Received: (nullmailer pid 1228499 invoked by uid 1000);
        Tue, 29 Mar 2022 20:38:45 -0000
Date:   Tue, 29 Mar 2022 15:38:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
Message-ID: <YkNuVTkTCfVJBFz+@robh.at.kernel.org>
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-3-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329114540.17140-3-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 29, 2022 at 07:45:39PM +0800, Tinghan Shen wrote:
> Add optional host top register base for the reg binding description.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 7032f7adf3ca..6d41bcec900f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,8 @@ properties:
>            - const: mediatek,mt8183-mmc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

If more than 1 entry, then you need to define what each one is.

>  
>    clocks:
>      description:
> -- 
> 2.18.0
> 
> 
