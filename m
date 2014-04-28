From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 33/38] mmc: sdhci: fix SDHCI dependencies
Date: Mon, 28 Apr 2014 10:28:49 -0600
Message-ID: <535E81C1.3020902@wwwdotorg.org>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2XT-0003wV-0H@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52254 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbaD1Q2w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 12:28:52 -0400
In-Reply-To: <E1Wd2XT-0003wV-0H@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On 04/23/2014 01:08 PM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

A patch description would be useful so I can work out why...

> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig

>  config MMC_SDHCI
> -	tristate "Secure Digital Host Controller Interface support"
> -	depends on HAS_DMA
> +	tristate
>  	help
>  	  This selects the generic Secure Digital Host Controller Interface.
>  	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)

... it's useful to remove that depends from here and ...
>  config MMC_SDHCI_TEGRA
>  	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
> -	depends on ARCH_TEGRA
> -	depends on MMC_SDHCI_PLTFM
> +	depends on ARCH_TEGRA && HAS_DMA

... duplicate it in all the HW-specific drivers.

On Tegra (and I believe at least any ARM system), I think HAS_DMA is
always true, so is there a need for "&& HAS_DMA" at all, now that this
statement is pushed into arch-/HW-specific options?
