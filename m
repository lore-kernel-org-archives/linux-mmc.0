From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Powerpc: Add voltage support in dts file
Date: Tue, 23 Jul 2013 11:19:20 -0500
Message-ID: <1374596360.15592.25@snotra>
References: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:18218
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933104Ab3GWQT0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Jul 2013 12:19:26 -0400
In-Reply-To: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Mon Jul 22 21:59:04 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

On 07/22/2013 09:59:04 PM, Haijun Zhang wrote:
> eSDHC of T4240 had 1.8v voltage support. Add this node to specify
> eSDHC voltage capacity. If this node not specified eSDHC driver
> still can read from eSDHC host capacity register.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for this patch set:
> 	- split from patch [PATCH 1/2] Powerpc: Add
> 	- voltage ranges support for T4
> 
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 3 +++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi         | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt  
> b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index bd9be0b..f1ac253 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -19,6 +19,8 @@ Optional properties:
>      "bus-width = <1>" property.
>    - sdhci,auto-cmd12: specifies that a controller can only handle  
> auto
>      CMD12.
> +  - 3300 3300: specifies that eSDHC controller can support voltages  
> ranges
> +    from 3300 to 3300.

"3300 3300" is not a property name -- and the voltage-ranges property  
should be defined more generically, as is done for mmc-spi-slot.txt.

-Scott
