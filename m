Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E7C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111C56103E
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbhIGUy3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhIGUy2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2021 16:54:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B8C06175F
        for <linux-mmc@vger.kernel.org>; Tue,  7 Sep 2021 13:53:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k4so344288lfj.7
        for <linux-mmc@vger.kernel.org>; Tue, 07 Sep 2021 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2nsQAg7kmIjIclpBrhtqlSTKrFIqUX3LxjUhDb/REE=;
        b=YCsQ08Usmp+NSFE2q8Vqqu+1k2Jxc19NJXOmL6Zp4reeKHQuFtk9hbHHDQ1Xmgd0m6
         bshPY/6nYk77pyO6ANj4wcbRwCSQa3QJ+vwudNf14BMBAQkxF89NI98nGh+WXthFEtpF
         5LV1zH69hfTjOdeQXh4bCWiJk6dplQNZp4kzI8t6aC8egWr7xwOHRDBBQEJqzp0P1BDl
         oHW89Ks9NHvUdtb9B3/rPkLOrYYDG3mpEf6+0nLOinqyHGlamXgbr/mEN/xCcKNiLapd
         6X+s0483+WA7SUQ5DE6qWrfJjZG3v8EsCt7AyCAnzxOW4A32rKdP6sCZxRm7mCBrh9oj
         G/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2nsQAg7kmIjIclpBrhtqlSTKrFIqUX3LxjUhDb/REE=;
        b=VnMaMTdvkTZ848ty3zdc+WkdLSYXKi+BEFBQkRV33NqyBDKGQl65JZbQPnxzOtqCfx
         1e2sfSRq6ygNuYZBLcFxtoQfYOZTaAJ5QtMeLG08+eqityL4mxjG1tiq5ZRtz3bak4Ev
         fazPeJ5h+8QQFH+/3Y7UOWjQJzqNg2CJ+jy2W+RQ1QzstigG60c0fcXoL4N9fvr7IAmu
         ggtUP2u+HPEavgBw6aeGCF3tz1YA2xHMCptb4IUq9KcVykwzTfZltHVv9xL5hoG2oXFt
         4S1RVjv8BRSnsNwwcGQ+EVIEhwLfpuHZdYY+QIFiN75jm8Rr8jZRDQw21o5puROHUjAR
         x0JQ==
X-Gm-Message-State: AOAM5338KAoZXjQ0YYnpWpti9Bgm9BdLqczSZmbygBa09rtTYH/ys8Un
        NGwRp971ei0ORdrbARbmZ2xGN9186M2UwY70kClHYw==
X-Google-Smtp-Source: ABdhPJzhBFK+nc5T6nsZ3d/UNCMCN4OBLlDwQPAjHtpwLPGtbms1OHE1axqApJ9PGJSVbkInMFi0jFJ5cFAgNd5Hu4M=
X-Received: by 2002:a05:6512:e89:: with SMTP id bi9mr207568lfb.95.1631047999878;
 Tue, 07 Sep 2021 13:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com> <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
In-Reply-To: <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Sep 2021 22:53:08 +0200
Message-ID: <CACRpkdYeE9piO=sfdBdq-Wd9uQpxyAb6xWYJ+9-JMTjrWX9pXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Yue Hu <huyue2@yulong.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 27, 2021 at 1:53 PM Wenbin Mei <wenbin.mei@mediatek.com> wrote:

> Add hs400 dly3 setting for mtk-sd yaml
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
(...)

> +  mediatek,hs400-ds-dly3:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 DS dly3 delay setting.
> +    minimum: 0
> +    maximum: 31

Which unit is this? Clock cycles? Then please write that in the
binding description.

Yours,
Linus Walleij
