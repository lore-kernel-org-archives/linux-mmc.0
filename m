From: Daniel Drake <drake@endlessm.com>
Subject: Re: [RFC 0/2] Add support for Meson MX "SDIO" MMC driver
Date: Fri, 26 May 2017 20:48:57 -0600
Message-ID: <CAD8Lp46oR0ODa4ybVW-rMPki9126My+ymxigZmjGwxPm2y1L3g@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA@mail.gmail.com>
 <CAFBinCDGBZAAx_61eyu1_XM57fX62Mk03TEiO3uTL+i8dfPyZA@mail.gmail.com>
 <CAPDyKFoC-cCEY+n2383W+JgDANbBMFbsU5cyB51-kG4kbLNNcw@mail.gmail.com> <CAFBinCDocqqo2GNLb2y1XE0ATTEG6TuqO+EZ_-h8=vuTjngr_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36341 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbdE0Cs7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 May 2017 22:48:59 -0400
Received: by mail-oi0-f54.google.com with SMTP id h4so32568270oib.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2017 19:48:59 -0700 (PDT)
In-Reply-To: <CAFBinCDocqqo2GNLb2y1XE0ATTEG6TuqO+EZ_-h8=vuTjngr_Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@caione.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 11, 2017 at 2:44 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> the code-names of the older (32-bit) SoCs (at least the ones which are
> not too old) all start with Meson X (where X is a number: Meson6,
> Meson8, Meson8b and Meson8m2), Amlogic's vendor code sometimes calls
> these "MX" (or Meson MX)

Just in case it helps you on any future adventures in the Amlogic
vendor code: I think this is not quite right. I believe that MX
specifically refers to Meson6 and no other SoC generation.

That said, if both MesonX (==Meson6) and Meson8/Meson8b all share the
same driver code, having this driver named "mx" makes sense to me,
especially because it helps distinguish from the GX* chips which
indeed have something rather different.

Daniel
