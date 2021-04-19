Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090BEC43461
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 04:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC24D61078
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 04:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDSE65 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Apr 2021 00:58:57 -0400
Received: from gw.atmark-techno.com ([13.115.124.170]:56256 "EHLO
        gw.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhDSE65 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Apr 2021 00:58:57 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 2A31F804CE
        for <linux-mmc@vger.kernel.org>; Mon, 19 Apr 2021 13:49:33 +0900 (JST)
Received: by mail-ot1-f72.google.com with SMTP id w6-20020a0568300786b0290297fb946e1aso2429446ots.4
        for <linux-mmc@vger.kernel.org>; Sun, 18 Apr 2021 21:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwmKkdj5vxFBpFK3bj8w7Gz2YNFOXfPhegLyPurLzW0=;
        b=Ynpd9X5uharZfuDX9NyXS6T1ULwNg5OqOOH2ZBSoh7xARgE+P7qGXuPu45N/mkZPon
         7oJF9ZIQMU29rvJvOOaUG1SklBsq+hPtvgiIqk/1qjrWRK5HCeDbXoIzj4FvTKcAWAC8
         PJVD4Ut4iH78BFx78Zqo9uEXmu7FZmjkOPj4T6ri4FV5NxB8irADgoABWkO/mwqYNp+R
         BKBWuL97Zwyg9PfLUSGvezxuusPNsvEXxzTQHjIuBh1GPOha1gDUujQ5MCPim+CPVgPF
         nv2jbJItI/3a+Q0azsvZdYMgC0WqzCw68xfCO7lUojkCZwo9OO74linkWfis8ewINESA
         sdgw==
X-Gm-Message-State: AOAM533t68UtoaeeKAWqC56gqZy/J9q6nUGa7wQJLfecJtWbqPhUj8Oo
        cGoTNh5bPthIr+3h/D/Ez60cCnKUGyayFgRbwjfEiGLcGNynZObNfJIjaJRGx4fZKIeweKk36Gg
        /sGFYA8cVoB4sVmpYWBroSrCr
X-Received: by 2002:a17:90a:430e:: with SMTP id q14mr10145503pjg.189.1618807761154;
        Sun, 18 Apr 2021 21:49:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxUh9TJ2x/K//IB2lTaeXhs2rGXIpLK5cuzzNIi1YdNWpQlLZsRv610IvzYjHsCM08ZYf1MA==
X-Received: by 2002:a17:90a:430e:: with SMTP id q14mr10145444pjg.189.1618807760853;
        Sun, 18 Apr 2021 21:49:20 -0700 (PDT)
Received: from pc-0115 (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id l22sm13247239pjc.13.2021.04.18.21.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Apr 2021 21:49:20 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94)
        (envelope-from <martinet@pc-0115>)
        id 1lYLqX-0016Kg-U8; Mon, 19 Apr 2021 13:49:17 +0900
Date:   Mon, 19 Apr 2021 13:49:07 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, tony@atomide.com,
        geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        vkoul@kernel.org, peter.ujfalusi@gmail.com, a.hajda@samsung.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch, khilman@baylibre.com, tomba@kernel.org,
        jyri.sarha@iki.fi, joro@8bytes.org, will@kernel.org,
        mchehab@kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, kishon@ti.com, kuba@kernel.org,
        linus.walleij@linaro.org, Roy.Pledge@nxp.com, leoyang.li@nxp.com,
        ssantosh@kernel.org, matthias.bgg@gmail.com, edubezval@gmail.com,
        j-keerthy@ti.com, balbi@kernel.org, linux@prisktech.co.nz,
        stern@rowland.harvard.edu, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-staging@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC v1 PATCH 1/3] drivers: soc: add support for
 soc_device_match returning -EPROBE_DEFER
Message-ID: <YH0Lwy2AYpXaJIex@atmark-techno.com>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-2-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419042722.27554-2-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

First comment overall for the whole serie:
Since it is the solution I had suggested when I reported the problem[1]
I have no qualm on the approach, comments for individual patches
follow.

[1] http://lore.kernel.org/r/YGGZJjAxA1IO+/VU@atmark-techno.com


Alice Guo (OSS) wrote on Mon, Apr 19, 2021 at 12:27:20PM +0800:
> From: Alice Guo <alice.guo@nxp.com>
> 
> In i.MX8M boards, the registration of SoC device is later than caam
> driver which needs it. Caam driver needs soc_device_match to provide
> -EPROBE_DEFER when no SoC device is registered and no
> early_soc_dev_attr.

This patch should be last in the set: you can't have soc_device_match
return an error before its callers handle it.

> Signed-off-by: Alice Guo <alice.guo@nxp.com>

As the one who reported the problem I would have been appreciated being
at least added to Ccs... I only happened to notice you posted this by
chance.

There is also not a single Fixes tag -- I believe this commit should
have Fixes: 7d981405d0fd ("soc: imx8m: change to use platform driver")
but I'm not sure how such tags should be handled in case of multiple
patches fixing something.

-- 
Dominique
