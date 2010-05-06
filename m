From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: +
	s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-bui
	ld.patch added to -mm tree
Date: Thu, 6 May 2010 02:21:03 +0100
Message-ID: <20100506012103.GR2589@trinity.fluff.org>
References: <201005042346.o44Nk6Oi025952@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:50840 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab0EFBVK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 May 2010 21:21:10 -0400
Content-Disposition: inline
In-Reply-To: <201005042346.o44Nk6Oi025952@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, mcuelenaere@gmail.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org, thomas.ab@samsung.com

On Tue, May 04, 2010 at 04:46:06PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      mmc: s3c6410: add new quirk in sdhci driver and update ADMA descriptor build.
> has been added to the -mm tree.  Its filename is
>      s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: mmc: s3c6410: add new quirk in sdhci driver and update ADMA descriptor build.
> From: Maurus Cuelenaere <mcuelenaere@gmail.com>

originally from Thomas Abraham <thomas.ab@samsung.com>
and resent by Maurus Cuelenaere <mcuelenaere@gmail.com>

see also same with second patch.
 
> The s3c6410 sdhci controller does not support the 'End' attribute and NOP
> attribute in the same 8-Byte ADMA descriptor.  This patch adds a new quirk
> to identify sdhci host contollers with such behaviour.  In addition to
> this, for controllers using the new quirk, the last entry in the ADMA
> descritor table is marked with the 'End' attribute (instead of using a NOP
> descriptor with 'End' attribute).
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/sdhci.c |   20 +++++++++++++++-----
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff -puN drivers/mmc/host/sdhci.c~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build drivers/mmc/host/sdhci.c
> --- a/drivers/mmc/host/sdhci.c~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build
> +++ a/drivers/mmc/host/sdhci.c
> @@ -496,12 +496,22 @@ static int sdhci_adma_table_pre(struct s
>  		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
>  	}
>  
> -	/*
> -	 * Add a terminating entry.
> -	 */
> +	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
> +		/*
> +		* Mark the last descriptor as the terminating descriptor
> +		*/
> +		if (desc != host->adma_desc) {
> +			desc -= 8;
> +			desc[0] |= 0x2; /* end */
> +		}
> +	} else {
> +		/*
> +		* Add a terminating entry.
> +		*/
>  
> -	/* nop, end, valid */
> -	sdhci_set_adma_desc(desc, 0, 0, 0x3);
> +		/* nop, end, valid */
> +		sdhci_set_adma_desc(desc, 0, 0, 0x3);
> +	}
>  
>  	/*
>  	 * Resync align buffer as we might have changed it.
> diff -puN drivers/mmc/host/sdhci.h~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build drivers/mmc/host/sdhci.h
> --- a/drivers/mmc/host/sdhci.h~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build
> +++ a/drivers/mmc/host/sdhci.h
> @@ -238,6 +238,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
>  /* Controller reports wrong base clock capability */
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> +/* Controller cannot support End Attribute in NOP ADMA descriptor */
> +#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
>  
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */
> _
> 
> Patches currently in -mm which might be from mcuelenaere@gmail.com are
> 
> s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build.patch
> s3c6410-enable-adma-feature-in-6410-sdhci-controller.patch
> sdhci-enable-multiblock-transfers-in-sdhci-s3c.patch
> s3c-rtc-driver-add-support-for-s3c64xx.patch
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

