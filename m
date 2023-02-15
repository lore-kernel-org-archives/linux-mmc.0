Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BBC6379F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 12:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBOMtD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 07:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjBOMtC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 07:49:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9857934C10
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:49:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ja21so12533526plb.13
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676465341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ4BUazyXS0K48fM6Er+hgNzJxPV4473C9yyzDZurhE=;
        b=DnpL/OJbs517pIJBv7UZkQPXuJR8Z2nfHPQPSGrgVEB3AgGXe2/9z+9pl6fRYuEKQM
         WUXCCVLCc7uOKfu6lT8/n27etN4D1EUA1S5awS7D9NnaxpLT3fHsB8AeSUaNPZTJ+rHF
         3Lq7mJgUAF44j3l1vtS++BCkZTin7RWVvctVr5/ejSMFlBostfi8WmjJFAo8t12fBQvz
         +1ZR7z5r4yy6pchXbNEZ0jeqZiHTPQNQu3omoRURf0W0Jj2VTXTJptKR6ZQNjR+Rwy+K
         qGTKHlG5fWbxis6XjSz4CJzknCwL/XpkLOHr6cinqtsRyEotQXxTotW8jO31FcB1DZvk
         wmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676465341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ4BUazyXS0K48fM6Er+hgNzJxPV4473C9yyzDZurhE=;
        b=Vg6BsAOeWhIcpFIsxgPQRcRPsANBk4hAt2zBJKbx0Hrh+N/I8/vkQR8Ah/2hae6P/t
         J/jYVrljH/j//dijapxEeQJqGT+WwfTP8YQkvxN7kYhB6I81BxX+CRM3H8ggQ58FWDe2
         pX1dh/TZqY2TQY/jATtVtyLKXBCDszTW4qVkjWwfp/+TDKTNTDMSG/60mypYyFeHrnk7
         F3RLAgkbP0TNRt6S6ofF91bvvlDRREo0wmUBDy2MKQkSI1Ji5F+BJxgCBJSJ1ElVSEVm
         L1nl8yTWOfoePAaarXtIBeXNGmZKCuzM5mAK8CA6HLSpVNEBKE2D+tRUzBNls7FM1OLK
         Avlw==
X-Gm-Message-State: AO0yUKWWg369HnjOumgMIVWmtTEuhIDoE6fVP4dju9AoDJtGk3GXUII6
        ZkQQEnWczYfPz/jF0HTUSXhZ+efY2sFtJZVU46DCWQ==
X-Google-Smtp-Source: AK7set+T7NKsh+QRbmcYjfUFAkz8tVhEKaLuhSPZ8VsL0cW+kM2Wy7wlgaC9MgBB5hg5VOCY6Tga4oo3jt03Pl9STMk=
X-Received: by 2002:a17:903:26d1:b0:199:15c2:99ae with SMTP id
 jg17-20020a17090326d100b0019915c299aemr469271plb.20.1676465341107; Wed, 15
 Feb 2023 04:49:01 -0800 (PST)
MIME-Version: 1.0
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
In-Reply-To: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Feb 2023 13:48:24 +0100
Message-ID: <CAPDyKFroB-TULOeia4OyXBW6rWMs7e3_Fp4Uw878Q8Gt=TDfag@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: support setting card detect interrupt from
 drivers and use it in meson-gx
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Feb 2023 at 22:39, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
> due to the design of gpio / interrupt controller. Therefore provide an
> option for drivers to pass the card detect interrupt number
> (retrieved e.g. from device tree) to mmc core.
>
> v2:
> - use another mechanism for passing and storing the cd interrupt
> - add patch 2
>
> Heiner Kallweit (3):
>   mmc: core: support setting card detect interrupt from drivers
>   dt-bindings: mmc: meson-gx: support specifying cd interrupt
>   mmc: meson-gx: support platform interrupt as card detect interrupt
>
>  .../bindings/mmc/amlogic,meson-gx-mmc.yaml      |  2 +-
>  drivers/mmc/core/slot-gpio.c                    | 17 ++++++++++++++++-
>  drivers/mmc/host/meson-gx-mmc.c                 |  5 ++++-
>  include/linux/mmc/slot-gpio.h                   |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
