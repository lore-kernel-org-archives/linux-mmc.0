From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4 V2] mmc: esdhc: Add broken timeout quirk for p4/p5
 board
Date: Wed, 17 Jul 2013 12:13:49 -0500
Message-ID: <1374081229.8183.361@snotra>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:43111
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756628Ab3GQROG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jul 2013 13:14:06 -0400
In-Reply-To: <1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Wed Jul 17 05:11:31 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

On 07/17/2013 05:11:31 AM, Haijun Zhang wrote:
> Sometimes command can't be completed within the time give
> in eSDHC_SYSCTL[DTOCV]. So just give the max value 0x14 to
> avoid this issue.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for v2:
> 	- Rebuild patch of eSDHC host need long time to generate
> 	 command interrupt
> 
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c  
> b/drivers/mmc/host/sdhci-of-esdhc.c
> index 570bca8..30bfb5c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -325,6 +325,12 @@ static void esdhc_of_platform_init(struct  
> sdhci_host *host)
> 
>  	if (vvn > VENDOR_V_22)
>  		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
> +
> +	if ((SVR_SOC_VER(svr) == SVR_B4860) ||
> +		(SVR_SOC_VER(svr) == SVR_P5020) ||
> +		(SVR_SOC_VER(svr) == SVR_P5040) ||
> +		(SVR_SOC_VER(svr) == SVR_P4080))
> +		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }

Please don't line up the continuation lines of the if-condition with  
the if-body.

Please check variant SoCs as well.  If the bug exists on p4080, then it  
exists on p4040.  Likewise with p5040/p5021, and p5020/p5010.

Is it present on all revisions of these SoCs?  How about p3041, which  
is usually pretty similar to p5020?  p2040/p2041?  Is there an erratum  
number for this problem?

-Scott
