From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: add myself as a tmio-mmc maintainer
Date: Sun, 17 Jul 2011 22:04:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107172157130.13485@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64631 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab1GQUEK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 16:04:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
It would be nice if I could get hold of some non-sh-mobile tmio-mmc 
hardware for regression tests. Until then I'll just do my best not to 
break those systems, any testing by Ian or any other lucky owners would be 
as always highly appreciated.

diff --git a/MAINTAINERS b/MAINTAINERS
index 187282d..400ebbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6242,9 +6242,14 @@ F:	drivers/char/toshiba.c
 F:	include/linux/toshiba.h
 
 TMIO MMC DRIVER
+M:	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
 M:	Ian Molton <ian@mnementh.co.uk>
+L:	linux-mmc@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/tmio_mmc.*
+F:	drivers/mmc/host/tmio_mmc*
+F:	drivers/mmc/host/sh_mobile_sdhi.c
+F:	include/linux/mmc/tmio.h
+F:	include/linux/mmc/sh_mobile_sdhi.h
 
 TMPFS (SHMEM FILESYSTEM)
 M:	Hugh Dickins <hughd@google.com>
