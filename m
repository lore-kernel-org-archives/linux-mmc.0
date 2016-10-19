From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4] MMC: meson: initial support for GX platforms
Date: Wed, 19 Oct 2016 13:20:54 -0300
Message-ID: <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
References: <20161018195605.21145-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35716 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933274AbcJSQU4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 12:20:56 -0400
Received: by mail-io0-f172.google.com with SMTP id f5so36904086ioj.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 09:20:55 -0700 (PDT)
In-Reply-To: <20161018195605.21145-1-khilman@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Kevin,

On Tue, Oct 18, 2016 at 4:56 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
> family of SoCs.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

[snip]

> +
> +MODULE_ALIAS("platform:" DRIVER_NAME);

Why is this module alias needed? I thought that the Amlogic was a
DT-only platform and so devices will always be registered from OF (and
the OF modalias used).

I've seen platform module aliases in other Meson drivers too (i.e:
meson-rng and meson-pwm), so the same question applies to those.

Best regards,
Javier
