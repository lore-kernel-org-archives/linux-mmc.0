From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 09:52:08 +0100
Message-ID: <20121018085208.GR21164@n2100.arm.linux.org.uk>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <1350541111.5263.3.camel@vkoul-udesk3> <507FA595.4020507@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <507FA595.4020507@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, djbw@fb.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, marex@denx.de, artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <shijie8@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 02:45:41PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 14:18, Vinod Koul =E5=86=
=99=E9=81=93:
>> Why cant you do start (prepare clock etc) when you submit the descri=
ptor
>> to dmaengine. Can be done in tx_submit callback.
>> Similarly remove the clock when dma transaction gets completed.
> I ever thought this method too.
>
> But it will become low efficient in the following case:
>
>   Assuming the gpmi-nand driver has to read out 1024 pages in one =20
> _SINGLE_ read operation.
> The gpmi-nand will submit the descriptor to dmaengine per page. So wi=
th =20
> your method,
> the system will repeat the enable/disable dma clock 1024 time. At eve=
ry =20
> enable/disable dma clock,
> the system has to enable the clock chain and it's parents ...

And what if you stop using clk_prepare_enable(), and prepare the clock
when the channel is requested and only use clk_enable() in the tx_submi=
t
method?
