Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9C6C4320E
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16646109D
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 20:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhHaUXV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:23:21 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:39445 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbhHaUXE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 16:23:04 -0400
Received: by mail-oo1-f47.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so128220ood.6;
        Tue, 31 Aug 2021 13:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SF/gjz3ryW3XgAL+26S9/LDHdM8zEpUjI5UG3UHGQg=;
        b=tGQtaEg4mEBX6Oa1tmR7BGCCdcy0t2iEbjcbsE34Cg4aoqppj37iPjxh9Zhv//A9yt
         eHulMnufDFh+/32dBTQEhMICfgL15iFkHh2VFQUp7p1mk9/ee0teeZgJY0CxX03SmeLi
         Dg+/S4GoqAKnsCQcXKINyYBVI+wwasiLhpeAcQ18RCDW3YZFXyZ9RoTQII3vBaMCobDX
         Jxe4s6ev2gYAnG2ZvW8vgF5272vios2UBkTvshc1cfpsO+OeJkx0bOe0zdJEL7S36FXo
         slm/zV4tVSb0cRSvDNhqnv6eADwlKURCHV6M3kEcKKvcW7HL+l6Hm5Lc3RjySxDKlE2+
         OUWQ==
X-Gm-Message-State: AOAM531whJpux6HUWKgQHk9AEpugc/YEJKNaLVL8HWE6Ozo2WhJ3PACA
        HsTeXhvcsVa4pEKsy43Vyg==
X-Google-Smtp-Source: ABdhPJxD0mW53nIn3ShPl3hu4xOaQP0bjv3KNsWQaD3rF/HgEfZvYrr/wZJnxy/xPtWr40T6SszGMQ==
X-Received: by 2002:a4a:a509:: with SMTP id v9mr15987260ook.73.1630441328317;
        Tue, 31 Aug 2021 13:22:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s10sm4105457otq.61.2021.08.31.13.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:22:07 -0700 (PDT)
Received: (nullmailer pid 589602 invoked by uid 1000);
        Tue, 31 Aug 2021 20:22:06 -0000
Date:   Tue, 31 Aug 2021 15:22:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>, Yue Hu <huyue2@yulong.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
Message-ID: <YS6PbrCTIZJwe1cX@robh.at.kernel.org>
References: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com>
 <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 27 Aug 2021 19:53:24 +0800, Wenbin Mei wrote:
> Add hs400 dly3 setting for mtk-sd yaml
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
