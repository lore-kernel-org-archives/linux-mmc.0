From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 1/5] drivercore: add new error value for deferred probe
Date: Fri, 07 Oct 2011 10:33:06 +0500
Message-ID: <1317963790-29426-2-git-send-email-manjugk@ti.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [117.192.88.236] ([117.192.88.236]:43661 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750960Ab1JGFFq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Oct 2011 01:05:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>


Add new error value so that drivers can request deferred probe
from drivercore.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Reported-by: Grant Likely <grant.likely@secretlab.ca>
---
Cc: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: Dilan Lee <dilee@nvidia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>

 include/linux/errno.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/errno.h b/include/linux/errno.h
index 4668583..83d8fcf 100644
--- a/include/linux/errno.h
+++ b/include/linux/errno.h
@@ -16,6 +16,7 @@
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
 #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
+#define EPROBE_DEFER	517	/* restart probe again after some time */
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
-- 
1.7.4.1

