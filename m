From: akpm@linux-foundation.org
Subject: [folded] mmc-core-sdio-suspend-resume-support-fix.patch removed from -mm tree
Date: Tue, 22 Sep 2009 14:43:45 -0700
Message-ID: <200909222143.n8MLhju1001157@imap1.linux-foundation.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47980 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604AbZIVVnn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 17:43:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, nico@marvell.com, mm-commits@vger.kernel.org


The patch titled
     mmc-core-sdio-suspend-resume-support-fix
has been removed from the -mm tree.  Its filename was
     mmc-core-sdio-suspend-resume-support-fix.patch

This patch was dropped because it was folded into mmc-core-sdio-suspend-resume-support.patch

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: mmc-core-sdio-suspend-resume-support-fix
From: Andrew Morton <akpm@linux-foundation.org>

drivers/mmc/core/sdio.c: In function 'mmc_sdio_suspend':
drivers/mmc/core/sdio.c:410: warning: initialization discards qualifiers from pointer target type
drivers/mmc/core/sdio.c:426: warning: initialization discards qualifiers from pointer target type
drivers/mmc/core/sdio.c: In function 'mmc_sdio_resume':
drivers/mmc/core/sdio.c:454: warning: initialization discards qualifiers from pointer target type

Cc: <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@marvell.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/core/sdio.c~mmc-core-sdio-suspend-resume-support-fix drivers/mmc/core/sdio.c
--- a/drivers/mmc/core/sdio.c~mmc-core-sdio-suspend-resume-support-fix
+++ a/drivers/mmc/core/sdio.c
@@ -407,7 +407,7 @@ static void mmc_sdio_suspend(struct mmc_
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
-			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
 				/* just remove the entire card in that case */
 				mmc_sdio_remove(host);
@@ -423,7 +423,7 @@ static void mmc_sdio_suspend(struct mmc_
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
-			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->suspend(&func->dev);
 		}
 	}
@@ -451,7 +451,7 @@ static void mmc_sdio_resume(struct mmc_h
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
-			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->resume(&func->dev);
 		}
 	}
_

Patches currently in -mm which might be from akpm@linux-foundation.org are

origin.patch
printk-boot_delay-rename-printk_delay_msec-to-loops_per_msec.patch
printk-add-printk_delay-to-make-messages-readable-for-some-scenarios.patch
generic-ipi-make-struct-call_function_data-lockless.patch
proc-connector-add-event-for-process-becoming-session-leader.patch
build_bug_on-fix-it-and-a-couple-of-bogus-uses-of-it.patch
mmc-register-mmci-omap-hs-using-platform_driver_probe.patch
sdio-add-cd-disable-support.patch
sdio-add-mmc_quirk_lenient_fn0.patch
at91-atmel-mci-platform-configuration-to-the-the-atmel-mci-driver.patch
mmc-core-sdio-suspend-resume-support.patch
mmc-core-sdio-suspend-resume-support-fix.patch
procfs-provide-stack-information-for-threads-v011-fix.patch
walk-system-ram-range-fix-2.patch
kcore-register-vmemmap-range-fix.patch
rtc-add-driver-for-mxcs-internal-rtc-module-fix.patch
rtc-add-driver-for-mxcs-internal-rtc-module-fix-fix.patch
davinci-fb-frame-buffer-driver-for-ti-da8xx-omap-l1xx.patch
davinci-fb-frame-buffer-driver-for-ti-da8xx-omap-l1xx-v4-cleanup.patch
drivers-video-add-kmalloc-null-tests-fix.patch
drivers-video-tmiofbc-fix-uninitialised-return-value.patch
v3-minixfs-add-missing-directory-type-checking-checkpatch-fixes.patch

