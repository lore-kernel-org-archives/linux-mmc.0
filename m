From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/12] Add removal of old OMAP private DMA
 implementation to feature removal
Date: Mon, 23 Apr 2012 17:17:55 -0700
Message-ID: <20120424001755.GG3739@atomide.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLoD-0002Wr-6z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab2DXAR6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 20:17:58 -0400
Content-Disposition: inline
In-Reply-To: <E1SMLoD-0002Wr-6z@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:12]:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 03ca210..aec6f37 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -539,3 +539,14 @@ When:	3.6
>  Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
>  	violates the spec.
>  Who:	Sasikantha Babu <sasikanth.v19@gmail.com>
> +
> +----------------------------
> +
> +What:	OMAP private DMA implementation
> +When:	2013
> +Why:	We have a DMA engine implementation; all users should be updated
> +	to use this rather than persisting with the old APIs.  The old APIs
> +	block merging the old DMA engine implementation into the DMA
> +	engine driver.
> +Who:	Russell King <linux@arm.linux.org.uk>,
> +	Santosh Shilimkar <santosh.shilimkar@ti.com>
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
