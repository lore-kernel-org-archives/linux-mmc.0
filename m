From: Dmitry Shmidt <dimitrysh@android.com>
Subject: [PATCH] mmc: core: Allow sdio operations in other thread during =?utf-8?b?c2Rpb19hZGRfZnVuYygp?=
Date: Sat, 12 Feb 2011 00:25:30 +0000 (UTC)
Message-ID: <loom.20110212T012443-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37401 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab1BLAZp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Feb 2011 19:25:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Po3J1-0004HZ-Rh
	for linux-mmc@vger.kernel.org; Sat, 12 Feb 2011 01:25:43 +0100
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 01:25:43 +0100
Received: from dimitrysh by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 01:25:43 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

commit 9cb71a1eb86a2acf0762d31af633984cf9e24d32
Author: Dmitry Shmidt <dimitrysh@google.com>
Date:   Fri Feb 11 16:10:33 2011 -0800

    mmc: core: Allow sdio operations in other thread during sdio_add_func()

    Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index dec4290..d4e6e6ef 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -834,7 +834,6 @@ int mmc_attach_sdio(struct mmc_host *host)
         */
        mmc_release_host(host);
        err = mmc_add_card(host->card);
-       mmc_claim_host(host);
        if (err)
                goto remove_added;

@@ -846,13 +845,12 @@ int mmc_attach_sdio(struct mmc_host *host)
                if (err)
                        goto remove_added;
        }
-
+       mmc_claim_host(host);
        return 0;


 remove_added:
        /* Remove without lock if the device has been added. */
-       mmc_release_host(host);
        mmc_sdio_remove(host);
        mmc_claim_host(host);
 remove:


