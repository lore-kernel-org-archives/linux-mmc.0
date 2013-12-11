From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 07/15] mmc: sdhi: Enable driver compilation with COMPILE_TEST
Date: Wed, 11 Dec 2013 22:01:53 +0400
Message-ID: <52A8A891.40302@cogentembedded.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1385515117-23664-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:51561 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab3LKSBz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 13:01:55 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so460795bkh.37
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2013 10:01:54 -0800 (PST)
In-Reply-To: <1385515117-23664-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org

Hello.

On 27-11-2013 5:18, Laurent Pinchart wrote:

> This helps increasing build testing coverage.

> The driver doesn't compile on (at least) x86 due (possibly among others)
> to missing readsw/writesw I/O accessors, restrict compilation to SUPERH
> or ARM.

> Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> controller or is Renesas-specific is unknown and impossible to test as
> we have no current or planned TMIO DMA users other than SUPERH and
> ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> list would extend this to multiarch kernels, but would break the driver
> for non-shmobile platforms if the register is Renesas-specific. We can
> thus get rid of the conditional compilation completely without
> introducing any further issue, and let future non-Renesas users deal
> with the situation if it turns out to be a the problem.

> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>   drivers/mmc/host/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..ca1315e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -479,7 +479,8 @@ config MMC_TMIO
>
>   config MMC_SDHI
>   	tristate "SH-Mobile SDHI SD/SDIO controller support"
> -	depends on SUPERH || ARCH_SHMOBILE
> +	depends on SUPERH || ARM
> +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST

    Hm, why 2 "depends" lines with SUPERH in both?

WBR, Sergei

