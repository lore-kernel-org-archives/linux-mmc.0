From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: RE: arm, am1808: using mmc1 controller and dma
Date: Fri, 2 Dec 2011 08:34:27 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF40293DB@DBDE01.ent.ti.com>
References: <4ED87FBA.40409@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab1LBIer convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 03:34:47 -0500
In-Reply-To: <4ED87FBA.40409@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "hs@denx.de" <hs@denx.de>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: Wolfgang Denk <wd@denx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vipin Bhandari <vipin.bhandari@ti.com>, "Kumar, Purushotam" <purushotam@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Fri, Dec 02, 2011 at 13:05:22, Heiko Schocher wrote:
> Hello,
> 
> trying Linux 3.2.0-rc3 on an am1808 based board using MMCSD1 controller,
> and facing problems with using DMA. Deactivating use_dma=0 in the
> davinci_mmc controller and mmc works in pio mode without problems.
> So there are no hardware problems, pinmux is ok, psc are all on.
> 

Please refer to the discussion at [1] where similar issue was discussed. Go through the
entire thread. In the patch posted by Juha in this link, I see that except for the below
hunk all others are integrated.

@@ -1508,7 +1506,7 @@ static int __init edma_probe(struct platform_device *pdev)
                 * started by the codec engine will not cause audio defects.
                 */
                for (i = 0; i < edma_info[j]->num_channels; i++)
-                       map_dmach_queue(j, i, EVENTQ_1);
+                       map_dmach_queue(j, i, edma_info[j]->default_queue);

                queue_tc_mapping = info[j].queue_tc_mapping;
                queue_priority_mapping = info[j].queue_priority_mapping;

Can you check whether the above patch fixes your issue?

[1] http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg17926.html 

Thanks,
Sudhakar
