From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFC 0/2] Add support for Meson MX "SDIO" MMC driver
Date: Sat, 27 May 2017 16:25:51 +0200
Message-ID: <CAFBinCAUEgXZ7PUinrOahpRsg8=m5Um7ju518PiFpqnmPxvQqw@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA@mail.gmail.com>
 <CAFBinCDGBZAAx_61eyu1_XM57fX62Mk03TEiO3uTL+i8dfPyZA@mail.gmail.com>
 <CAPDyKFoC-cCEY+n2383W+JgDANbBMFbsU5cyB51-kG4kbLNNcw@mail.gmail.com>
 <CAFBinCDocqqo2GNLb2y1XE0ATTEG6TuqO+EZ_-h8=vuTjngr_Q@mail.gmail.com> <CAD8Lp46oR0ODa4ybVW-rMPki9126My+ymxigZmjGwxPm2y1L3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33577 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbdE0O0N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 27 May 2017 10:26:13 -0400
In-Reply-To: <CAD8Lp46oR0ODa4ybVW-rMPki9126My+ymxigZmjGwxPm2y1L3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@caione.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Daniel,

On Sat, May 27, 2017 at 4:48 AM, Daniel Drake <drake@endlessm.com> wrote:
> On Thu, May 11, 2017 at 2:44 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> the code-names of the older (32-bit) SoCs (at least the ones which are
>> not too old) all start with Meson X (where X is a number: Meson6,
>> Meson8, Meson8b and Meson8m2), Amlogic's vendor code sometimes calls
>> these "MX" (or Meson MX)
>
> Just in case it helps you on any future adventures in the Amlogic
> vendor code: I think this is not quite right. I believe that MX
> specifically refers to Meson6 and no other SoC generation.
thanks for that hint - I guess that's due to the marketing name of the
Meson6 SoCs then (AML8726-MX). do you know if there's any codename
that includes the Meson6 and Meson8 (including Meson8b and Meson8m2)
families?


> That said, if both MesonX (==Meson6) and Meson8/Meson8b all share the
> same driver code, having this driver named "mx" makes sense to me,
> especially because it helps distinguish from the GX* chips which
> indeed have something rather different.
from what I could read in Amlogic's GPL kernel sources the MMC
controller IP is also used in Meson6 SoCs (and possibly even older
generations). that said, I don't have any Meson6 hardware, which is
why I didn't add the "amlogic,meson6-sdio" binding.
so I guess using the "mx" name here should be OK (nevertheless, I'll
make sure that I don't use "MX" for anything that's
Meson8/Meson8b/Meson8m2 specific)


Regards,
Martin
