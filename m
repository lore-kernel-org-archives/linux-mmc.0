From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
Date: Wed, 27 Feb 2013 20:54:18 +0000
Message-ID: <201302272054.18829.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org> <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63009 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab3B0UyW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 15:54:22 -0500
In-Reply-To: <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wednesday 27 February 2013, Shawn Guo wrote:
>  Required properties:
>  - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
>    imx23 and imx28.
> -- interrupts: Should contain ERROR and DMA interrupts
> -- fsl,ssp-dma-channel: APBH DMA channel for the SSP
> +- interrupts: Should contain ERROR interrupt number
> +- dmas: DMA specifier, consisting of a phandle to DMA controller node
> +  and SSP DMA channel ID.
> +  Refer to dma.txt and fsl-mxs-dma.txt for details.

I wonder if we should leave support for old device trees files around,
at least for a while. Your patch removes a lot of unnecessary code if
we decide not to worry about backwards compatibility here, but I could
imagine that we see a few surprises here.

> +- dma-names: Must be "ssp".

I would prefer calling this "data" rather than "ssp". The name only
has local significance in the ssp device, so calling the channel
"ssp" seems wrong.

	Arnd
