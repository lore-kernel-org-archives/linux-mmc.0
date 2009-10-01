From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [patch 077/232] sdio: fix read buffer overflow
Date: Thu, 01 Oct 2009 11:08:04 +0100
Message-ID: <4AC47F84.20806@cam.ac.uk>
References: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:57546 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbZJAKHh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 06:07:37 -0400
In-Reply-To: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: roel.kluin@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org, "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>

Hi All,

This patch is causing a regression with libertas 8686.
It's only finding 3 strings which I'm guessing means
it is an invalid CISTPL_VERS_1. Unfortunately the libertas_sdio
code relies on a string in one of them to tell it what model of
card we have.

Can someone confirm what the CIS_VERS_1 spec actually is?
I've found one vague reference to entries 3 and 4 being optional
but the simplified sdio spec refers to the pcmcia 3.2.10 spec
which I don't have easy access to.

Any suggestions on a work around?

Thanks,

Jonathan


> From: Roel Kluin <roel.kluin@gmail.com>
> 
> Avoid buffer underrun when parsing an invalid CISTPL_VERS_1.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Cc: David Vrabel <david.vrabel@csr.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/core/sdio_cis.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/mmc/core/sdio_cis.c~sdio-fix-read-buffer-overflow drivers/mmc/core/sdio_cis.c
> --- a/drivers/mmc/core/sdio_cis.c~sdio-fix-read-buffer-overflow
> +++ a/drivers/mmc/core/sdio_cis.c
> @@ -40,7 +40,7 @@ static int cistpl_vers_1(struct mmc_card
>  			nr_strings++;
>  	}
>  
> -	if (buf[i-1] != '\0') {
> +	if (nr_strings < 4) {
>  		printk(KERN_WARNING "SDIO: ignoring broken CISTPL_VERS_1\n");
>  		return 0;
>  	}
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

