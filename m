From: Heiko Schocher <hs@denx.de>
Subject: Re: arm, am1808: using mmc1 controller and dma
Date: Fri, 02 Dec 2011 09:55:48 +0100
Message-ID: <4ED89294.6010804@denx.de>
References: <4ED87FBA.40409@denx.de>
 <B6A220404B6BFC4BBD2AB91C54D39DF40293DB@DBDE01.ent.ti.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:54042 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1LBIz5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 03:55:57 -0500
In-reply-to: <B6A220404B6BFC4BBD2AB91C54D39DF40293DB@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Wolfgang Denk <wd@denx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vipin Bhandari <vipin.bhandari@ti.com>, "Kumar, Purushotam" <purushotam@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello Rajashekhara, Sudhakar,

Rajashekhara, Sudhakar wrote:
> Hi,
> 
> On Fri, Dec 02, 2011 at 13:05:22, Heiko Schocher wrote:
>> Hello,
>>
>> trying Linux 3.2.0-rc3 on an am1808 based board using MMCSD1 controller,
>> and facing problems with using DMA. Deactivating use_dma=0 in the
>> davinci_mmc controller and mmc works in pio mode without problems.
>> So there are no hardware problems, pinmux is ok, psc are all on.
>>
> 
> Please refer to the discussion at [1] where similar issue was discussed. Go through the

Oh, sorry, missed this! Thanks for the hint!

> entire thread. In the patch posted by Juha in this link, I see that except for the below
> hunk all others are integrated.
> 
> @@ -1508,7 +1506,7 @@ static int __init edma_probe(struct platform_device *pdev)
>                  * started by the codec engine will not cause audio defects.
>                  */
>                 for (i = 0; i < edma_info[j]->num_channels; i++)
> -                       map_dmach_queue(j, i, EVENTQ_1);
> +                       map_dmach_queue(j, i, edma_info[j]->default_queue);
> 
>                 queue_tc_mapping = info[j].queue_tc_mapping;
>                 queue_priority_mapping = info[j].queue_priority_mapping;
> 
> Can you check whether the above patch fixes your issue?

Yuhu! that works for me! But I had to fix it a little, because "edma_info"
is now named "info". Here my diff:

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..e10a251 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
                 * started by the codec engine will not cause audio defects.
                 */
                for (i = 0; i < edma_cc[j]->num_channels; i++)
-                       map_dmach_queue(j, i, EVENTQ_1);
+                       map_dmach_queue(j, i, info[j]->default_queue);

                queue_tc_mapping = info[j]->queue_tc_mapping;
                queue_priority_mapping = info[j]->queue_priority_mapping;

> [1] http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg17926.html 

Do you prepare a patch, or should I send it?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
