From: zamek <zamek@vili.pmmf.hu>
Subject: hard wired wifi chip on sdio
Date: Sat, 30 Apr 2011 17:42:40 +0200
Message-ID: <4DBC2DF0.30101@vili.pmmf.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from witch.pmmf.hu ([193.6.55.10]:42649 "EHLO witch.pmmf.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab1D3QCI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Apr 2011 12:02:08 -0400
Received: from vili.pmmf.hu (unknown [193.6.56.12])
	by witch.pmmf.hu (Postfix) with ESMTP id 1959F2BEA42
	for <linux-mmc@vger.kernel.org>; Sat, 30 Apr 2011 17:43:32 +0200 (CEST)
Received: from [192.168.0.42] (unknown [89.135.45.70])
	by vili.pmmf.hu (Postfix) with ESMTP id 068AF1B44F6
	for <linux-mmc@vger.kernel.org>; Sat, 30 Apr 2011 17:42:40 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi All,

I have a Freescale iMX25 based (tx25) board with a Marvell 8688 wireless 
module on sdio bus.
My kernel is a rel_imx_2.6.35_11.03.00 from Freescale git repository.

The wireless chip is hard  wired on sdio bus, not plugged in. On end of 
sdhci_probe_slot() function I call the 
tasklet_schedule(&host->card_tasklet)
to force detecting card.

It seems to be good, mmc0 detected well.

When I try to load wifi module, it failed, cannot download helper binary 
to chip.

I tried to see the sdio bus with an oscilloscope to test it and I need a 
lot of modprobe/rmmod sequence and I wonder, after  the n-th sequence it 
could works well.

It confirms my opinion, there should be an initialization problem, 
because this card is a wired, not a pluggable card.

What is the correct method to force insert card event?


-- 
  thx,
----------------------------------
Zoltan Zidarics programmer
PTE-PMMFK H-7621 Pecs, Boszorkany u. 2. Hungary
E-Mail: zamek@vili.pmmf.hu
----------------------------------
       

