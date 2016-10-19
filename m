From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4] MMC: meson: initial support for GX platforms
Date: Wed, 19 Oct 2016 11:01:53 -0700
Message-ID: <7hinso8bfy.fsf@baylibre.com>
References: <20161018195605.21145-1-khilman@baylibre.com>
        <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34157 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941011AbcJSSB4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 14:01:56 -0400
Received: by mail-pf0-f180.google.com with SMTP id r16so19906815pfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 11:01:56 -0700 (PDT)
In-Reply-To: <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
        (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 13:20:54
        -0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Javier Martinez Canillas <javier@dowhile0.org> writes:

> Hello Kevin,
>
> On Tue, Oct 18, 2016 at 4:56 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
>> family of SoCs.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> [snip]
>
>> +
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>
> Why is this module alias needed? I thought that the Amlogic was a
> DT-only platform and so devices will always be registered from OF (and
> the OF modalias used).

You're right, I probably copy/pasted it from another driver.

Testing without it also made me realize that the module filename (meson_gx)
isn't really useful when listed in lsmod, so I 'll respin to have mmc in
the filename so the module name also shows mmc.

Kevin
