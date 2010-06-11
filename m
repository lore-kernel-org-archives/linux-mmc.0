From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: + s5pc110-sdhci-s3c-can-override-host-capabilities.patch added
	to -mm tree
Date: Fri, 11 Jun 2010 01:34:14 +0100
Message-ID: <20100611003414.GB3498@trinity.fluff.org>
References: <201006102043.o5AKhEtI022722@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:39401 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab0FKAeZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 20:34:25 -0400
Content-Disposition: inline
In-Reply-To: <201006102043.o5AKhEtI022722@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, kmpark@infradead.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

On Thu, Jun 10, 2010 at 01:43:14PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      s5pc110: SDHCI-s3c can override host capabilities
> has been added to the -mm tree.  Its filename is
>      s5pc110-sdhci-s3c-can-override-host-capabilities.patch
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
> Subject: s5pc110: SDHCI-s3c can override host capabilities
> From: Kyungmin Park <kmpark@infradead.org>
> 
> Each board can override the default sdhci host capabilities.
> Some board has broken features by hardwares and support 8-bit bandwidth.

I'd much rather see a mask to remove unsupported features than simply
override the already read hardware mask.
 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm/plat-samsung/dev-hsmmc.c  |    2 ++
>  arch/arm/plat-samsung/dev-hsmmc1.c |    2 ++
>  arch/arm/plat-samsung/dev-hsmmc2.c |    2 ++
>  3 files changed, 6 insertions(+)
> 
> diff -puN arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc.c
> --- a/arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-override-host-capabilities
> +++ a/arch/arm/plat-samsung/dev-hsmmc.c
> @@ -65,4 +65,6 @@ void s3c_sdhci0_set_platdata(struct s3c_
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->host_caps)
> +		set->host_caps = pd->host_caps;
>  }
> diff -puN arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc1.c
> --- a/arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-override-host-capabilities
> +++ a/arch/arm/plat-samsung/dev-hsmmc1.c
> @@ -65,4 +65,6 @@ void s3c_sdhci1_set_platdata(struct s3c_
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->host_caps)
> +		set->host_caps = pd->host_caps;
>  }
> diff -puN arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc2.c
> --- a/arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-override-host-capabilities
> +++ a/arch/arm/plat-samsung/dev-hsmmc2.c
> @@ -66,4 +66,6 @@ void s3c_sdhci2_set_platdata(struct s3c_
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->host_caps)
> +		set->host_caps = pd->host_caps;
>  }
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

