From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] [MMC] propagate error codes back from bus drivers'
 suspend/resume methods
Date: Wed, 16 Sep 2009 16:43:17 -0700
Message-ID: <20090916164317.00fc1d66.akpm@linux-foundation.org>
References: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
	<1253073109-13849-3-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41139 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760577AbZIPXne (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2009 19:43:34 -0400
In-Reply-To: <1253073109-13849-3-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, 15 Sep 2009 23:51:48 -0400
Nicolas Pitre <nico@fluxnic.net> wrote:

> Especially for SDIO drivers which may have special conditions/errors
> to report, it is a good thing to relay the returned error code back to
> upper layers.
> 
> This also allows for the rationalization of the resume path where code
> to "remove" a no-longer-existing or replaced card was duplicated into
> the MMC, SD and SDIO bus drivers.
> 
> In the SDIO case, if a function suspend method returns an error, then
> all previously suspended functions are resumed and the error returned.
> An exception is made for -ENOSYS which the core interprets as "we don't
> support suspend so just kick the card out for suspend and return success".
> 
> When resuming SDIO cards, the core code only validates the manufacturer
> and product IDs to make sure the same kind of card is still present
> before invoking functions resume methods.  It's the function driver's
> responsibility to perform further tests to confirm that the actual same
> card is present (same MAC address, etc.) and return an error otherwise.


This one spat a reject (below), presumably due to the many, many mmc
changes which are pending.

I think I fixed it up OK.


***************
*** 958,984 ****
   */
  int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
  {
  	cancel_delayed_work(&host->detect);
  	mmc_flush_scheduled_work();
  
  	mmc_bus_get(host);
  	if (host->bus_ops && !host->bus_dead) {
  		if (host->bus_ops->suspend)
- 			host->bus_ops->suspend(host);
- 		if (!host->bus_ops->resume) {
  			if (host->bus_ops->remove)
  				host->bus_ops->remove(host);
- 
  			mmc_claim_host(host);
  			mmc_detach_bus(host);
  			mmc_release_host(host);
  		}
  	}
  	mmc_bus_put(host);
  
- 	mmc_power_off(host);
  
- 	return 0;
  }
  
  EXPORT_SYMBOL(mmc_suspend_host);
--- 958,991 ----
   */
  int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
  {
+ 	int err = 0;
+ 
  	cancel_delayed_work(&host->detect);
  	mmc_flush_scheduled_work();
  
  	mmc_bus_get(host);
  	if (host->bus_ops && !host->bus_dead) {
  		if (host->bus_ops->suspend)
+ 			err = host->bus_ops->suspend(host);
+ 		if (err == -ENOSYS || !host->bus_ops->resume) {
+ 			/*
+ 			 * We simply "remove" the card in this case.
+ 			 * It will be redetected on resume.
+ 			 */
  			if (host->bus_ops->remove)
  				host->bus_ops->remove(host);
  			mmc_claim_host(host);
  			mmc_detach_bus(host);
  			mmc_release_host(host);
+ 			err = 0;
  		}
  	}
  	mmc_bus_put(host);
  
+ 	if (!err)
+ 		mmc_power_off(host);
  
+ 	return err;
  }
  
  EXPORT_SYMBOL(mmc_suspend_host);

