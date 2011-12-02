From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: RE: arm, am1808: using mmc1 controller and dma
Date: Fri, 2 Dec 2011 09:00:08 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF4029429@DBDE01.ent.ti.com>
References: <4ED87FBA.40409@denx.de>
 <B6A220404B6BFC4BBD2AB91C54D39DF40293DB@DBDE01.ent.ti.com>
 <4ED89294.6010804@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab1LBJAY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 04:00:24 -0500
In-Reply-To: <4ED89294.6010804@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "hs@denx.de" <hs@denx.de>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Wolfgang Denk <wd@denx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vipin Bhandari <vipin.bhandari@ti.com>, "Kumar, Purushotam" <purushotam@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Fri, Dec 02, 2011 at 14:25:48, Heiko Schocher wrote:
> Hello Rajashekhara, Sudhakar,
> 
> Rajashekhara, Sudhakar wrote:
> > Hi,
> > 
> > On Fri, Dec 02, 2011 at 13:05:22, Heiko Schocher wrote:
> >> Hello,
> >>
> >> trying Linux 3.2.0-rc3 on an am1808 based board using MMCSD1 controller,
> >> and facing problems with using DMA. Deactivating use_dma=0 in the
> >> davinci_mmc controller and mmc works in pio mode without problems.
> >> So there are no hardware problems, pinmux is ok, psc are all on.
> >>
> > 
> > Please refer to the discussion at [1] where similar issue was discussed. Go through the

[...]

> 
> Yuhu! that works for me! But I had to fix it a little, because "edma_info"
> is now named "info". Here my diff:
> 

Yup, this patch was on an older version.

> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
> index da90103..e10a251 100644
> --- a/arch/arm/mach-davinci/dma.c
> +++ b/arch/arm/mach-davinci/dma.c
> @@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
>                  * started by the codec engine will not cause audio defects.
>                  */
>                 for (i = 0; i < edma_cc[j]->num_channels; i++)
> -                       map_dmach_queue(j, i, EVENTQ_1);
> +                       map_dmach_queue(j, i, info[j]->default_queue);
> 
>                 queue_tc_mapping = info[j]->queue_tc_mapping;
>                 queue_priority_mapping = info[j]->queue_priority_mapping;
> 
> > [1] http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg17926.html 
> 
> Do you prepare a patch, or should I send it?
> 

You can go ahead and submit the patch but Juha was the person who found out this issue.

Thanks,
Sudhakar
