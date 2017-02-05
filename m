From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 1/9] mmc: meson-gx: fix setting f_min
Date: Sun, 5 Feb 2017 16:15:08 +0100
Message-ID: <321a326a-b3dc-7ecc-e435-e7c868798695@gmail.com>
References: <e8f1b59a-927b-b50e-4137-0b4b9e3cbc6e@gmail.com>
 <CAPDyKFq9mScEuqcmP0E3Lz0APhYbHYtyUvc6WXkGGXR1OZavgg@mail.gmail.com>
 <78e18d60-8359-df37-ebcb-34134b31f708@gmail.com>
 <CAFBinCB=xx41G4pUsCmMPAxyXutGBDJkapO8Ezd7gdCHOdzY6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34478 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdBEPPP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Feb 2017 10:15:15 -0500
Received: by mail-wr0-f194.google.com with SMTP id 89so1395758wrr.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2017 07:15:14 -0800 (PST)
In-Reply-To: <CAFBinCB=xx41G4pUsCmMPAxyXutGBDJkapO8Ezd7gdCHOdzY6A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 05.02.2017 um 02:28 schrieb Martin Blumenstingl:
> On Sat, Feb 4, 2017 at 11:12 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [snip]
>> Requesting 100kHz resulted in f_min = 0 in my tests. Same for 200kHz
>> and 300 kHz. 400kHz results in f_min = 400kHz with actual rate = 380kHz.
>> 380kHz = 24MHz / 63 is the lowest possible frequency on Meson anyway.
>> All requested frequencies below this value seem to be rounded down to 0.
> doesn't that sound more like an issue with the clock configuration
> which should be investigated? the divider for example has
> CLK_DIVIDER_ROUND_CLOSEST set, removing that will probably make it
> round up (but I'm not sure if that would break other things).
> 
IMHO rounding down makes sense as it prevents the system from silently
setting a frequency higher than requested.

In case we would prefer rounding to closest frequency, most likely
we would have to replace the default ops in init.ops = &clk_mux_ops;
with ops using __clk_mux_determine_rate_closest.

Heiner
> 
> Martin
> 

