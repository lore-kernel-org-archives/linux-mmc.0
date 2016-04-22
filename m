From: Scott Wood <oss@buserror.net>
Subject: Re: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific
 driver
Date: Fri, 22 Apr 2016 18:22:32 -0500
Message-ID: <1461367352.32510.218.camel@buserror.net>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
	 <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:50837 "EHLO
	host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcDVXWm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 19:22:42 -0400
In-Reply-To: <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, Zhao Qiang <qiang.zhao@freescale.com>, Russell King <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, scott.wood@nxp.com, Claudiu Manoil <claudiu.manoil@freescale.com>, Kumar Gala <galak@codeaurora.org>, leoyang.li@nxp.com, xiaobo.xie@nxp.com, Michael Ellerman <mpe@ellerman.id.au>

On Fri, 2016-04-22 at 14:27 +0800, Yangbo Lu wrote:
> Add maintainer entry for Freescale SoC specific driver including
> the QE library and the GUTS driver. Also add entry for GUTS driver
> and add maintainer for QE library.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> ---
>  MAINTAINERS | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d5b4be..d20aeb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,13 +4622,27 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
>  F:	drivers/net/ethernet/freescale/fec.h
>  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
>  
> +FREESCALE SOC SPECIFIC DRIVER

FREESCALE SOC DRIVERS

> +M:	Scott Wood <oss@buserror.net>

Please CC me at this address, not the NXP address that you sent this to...

> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/soc/fsl/
> +F:	include/linux/fsl/

This directory will contain drivers that work on PPC and ARM... I'm not 
sure what to put here in terms of mailing lists (we could put both, but 
people probably shouldn't spam both lists if only one arch is relevant 
to the patch), and whom to make pull requests to.
 
> +FREESCALE GUTS DRIVER
> +M:	Yangbo Lu <yangbo.lu@nxp.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/soc/fsl/guts.c

What about the header?

Does guts really need a separate maintainer from drivers/soc/fsl?

-Scott


