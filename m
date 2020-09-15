Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42826C433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D212078D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzvat5xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIOI3E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgIOI2z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 04:28:55 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD4C061788
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 01:28:53 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id e14so1411599vsa.9
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6BjYQLaAwV26Mi2vh+LML/U8Q9Whk76Cx/0/rrw3U0=;
        b=gzvat5xvmuyXYfMhmMKwSfytbSLfCrn7HB51Hptx+u23fZcnFwGU9aBnQw9dMNvjO6
         hni+S4JTYL1xeDxowckQFpaHuuNP0dyACRXJBfSHORgyHdlOe3cX0THvrQZC3Hw9N6+z
         Z7hjqAzrKstAZxnKJCMnUoBwqc7um0deLh9ocwU2aMcnEAbuEFyJ1AeYTrbD9HLcUoCr
         GTGplSxThusbFvMQp6h8aDPeKN1p0Cpjl01cP/kyNTsbA8PbX0okuAhv9eSWuzjNvz1m
         uOxIwaLjW4nQ0FW8ia5x6bavZAKeJ6ShRDj+QU0yKfkYftHMoJasrMHDBs2hphvF4OT/
         VfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6BjYQLaAwV26Mi2vh+LML/U8Q9Whk76Cx/0/rrw3U0=;
        b=OZR8coM90w0yyQWVfco8FbYaojjAGzGJMNwuz15m4/qxRuU7d6UstR+hgaF2aZfTz2
         GaRCFNpg/a7vCyTGcNo5afpvmtGDp909+YUXrpc9SZCq0fzBRXEKWfUidOq8KbFba4SI
         lqNBhfIfAe8eX0mE3dZIf2xEpi2XwRIMf2blYtthSvXN5RUgXwhyHIzhuOhP62xAvGtE
         2XgOcyqQlCasFxN/B4MBIu7bGxL08qf+9egeBTVyVXGKhTjCUZV67Q6ZCFoTAk4re20G
         JRyLXp1cMH6dwxpEcNatiG9xZvwlQ6qHEI8Az2LaV8xAz41v1i+mjm8lK5RlK0zqWc0Y
         icpA==
X-Gm-Message-State: AOAM530Du1Buh+IZh6LPr/brGcouQlHCrN/8arCPUeH5awreD5u45x3q
        Cq327Cv48bXE4quAf9Ntb/I+P9BxFvU9IOyg2FB4ag==
X-Google-Smtp-Source: ABdhPJySeYdpF5S+wZ0ekph6d6N8fb5D/jkEqVNTRLa/wzfrhZMiJMLds6ZCRrZRSUVqxtY6ZFD3JGm2s+sfXSsU8d0=
X-Received: by 2002:a67:d011:: with SMTP id r17mr418947vsi.48.1600158532082;
 Tue, 15 Sep 2020 01:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200915061110.25833-1-wenbin.mei@mediatek.com> <20200915061110.25833-2-wenbin.mei@mediatek.com>
In-Reply-To: <20200915061110.25833-2-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Sep 2020 10:28:15 +0200
Message-ID: <CAPDyKFpYAmhZXin7Lms9ymc2aXNY9UKyxYvW5PPZUqET2jBZOg@mail.gmail.com>
Subject: Re: [RESEND 1/3] mmc: dt-bindings: add support for MT8192 SoC
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Sep 2020 at 08:13, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> MT8192 mmc host ip is compatible with MT8183.
> Add support for this.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Before we continue to extend the current DT bindings, can you please
convert from the legacy text based format to the yaml format. Then,
please add the new properties for MT8183 on top.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 26a8f320a156..6422ad7d439d 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -10,7 +10,7 @@ Required properties:
>  - compatible: value should be either of the following.
>         "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>         "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> -       "mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> +       "mediatek,mt8192-mmc", "mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
>         "mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
>         "mediatek,mt6779-mmc": for mmc host ip compatible with mt6779
>         "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> @@ -27,6 +27,10 @@ Required properties:
>         "hclk" - HCLK which used for host (required)
>         "source_cg" - independent source clock gate (required for MT2712)
>         "bus_clk" - bus clock used for internal register access (required for MT2712 MSDC0/3)
> +       "sys_cg" - msdc subsys clock gate (required for MT8192)
> +       "pclk_cg" - peripheral bus clock gate (required for MT8192)
> +       "axi_cg" - AXI bus clock gate (required for MT8192)
> +       "ahb_cg" - AHB bus clock gate (required for MT8192)
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> --
> 2.18.0
