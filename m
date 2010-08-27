From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] omap_hsmmc: Remove unused state variable
Date: Fri, 27 Aug 2010 20:52:01 +0100
Message-ID: <20100827195201.GK23079@void.printf.net>
References: <1276178406-5747-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40223 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab0H0TwF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:52:05 -0400
Content-Disposition: inline
In-Reply-To: <1276178406-5747-1-git-send-email-saaguirre@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Hi,

Andrew, please take this one.

From: Sergio Aguirre <saaguirre@ti.com>
Date: Thu, 10 Jun 2010 09:00:06 -0500

This fixes the following warning:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2275: warning: unused variable 'state'

Introduced by commit ID:

  commit 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e
  Author: Matt Fleming <matt@console-pimps.org>
  Date:   Wed May 26 14:42:08 2010 -0700

      mmc: remove the "state" argument to mmc_suspend_host()

The unique usage of this var was removed there, and missed
removing the respective declaration aswell.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 077bbdb..ba623d6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2305,7 +2305,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
