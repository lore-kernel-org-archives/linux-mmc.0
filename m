From: akpm@linux-foundation.org
Subject: + mmc-bfin_sdh-drop-redundant-mmc-depend-string.patch added to -mm tree
Date: Mon, 25 Jan 2010 16:06:00 -0800
Message-ID: <201001260006.o0Q060Ca019154@imap1.linux-foundation.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35114 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab0AZAGC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2010 19:06:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: vapier@gentoo.org, linux-mmc@vger.kernel.org


The patch titled
     mmc: bfin_sdh: drop redundant MMC depend string
has been added to the -mm tree.  Its filename is
     mmc-bfin_sdh-drop-redundant-mmc-depend-string.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/SubmitChecklist when testing your code ***

See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
out what to do about this

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: mmc: bfin_sdh: drop redundant MMC depend string
From: Mike Frysinger <vapier@gentoo.org>

The host/Kconfig file is only included when MMC is selected.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/Kconfig~mmc-bfin_sdh-drop-redundant-mmc-depend-string drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~mmc-bfin_sdh-drop-redundant-mmc-depend-string
+++ a/drivers/mmc/host/Kconfig
@@ -396,7 +396,7 @@ config MMC_VIA_SDMMC
 
 config SDH_BFIN
 	tristate "Blackfin Secure Digital Host support"
-	depends on MMC && ((BF54x && !BF544) || (BF51x && !BF512))
+	depends on (BF54x && !BF544) || (BF51x && !BF512)
 	help
 	  If you say yes here you will get support for the Blackfin on-chip
 	  Secure Digital Host interface.  This includes support for MMC and
_

Patches currently in -mm which might be from vapier@gentoo.org are

linux-next.patch
mmc-bfin_sdh-fix-unused-sg-warning-on-bf51x-bf52x-systems.patch
mmc-bfin_sdh-drop-redundant-mmc-depend-string.patch
mmc-bfin_sdh-set-timeout-based-on-actual-card-data.patch
fbdev-bf54x-lq043fb-bfin-t350mcqb-fb-drop-custom-mmap-handler.patch

