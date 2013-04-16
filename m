From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Tue, 16 Apr 2013 18:30:51 +0900
Message-ID: <001601ce3a85$16087f00$42197d00$%jun@samsung.com>
References: <1365698338-27503-1-git-send-email-dianders@chromium.org>
 <001701ce39d2$c0dbf8c0$4293ea40$%jun@samsung.com>
 <CAD=FV=XqmLRjQPwWCZfw0Nfu_uK16SOP=OgJcrbziWs4e__h7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=XqmLRjQPwWCZfw0Nfu_uK16SOP=OgJcrbziWs4e__h7A@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Bing Zhao' <bzhao@marvell.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday, April 16, 2013, Doug Anderson
> Seungwon,
> 
> On Mon, Apr 15, 2013 at 5:14 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> +             MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> >> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> > This line for [1]
> >> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> >> +     MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> > [1] is for mshc1. mshc1 is only used for SDIO.
> > As I know, The others are improper for SDIO.
> 
> I'm nearly certain that all of the ports are OK for SDIO.  Specifically:
> 
> * On the ARM Chromebook (exynos5250) we are using mmc3 (12230000) for
> the SDIO connection to WiFi.
> 
> * I have plugged in an external WiFi module to the SD card slot on the
> ARM Chromebook and seen it work (including interrupts).  This is mmc2
> (12220000).
Yes, we also have tested WiFi module type of sd slot with ch#2.

> 
> * I have seen a board where mmc1 was wired up to WiFi and seen it work.
Yes, mmc2, mmc3 can 
> 
> 
> It is possible that mmc0 wouldn't work for SDIO.  I've never tested it
> since mmc0 is intended for eMMC and every system I've worked with has
> eMMC on that port.  There is some evidence that mmc0 would work for
> SDIO, though: there is a muxing slot on GPC0[2] for SD_0_CARD_INT_n.
> That implies that mmc0 ought to also work for SDIO (and even could be
> configured for an external eSDIO interrupt, I guess).
I don't mean that SDIO is impossible except in ch#1.
Basically, SDIO device can be attached on all host's channel and may works.
In case of ch#0, it's almost dedicated for eMMC and is actually arranged for eMMC.
And ch#1 is recommended for SDIO and can support UHS-I speed.
So, I don't think MMC_CAP_SDIO_IRQ is needed to ch#0.
Similarly, MMC_CAP_SDIO_IRQ is not a good choice for ch#2, ch#3 by default.
If needed for specific channel, it can be got from dts as property.
if (of_find_property(np, "cap-sdio-irq", NULL))
	pdata->caps |= MMC_CAP_SDIO_IRQ;
	
Thanks,
Seungwon Jeon
> 
> 
> Thanks!
> 
> -Doug
