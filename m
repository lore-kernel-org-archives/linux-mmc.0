From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: mediatek: Add online-tuning support of EMMC/SD
Date: Wed, 26 Aug 2015 17:06:45 +0200
Message-ID: <CAPDyKFp0Eypyr8Asx_-_+VOfnDVW19Lrc-MmG2XA8kW+WM6Cnw@mail.gmail.com>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
	<1439367845-5891-2-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFpX4Pp1+U9eNBuGd83sBeBgLU17qysAJ-2V-ABZZHYAGQ@mail.gmail.com>
	<1439812888.5627.9.camel@mhfsdcap03>
	<CAPDyKFpGk9gcLLjBnN=+BD5WP-7dZ0+XHC1bcEEGGLvLbTyKHw@mail.gmail.com>
	<1440578416.26912.12.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1440578416.26912.12.camel@mhfsdcap03>
Sender: linux-gpio-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek
List-Id: linux-mmc@vger.kernel.org

On 26 August 2015 at 10:40, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Tue, 2015-08-25 at 14:07 +0200, Ulf Hansson wrote:
>> On 17 August 2015 at 14:01, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> > Hi Ulf,
>> > Thanks, please see my comment:
>> > On Mon, 2015-08-17 at 13:31 +0200, Ulf Hansson wrote:
>> >> On 12 August 2015 at 10:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> >> > Schedule a workqueue to do tuning when CRC error
>> >> > Call mmc_hw_reset to re-init card when data timeout
>> >>
>> >> Thanks to Adrian Hunter, the mmc core already supports re-tuning for
>> >> the above scenarios through the mmc_retune_*() APIs.
>> >>
>> >> SDHCI driver has already adopted to use that feature, you should do
>> >> that for the mtk-sd driver as well.
>> >>
>> >> Kind regards
>> >> Uffe
>> >>
>> > I also noticed that the mmc core already supports re-tuning, but it is
>> > not suitable for our host.
>> > For EMMC, the CMD21 only support HS200/HS400 mode, for SD card, CMD19
>> > only support SDR50/SDR104 mode, but in our host, even 50Mhz clock
>> > frequency may also occur CRC error, Cannot find a parameter that can
>> > cover all SD cards which running at 50Mhz, even 25Mhz, will occur CRC
>> > error for stress test, DDR50 mode is worse.
>>
>> I don't follow. You may run for example HS200 in lower speed, nothing
>> will prevent tuning and re-tuning from happen for these scenarios.
>>
>> Or you are talking about other speed modes than HS200/400 and
>> SDR50/104? If so, which speed modes are these?
>>
> Yes, I am talking about other speed modes.
> For SD card, the speed mode is High Speed, for EMMC, the speed may be
> High Speed or DDR mode.
> If CRC error occurs at these speed modes, the MMC core layer will never
> handler it. even propagate the -EILSEQ towards to the mmc core, it will
> not start mmc_retune.

That's true and that's because the MMC/SD/SDIO specs states it.
Moreover, there a no tuning ever executed even while initializing such
cards. I think you need to elaborate more on what kind of "tuning"
your controller needs for these legacy speed modes, can you please do
that?

Currently the mmc block layer has request retry mechanism when
encountering IO errors. That may even reset or power cycle the card,
via mmc_hw_reset(). Isn't that sufficient?

>> BTW, there are currently a patch being discussed which is about adding
>> tuning for DDR mode. Please have look.
>> http://www.spinics.net/lists/arm-kernel/msg438434.html
>>
>> Regarding re-tuning on CRC errors, that's already supported by the mmc
>> core. More precisely when a host driver returns -EILSEQ for a request.
>>
>> > By the way,there are too many tune parameters need try for response,
>> > read data, write crc status CRC error, these parameters are
>> > multidimensional, it is hard to find a best parameter, and, try
>> > thousands of parameters will take long time.
>>
>> As I see, it's your responsibility from the host driver to propagate
>> the proper error code towards the mmc core. If you encounter an error
>> that you want to trigger a retune, just return -EILSEQ.
>>
>> Moreover, if you see a need to extend the tuning/re-tuning support in
>> the mmc core to suit your need - I am definitely open to look into
>> that. More importantly, I don't want to see host specific hacks trying
>> to deal with this.
>>
> In addition, the CMD21 is only valid for HS200 mode, do not support
> HS400, So that there is no chance to tune the HS400 read/write data with
> current mmc core layer codes.
> As you see, in our platform, tune of HS200 and HS400 is different, but
> if use the CMD21, it will never work at HS400 mode, even with
> "prepare_hs400_tuning", but it prepare what ? what we need is that
> running at HS400 mode and tune the read/write parameters, but not HS200,
> because for data Rx path, the tune result of HS200 is meaningless for
> HS400.

So, should we perhaps add another host_ops callback to satisfy your
need for HS400?

Kind regards
Uffe
