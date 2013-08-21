From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH RESEND] mmc: mmc_spi: use spi_get_drvdata() and
 spi_set_drvdata()
Date: Wed, 21 Aug 2013 08:30:49 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE31BC50C0@NWD2MBX7.ad.analog.com>
References: <000101ce9e33$2bfcc6b0$83f65410$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:10390 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618Ab3HUIb6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Aug 2013 04:31:58 -0400
In-Reply-To: <000101ce9e33$2bfcc6b0$83f65410$%han@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Jingoo Han [mailto:jg1.han@samsung.com]
>Sent: Wednesday, August 21, 2013 1:56 PM
>To: 'Chris Ball'
>Cc: linux-mmc@vger.kernel.org; Zhang, Sonic; 'Jingoo Han'
>Subject: [PATCH RESEND] mmc: mmc_spi: use spi_get_drvdata() and
>spi_set_drvdata()
>
>Use the wrapper functions for getting and setting the driver data using spi_device
>instead of using dev_{get|set}_drvdata with &spi->dev, so we can directly pass a
>struct spi_device. This is a cosmetic change in order to enhance the readability and
>make the code simpler.
>
>Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>---
> drivers/mmc/host/mmc_spi.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c index
>74145d1..5bc7a90 100644
>--- a/drivers/mmc/host/mmc_spi.c
>+++ b/drivers/mmc/host/mmc_spi.c
>@@ -1406,7 +1406,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>                       host->powerup_msecs = 250;
>       }
>
>-      dev_set_drvdata(&spi->dev, mmc);
>+      spi_set_drvdata(spi, mmc);
>
>       /* preallocate dma buffers */
>       host->data = kmalloc(sizeof(*host->data), GFP_KERNEL); @@ -1477,7
>+1477,7 @@ fail_glue_init:
> fail_nobuf1:
>       mmc_free_host(mmc);
>       mmc_spi_put_pdata(spi);
>-      dev_set_drvdata(&spi->dev, NULL);
>+      spi_set_drvdata(spi, NULL);
>
> nomem:
>       kfree(ones);
>@@ -1487,7 +1487,7 @@ nomem:
>
> static int mmc_spi_remove(struct spi_device *spi)  {
>-      struct mmc_host         *mmc = dev_get_drvdata(&spi->dev);
>+      struct mmc_host         *mmc = spi_get_drvdata(spi);
>       struct mmc_spi_host     *host;
>
>       if (mmc) {
>@@ -1512,7 +1512,7 @@ static int mmc_spi_remove(struct spi_device *spi)
>               spi->max_speed_hz = mmc->f_max;
>               mmc_free_host(mmc);
>               mmc_spi_put_pdata(spi);
>-              dev_set_drvdata(&spi->dev, NULL);
>+              spi_set_drvdata(spi, NULL);
>       }
>       return 0;
> }
>--
>1.7.10.4
>
>


