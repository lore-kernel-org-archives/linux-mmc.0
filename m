From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 17:13:11 +0800
Message-ID: <507FC827.40601@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <201210181016.06782.marex@denx.de> <507FC290.10205@freescale.com> <201210181049.21556.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201210181049.21556.marex@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, djbw@fb.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Huang Shijie <shijie8@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-mmc@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 16:49, Marek Vasut =E5=86=
=99=E9=81=93:
> Dear Huang Shijie,
>
>> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 16:16, Marek Vasut =E5=
=86=99=E9=81=93:
>>> So we can't stream data from the chip? About time to adjust the MTD
>>> framework to allow that. Maybe implement a command queue?
>> IMHO, it's not possible. Because the READ-PAGE(00h-30h) command need=
s to
>> check the busy status
>> which means we have to stop in the middle, so we can not chain the a=
ll
>> the read-pages DMA commands.
> Can the DMA not branch?
it's too complicated to the MTD layer, as well as the gpmi driver.

Best Regards
Huang Shijie
