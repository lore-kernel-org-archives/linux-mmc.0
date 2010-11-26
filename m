From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/3] sh, mmc: Make mmcif_update_progress static inline
Date: Sat, 27 Nov 2010 08:02:57 +0900
Message-ID: <1290812579-20410-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42880 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab0KZXDJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Nov 2010 18:03:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

extern inline doesn't make much sense

Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/sh/include/mach-common/mach/romimage.h   |    2 +-
 arch/sh/include/mach-ecovec24/mach/romimage.h |    2 +-
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/mach-common/mach/romimage.h b/arch/sh/include/mach-common/mach/romimage.h
index 08fb422..3670455 100644
--- a/arch/sh/include/mach-common/mach/romimage.h
+++ b/arch/sh/include/mach-common/mach/romimage.h
@@ -4,7 +4,7 @@
 
 #else /* __ASSEMBLY__ */
 
-extern inline void mmcif_update_progress(int nr)
+static inline void mmcif_update_progress(int nr)
 {
 }
 
diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
index 1dcf5e6..d63ef51 100644
--- a/arch/sh/include/mach-ecovec24/mach/romimage.h
+++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
@@ -35,7 +35,7 @@
 #define HIZCRA		0xa4050158
 #define PGDR		0xa405012c
 
-extern inline void mmcif_update_progress(int nr)
+static inline void mmcif_update_progress(int nr)
 {
 	/* disable Hi-Z for LED pins */
 	__raw_writew(__raw_readw(HIZCRA) & ~(1 << 1), HIZCRA);
diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/include/mach-kfr2r09/mach/romimage.h
index 976256a..7a88316 100644
--- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
@@ -23,7 +23,7 @@
 
 #else /* __ASSEMBLY__ */
 
-extern inline void mmcif_update_progress(int nr)
+static inline void mmcif_update_progress(int nr)
 {
 }
 
-- 
1.7.2.3

