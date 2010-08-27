From: Matt Fleming <matt@console-pimps.org>
Subject: Re: +
 arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected.patch
 added to -mm tree
Date: Fri, 27 Aug 2010 21:23:47 +0100
Message-ID: <20100827202347.GC18829@console-pimps.org>
References: <201008272003.o7RK3d33013124@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:37386 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057Ab0H0UXt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 16:23:49 -0400
Content-Disposition: inline
In-Reply-To: <201008272003.o7RK3d33013124@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, jiri.pinkava@vscht.cz, cjb@laptop.org, linux-mmc@vger.kernel.org, rmk@arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>

Best get Ben's opinion on this (now Cc'd).

On Fri, Aug 27, 2010 at 01:03:39PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      ARM: SAMSUNG: MMC: fix build error when both DMA and PIO mode selected
> has been added to the -mm tree.  Its filename is
>      arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected.patch
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
> Subject: ARM: SAMSUNG: MMC: fix build error when both DMA and PIO mode selected
> From: Jiri Pinkava <jiri.pinkava@vscht.cz>
> 
> Date: Tue, 25 May 2010 09:48:58 +0200
> 
> [cjb: fix line-wrapped patch]
> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/s3cmci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/mmc/host/s3cmci.c~arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected drivers/mmc/host/s3cmci.c
> --- a/drivers/mmc/host/s3cmci.c~arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected
> +++ a/drivers/mmc/host/s3cmci.c
> @@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct
>  	host->pio_active 	= XFER_NONE;
>  
>  #ifdef CONFIG_MMC_S3C_PIODMA
> -	host->dodma		= host->pdata->dma;
> +	host->dodma		= host->pdata->use_dma;
>  #endif
>  
>  	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> _
> 
> Patches currently in -mm which might be from jiri.pinkava@vscht.cz are
> 
> arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected.patch
> 
