From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: + s5pc110-sdhci-s3c-support-on-s5pc110.patch added to -mm tree
Date: Fri, 11 Jun 2010 01:36:32 +0100
Message-ID: <20100611003632.GC3498@trinity.fluff.org>
References: <201006102043.o5AKhHK1022728@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:39514 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab0FKAgh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 20:36:37 -0400
Content-Disposition: inline
In-Reply-To: <201006102043.o5AKhHK1022728@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, kmpark@infradead.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org


On Thu, Jun 10, 2010 at 01:43:17PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      s5pc110: SDHCI-s3c support on s5pc110
> has been added to the -mm tree.  Its filename is
>      s5pc110-sdhci-s3c-support-on-s5pc110.patch
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
> Subject: s5pc110: SDHCI-s3c support on s5pc110
> From: Kyungmin Park <kmpark@infradead.org>
> 
> s5pc110 (aka s5pv210) uses the same SDHCI IP.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/mmc/host/Kconfig~s5pc110-sdhci-s3c-support-on-s5pc110 drivers/mmc/host/Kconfig
> --- a/drivers/mmc/host/Kconfig~s5pc110-sdhci-s3c-support-on-s5pc110
> +++ a/drivers/mmc/host/Kconfig
> @@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
>  
>  config MMC_SDHCI_S3C
>  	tristate "SDHCI support on Samsung S3C SoC"
> -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> +	depends on MMC_SDHCI && PLAT_SAMSUNG

I've no problem with drivers being made available across the
PLAT_SAMSUNG range when they are truly generic, however the SDHCI
is only almost generic.

I'm not sure whether to ask for this one to be held until we've had
some time to discuss what we do about these on the relevant mailing
lists or say ok, this is what we should do.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

