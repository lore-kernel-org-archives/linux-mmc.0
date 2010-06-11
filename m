From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: + sdhci-add-no-hi-speed-bit-quirk-support.patch added to -mm
	tree
Date: Fri, 11 Jun 2010 01:42:29 +0100
Message-ID: <20100611004229.GD3498@trinity.fluff.org>
References: <201006102043.o5AKhJjl022731@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:48806 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab0FKAmh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 20:42:37 -0400
Content-Disposition: inline
In-Reply-To: <201006102043.o5AKhJjl022731@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, kmpark@infradead.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

On Thu, Jun 10, 2010 at 01:43:19PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      SDHCI: add no hi-speed bit quirk support
> has been added to the -mm tree.  Its filename is
>      sdhci-add-no-hi-speed-bit-quirk-support.patch
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
> Subject: SDHCI: add no hi-speed bit quirk support
> From: Kyungmin Park <kmpark@infradead.org>
> 
> Some SDHCI controllers like s5pc110 don't have an HISPD bit in the HOSTCTL
> register.

It would be nice for someone at Samsung to (a) explain the differences
from the base SDHCI spec for all their hardware (the databooks are often
vague in this area) and (b) for the information for the extra registers
this IP block has to be explained in more detail (and the platform code
checked for this too).

The CTRL2/CTRL3 registers definitions in the datasheets leave out useful
information such as how the feedback and filtering bits should be set
and how they depend on things such as the card type and bus speed.
 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/sdhci.c |    3 ++-
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-support drivers/mmc/host/sdhci.c
> --- a/drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-support
> +++ a/drivers/mmc/host/sdhci.c
> @@ -1164,7 +1164,8 @@ static void sdhci_set_ios(struct mmc_hos
>  	else
>  		ctrl &= ~SDHCI_CTRL_4BITBUS;
>  
> -	if (ios->timing == MMC_TIMING_SD_HS)
> +	if (ios->timing == MMC_TIMING_SD_HS &&
> +	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
>  		ctrl |= SDHCI_CTRL_HISPD;
>  	else
>  		ctrl &= ~SDHCI_CTRL_HISPD;
> diff -puN drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-support drivers/mmc/host/sdhci.h
> --- a/drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-support
> +++ a/drivers/mmc/host/sdhci.h
> @@ -240,6 +240,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> +#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<27)
>  
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */
> _
> 
> Patches currently in -mm which might be from kmpark@infradead.org are
> 
> mmc-recognize-csd-structure.patch
> mmc-recognize-csd-structure-fix.patch
> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
> s5pc110-sdhci-s3c-support-on-s5pc110.patch
> sdhci-add-no-hi-speed-bit-quirk-support.patch
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

