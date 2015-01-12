From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: core: Add support for MMC power sequences
Date: Mon, 12 Jan 2015 15:43:24 +0100
Message-ID: <CAPDyKFoXxCT8uED3SxY9e1N6HhRyk1RGwpHOHRtzUY5vcBtcYA@mail.gmail.com>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
	<CAAObsKDXTwmXQ_oviSv4jyvaVepgsw8g5VJNpt1X=JCzfpTYuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:52924 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbbALOnZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 09:43:25 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so18178620qcv.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 06:43:25 -0800 (PST)
In-Reply-To: <CAAObsKDXTwmXQ_oviSv4jyvaVepgsw8g5VJNpt1X=JCzfpTYuw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, NeilBrown <neilb@suse.de>, Linus Walleij <linus.walleij@linaro.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12 January 2015 at 15:26, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 2 January 2015 at 17:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> This is yet another try to solve the issues of dealing with power sequences for
>> the MMC subsystem. The latest attempt, see link below, took a generic approach
>> by adding a new top level driver layer. That's was rejected by several reasons.
>> http://lwn.net/Articles/602855/
>>
>> This time the approach is focused to fix the issues for MMC only.
>>
>> To give a short background, SOCs may specify a specific MMC power sequence. To
>> successfully detect an (e)MMC/SD/SDIO card, that power sequence must be followed
>> while initializing the card.
>
> Hi Ulf,
>
> have used this to successfully init a mwifiex_sdio card but had to
> also add a delay while the reset line is asserted. May make sense to
> add a property to the pwrseq node to specify the minimum amount of
> time that the reset GPIO needs to be asserted?

To me that is description of the HW, so I would happily accept such a
DT property. Can you please send a patch, based on top of this
patchset?

BTW, I guess you only need the delay while the ->power_up() callback
is invoked and not for ->power_off()?

>
> Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks for helping out testing!

Kind regards
Uffe
