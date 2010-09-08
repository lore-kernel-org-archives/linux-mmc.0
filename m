From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Tue, 7 Sep 2010 18:03:33 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:54530 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab0IHBDg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2010 21:03:36 -0400
In-Reply-To: <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Nicolas,

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Thursday, September 02, 2010 4:30 PM
> To: Bing Zhao
> Cc: linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball; Andrew Morton
> Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
> 
> On Thu, 2 Sep 2010, Bing Zhao wrote:
> 
> > > Please look at the if() condition, and at the last argument to
> > > mmc_sdio_init_card(), then ponder.
> >
> > You are right. The last argument passed to mmc_sdio_init_card() is zero actually.
> >
> > 		err = mmc_sdio_init_card(host, host->ocr, host->card, 0);
> >
> > >
> > > I think the proper fix goes _inside_ mmc_sdio_init_card() as there are
> > > certainly still validation checks which are appropriate to perform.
> >
> > When you have a thought for the fix, I can do the testing on my system.
> 
> I'm telling you that you should use the powered_resume argument of
> mmc_sdio_init_card() to skip problematic initializations inside
> mmc_sdio_init_card() when powered_resume is not zero.  Looking at the
> existing code should give you examples of how powered_resume is used and
> why.

Thanks for the hint.

The new patch skips reading CCCR, common CIS, and validation of vendor/device IDs inside mmc_sdio_init_card() when powered_resume is not zero.

If it looks okay for you I will resend it as V3.


drivers/mmc/core/sdio.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f332c52..37f64d6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -434,28 +434,32 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		goto finish;
 	}
 
-	/*
-	 * Read the common registers.
-	 */
-	err = sdio_read_cccr(card);
-	if (err)
-		goto remove;
+	if (!powered_resume) {
+		/*
+		 * Read the common registers.
+		 */
+		err = sdio_read_cccr(card);
+		if (err)
+			goto remove;
 
-	/*
-	 * Read the common CIS tuples.
-	 */
-	err = sdio_read_common_cis(card);
-	if (err)
-		goto remove;
+		/*
+		 * Read the common CIS tuples.
+		 */
+		err = sdio_read_common_cis(card);
+		if (err)
+			goto remove;
+	}
 
 	if (oldcard) {
-		int same = (card->cis.vendor == oldcard->cis.vendor &&
-			    card->cis.device == oldcard->cis.device);
 		mmc_remove_card(card);
-		if (!same)
-			return -ENOENT;
 
-		card = oldcard;
+		if (!powered_resume) {
+			int same = (card->cis.vendor == oldcard->cis.vendor &&
+				    card->cis.device == oldcard->cis.device);
+			if (!same)
+				return -ENOENT;
+		}
+
 		return 0;
 	}


Regards,

Bing

> 
> 
> Nicolas
