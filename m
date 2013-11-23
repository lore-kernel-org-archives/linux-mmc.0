From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] V4L2: remove myself as a maintainer of two drivers
Date: Sat, 23 Nov 2013 09:55:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1311230954410.9194@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Since I'm currently unable to dedicate sufficient time to the maintainership
of these two drivers update their status to "orphan" until new maintainers
appear.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 MAINTAINERS |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e37e8c0..f7d6b05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7654,15 +7654,13 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
 SH_VEU V4L2 MEM2MEM DRIVER
-M:	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/media/platform/sh_veu.c
 
 SH_VOU V4L2 OUTPUT DRIVER
-M:	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
 L:	linux-media@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 F:	drivers/media/platform/sh_vou.c
 F:	include/media/sh_vou.h
 
-- 
1.7.2.5

