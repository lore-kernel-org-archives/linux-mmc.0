From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 16:49:20 +0800
Message-ID: <507FC290.10205@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com> <201210180914.58527.marex@denx.de> <507FB495.7050104@freescale.com> <201210181016.06782.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:47628 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753220Ab2JRIqp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 04:46:45 -0400
In-Reply-To: <201210181016.06782.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, djbw@fb.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, cjb@laptop.org, dwmw2@infradead.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Huang Shijie <shijie8@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 16:16, Marek Vasut =E5=86=
=99=E9=81=93:
> So we can't stream data from the chip? About time to adjust the MTD f=
ramework to
> allow that. Maybe implement a command queue?
>
IMHO, it's not possible. Because the READ-PAGE(00h-30h) command needs t=
o=20
check the busy status
which means we have to stop in the middle, so we can not chain the all=20
the read-pages DMA commands.

thanks
Huang Shijie


