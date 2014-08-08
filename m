From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/3 resend] omap_hsmmc: reuse mmc/slot-gpio functions
Date: Fri,  8 Aug 2014 12:16:57 +0200
Message-ID: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:64107 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210AbaHHKRG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Aug 2014 06:17:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, daniel@zonque.org, Andreas Fenkart <afenkart@gmail.com>

Hi,

I would like to reuse mmc_of_parse for standard mmc features: 
- cd-gpios / wp-gpios
- bus-width 
- max-frequency
- keep-power-in-suspend
- enable-sdio-wakeup
- ti,non-removable, evtl.

Currently these are open-coded in of_get_hsmmc_pdata. I tried
removing them from of_get_hsmmc_pdata and call mmc_of_parse
at the end of the probe function:

@@ -2241,8 +2264,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
        omap_hsmmc_protect_card(host);
+       mmc_of_parse(host->mmc);
        mmc_add_host(mmc);

This could work transparently for most features but definitely
not for cd-gpios/wp-gpios. Pls can somebody have a look at the
followup patches? I tried an intermediate step mapping card
detect / read-only detect onto mmc/slot-gpio, that are used by
mmc_of_parse. I don't have card detect/read-only detect pins, so
patches are untested, :-( 

Do we need cover_detect functionality or could it be merged with
card detect?

Another issue is 'ti,non-removable' which could be mappend to
stanadard 'non-removable' if 'no_regulator_off_init' was handled
in a different way.

        if (of_find_property(np, "ti,non-removable", NULL)) {      
                pdata->slots[0].nonremovable = true;                     
                pdata->slots[0].no_regulator_off_init = true;              
        }   

/Andreas

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

