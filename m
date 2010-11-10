From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Wed, 10 Nov 2010 16:28:06 +0100
Message-ID: <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:50751 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756719Ab0KJP2d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:33 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F416B9B
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:30 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF70E5419
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:30 +0000 (GMT)
In-Reply-To: <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

HC driver will be able to use the pm_flags to
undestand if the system can be woken-up by the driver.
So the mmc_suspend_host hasn't to reset this field
in the host structure.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/core/core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 569e94d..6d2d6e4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1276,7 +1276,6 @@ int mmc_suspend_host(struct mmc_host *host)
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
 			mmc_release_host(host);
-			host->pm_flags = 0;
 			err = 0;
 		}
 	}
-- 
1.5.5.6

