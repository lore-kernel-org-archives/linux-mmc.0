From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/3] omap_hsmmc: reuse mmc/slot-gpio functions
Date: Fri, 18 Jul 2014 09:22:00 +0200
Message-ID: <1405668123-17073-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50796 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaGRHWL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jul 2014 03:22:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, ulf.hansson@linaro.org, daniel@zonque.org, Andreas Fenkart <afenkart@gmail.com>

Hi Balaji,

I'm trying to reuse mmc_of_parse for parsing standard mmc features: 
- cd-gpios / wp-gpios
- bus-width 
- max-frequency
- keep-power-in-suspend
- enable-sdio-wakeup
- ti,non-removable, evtl.

Currently these are open-coded in of_get_hsmmc_pdata. I tried
removing them all from of_get_hsmmc_pdata and call mmc_of_parse
at the end of the probe function:

@@ -2241,8 +2264,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
        omap_hsmmc_protect_card(host);
+       mmc_of_parse(host->mmc);
        mmc_add_host(mmc);

This should work transparently for most features except,
cd-gpios/wp-gpios. Pls can you have a look at the followup
patches? I tried an intermediate step mapping card detect /
read-only detect onto mmc/slot-gpio that are used by
mmc_of_parse. I don't have card detect/read-only detect pins, :-(

Do we still need cover_detect functionality or could it be merged
with card detect?

Another issue is 'ti,non-removable' which could be mappend to
'non-removable' if 'no_regulator_off_init' could be handled in a
different way.

        if (of_find_property(np, "ti,non-removable", NULL)) {      
                pdata->slots[0].nonremovable = true;                     
                pdata->slots[0].no_regulator_off_init = true;              
        }   

thanks,
Andreas

Andreas Fenkart (3):
  omap_hsmmc: reuse mmc/slot-gpio for write protect detection
  omap_hsmmc: separate card_detect/cover detect logic
  omap_hsmmc: reuse mmc/slot-gpio for card detect instead of open-coded
    version

 drivers/mmc/host/omap_hsmmc.c          | 172 ++++++++++++++-------------------
 include/linux/platform_data/mmc-omap.h |   6 +-
 2 files changed, 73 insertions(+), 105 deletions(-)

-- 
2.0.0

