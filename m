From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 11:18:53 -0400
Message-ID: <CAMiH66H=VMEgHFMdEhCTqA5AtVw6iN97-cbwUd86Ghd77OLcWA@mail.gmail.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
	<1350541111.5263.3.camel@vkoul-udesk3>
	<507FA595.4020507@freescale.com>
	<CAJe_ZhfarH-HpJkEOpH=jY1Gc-UPEyuA4bJ4LSQES7Uyea2BQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJe_ZhfarH-HpJkEOpH=jY1Gc-UPEyuA4bJ4LSQES7Uyea2BQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@linux.intel.com>, marex@denx.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, tiwai@suse.de, artem.bityutskiy@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, perex@perex.cz, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, djbw@fb.com, khali@linux-fr.org, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 5:29 AM, Jassi Brar <jaswinder.singh@linaro.org=
> wrote:
> On 18 October 2012 12:15, Huang Shijie <b32955@freescale.com> wrote:
>> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=86=
=99=E9=81=93:
>>
>>> Why cant you do start (prepare clock etc) when you submit the descr=
iptor
>>> to dmaengine. Can be done in tx_submit callback.
>>> Similarly remove the clock when dma transaction gets completed.
>>
>> I ever thought this method too.
>>
>> But it will become low efficient in the following case:
>>
>>   Assuming the gpmi-nand driver has to read out 1024 pages in one _S=
INGLE_
>> read operation.
>> The gpmi-nand will submit the descriptor to dmaengine per page. So w=
ith your
>> method,
>> the system will repeat the enable/disable dma clock 1024 time. At ev=
ery
>> enable/disable dma clock,
>> the system has to enable the clock chain and it's parents ...
>>
>> But with this patch, we only need to enable/disable dma clock one ti=
me, just
>> at we select the nand chip.
>>
> If the clock is the dmac's property (not channels'), the toggling
> seems too aggressive.
> You could try using runtime_suspend/resume for clock
> disabling/enabling. How about employing autosuspend with a few ms
> delay?

Yes, employing the autosuspend is workable method too.o
But it's a little more complicated then this patch. You have to create
a thread or workqueue to
do the job.

What's more, I think other DMA engine may also meets the same issue as
the mxs-dma, such as the imx-sdma.
It's somehow a common issue to disable the clocks when no one use the
DMA engine.
Do you also suggest employing the autosuspend? Why not use a simple
way to handle this issue?
When the dma device want to use a DMA engine, it just needs to issue a
DMA_START command.

thanks
Huang Shijie
Huang Shijie
