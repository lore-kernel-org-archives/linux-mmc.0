From: Matt Fleming <matt@console-pimps.org>
Subject: Re: crash in mmc subsystem during suspend
Date: Sat, 21 Nov 2009 12:31:49 +0000
Message-ID: <20091121123149.GA18478@console-pimps.org>
References: <1258707087.2235.6.camel@localhost.localdomain> <1258729858.2235.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:45950 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZKUMbq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Nov 2009 07:31:46 -0500
Content-Disposition: inline
In-Reply-To: <1258729858.2235.29.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, Nov 20, 2009 at 03:10:58PM +0000, Daniel Drake wrote:
> On Fri, 2009-11-20 at 08:51 +0000, Daniel Drake wrote:
> > We're busy testing the suspend/resume functionality on the new OLPC
> > XO-1.5 laptop. This uses a SD card as its primary disk, which is on a
> > SDHCI controller on the VIA VX855 chipset. We are running Linux v2.6.31
> > 
> > We are occasionally encountering a crash from below mmc_rescan() during
> > suspend:
> 
> OK, I just realised that our kernel includes various non-upstream
> patches (yet), some of which are executing during suspend/resume and may
> be a contributing factor to this problem.
> (the patches allow us to retain power to our SDIO wifi card during
> suspend)
> 
> Nevertheless, any help on our battle to stable suspend/resume and the
> other bits we're working on is always appreciated. :)
> 
> Daniel
> 
> 

Fancy giving this patch a try? I think it's just a case of removing too
many funcs in the error path.

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cdb845b..cdec9c8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -516,7 +516,8 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
 	 */
-	card->sdio_funcs = funcs = (ocr & 0x70000000) >> 28;
+	funcs = (ocr & 0x70000000) >> 28;
+	card->sdio_funcs = 0;
 
 	/*
 	 * If needed, disconnect card detection pull-up resistor.
@@ -528,7 +529,7 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	/*
 	 * Initialize (but don't add) all present functions.
 	 */
-	for (i = 0;i < funcs;i++) {
+	for (i = 0;i < funcs;i++,card->sdio_funcs++) {
 		err = sdio_init_func(host->card, i + 1);
 		if (err)
 			goto remove;
