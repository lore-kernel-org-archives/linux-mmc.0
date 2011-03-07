From: Chris Ball <cjb@laptop.org>
Subject: MMC fix for 2.6.38
Date: Mon, 07 Mar 2011 18:03:33 -0500
Message-ID: <m3bp1m7cu2.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

to fix an SDIO initialization regression introduced in -rc1.  Thanks.

The following changes since commit 214d93b02c4fe93638ad268613c9702a81ed9192:
  Linus Torvalds (1):
        Merge branch 'omap-fixes-for-linus' of git://git.kernel.org/.../tmlind/linux-omap-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

Dmitry Shmidt (1):
      mmc: sdio: Allow sdio operations in other threads during sdio_add_func()

 drivers/mmc/core/sdio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

From: Dmitry Shmidt <dimitrysh@google.com>
Date: Thu, 3 Mar 2011 17:40:10 -0500
Subject: [PATCH] mmc: sdio: Allow sdio operations in other threads during sdio_add_func()

This fixes a bug introduced by 807e8e40673d ("mmc: Fix sd/sdio/mmc
initialization frequency retries") that prevented SDIO drivers from
performing SDIO commands in their probe routines -- the above patch
called mmc_claim_host() before sdio_add_func(), which causes a deadlock
if an external SDIO driver calls sdio_claim_host().

Fix tested on an OLPC XO-1.75 with libertas on SDIO.

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
Reviewed-and-Tested-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/sdio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5c4a54d..ebc62ad 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -792,7 +792,6 @@ int mmc_attach_sdio(struct mmc_host *host)
 	 */
 	mmc_release_host(host);
 	err = mmc_add_card(host->card);
-	mmc_claim_host(host);
 	if (err)
 		goto remove_added;
 
@@ -805,12 +804,12 @@ int mmc_attach_sdio(struct mmc_host *host)
 			goto remove_added;
 	}
 
+	mmc_claim_host(host);
 	return 0;
 
 
 remove_added:
 	/* Remove without lock if the device has been added. */
-	mmc_release_host(host);
 	mmc_sdio_remove(host);
 	mmc_claim_host(host);
 remove:
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
