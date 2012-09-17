From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: dt: Support "power-gpios" property
Date: Mon, 17 Sep 2012 12:39:40 +0800
Message-ID: <CAN1soZweREKHqtzcYEzRPnTQd_D-sgjv4HJj0jKL22MviBrUFw@mail.gmail.com>
References: <87ligjzyge.fsf@octavius.laptop.org>
	<CAMj5Bkji+WV0dx7vuC8OxprbW0TAOWBsCUimmr5r9iiXAEVw_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63603 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2IQEjm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 00:39:42 -0400
Received: by wibhq12 with SMTP id hq12so3902510wib.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Sep 2012 21:39:40 -0700 (PDT)
In-Reply-To: <CAMj5Bkji+WV0dx7vuC8OxprbW0TAOWBsCUimmr5r9iiXAEVw_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, kliu5@marvell.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Tue, Sep 11, 2012 at 1:00 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> On Sun, Sep 9, 2012 at 11:06 AM, Chris Ball <cjb@laptop.org> wrote:
>> Tested on OLPC XO-4/MMP3, where the card power for two of the
>> controllers is a sideband GPIO.  The third cell in the power-gpios
>> property controls whether the GPIO is active high/active low.
>>
>> (Also, pass host_caps2 through from platdata to the mmc host.)
>>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>> This patch depends on "mmc: slot-gpio: Add support for power gpios"
>>
>>  drivers/mmc/host/sdhci-pxav3.c          | 25 +++++++++++++++++++++++++
>>  include/linux/platform_data/pxa_sdhci.h |  2 ++
>>  2 files changed, 27 insertions(+)
>
> Thanks Chris.
> One questions is could we simply use fixed voltage regulator to control gpio?
> And register this gpio as vmmc.
>
> Thanks

Hi Chris,

As my understanding, the buck/LDO supplies power to MMC slot with 2.8V. We
can call it as regulator A. GPIO pin is used to control this power
supply to MMC
slot. We can call it as regulator B (fixed regulator).

I think that we can linked these two regulators as cascade. Since we
won't change
voltage as regulator A. This link won't bring us any issue. So we only need to
control regulator B in mmc driver. How do you think about this idea?

Regards
Haojian
