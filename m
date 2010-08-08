From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: + omap_hsmmc-remove-ugly-hack-workaround-regulator-framework-bugs.patch
 added to -mm tree
Date: Sun, 08 Aug 2010 14:42:50 +0300
Message-ID: <4C5E983A.1070700@nokia.com>
References: <201008052133.o75LXueh006102@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41567 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0HHLnJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Aug 2010 07:43:09 -0400
In-Reply-To: <201008052133.o75LXueh006102@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "matt@console-pimps.org" <matt@console-pimps.org>, "tony@atomide.com" <tony@atomide.com>

akpm@linux-foundation.org wrote:
> The patch titled
>      omap_hsmmc: remove 'UGLY HACK:  workaround regulator framework bugs'
> has been added to the -mm tree.  Its filename is
>      omap_hsmmc-remove-ugly-hack-workaround-regulator-framework-bugs.patch
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
> Subject: omap_hsmmc: remove 'UGLY HACK:  workaround regulator framework bugs'
> From: Adrian Hunter <adrian.hunter@nokia.com>

This patch is also wrong, sorry.

Andrew please remove it.


> 
> The framework is fixed.  The hack can be removed.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/omap_hsmmc.c |   19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-remove-ugly-hack-workaround-regulator-framework-bugs drivers/mmc/host/omap_hsmmc.c
> --- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-remove-ugly-hack-workaround-regulator-framework-bugs
> +++ a/drivers/mmc/host/omap_hsmmc.c
> @@ -401,25 +401,6 @@ static int omap_hsmmc_reg_get(struct oma
>  		/* Allow an aux regulator */
>  		reg = regulator_get(host->dev, "vmmc_aux");
>  		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
> -
> -		/*
> -		* UGLY HACK:  workaround regulator framework bugs.
> -		* When the bootloader leaves a supply active, it's
> -		* initialized with zero usecount ... and we can't
> -		* disable it without first enabling it.  Until the
> -		* framework is fixed, we need a workaround like this
> -		* (which is safe for MMC, but not in general).
> -		*/
> -		if (regulator_is_enabled(host->vcc) > 0) {
> -			regulator_enable(host->vcc);
> -			regulator_disable(host->vcc);
> -		}
> -		if (host->vcc_aux) {
> -			if (regulator_is_enabled(reg) > 0) {
> -				regulator_enable(reg);
> -				regulator_disable(reg);
> -			}
> -		}
>  	}
>  
>  	return 0;
> _
> 
> Patches currently in -mm which might be from adrian.hunter@nokia.com are
> 
> origin.patch
> linux-next.patch
> mmc-recognize-csd-structure.patch
> mmc-recognize-csd-structure-fix.patch
> mmc-split-mmc_sd_init_card.patch
> mmc-implement-sd-combo-iomem-support.patch
> mmc-omap-fix-for-bus-width-which-improves-sd-cards-peformance.patch
> sdio-allow-non-standard-sdio-cards.patch
> omap_hsmmc-add-init_card-pass-through-callback.patch
> omap-pandora-pass-wl1251-information-to-sdio-core.patch
> mmc-add-erase-secure-erase-trim-and-secure-trim-operations.patch
> mmc_block-add-discard-support.patch
> omap_hsmmc-add-erase-capability.patch
> block-add-secure-discard.patch
> mmc_block-add-support-for-secure-discard.patch
> mmc_test-add-performance-tests.patch
> mmc_test-fix-large-memory-allocation.patch
> mmc-use-regulator-framework-correctly.patch
> omap_hsmmc-remove-ugly-hack-workaround-regulator-framework-bugs.patch
> 
> 

