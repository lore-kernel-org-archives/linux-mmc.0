From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Powerpc/t4240: change the compatible flags for t4240qds
 board
Date: Mon, 8 Jul 2013 12:14:05 -0500
Message-ID: <1373303645.8183.163@snotra>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:52442
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab3GHROR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jul 2013 13:14:17 -0400
In-Reply-To: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Mon Jul  8 02:16:03 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

On 07/08/2013 02:16:03 AM, Haijun Zhang wrote:
> In order to make a difference between different T4240 board.
> Specify T4240QDS board the unique compatible flags for t4240qds
> eSDHC host.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi  
> b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> index bd611a9..08b47d0 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -397,7 +397,7 @@
> 
>  /include/ "qoriq-esdhc-0.dtsi"
>  	sdhc@114000 {
> -		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
> +		compatible = "fsl,t4240qds-esdhc", "fsl,esdhc";
>  		sdhci,auto-cmd12;
>  	};

NACK.  This node is describing the sdhc block of the t4240 SoC.  What  
board you stick it in doesn't change what it is.

Plus, what about users with old device trees?

-Scott
