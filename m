From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [to-be-updated]
	sdio-initialise-sdio-functions-and-update-card-sdio_funcs-in-lockste
	p.patch removed from -mm tree
Date: Tue, 8 Dec 2009 20:59:23 +0000
Message-ID: <20091208205923.GA21357@console-pimps.org>
References: <200912022351.nB2NpNNG031853@imap1.linux-foundation.org> <20091208135718.GA6623@console-pimps.org> <20091208120820.2af3cedb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:45447 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966123AbZLHU7W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2009 15:59:22 -0500
Content-Disposition: inline
In-Reply-To: <20091208120820.2af3cedb.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dsd@laptop.org, linux-mmc@vger.kernel.org

On Tue, Dec 08, 2009 at 12:08:20PM -0800, Andrew Morton wrote:
> On Tue, 8 Dec 2009 13:57:19 +0000
> Matt Fleming <matt@console-pimps.org> wrote:
> 
> > On Wed, Dec 02, 2009 at 03:51:23PM -0800, Andrew Morton wrote:
> > > 
> > > The patch titled
> > >      sdio: initialise SDIO functions and update card->sdio_funcs in lockstep
> > > has been removed from the -mm tree.  Its filename was
> > >      sdio-initialise-sdio-functions-and-update-card-sdio_funcs-in-lockstep.patch
> > > 
> > > This patch was dropped because an updated version will be merged
> > > 
> > > The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> > > 
> > 
> > Andrew, have you got an updated version of this patch anywhere? I can't
> > find one at http://userweb.kernel.org/~akpm/mmotm/.
> >  
> 
> Nope, and I can't find any record of why I decided it needed updating :(  Perhaps
> it was discussed under a different Subject:

Interesting!

I'm unaware of any discussion surrounding this patch apart from the
emails exchanged between me and Daniel starting in this thread,

       http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00820.html

Actually, now I think about it, that changelog from Daniel's patch could
do with being incorporated into mine, particularly the url to the ticket
on http://dev.laptop.org. So maybe a patch like the following with your
checkpatch.pl changes included. Unless you remember why you dropped the
original?

---

>From 3c23049de4d13e20c819d936a305544f208b67d1 Mon Sep 17 00:00:00 2001
From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 1 Dec 2009 14:50:56 +0000
Subject: [PATCH] sdio: Initialise SDIO functions and update card->sdio_funcs in lockstep

Daniel Drake noticed a crash in the error path of mmc_attach_sdio().
This bug is discussed at http://dev.laptop.org/ticket/9707.

BUG: unable to handle kernel paging request at 6b6b6c57
IP: [<b066d6e2>] sdio_remove_func+0x9/0x27
Call Trace:
[<b066cfb4>] ? mmc_sdio_remove+0x34/0x65
[<b066d1fc>] ? mmc_attach_sdio+0x217/0x240
[<b066a22f>] ? mmc_rescan+0x1a2/0x20f
[<b042e9a0>] ? worker_thread+0x156/0x1e

We need to accurately track how many SDIO functions have been
initialised (and keep card->sdio_funcs in sync) so that we don't try to
remove more functions than we initialised if we hit the error path in
mmc_attach_sdio().

Without this patch if we hit the error path in mmc_attach_sdio() we run
the risk of deferencing invalid memory in sdio_remove_func(), leading to
a crash.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/core/sdio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cdb845b..06b6408 100644
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
+	for (i = 0; i < funcs; i++, card->sdio_funcs++) {
 		err = sdio_init_func(host->card, i + 1);
 		if (err)
 			goto remove;
-- 
1.6.2.5

