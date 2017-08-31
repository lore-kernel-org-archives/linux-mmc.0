From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/13] mmc: meson-gx: driver fixups and upgrades
Date: Thu, 31 Aug 2017 12:46:12 +0200
Message-ID: <CAPDyKFpTkqH4qvLAraWxfxm=LOuWZv7P9nrznJ+o81y+9hDjjA@mail.gmail.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com> <CAPDyKFogy=L=BDKtMhKCN0nMLi-Yy5SHgAhB_=jog+CX91breA@mail.gmail.com>
 <7hr2vsdgj4.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:38101 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdHaKqN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Aug 2017 06:46:13 -0400
Received: by mail-io0-f174.google.com with SMTP id 81so20220085ioj.5
        for <linux-mmc@vger.kernel.org>; Thu, 31 Aug 2017 03:46:13 -0700 (PDT)
In-Reply-To: <7hr2vsdgj4.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30 August 2017 at 21:03, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Ulf,
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> On 28 August 2017 at 16:29, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>> The patchset features several bugfixes, rework and upgrade for the
>>> meson-gx MMC driver.
>>>
>>> The main goal is to improve readability and enable new high speed
>>> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
>>>
>>> SDR104 is not working with a few cards on the p200 and the
>>> libretech-cc. I suspect that 200Mhz might be a bit too fast for the PCB
>>> of these boards, adding noise to the signal and eventually breaking
>>> the communication with some cards. The same cards are working well on a
>>> laptop or the nanopi-k2 at 200Mhz.
>>>
>>> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
>>> gxl-s905x-libretech-cc
>>>
>>> Changes since v2 [1]:
>>> * Drop patches 1 to 3: Applied.
>>> * Drop patch 4: Debug stuff which should not have been sent.
>>> * Added fix to previous patch 3:
>>>   If the clock register is not initialized before registering the clk
>>>   with CCF, the framework will complain about an illegal divider value.
>>>   This had gone unnoticed because it was later fixed by the clock init
>>>   rework.
>>>
>>>   Ulf, I know it is getting late but it would be nice if patch #1 of
>>>   this v3 could go with 3 patches you already applied. The rest can
>>>   wait for the following cycle.
>>
>> I decided to pick them all, so applied for next!
>>
>
> Just to double-check, so I can plan for the DT patches
> accordingly... you are queuing this for v4.14, right?

Yes, correct!

Kind regards
Uffe
