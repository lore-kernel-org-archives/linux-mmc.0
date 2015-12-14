From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 2/6] dt: move guts devicetree doc out of powerpc directory
Date: Mon, 14 Dec 2015 16:10:05 -0600
Message-ID: <1450131005.15946.387.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-3-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0145.outbound.protection.outlook.com ([157.56.111.145]:7136
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753527AbbLNWK2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Dec 2015 17:10:28 -0500
In-Reply-To: <1450067067-44869-3-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Mon, 2015-12-14 at 12:24 +0800, Yangbo Lu wrote:
> Move guts devicetree doc to Documentation/devicetree/bindings/soc/
> since it's used by not only PowerPC but also ARM. Add a specification
> for 'little-endian' property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> ---
>  Documentation/devicetree/bindings/{powerpc/fsl => soc}/guts.txt | 3 +++
>  1 file changed, 3 insertions(+)
>  rename Documentation/devicetree/bindings/{powerpc/fsl => soc}/guts.txt
> (90%)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> b/Documentation/devicetree/bindings/soc/guts.txt
> similarity index 90%
> rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> rename to Documentation/devicetree/bindings/soc/guts.txt
> index b71b203..6ae2269 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> +++ b/Documentation/devicetree/bindings/soc/guts.txt
> @@ -25,6 +25,9 @@ Recommended properties:
>   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
>     registers, for those SOCs that have a PAMU device.
>  
> + - little-endian : Indicates that the global utilities block is little
> +   endian mode. And it's big endian mode in default.
> +
>  Examples:
>  	global-utilities@e0000 {	/* global utilities block */
>  		compatible = "fsl,mpc8548-guts";

...bindings/soc/fsl/guts.txt

s/endian mode/endian/g

s/And it's big endian mode in default/The default is big endian/

-Scott

