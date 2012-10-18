From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 15:49:41 +0800
Message-ID: <507FB495.7050104@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <1350541111.5263.3.camel@vkoul-udesk3> <507FA595.4020507@freescale.com> <201210180914.58527.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:29340
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443Ab2JRHqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 03:46:42 -0400
In-Reply-To: <201210180914.58527.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, djbw@fb.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Huang Shijie <shijie8@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 15:14, Marek Vasut =E5=86=
=99=E9=81=93:
> Dear Huang Shijie,
>
> Why such massive CC ?
>
>> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=86=
=99=E9=81=93:
>>> Why cant you do start (prepare clock etc) when you submit the descr=
iptor
>>> to dmaengine. Can be done in tx_submit callback.
>>> Similarly remove the clock when dma transaction gets completed.
>> I ever thought this method too.
>>
>> But it will become low efficient in the following case:
>>
>>     Assuming the gpmi-nand driver has to read out 1024 pages in one
>> _SINGLE_ read operation.
>> The gpmi-nand will submit the descriptor to dmaengine per page.
> It will? Then GPMI NAND is flat our broken ... again.
yes.

Please read the NAND chip spec about the comand READ PAGE(00h-30h) and=20
the code
nand_do_read_ops(). The nand chip limits us only read one page out one =
time.
So the driver will submit the descriptor to dmaengine per page.



>> So with
>> your method,
>> the system will repeat the enable/disable dma clock 1024 time.
> Yes, it is the driver that's wrong.
not the driver.
>> At every
>> enable/disable dma clock,
>> the system has to enable the clock chain and it's parents ...
>>
>> But with this patch, we only need to enable/disable dma clock one ti=
me,
>> just at we select the nand chip.
> You are fixing a driver problem at a framework level, wrong.
>
> So, check how the MXS SPI driver handles descriptor chaining. Indeed,=
 the
> Sigmatel screwed the DMA stuff good. But if you analyze the SPI drive=
r, you'll
> notice a few important points that might come handy when you fix the =
GPMI NAND
> driver properly.
>
> The direction to take here is:
> 1) Implement DMA chaining into the GPMI NAND driver
How can i implement the DMA chain if the nand chip READ-PAGE command=20
gives us the one page limit?

thanks
Huang Shijie


> 2) You might need to do one PIO transfer to reconfigure the IP regist=
ers between
> each segment of the DMA chain (just as MXS SPI does it)
> 3) You might run out of DMA descriptors when doing too long chains --=
 so you
> might need to fix that part of the mxs DMA driver.


