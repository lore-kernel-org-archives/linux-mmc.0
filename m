Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2FDC433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BC764F10
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhCDIxR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhCDIwp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 03:52:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00089C061756
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 00:52:04 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e2so25162974ljo.7
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0XMK2C3jkeiWB9VzQQQ0cOj8xpFdNqQrK20xkK9i1A=;
        b=lSyQGH2WdOfmSXrtbCsBPnVj//cGCUNzQNd2nr1iLgsYdyeZ2UROgyYVda1T5m9WZv
         jA2MSnC5sCaprR0fPW8ymMXHYN2M6dEqr2RPA8gAtydmewhOZ2GJHpCyWdQbdYAyultX
         tneNhjNhyv3tFI63o9bv/6LGmMb3e3ExnfPvMR89aqyP8c3o6KiFKCku6legmwk0p2OO
         UbIEc/1a1Mm6ldokUTB431l3fFt5z0lXZfiwu6LEzJiNxn+m8bhju8ijAn3XefLCtWvu
         yMho7AlweWK+1JmlcbjdAANchs2FW3KyRGkcZxqaxQsDp5xnSQgI1upmqresIJZc7Pwq
         /OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0XMK2C3jkeiWB9VzQQQ0cOj8xpFdNqQrK20xkK9i1A=;
        b=QzdnVEGazHmN8+bhH/mU8LPMjoKPfdospnAULk+5Hvtd4jCBB0VN0OlNriu7F9OpxD
         T1bWaSEOnd2ELxsoS20AEyYyKYcGXUSLYlAJX8lAHS/WXarT+2hLu1NXOdUCyooevFJl
         wvARQD34MCrY3koF9LeJBVxKxMU7Y2yy+96LlxgevMHWb+5gE71iX+Yg3H7oQ78dOszC
         wRJRC/DwLFXS4k9p5bI8eLmQ1GaSccZd1/1sA4dIsPkigsnm/OL5b4z62+Pf7f9HFXNy
         pO5u16C0XxBlc4YPW8lGvNF/smM3Kbg+RsltHBZcmiGGLbb3N5/eYsQZe9y4KrgABEGF
         7AFw==
X-Gm-Message-State: AOAM532QWUZyTy80gzC/IyFkLzjR/KfzUluPrw1iclu9ygLA00+m/Cw+
        LksJEnlSV4fN12JJynk2VKDnTlLkRm6+RDhOhk+fOg==
X-Google-Smtp-Source: ABdhPJzbb++Rp2hEA6RLGpqIxuh+P7Z4Bnbc7cEOCh/2DXY+1S8b4BFA/vD6pDDcq1594E0+HBqctMM4/DGjkb4ej40=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr1838007ljw.74.1614847923518;
 Thu, 04 Mar 2021 00:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
In-Reply-To: <20210304034141.7062-8-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:51:52 +0100
Message-ID: <CACRpkdZr8qrQ+b15z_zRP3wAntQeW7T0Z515sUv6e2gL9GzDyg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
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

> Add Pensando common and Elba SoC specific device nodes
> and corresponding binding documentation.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
(...)
>  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++

Please use YAML schema for this.

See Documentation/devicetree/writing-schema.rst
for instructions, you need to install some python pip packages
to test your schema.

Yours,
Linus Walleij
