From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v1 3/5] ARM: imx28evk: add mmc dt support
Date: Tue, 13 Mar 2012 09:39:30 -0500
Message-ID: <4F5F5C22.1080506@gmail.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com> <1331628428-24017-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65094 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2CMOjf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Mar 2012 10:39:35 -0400
In-Reply-To: <1331628428-24017-4-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, rob.herring@calxeda.com, grant.likely@secretlab.ca, rdunlap@xenotime.net, kernel@pengutronix.de, cjb@laptop.org, shawn.guo@freescale.com

On 03/13/2012 03:47 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |   14 ++++++++++++++
>  arch/arm/boot/dts/imx28.dtsi    |   33 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/imx28-dt.c    |    2 ++
>  3 files changed, 49 insertions(+), 0 deletions(-)

snip

> diff --git a/arch/arm/mach-mxs/imx28-dt.c b/arch/arm/mach-mxs/imx28-dt.c
> index 78d1129..429b88e 100644
> --- a/arch/arm/mach-mxs/imx28-dt.c
> +++ b/arch/arm/mach-mxs/imx28-dt.c
> @@ -23,6 +23,8 @@ static const struct of_dev_auxdata imx28_auxdata_lookup[] __initconst = {
>  	OF_DEV_AUXDATA("arm,pl011", MX28_DUART_BASE_ADDR, "duart", NULL),
>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC0_BASE_ADDR, "imx28-fec.0", NULL),
>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC1_BASE_ADDR, "imx28-fec.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP0_BASE_ADDR, "mxs-mmc.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP1_BASE_ADDR, "mxs-mmc.1", NULL),

Why is this needed?

>  	{ /* sentinel */ }
>  };
>  

