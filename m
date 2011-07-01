From: Philip Rakity <prakity@marvell.com>
Subject: Bus Width Testing on Suspend/Resume  (REGRESSION)
Date: Thu, 30 Jun 2011 17:06:44 -0700
Message-ID: <840AA935-2855-41D1-B1DF-49D30FF52C01@marvell.com>
References: <4E0D0D4E.3050404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57078 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752533Ab1GAAJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 20:09:53 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>



Begin forwarded message:

> From: Jaehoon Chung <jh80.chung@samsung.com>
> Date: June 30, 2011 4:57:02 PM PDT
> To: Philip Rakity <prakity@marvell.com>
> Cc: Chris Ball <cjb@laptop.org>
> Subject: Re: Bus Width Testing on Suspend/Resume (REGRESSION)
> 
> Hi Philip..
> 
> I tested this patch..it's working fine on suspend/resume..
> 
> But you mentioned on comment, in future, we can avoid the bus-testing
> on suspend/resume.
> (if know what bus-width card support and assume non-removable)
> 
> I added the Signed-Off in the patch.
> 
> Who send this patch to mailing? you or me?
> 
> Jaehoon
> 




>From 68fdf54ae07cf85c30f210e09d3c811daf3b0219 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Thu, 30 Jun 2011 11:50:50 -0700
Subject: [PATCH] mmc: Bus width testing needs to handle suspend/resume

We need to read the ext_csd when doing bus width testing for
old cards to ensure test is run correctly.

We can avoid the ddr / bus width testing in future by refactoring
the code but this is a more extensive mod and needs careful
thought.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/mmc.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2a7e43b..4da35a7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -614,17 +614,17 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (!oldcard) {
-		/*
-		 * Fetch and process extended CSD.
-		 */
+	/*
+	 * Fetch and process extended CSD.
+	 */
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err)
+		goto free_card;
+	err = mmc_read_ext_csd(card, ext_csd);
+	if (err)
+		goto free_card;
 
-		err = mmc_get_ext_csd(card, &ext_csd);
-		if (err)
-			goto free_card;
-		err = mmc_read_ext_csd(card, ext_csd);
-		if (err)
-			goto free_card;
+	if (!oldcard) {
 
 		/* If doing byte addressing, check if required to do sector
 		 * addressing.  Handle the case of <2GB cards needing sector
-- 
1.7.0.4



