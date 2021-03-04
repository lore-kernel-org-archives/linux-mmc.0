Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97102C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6001F64F1E
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhCDIte (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhCDItK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 03:49:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6DC061761
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 00:48:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id e7so41907257lft.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2wbxkZ5EFhhbbOmwBTKlvU1xjWHEm3aG6/6XZryrvM=;
        b=aP2tQTyLBKDPBoAnWKTOPwDqLrDfAzvHWjHRByw8Q2HneMAUDwP/6S3cHX5ozzAxSc
         mr/c++GCpYQcsIn0n4iMZK9iT+3Y7/GTWYLayG5b/NiUHV292Obc1KsdVePmOAGnuFnP
         dLZ/btA6PpMa1U/KMCHGMNAhub4bmozr5RJZbJ75y+St9LLksdz4HQpeMyyM7q0NGTKb
         XJDLW/N8DaA3AIdtaanC7CBGLXPw/Uhx+oOn1uJvR86/6/n8c4BOOsXxLikhMEf/1yeJ
         Ywnj2iLiASEAeh15xadVyP/Dpk+E/MQpIq83p6oFAXLQOHQhWs+U1ByEjbei5Bug16y2
         fJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2wbxkZ5EFhhbbOmwBTKlvU1xjWHEm3aG6/6XZryrvM=;
        b=imbV09IbqjQ25f+AwvLWCOESEpmSsnbP/gHE9nNBUwHNqas7goZcDPvlOSQipQ2Xdf
         qSF1/1Olmm8poWpZXzWdROORu4Fdon1yMzhiYcPiSUQR/eoUJIZRLlaaFdrKWMG/shkt
         DKKFFfjPANagk39BLMgRzhov00CfihcoIp8kE8ZUNM4u9YvRGGeiCymOjSZc8TRTkKfC
         +a5B52OTf05pnE5JMqgAOtSztv+OxN0Wh79Ua7bjyuEE7loPj6wp4/ZX4qS5d3uNmIcu
         5OTp2KZGtE6EEM3GAdRZjzqKjjudzS+wHK4b04ASBuW0MYnP3LVVQI97XLarnw0nRENs
         BuVw==
X-Gm-Message-State: AOAM533eQaL6/92rVYzN5fOKgBqpn2XR0NOhUE8vrOdHDKGSZE/v/fsH
        QGJkTtKo0+TJokde5vevnALzAuuf72V8E1Bus8RgIw==
X-Google-Smtp-Source: ABdhPJy1+p6e1tWc1GyX6LEEz232ReBa7exSHnMHwCH8+LPQuXuIdaQFmdvSbMVG2X4FN7uvfv/aIVi6+AmRoKuFNHc=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr1696001lfl.529.1614847708722;
 Thu, 04 Mar 2021 00:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-4-brad@pensando.io>
In-Reply-To: <20210304034141.7062-4-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:48:18 +0100
Message-ID: <CACRpkdbqkmUXTPyX8OFxBRJahEL-vdxR0wP=rMAWud34bq7tcQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: dw: Add support for Pensando Elba SoC SPI
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:

> The Pensando Elba SoC uses a GPIO based chip select
> for two DW SPI busses with each bus having two
> chip selects.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

I agree with Serge's comments here: the existing cs callback should
work for your SoC, you should only need the new compatible string.

I see why you need the special GPIO driver for this now, as that
is obviously driven by totally different hardware.

Yours,
Linus Walleij
