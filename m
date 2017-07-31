From: Jerome Brunet <jbrunet@baylibre.com>
Subject: mmc: UHS Voltage switch and operating frequency question
Date: Mon, 31 Jul 2017 18:20:04 +0200
Message-ID: <1501518004.2759.5.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38420 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdGaQUH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2017 12:20:07 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so174776417wma.1
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jul 2017 09:20:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

Hi Ulf,

I am working on adding signal voltage switch callback to the meson mmc driver.
While testing, I noticed that a few cards fail to exit the busy state after the
voltage switch.

After tinkering with the driver a bit, I noticed that increasing the clock
frequency from 400kHz to 1MHz solve the problem. Strange, isn't it ?

I'm don't know MMC that much but is it possible that some card require a minimum
operating frequency to enter UHS mode ?

The simplified spec (Part 1 - Physical Layer) says that before CMD11, we should
have had CMD41 (Init Command) . After CMD41, the card should be operating at
Default Speed or SDR12. 

I believe that in both case, the frequency is "up to 25Mhz" ? This would be the
maximum, but is there a minimum ? 400kHz seems pretty low compared to 25Mhz ...

I hope you will able to shed light on this :)

Best Regards
jerome
