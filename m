From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 0/2] patch set about the MXS-DMA
Date: Fri, 02 Mar 2012 15:50:25 -0500
Message-ID: <m2mx7yn2we.fsf@bob.laptop.org>
References: <1329373053-19494-1-git-send-email-b32955@freescale.com>
	<4F4D9725.3090100@freescale.com>
	<1330502098.3545.78.camel@sauron.fi.intel.com>
	<4F4DE0E5.8070808@freescale.com>
	<1330516974.3545.104.camel@sauron.fi.intel.com>
	<CAMiH66HmV+58w36DGCt+e=ihTrYUwXf1Cur+678YX2GKcB1-jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32808 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759094Ab2CBUuy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 15:50:54 -0500
In-Reply-To: <CAMiH66HmV+58w36DGCt+e=ihTrYUwXf1Cur+678YX2GKcB1-jA@mail.gmail.com>
	(Huang Shijie's message of "Wed, 29 Feb 2012 08:13:15 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>, Huang Shijie <b32955@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "LW@KARO-electronics.de" <LW@karo-electronics.de>

Hi,

On Wed, Feb 29 2012, Huang Shijie wrote:
>> Pushed both to l2-mtd.git tree, thanks. I am worried that it touches
>> other subsystems like dma, sound, and mmc and there are no acks for
>> those. Would be nice to get them somehow.
>
> I ever thought Vinod could accept this patch set.
>
> To Vinod & Chris:
>       Could you give the ack to the first patch?

Yes -- for the first patch:

Acked-by: Chris Ball <cjb@laptop.org>

(I think Shawn's ACK is sufficient for the second patch.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
