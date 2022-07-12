Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D02ECCA480
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiGLLKb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiGLLKS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:10:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E98B027F
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so13369332lfr.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIxn205KIvmS9VSb5lDf2UBPI0iYaOAaJ1A1MJqqVxk=;
        b=FNUE2acQhszuFh5gwSVw+Rwn9vCbiz5eeW9tj0ulcEp5CB+CXfZNt8End8wSLExYwg
         4MO0Xl4cRWRKs5XBHGbmhjPB/i1vtyPNV90bz1iw4x++t5iu24KV5R6FJi7W09ebLp9x
         S7wFe2tgt8oEN1HIukddBfHCiZO3jZmcu5z3d3BrD2zxyY2u0qHd++sqPDQ+kzN2tovj
         3q8HBg3/FmHKaEXwYT4Dfqb+TnqK4st+QY5oGz7HEfCyVhDwcVT+XW8TO0xoa0lPVoEs
         iojT44I21fzo9Uf3MJBs0yP9F1SVii8xWazC9xjcbn2X5a0LWztVRBgtuz01spJQs9uV
         WKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIxn205KIvmS9VSb5lDf2UBPI0iYaOAaJ1A1MJqqVxk=;
        b=tBSun64P+254BkXOWMpD2PS7NgE4GaHKaND2K48h77iuBStis8YBF67naiSNqEADbm
         GlbRrGOV+PelyhV5nMdBOH3k+pLPFawGKO7X6lXSgWOuskNWt33DhowQm1ceA5HgtKX6
         +/1bxT9VhgwA01WAQueZcSW+vFQ1VJt8r8spWGVA0uyVlBpZrc4HIe0KA5bIBJ16qEC1
         WrMjmiEwym4M6r6qZ1MY3Y0OO478EayiuaboxmGrvrb3qeUMmzVc9mHqfee/aOSaJjtP
         xvdtxiJUpIs5/lPuXPdKCa6pAvgAg7w7z56lVL5k5EHQvBgL6l4cpA+IWUPP5vBKQkaw
         kb+Q==
X-Gm-Message-State: AJIora+MTGboHdOnac/H/iJVzHW1V2FugcHgsa017xoqlYAKDw1IQwSi
        qfRoen0heycXuZqmoftb9Nsp1J0JxsIl2tKmvVxJwQ==
X-Google-Smtp-Source: AGRyM1tW9I2SNwUkOEFsvNntEhlOoXvMH17jCpZPzFWoPNjDoKFFg72huJu8nMkwl68VqtR7rGwljMo7GbdaofhPCqM=
X-Received: by 2002:a05:6512:3d03:b0:47f:7023:2c57 with SMTP id
 d3-20020a0565123d0300b0047f70232c57mr14045143lfv.254.1657624215580; Tue, 12
 Jul 2022 04:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220708114747.13878-1-johnson.wang@mediatek.com>
In-Reply-To: <20220708114747.13878-1-johnson.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:39 +0200
Message-ID: <CAPDyKFqcP69cBEKDx1Uu0BKGOA6s1U+Suiz1KXDXtwn8Qj8kBA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Add compatible for MediaTek MT8188
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Jul 2022 at 13:47, Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> This commit adds dt-binding documentation of mmc for MediaTek MT8188 SoC
> platform.
>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..be366cefffc2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -30,13 +30,11 @@ properties:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
>        - items:
> -          - const: mediatek,mt8186-mmc
> -          - const: mediatek,mt8183-mmc
> -      - items:
> -          - const: mediatek,mt8192-mmc
> -          - const: mediatek,mt8183-mmc
> -      - items:
> -          - const: mediatek,mt8195-mmc
> +          - enum:
> +              - mediatek,mt8186-mmc
> +              - mediatek,mt8188-mmc
> +              - mediatek,mt8192-mmc
> +              - mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
>    reg:
> --
> 2.18.0
>
