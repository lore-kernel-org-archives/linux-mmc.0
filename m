From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] s3cmci: port DMA code to dmaengine API
Date: Wed, 21 May 2014 10:57:34 +0200
Message-ID: <4563444.HLmgOoMRYe@wuerfel>
References: <1400617259-6939-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59097 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaEUI5r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 May 2014 04:57:47 -0400
In-Reply-To: <1400617259-6939-1-git-send-email-anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Tuesday 20 May 2014 23:20:59 Vasily Khoruzhick wrote:
> index 1384f67..e70e4cf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -420,6 +420,7 @@ config MMC_SPI
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
>         depends on ARCH_S3C24XX
> +       select S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in
>            Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
> 

I think you should use 'depends on S3C24XX_DMAC' here.

Other than that,

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
