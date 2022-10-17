Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8914C4321E
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJQLdB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiJQLc5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:32:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D2FCC
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z20so10470744plb.10
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bdK9mneUffg7vrl8/7bCDtFIGEs6sGRdqhjkxulvnc=;
        b=aFS7wO1yw0ZlKRkCRUv69DVp98zT90OREaESy05Z8abdYUfBmpS9/hYKI4pPqctfuf
         T1LuZYjcFLspJztThyXrgw8/1hMigzJ4xRLCbTEazWcSoGwB3tVFv9EJVb3nPnGr0SdA
         MFTbKZ4GvNv9bcHqh4vt845Jz8gFDwqznDyPLAstVh9nb1JBcTb1MGKaqj8hO3cZQ0Yf
         LQnywhV0c+ioGy6hHkD6e4rHfsGPkSBGMDmrAuOwKjSi48tMII6SZU6aEpzzRmkAz/pG
         ME4qf4+VbWm1pl0IDXqkWPt+teI62Ma84X5sHoO8hj/2DOYiAZMwjhu5hq1cm5dxYld9
         hVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bdK9mneUffg7vrl8/7bCDtFIGEs6sGRdqhjkxulvnc=;
        b=aZ0gUnvEIrPxnhyNvDOatcrDs7GjtgfVah0jPN67AmZgsSjNVj+iob/6kK3jqI+cLJ
         7qmffB3WR1jnwuh/Jb0nubZ7fNJEjmT1mrjdKHkbKb09gP66otSHmyo693R+2R818BL6
         JoiYl9P7W2I16eFGejb/p5hUMH6X0qhr0Dz1jq2xYTIkdISoIh0VWSvu8IjnqrwP8zvh
         pv4HNLdLs23/QMnsMg//TL73LPV2+UCmMw/uRuVoXy+TPsJq6VGiZ94nkJ/dVFnw1eCS
         O48WTOhWKuv3v627T53+iUmMWEcch7o81+pXBNq0hn9ecYw+wadGN7YnJA/fyUyE+K8k
         rm3g==
X-Gm-Message-State: ACrzQf0MTzoXgnkLUzPfwEIir3/aU6F8yl25BxEEmm1yW6CeyIv+slCp
        y25cG/E9OAVrDSRxR6lyN8Kv+aik6UQOzMeYd4oROg==
X-Google-Smtp-Source: AMsMyM64F1AByUxVpwF+xNpouI68PXnAVou2M9ZEq+osjZjmbSnoVIZ0AdFoc9/BroLt6Vdbuv3QFHt75voftbs1BLY=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr33490233pjb.164.1666006376413; Mon, 17
 Oct 2022 04:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221013024021.121104-1-mranostay@ti.com>
In-Reply-To: <20221013024021.121104-1-mranostay@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:32:19 +0200
Message-ID: <CAPDyKFrSficTSQpWxJxcmtGgW0bOhMkJjkX2jZvsinprfLRR9g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: add ti,itap-del-sel-ddr50
 to schema
To:     Matt Ranostay <mranostay@ti.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2022 at 04:40, Matt Ranostay <mranostay@ti.com> wrote:
>
> Add missing ti,itap-del-sel-ddr50 property to schema to clear up the
> following warnings.
>
> mmc@4fb0000: Unevaluated properties are not allowed ('ti,itap-del-sel-ddr50' was unexpected)
>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index ea9121fb188d..382d5face49a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -159,6 +159,12 @@ properties:
>      minimum: 0
>      maximum: 0x1f
>
> +  ti,itap-del-sel-ddr50:
> +    description: Input tap delay for MMC DDR50 timing
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 0x1f
> +
>    ti,itap-del-sel-ddr52:
>      description: Input tap delay for MMC DDR52 timing
>      $ref: "/schemas/types.yaml#/definitions/uint32"
> --
> 2.38.0.rc0.52.gdda7228a83
>
