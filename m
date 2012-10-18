From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 20:55:30 +0530
Message-ID: <CAJe_ZheWd3scXDhWukeZMuOOz8+bZRwZOw_ftDW8wmkqq9H45Q@mail.gmail.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
	<1350541111.5263.3.camel@vkoul-udesk3>
	<507FA595.4020507@freescale.com>
	<CAJe_ZhfarH-HpJkEOpH=jY1Gc-UPEyuA4bJ4LSQES7Uyea2BQw@mail.gmail.com>
	<CAMiH66H=VMEgHFMdEhCTqA5AtVw6iN97-cbwUd86Ghd77OLcWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52148 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2JRPZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 11:25:31 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so8936215vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 18 Oct 2012 08:25:31 -0700 (PDT)
In-Reply-To: <CAMiH66H=VMEgHFMdEhCTqA5AtVw6iN97-cbwUd86Ghd77OLcWA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@linux.intel.com>, marex@denx.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, tiwai@suse.de, artem.bityutskiy@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, perex@perex.cz, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, djbw@fb.com, khali@linux-fr.org, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18 October 2012 20:48, Huang Shijie <shijie8@gmail.com> wrote:
> On Thu, Oct 18, 2012 at 5:29 AM, Jassi Brar <jaswinder.singh@linaro.o=
rg> wrote:
>> On 18 October 2012 12:15, Huang Shijie <b32955@freescale.com> wrote:
>>> =D3=DA 2012=C4=EA10=D4=C218=C8=D5 14:18, Vinod Koul =D0=B4=B5=C0:
>>>
>>>> Why cant you do start (prepare clock etc) when you submit the desc=
riptor
>>>> to dmaengine. Can be done in tx_submit callback.
>>>> Similarly remove the clock when dma transaction gets completed.
>>>
>>> I ever thought this method too.
>>>
>>> But it will become low efficient in the following case:
>>>
>>>   Assuming the gpmi-nand driver has to read out 1024 pages in one _=
SINGLE_
>>> read operation.
>>> The gpmi-nand will submit the descriptor to dmaengine per page. So =
with your
>>> method,
>>> the system will repeat the enable/disable dma clock 1024 time. At e=
very
>>> enable/disable dma clock,
>>> the system has to enable the clock chain and it's parents ...
>>>
>>> But with this patch, we only need to enable/disable dma clock one t=
ime, just
>>> at we select the nand chip.
>>>
>> If the clock is the dmac's property (not channels'), the toggling
>> seems too aggressive.
>> You could try using runtime_suspend/resume for clock
>> disabling/enabling. How about employing autosuspend with a few ms
>> delay?
>
> Yes, employing the autosuspend is workable method too.o
> But it's a little more complicated then this patch. You have to creat=
e
> a thread or workqueue to
> do the job.
>
I am not sure why you would need to create any thread/workqueue ?
Just pm_runtime_put_autosuspend() in drivers/ to see how it works.
