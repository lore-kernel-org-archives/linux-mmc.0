From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/6] mfd: remove now redundant sh_mobile_sdhi.h header
Date: Fri, 11 Mar 2011 08:52:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110848121.23675@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1CKHwn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 02:52:43 -0500
In-Reply-To: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mfd/sh_mobile_sdhi.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)
 delete mode 100644 include/linux/mfd/sh_mobile_sdhi.h

diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
deleted file mode 100644
index 10af7f9..0000000
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef MFD_SH_MOBILE_SDHI_H
-#define MFD_SH_MOBILE_SDHI_H
-
-/* Compatibility header - will disappear once all platforms are converted */
-#include <linux/mmc/sh_mobile_sdhi.h>
-
-#endif /* MFD_SH_MOBILE_SDHI_H */
-- 
1.7.2.3

