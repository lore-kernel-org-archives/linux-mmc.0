Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37659C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiKGUOm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiKGUOK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:14:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB002AE2D
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:14:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15734399pjc.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IgPXmc42gSS+9RDbk9bPwPQ6xa5IFwcVI8Es/AMs5QQ=;
        b=Lv0jaAlJO3Pfx2NP9fOi99sjktk/EKRfwOlofukUKOgpp9M2209JDrInYlC/Hb96kX
         WiFgfbpqnRnlKBoFNwrkXH8hdPPEdvc+JMppDiaruAqyLaQClFKAVZtFDzGkHwW7T2RL
         WmqOYCgFSpdcFq5UUU2a314WlDmSL5htwNEqvYznRbM62EhrkUo4OQ60Zi7OKV7aVCqN
         nrAAeEPNouP9/5fi3qrJL26TZ2acC+1IMFkeaV1a3w4/bMys9H4EYRl0pvQ5A5ZL4kee
         +s0yRYYrISNeQuVGL6Zs/zy2ps2eAYlnxiOGNZxpi60pbVpK5w27mE62FYhwoABPH+2A
         C+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgPXmc42gSS+9RDbk9bPwPQ6xa5IFwcVI8Es/AMs5QQ=;
        b=wlVZo0XF9FoRGzeXiaggRlgO+lgAdc9mzu5CsU+FxDej8CY9hYgYLq++648hq/r1dR
         Rumu+hHjD8gvDzzp85/0ohiOG7xYZwRpJPzfjssRhPH/C82WE6Flmgmh5YenetBrL7px
         4Z4M5csjTAWN1MsB+WET6L3AS9ET74flG2e0YXj2NgCnaCmSi2YTQsaU0tik7ccMcgNB
         UZEs4V5vKPu1ec+fQPcCKgiWj7Mxq4vZsVj9vilmwpvoKRomaVoZit+sJ7ynAJX1nhlq
         pbnYwihF2Yw6NoDhPUB07wC2PD3ijJB6yCbpNW5uqsztRm6Co2Hj30w5y1lYjrVjzdpM
         t5uw==
X-Gm-Message-State: ACrzQf0tiF4K9QdRXot5EgBNIHcDPT0KQKlEQJFIFVp4g6SVHO4y7sr1
        rrNhkcn9+gbTT5faffUJqiH+cBRt7tuBEycGoVPk8w==
X-Google-Smtp-Source: AMsMyM4Uqs3O9TcimuuptYpAiUUKJmyf19xvGSioeogsaTGjXrG+KhSscjv5iIa2S1MqvOlKLMq04hYJyEoDAQTxJ/A=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr71864059pjb.164.1667852042927; Mon, 07
 Nov 2022 12:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:25 +0100
Message-ID: <CAPDyKFp4wEaiGvyXQJPehbDkkZReUXk5fsXwJGLpVX9w2ZOZjQ@mail.gmail.com>
Subject: Re: [RESEND v2 0/2] Mediatek eMMC Inline Crypto Engine support
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc:     chaotian.jing@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        wenbin.mei@mediatek.com, angelogioacchino.delregno@collabora.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 6 Nov 2022 at 04:39, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> Change in v2
> - change patch 1 commit title
> - change patch 2 commit title, and correct commit message
> - add crypto clock description base on new code base
>
> Mediatek eMMC hardware IP has Inline Crypto Engine (ICE), we support inline encryption now.
>
> This patchset supports Mediatek eMMC inline encryption which meets the upcoming version of the eMMC specification such as v5.1 or v5.2.
>
> Patch 1, add crypto clock control flow in mtk-sd driver, patch 2, document the device tree description about crypto clock.
>
> Mengqi Zhang (2):
>   mmc: mtk-sd: add Inline Crypto Engine clock control
>   dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
>  drivers/mmc/host/mtk-sd.c                     | 12 ++++++++++
>  2 files changed, 34 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
