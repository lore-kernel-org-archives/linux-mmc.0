From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: Add architecture dependency for Marvell SoC controller
Date: Mon, 13 Sep 2010 12:48:38 +0200
Message-ID: <201009131248.38501.arnd@arndb.de>
References: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63733 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0IMKsq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2010 06:48:46 -0400
In-Reply-To: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 13 September 2010, Mark Brown wrote:
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index ce099c4..5fa4e2b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -133,6 +133,7 @@ config MMC_SDHCI_CNS3XXX
>  config MMC_SDHCI_MV
>         tristate "SDHCI support on Marvell's SoC"
>         depends on MMC_SDHCI
> +       depends on (PLAT_PXA || PLAT_ORION)
>         select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the Secure Digital Host Controller Interface in

I think we normally try to do the the other way round: in order to increase
build coverage, try to enable all drivers on as many platforms as possible,
just don't have them in the defconfig.

Do you get build errors on other platforms? If yes, there is probably
a bug in the driver that should be fixed instead.

	Arnd
