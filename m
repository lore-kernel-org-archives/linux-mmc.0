From: Philip Rakity <prakity@marvell.com>
Subject: RE:  mmc: sdio add regulator vsdio
Date: Thu, 21 Jul 2011 16:55:09 -0700
Message-ID: <546AA1AA-99EE-45E4-A322-6E34C7EBF63F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:36933 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751607Ab1GVAA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2011 20:00:58 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zgao6@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>


Hi Zhangfei,

See below.

Philip

>
>sdio client may be required power on/off dynamically.
>With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down
>
>CC: Ohad Ben-Cohen <ohad@wizery.com>
>Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>
>---
>drivers/mmc/host/sdhci.c  |   24 ++++++++++++++++++++++++
> include/linux/mmc/sdhci.h |    2 ++
> 2 files changed, 26 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>index 790f959..61fff10 100644
>--- a/drivers/mmc/host/sdhci.c
>+++ b/drivers/mmc/host/sdhci.c
>@@ -1295,6 +1295,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 
> 	sdhci_set_clock(host, ios->clock);
> 
>+	if (host->vsdio) {

Why does this code need to be specific to sdio ?  Should be generalized.

>+		if (ios->power_mode != host->power_mode_old) {
>+			if (ios->power_mode == MMC_POWER_OFF)
>+				regulator_disable(host->vsdio);
>+
>+			if (ios->power_mode == MMC_POWER_UP)
>+				regulator_enable(host->vsdio);
>+		}
>+
>+		host->power_mode_old = ios->power_mode;

move up inside if since if not change no need to set.

if the regulator is shared between different devices will this work ?

>+	}
>+
> 	if (ios->power_mode == MMC_POWER_OFF)
> 		sdhci_set_power(host, -1);
> 	else
>@@ -2751,6 +2763,13 @@ int sdhci_add_host(struct sdhci_host *host)
> 		regulator_enable(host->vmmc);
> 	}
> 
>+	host->vsdio = regulator_get(mmc_dev(mmc), "vsdio");

comment on name -- should have nothing to do with sdio.

>+	if (IS_ERR(host->vsdio))
>+		host->vsdio = NULL;
>+	else
>+		printk(KERN_INFO "%s: vsdio regulator found\n",
>+			mmc_hostname(mmc));
>+
> 	sdhci_init(host, 0);
> 
> #ifdef CONFIG_MMC_DEBUG
>@@ -2842,6 +2861,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> 		regulator_put(host->vmmc);
> 	}
> 
>+	if (host->vsdio) {
>+		regulator_disable(host->vsdio);
>+		regulator_put(host->vsdio);
>+	}
>+
> 	kfree(host->adma_desc);
> 	kfree(host->align_buffer);
> 
>diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>index 13c13f8..bea07c7 100644
>--- a/include/linux/mmc/sdhci.h
>+++ b/include/linux/mmc/sdhci.h
>@@ -94,6 +94,8 @@ struct sdhci_host {
> 	const struct sdhci_ops *ops;	/* Low level hw interface */
> 
> 	struct regulator *vmmc;	/* Power regulator */
>+	struct regulator *vsdio;	/* sdio Power regulator */
>+	unsigned char power_mode_old;	/* power supply mode */
> 
> 	/* Internal data */
> 	struct mmc_host *mmc;	/* MMC structure */
>