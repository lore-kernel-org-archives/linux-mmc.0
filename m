From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Thu, 8 Dec 2016 15:05:41 +0100
Message-ID: <CAPDyKFpFmBnydazS0pYOYajN1-QOiw=Sxid6Uuxn8z4RMVO3KA@mail.gmail.com>
References: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com>
 <1480903854-22701-3-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqbAzCyXArikgTUeTrs9vOzfwKWJcs3TgF7D-4f_xfjfQ@mail.gmail.com> <CAK7LNAQkJO0vN9T-pB3ys4N=3pG9wdWZ9z+VkYToL7F_fLo9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f171.google.com ([209.85.210.171]:33597 "EHLO
        mail-wj0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753187AbcLHOFo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2016 09:05:44 -0500
Received: by mail-wj0-f171.google.com with SMTP id xy5so389108878wjc.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2016 06:05:44 -0800 (PST)
In-Reply-To: <CAK7LNAQkJO0vN9T-pB3ys4N=3pG9wdWZ9z+VkYToL7F_fLo9dA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Andrei Pistirica <andrei.pistirica@microchip.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Joshua Henderson <joshua.henderson@microchip.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>, Eric Anholt <eric@anholt.net>

On 8 December 2016 at 13:52, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Ulf,
>
> 2016-12-08 21:32 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 5 December 2016 at 03:10, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> Add a driver for the Cadence SD4HC SD/SDIO/eMMC Controller.
>>>
>>> For SD, it basically relies on the SDHCI standard code.
>>> For eMMC, this driver provides some callbacks to support the
>>> hardware part that is specific to this IP design.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Thanks, applied for next!
>>
>
>
> Very sorry for my fix at the last minute.
>
> I've just posted v5.
>
> Please make sure to apply v5.

Okay, I have replaced v4 with v5.

Perhaps you should have a look at my next branch to make sure it's all okay.

Kind regards
Uffe
