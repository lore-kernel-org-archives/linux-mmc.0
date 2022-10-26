Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71938C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 11:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiJZL0d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiJZL02 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 07:26:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C68E9A3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g62so10931160pfb.10
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZbe2wun9Nqu6qN8s5Py+mfA179UedFb0/HlEHAJWEc=;
        b=EY5krOyeSYND3rduuFqwBBQ44JAqBopN5Xu5jOFIsv72ahGrxHHLp1MfYafE9C5vgw
         Q3p5dav+LMO9R/ySL7vNZ4zI0AYd1T1YefdjQieSumzAu4KFvD99qresxYYsmm6oIBCU
         ONpuS5z+0RqbiV1Y5SmSGUv8rBAZhY+ot9DkugNM4FXhamq9ccaxjldh3r78a4ld1/K1
         63eaAIhTys4cxp+77j/ZUGx+8Uztt19FFFLmRNaWyoxgboxJUvx+mjgJQR6ZJsqBBfWL
         /GJC9d/VZ8pClzR9BYoWXiXTv/HdVZkyyXDNEe5AS83M9CdKT3LxG97BHA0Jcu+YYG8u
         oNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZbe2wun9Nqu6qN8s5Py+mfA179UedFb0/HlEHAJWEc=;
        b=EWh8eOkkFv8NtBq9KpIGLxRJRv804oNzgEB4lkxdanKVrgeDq8eCJmncCJvuZ4ETHw
         QUuW6cxFvLM8+DwR7JGA0Uunb1OypxL0hIQxZlCAQwzy/HDBpJ7NjvA4npjUy7ZR46hY
         fx//kj1C2LKQsRlNVky59v4xYB9eyGWC09RBbDnd1USy/7Nv7R3KXF7pqGND0H51y2BW
         i3xWAl+5pXKj3Ofs4DixNY5TFvfqq68dqEJoesHBSp/dfxjt7xVliR4ZsuWm9OHlAcz+
         gr3MFp29bd+rMWuwpt+mpndLMM43nuzcXhTZ4Szp0OYKXaYCwYSzLIb95vKuxWrH88Qa
         oQKA==
X-Gm-Message-State: ACrzQf1Ly+r3nFTCoJY1yD/yiK9TPUPaaKKR1rukeC6cHBODSpxN37mx
        mlvKtn3j85/oIxH3Y8QN/+daS2v20wS20qVe1NMpaQ==
X-Google-Smtp-Source: AMsMyM4MAUEdyO44glc1foFoVeqTE3QX++as8FdjLMcBxQeUfsJYaBq3EgRucpKQzyGQqRc80yatWSut0rZNtR0Sc1g=
X-Received: by 2002:a63:90c4:0:b0:45f:c571:67eb with SMTP id
 a187-20020a6390c4000000b0045fc57167ebmr35995880pge.541.1666783584883; Wed, 26
 Oct 2022 04:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221025132953.81286-1-linux@fw-web.de>
In-Reply-To: <20221025132953.81286-1-linux@fw-web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:48 +0200
Message-ID: <CAPDyKFriLmsSsy5LfiJJH-s7uQMD1AycE7R4NtN1_Td3XocyOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add mmc-support for mt7986
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Oct 2022 at 15:29, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> I've noticed the mtk-sd binding needs a bit more work get into a more
> clean state.
>
> There are 2 properties missing that maybe need to be added later or
> dropped from devicetrees:
> drv-type (which is used in mt8183-kukui.dtsi and set to <2>)
> and
> r_smpl (used in mt7622-rfb1.dts and mt7622-bananapi-bpi-r64.dts, both
> times set to <1>)
>
> i don't know their function and boundaries and i do not find them in
> driver. I guess they are added by accident, so i removing them in the
> patches 5+6.
>
> v2:
> - add compatible based binding
> v3:
> - solve "not" statement in binding and reorder if statements,drop mt8183
> - added patches removing invalid properties (not in driver)
> v4:
> - squashed part 1 (compatible) and 3 (SoC specific clock config)
> - new mt7986 clock bindings based on info from mtk
> - re-add mt8183 reg boundary
> v5:
> - add fixes-tags to Patches 4+5 and reviewed-by to 6
> - drop quotes from mt7986 clock-names from patch 2
>
> Frank Wunderlich (3):
>   arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
>   arm64: dts: mt8183: drop drv-type from mmc-node
>   arm64: dts: mt7622: drop r_smpl property from mmc node
>
> N=C3=ADcolas F. R. A. Prado (1):
>   dt-bindings: mmc: mtk-sd: Set clocks based on compatible
>
> Sam Shih (2):
>   dt-bindings: mmc: Add support for Mediatek MT7986
>   mmc: mediatek: add support for MT7986 SoC
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 149 ++++++++++++++----
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   6 +-
>  .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   1 -
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   1 -
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 -
>  drivers/mmc/host/mtk-sd.c                     |  14 ++
>  6 files changed, 136 insertions(+), 36 deletions(-)

I have dropped the earlier two patches I have applied for MT7986 and
applied patch1, 2 and 6 from this series instead, thanks!

Kind regards
Uffe
