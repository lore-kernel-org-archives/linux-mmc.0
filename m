Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A1FC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 23:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF99611CA
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhIPXeY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Sep 2021 19:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIPXeY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2021 19:34:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE0C061574
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 16:33:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so25361781lfg.6
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjHqvEYv6+gMyg4Tq+Rh/G8JnWMIR7cUG1Fmcv07v/Y=;
        b=mVwI96FJbGbROeb+waDs8Fr9jg58Ppg3G2f/qwPZr8axanVXE1bqdoj0ztls5rFeZs
         7VP7jjoGJfuz3jYXmZXGUUni8EfJ0lHPi6gBIwHP/3X+JyNUfkM64ieQN7Eup9QB3k9+
         vuJiV+V11n2Sz8DjTwNiUX7vhU6ELwHZd9a1rYo3jBA8DojYTwgzZN1KmzCSV73sP+lr
         XQiXPoqQ9zuPRQKFU7kB7mBZs4lDHUt202CByLC5d9bKgKa3M18kMIbzFQ/7AvVQvp2f
         Mv4pVqPYTnLLv3IYLLOI9QoERjjqo3vdcr/qYaQ/3TiL0X0yeZOBfspENrBEt6KUVBUs
         6vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjHqvEYv6+gMyg4Tq+Rh/G8JnWMIR7cUG1Fmcv07v/Y=;
        b=VXwlhVoYTSyE1h/o0G3fUe6BbcX//B4LVE6/azdwJUUlMWYW9yk7ZL2Dal/r5/AS/z
         f4ifES/ojb/+09sage/hv9PemJw+UZdRgBcvohJ9WuiT3RS2Nu/3vL49lI2YacQWYv45
         4WInCyV/DANsfmvQQgvAeLeft2kmwqZGsF3W8iV+GVJAH7FK9oHguTrThDKWLlY6FTet
         Hj6UdLhveOn4blhHsX4WiHUqYizWi7ijcTvVvVGvxBcKYFFVml9jutvUHIapX2amd4Zq
         2ys2wsDJcOnxJPSfVSY2jMOxWY5vWxcfoFDYX4SeFCZbkuraHiuM+bw3YD6YKYi9hLRO
         yfAA==
X-Gm-Message-State: AOAM531v27TVjtpNAFJLVhp/hBbE3QC5isKL4d+zYcNPcz73cHHhWb4c
        hwZhacC3+snhYP+0xb2ybM71u5wiEX4/5rcTj5c7Pw==
X-Google-Smtp-Source: ABdhPJx3qUqm8D+MvhzJv8yo3TmSo9hTYPFYIbXvo26tL6U4gur7fI6B/LsMvGG2bOFUWelJ1aarRW0hBAjmL6Wq+v0=
X-Received: by 2002:a19:f249:: with SMTP id d9mr5952890lfk.229.1631835180984;
 Thu, 16 Sep 2021 16:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210908013218.29702-1-wenbin.mei@mediatek.com> <20210908013218.29702-2-wenbin.mei@mediatek.com>
In-Reply-To: <20210908013218.29702-2-wenbin.mei@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 01:32:50 +0200
Message-ID: <CACRpkdYxSwr05eK1x+BAgHxgccQWGUxW-_q_xSGmfkTHEbs+5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 8, 2021 at 3:32 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:

> Add hs400 dly3 setting for mtk-sd yaml
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Excellent doc!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
