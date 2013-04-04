From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Thu, 4 Apr 2013 09:44:25 +0000 (UTC)
Message-ID: <loom.20130404T113956-355@post.gmane.org>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43698 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759312Ab3DDJtu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 05:49:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UNgo1-0001yT-A4
	for linux-mmc@vger.kernel.org; Thu, 04 Apr 2013 11:50:06 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 11:50:05 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 11:50:05 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Kevin Liu <kliu5 <at> marvell.com> writes:

> 
> host->ocr has been reset in power off but not restored after power up
> in resume. And operation voltage will be set to the highest after resume
> back. This patch fix these two bugs.
> 
> Signed-off-by: Kevin Liu <kliu5 <at> marvell.com>
> ---
>  drivers/mmc/core/core.c  |    3 ++-
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 08a3cf2..b8c3d41 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
>  <at>  <at>  -1523,6 +1523,7  <at>  <at>  void mmc_power_off(struct 
mmc_host *host)
>  	 * Reset ocr mask to be the highest possible voltage supported for
>  	 * this mmc host. This value will be used at next power up.
>  	 */
> +	host->ocr_bak = host->ocr;
>  	host->ocr = 1 << (fls(host->ocr_avail) - 1);
> 
>  	if (!mmc_host_is_spi(host)) {
>  <at>  <at>  -2666,7 +2667,7  <at>  <at>  int mmc_resume_host(struct 
mmc_host *host)
>  	if (host->bus_ops && !host->bus_dead) {
>  		if (!mmc_card_keep_power(host)) {
>  			mmc_power_up(host);
> -			mmc_select_voltage(host, host->ocr);
> +			host->ocr = mmc_select_voltage(host, host->ocr_bak);
>  			/*
>  			 * Tell runtime PM core we just powered up the card,
>  			 * since it still believes the card is powered off.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index d6f20cc..6e355d1 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
>  <at>  <at>  -309,6 +309,7  <at>  <at>  struct mmc_host {
> 
>  	struct mmc_ios		ios;		/* current io bus settings 
*/
>  	u32			ocr;		/* the current OCR setting 
*/
> +	u32			ocr_bak;	/* save current OCR setting 
*/
> 
>  	/* group bitfields together to minimize padding */
>  	unsigned int		use_spi_crc:1;


Hello Kevin,

Any update on this patch? 

I have seen an issue where during initialization, core will get card's ocr 
and match with host ocr available and select the appropriate voltage (3.0V)
But during suspend, maximum supported voltage from host is saved back and 
when resuming back requesting for highest voltage of host (3.3V).
It doesn't care about card's OCR.

This patch fixes it. Looks valid for me.

Thanks & Regards,
Prasanna NAVARATNA

