Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37250C41535
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJQLdC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQLcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:32:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D055A1E716
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f23so10492666plr.6
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFZAkgQVKGfDZFAsZcs3VpuVekeTrUTJT67TyCxEN30=;
        b=UA1It1zbSwRfJj28MU6PnRptI/IEZ8XuZ0lMn2NhltmuEwdyBwsCkDMYv8tKyM8iK4
         deeePjYDWgdFbxYqj4ZVC284OGhaHLIUQSfIUV+VOpMVZ29a7dht2Qx8p1eMSvNKQOo1
         K3BuUIjj0OpaSBFrGZB6sk4hvyeL5S6MRjCtHUIowlxwd+22Re7T0+kTRTXqNhJgeKzD
         55NC4I/uLff9s/SRzyjM4RPoYsiYy1YkXZYzPNc52dMF4r4dt9GAal631DJFMufUeZxe
         IMAtjgG7bXphJ5AYebX1z/JGNhSaTPjvQk42S/HGk+TWYuSz3LgXMi76r2Q5la+7vMXm
         HuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFZAkgQVKGfDZFAsZcs3VpuVekeTrUTJT67TyCxEN30=;
        b=fGIRCXTWuFdJg6gE6O0uJN+ooj69H12k3/udQA+qocrEML6uq/ffVKpjyr23MR4QQY
         52BS+JVRWsg+v5yyhcsP1L/4dDXpV0XcMW4k+GcjBckSSpmqcLJOUGN2wmR3aPJjJYxz
         0rWMs4kN/t0n/CuaHIhv3FwlzqRIOhPsGG2NiH5MLYP4sv51gQGfK933xQWhZXBzRgDN
         q8ib+OSi8+RDuHDXL7Ym5tmPu6Y8txL/N/Lt2MCuq9x6bEWMLEoxKKKglF1gLZcjpt3/
         Ymn+/iRnJPpddA1cwMfUoaq8lRNo5Z2zWiwdhSvc9zSTEUz7v2++M9kVobRBM6+aEBUl
         FcfQ==
X-Gm-Message-State: ACrzQf1F+mi/NgFLZNEHtVS74si+LJY03br/arVxlOChRZFsmWfal73r
        MA6uxEC7aLr6Y9M0K08YO/SP5abIMEfAWD8jqKqL3g==
X-Google-Smtp-Source: AMsMyM56W8HNW0wj/hARLIDv0QHhOGQAKyiiDcRuFr/Z9WfxiacZAshf2EGBYm8ugWgCI/qbnX/BXd/uGVdJdB34dFc=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr11551113plh.37.1666006366377; Mon, 17
 Oct 2022 04:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221008165627.114782-1-linux@fw-web.de>
In-Reply-To: <20221008165627.114782-1-linux@fw-web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:32:08 +0200
Message-ID: <CAPDyKFrtW0Uz3beYyhGmrzF=Ge39T8_eCz8=mH4zasxhE9ZRVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add mmc-support for mt7986
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 8 Oct 2022 at 18:56, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> This small series adds dt-binding and driver change for supporting
> mmc-controller of mt7986.
>
> Sam Shih (2):
>   dt-bindings: mmc: Add compatible for Mediatek MT7986
>   mmc: mediatek: add support for MT7986 SoC
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  1 +
>  drivers/mmc/host/mtk-sd.c                         | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
