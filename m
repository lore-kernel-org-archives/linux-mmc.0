From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 00/14] mmc: meson-gx: driver fixups and upgrade
Date: Mon, 07 Aug 2017 14:44:00 -0700
Message-ID: <7hshh3njdr.fsf@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
        <1502124502.2759.32.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32785 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdHGVoC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 17:44:02 -0400
Received: by mail-pg0-f47.google.com with SMTP id u5so6550037pgn.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 14:44:02 -0700 (PDT)
In-Reply-To: <1502124502.2759.32.camel@baylibre.com> (Jerome Brunet's message
        of "Mon, 07 Aug 2017 18:48:22 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri, 2017-08-04 at 19:43 +0200, Jerome Brunet wrote:
>> The patchset features several bugfixes, rework and upgrade for the
>> meson-gx MMC driver.
>> 
>> The main goal is to improve readability and enable new high speed
>> modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
>> 
>> While full speed SDR104 is stable with most cards, a few seems to
>> require an even more precise tuning. For this, we'll probably have
>> to implement per-line delay calibration.
>> 
>> This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
>> gxl-s905x-libretech
>> 
>
> Ulf, Kevin,
>
> Please ignore this series. I'll resend it soon
>
> I've discovered new things around the tuning capabilities of the SoC.
> I'll probably rework the tuning function again.
>
> Sorry for the noise

No worries, I had a couple very minor comments on some individual
patches. Other than that, LGTM.

Feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

to anything that doesn't need major rework.

Also, You might want to separate out the fixups/cleanups from the
voltage/clock changes stuff.

Kevin
