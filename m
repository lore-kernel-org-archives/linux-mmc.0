From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Mon, 15 Apr 2013 08:05:22 -0700
Message-ID: <CAD=FV=XqmLRjQPwWCZfw0Nfu_uK16SOP=OgJcrbziWs4e__h7A@mail.gmail.com>
References: <1365698338-27503-1-git-send-email-dianders@chromium.org>
	<001701ce39d2$c0dbf8c0$4293ea40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:41230 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3DOPFY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Apr 2013 11:05:24 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so4543612lbh.7
        for <linux-mmc@vger.kernel.org>; Mon, 15 Apr 2013 08:05:23 -0700 (PDT)
In-Reply-To: <001701ce39d2$c0dbf8c0$4293ea40$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Thomas Abraham <thomas.abraham@linaro.org>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Seungwon,

On Mon, Apr 15, 2013 at 5:14 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> +             MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
>> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> This line for [1]
>> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
>> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> [1] is for mshc1. mshc1 is only used for SDIO.
> As I know, The others are improper for SDIO.

I'm nearly certain that all of the ports are OK for SDIO.  Specifically:

* On the ARM Chromebook (exynos5250) we are using mmc3 (12230000) for
the SDIO connection to WiFi.

* I have plugged in an external WiFi module to the SD card slot on the
ARM Chromebook and seen it work (including interrupts).  This is mmc2
(12220000).

* I have seen a board where mmc1 was wired up to WiFi and seen it work.


It is possible that mmc0 wouldn't work for SDIO.  I've never tested it
since mmc0 is intended for eMMC and every system I've worked with has
eMMC on that port.  There is some evidence that mmc0 would work for
SDIO, though: there is a muxing slot on GPC0[2] for SD_0_CARD_INT_n.
That implies that mmc0 ought to also work for SDIO (and even could be
configured for an external eSDIO interrupt, I guess).


Thanks!

-Doug
