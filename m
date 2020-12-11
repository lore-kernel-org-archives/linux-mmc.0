Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D78C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635B823E26
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbgLKNsY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393813AbgLKNsW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 08:48:22 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A70C06179C
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:47:08 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id w18so4777602vsk.12
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfZ8Hbqg5JOVMCVU7zFQQsVHbxKEp1AAS0eJ5Y7LnV4=;
        b=nsFbhL9mAsmWp/jt5PSJgGDYNEwHYlwEVqGJ2AEAoidm6SBverb74n1+1qnawRF61O
         Wm+qq9KhtiBet5cXimLfrtOXbxmTAyvRuSuQZy0kcPtlrwbi3lIRlWdfw1zmv6XkCY/j
         O1XqtKw+zE1Cx3aKWQInx+KTqEbBV5/8SGFirjTVzHbJbJNVA7UDHc5cLC3q19uA87BI
         2ElrfG/qvsWy1DnGU3q95X7jPcct1+GoMPD59/ywMAvpXBbbeb76Sf1lQMmTo+67i8k5
         VNnDEp19Jc9RMHkO2NN7lve4ZSyAdBE7ZDM8gJ2URSETW7xq0+1PvRuOMjQ7H6Rzg8jk
         S5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfZ8Hbqg5JOVMCVU7zFQQsVHbxKEp1AAS0eJ5Y7LnV4=;
        b=UhY1YR007t9bvZ9h4MYOvkwK2u+aB2lI11AkQHyNSt++PXIAivJYuKlCji085Hz4vX
         Q6QGooGIawS47AQiwiokrs3AvHBZtHoBOyRmEqXZuGKgmw4Z3aUnylzbZVo2QH01+S6w
         1jQkm6e2RnNCK6LaUPZx7BNcHuIwCnKPz3vYM3cPoInyjLtK1JVGQKnV+J5Z+n5dUFBA
         NIoNAVzGtOm54q1kKm64t1IOkcyHFOuVouagJYNZT8ZMvC+JAxow2tP1FSmgkncHl9NJ
         iYy62hlbrNnKR+OCLEImw/JzbSCLmxT1DfN7JL+eLSzNIFZqSXqd0mFwITvWe/wevK/D
         8v5g==
X-Gm-Message-State: AOAM532rldVRIJ+8gfWp7fHUqLCO96b8dfRwnz/6Q/h2Lmbk7p50q/6g
        fKstaq7MhceRff29+0jmGrhh+r5Cnyn7tfhAMq8TZQ==
X-Google-Smtp-Source: ABdhPJylD1P8t8sm/PPT2AIOH0OZEU0uw5g6BFwZEtaYiQ6BCREPd64WU7PMO3pXVotWlSLhn2H07FbQkf+hp2l5rd4=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr13236500vsg.48.1607694427887;
 Fri, 11 Dec 2020 05:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20201207032626.1445-1-thunder.leizhen@huawei.com> <20201207032626.1445-2-thunder.leizhen@huawei.com>
In-Reply-To: <20201207032626.1445-2-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Dec 2020 14:46:31 +0100
Message-ID: <CAPDyKFqJrb5SQ0o4cc9=Yv=GAZ3chjQoDRrKjPUUnUi__g7iiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: eliminate yamllint warnings
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Dec 2020 at 04:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> :20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> :30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> :33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 26 +++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 030e3fdce49293a..01630b0ecea773e 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -17,21 +17,21 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> -        - mediatek,mt2701-mmc
> -        - mediatek,mt2712-mmc
> -        - mediatek,mt6779-mmc
> -        - mediatek,mt7620-mmc
> -        - mediatek,mt7622-mmc
> -        - mediatek,mt8135-mmc
> -        - mediatek,mt8173-mmc
> -        - mediatek,mt8183-mmc
> -        - mediatek,mt8516-mmc
> +          - mediatek,mt2701-mmc
> +          - mediatek,mt2712-mmc
> +          - mediatek,mt6779-mmc
> +          - mediatek,mt7620-mmc
> +          - mediatek,mt7622-mmc
> +          - mediatek,mt8135-mmc
> +          - mediatek,mt8173-mmc
> +          - mediatek,mt8183-mmc
> +          - mediatek,mt8516-mmc
>        - items:
> -        - const: mediatek,mt7623-mmc
> -        - const: mediatek,mt2701-mmc
> +          - const: mediatek,mt7623-mmc
> +          - const: mediatek,mt2701-mmc
>        - items:
> -        - const: mediatek,mt8192-mmc
> -        - const: mediatek,mt8183-mmc
> +          - const: mediatek,mt8192-mmc
> +          - const: mediatek,mt8183-mmc
>
>    clocks:
>      description:
> --
> 1.8.3
>
>
