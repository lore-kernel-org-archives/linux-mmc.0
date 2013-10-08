From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 2/2] mmc: mmc_spi: remove unnecessary spi_set_drvdata()
Date: Tue, 8 Oct 2013 05:42:22 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE610938A8@NWD2MBX7.ad.analog.com>
References: <000201cebf4a$63a313c0$2ae93b40$%han@samsung.com>
 <000301cebf4a$78d9d530$6a8d7f90$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:10318 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753921Ab3JHFnR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Oct 2013 01:43:17 -0400
In-Reply-To: <000301cebf4a$78d9d530$6a8d7f90$%han@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Jingoo Han [mailto:jg1.han@samsung.com]
>Sent: Wednesday, October 02, 2013 4:36 PM
>To: 'Chris Ball'
>Cc: linux-mmc@vger.kernel.org; Zhang, Sonic; 'Jingoo Han'
>Subject: [PATCH 2/2] mmc: mmc_spi: remove unnecessary spi_set_drvdata()
>
>The driver core clears the driver data to NULL after device_release or on probe
>failure. Thus, it is not needed to manually clear the device driver data to NULL.
>
>Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>---
> drivers/mmc/host/mmc_spi.c |    2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c index
>40770a5..4c5e279 100644
>--- a/drivers/mmc/host/mmc_spi.c
>+++ b/drivers/mmc/host/mmc_spi.c
>@@ -1472,7 +1472,6 @@ fail_glue_init:
> fail_nobuf1:
>       mmc_free_host(mmc);
>       mmc_spi_put_pdata(spi);
>-      spi_set_drvdata(spi, NULL);
>
> nomem:
>       kfree(ones);
>@@ -1507,7 +1506,6 @@ static int mmc_spi_remove(struct spi_device *spi)
>               spi->max_speed_hz = mmc->f_max;
>               mmc_free_host(mmc);
>               mmc_spi_put_pdata(spi);
>-              spi_set_drvdata(spi, NULL);
>       }
>       return 0;
> }
>--
>1.7.10.4
>
>


