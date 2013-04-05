From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: core: negotiate ocr during resume
Date: Fri, 5 Apr 2013 10:49:58 +0000 (UTC)
Message-ID: <loom.20130405T124720-793@post.gmane.org>
References: <CADz5_gKbDh6Q6H=CJf8ZeH_t9gQ4J_L+wtJghVDo7tep2N4qYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54739 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765928Ab3DFTOi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 6 Apr 2013 15:14:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UOYVM-0001Yq-3I
	for linux-mmc@vger.kernel.org; Sat, 06 Apr 2013 21:10:24 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 06 Apr 2013 21:10:24 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 06 Apr 2013 21:10:24 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Kevin Liu <keyuan.liu <at> gmail.com> writes:

Please find my updated patch and comments under _PNN_ below :-

> I think there are several issues here:
> 1. with this patch the vmmc voltage should still be 3.3v after resume
> back since the vmmc voltage is updated in set_ios which depend on
> mmc_select_voltage. But mmc_select_voltage didn't notice your ocr
> update.
_PNN_: Yes, good point. I agree. Accordingly updated the patch.

> 2. you didn't handle the special case that the card is changed to a
> new card during suspended. So the ocr may be different here.
_PNN_ : This case doesn't holds good because even when new card is inserted 
druing suspend, cd interrupt is generated and mmc_detect_change will be 
called and mmc_rescan will be scheduled to begin initialization from the 
begining, where ocr is freshly read from new card (mmc_attach_***) and my 
patch will take care to update new ocr in card->ocr.
Although consider an hypothetical situtaion where within the debounce time 
of cd, suppose resume gets called, it may fail. But fair enough after 200ms, 
fresh initialization will begin and card re-inits. So no need to take 
special consideration here. Don't you agree?

> 3. mmc.c and sdio.c should also be updated besides sd.c.
> 
_PNN_ : Thanks for pointing this out. Patch updated.

> I have another old version of this patch attached below for your 
reference.
_PNN_ : I do agree with your patch, but i would suggest to consider my below 
patch rather than yours for following reasons:
 a. Very simple & less code changes.
 b. Similar to rca, cid, csa, better to have "ocr" structure member in 
"struct mmc_card" which is card specific.
 c. mmc_select_voltage is localised in core.c rather than moving it accross 
sd.c sdio.c and mmc.c
 d. ocr field might be helpful in future too. So better to have it rather 
than "ocr_bak" in struct mmc_host.

>From ad70dbd00db355d1e8ca08e7ad12e73cb41df960 Mon Sep 17 00:00:00 2001
From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
Date: Thu, 4 Apr 2013 19:55:19 +0530
Subject: [PATCH] mmc: core: proper ocr negotiation during resume

Save the card ocr into struct mmc_card when read from card
during initialization of sd/mmc/sdio.
Druing mmc_resume_host, supply saved card's ocr to
mmc_select_voltage so as to negotiate voltage appropriately.
---
 drivers/mmc/core/core.c  |    2 +-
 drivers/mmc/core/mmc.c   |    3 +++
 drivers/mmc/core/sd.c    |    3 +++
 drivers/mmc/core/sdio.c  |    3 +++
 include/linux/mmc/card.h |    1 +
 5 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..aad511a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2680,7 +2680,7 @@ int mmc_resume_host(struct mmc_host *host)
 	if (host->bus_ops && !host->bus_dead) {
 		if (!mmc_card_keep_power(host)) {
 			mmc_power_up(host);
-			mmc_select_voltage(host, host->ocr);
+			mmc_select_voltage(host, host->card->ocr);
 			/*
 			 * Tell runtime PM core we just powered up the card,
 			 * since it still believes the card is powered off.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d584f7c..923eb53 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1566,6 +1566,9 @@ int mmc_attach_mmc(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9e645e1..965504b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1185,6 +1185,9 @@ int mmc_attach_sd(struct mmc_host *host)
 		ocr &= ~MMC_VDD_165_195;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index aa0719a..3f9e08d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1090,6 +1090,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f31725b..1bbec2f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -273,6 +273,7 @@ struct mmc_card {
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
+	u32			ocr;		/* card OCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
 	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card 
specific */
-- 
1.7.6


Note : mmc_select_voltage(host, host->card->ocr);
Here host->card->ocr is directly dereferenced because during resume, we will 
always have host->card !

Regards,
Prasanna


