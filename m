From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/9] mmc: meson-gx: fix setting f_min
Date: Sun, 5 Feb 2017 02:28:56 +0100
Message-ID: <CAFBinCB=xx41G4pUsCmMPAxyXutGBDJkapO8Ezd7gdCHOdzY6A@mail.gmail.com>
References: <e8f1b59a-927b-b50e-4137-0b4b9e3cbc6e@gmail.com>
 <CAPDyKFq9mScEuqcmP0E3Lz0APhYbHYtyUvc6WXkGGXR1OZavgg@mail.gmail.com> <78e18d60-8359-df37-ebcb-34134b31f708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35615 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdBEB3R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Feb 2017 20:29:17 -0500
Received: by mail-qk0-f193.google.com with SMTP id u25so3957301qki.2
        for <linux-mmc@vger.kernel.org>; Sat, 04 Feb 2017 17:29:17 -0800 (PST)
In-Reply-To: <78e18d60-8359-df37-ebcb-34134b31f708@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On Sat, Feb 4, 2017 at 11:12 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
[snip]
> Requesting 100kHz resulted in f_min = 0 in my tests. Same for 200kHz
> and 300 kHz. 400kHz results in f_min = 400kHz with actual rate = 380kHz.
> 380kHz = 24MHz / 63 is the lowest possible frequency on Meson anyway.
> All requested frequencies below this value seem to be rounded down to 0.
doesn't that sound more like an issue with the clock configuration
which should be investigated? the divider for example has
CLK_DIVIDER_ROUND_CLOSEST set, removing that will probably make it
round up (but I'm not sure if that would break other things).


Martin
