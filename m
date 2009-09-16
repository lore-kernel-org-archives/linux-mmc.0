From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] [MMC] core SDIO suspend/resume support
Date: Wed, 16 Sep 2009 16:39:54 -0700
Message-ID: <20090916163954.ee93e9dd.akpm@linux-foundation.org>
References: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
	<1253073109-13849-2-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34717 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933678AbZIPXjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2009 19:39:53 -0400
In-Reply-To: <1253073109-13849-2-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, 15 Sep 2009 23:51:47 -0400
Nicolas Pitre <nico@fluxnic.net> wrote:

> Subject: [PATCH 1/3] [MMC] core SDIO suspend/resume support

Please use titles of the form

	[patch n/m] mmc: ...

because text which goes inside [] is conventionally stripped away by
the patch recipient, but we do want the patch's title to identify its
subsystem within its leading text.

> Date: Tue, 15 Sep 2009 23:51:47 -0400
> X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
> 
> Currently, all SDIO cards are virtually removed upon a suspend, and
> completely reprobed upon a resume.  This adds the suspend and resume
> methods to the SDIO bus driver so to be able to dispatch those events
> to the actual SDIO function drivers for real suspend/resume instead.
> 
> All active functions on a card must have a driver with both a suspend
> and a resume method though.  Failing that, we fall back to the current
> behavior of simply "removing" the card when suspending.
> 
> When resuming, we make sure the same card is still inserted by comparing
> the vendor and product IDs.  If there is a mismatch, or if there is simply
> no card anymore in the slot, then the previous card is "removed" and the
> new card is detected.  This is further enhanced with the next patch.

I get these:

drivers/mmc/core/sdio.c: In function 'mmc_sdio_suspend':
drivers/mmc/core/sdio.c:410: warning: initialization discards qualifiers from pointer target type
drivers/mmc/core/sdio.c:426: warning: initialization discards qualifiers from pointer target type
drivers/mmc/core/sdio.c: In function 'mmc_sdio_resume':
drivers/mmc/core/sdio.c:454: warning: initialization discards qualifiers from pointer target type

			struct dev_pm_ops *pmops = func->dev.driver->pm;

			struct dev_pm_ops *pmops = func->dev.driver->pm;

			struct dev_pm_ops *pmops = func->dev.driver->pm;

because someone changed the type of device_driver.pm in the development
code.

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

