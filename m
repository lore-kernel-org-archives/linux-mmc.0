From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: Add regulator support for vccq (voltage regualor)
Date: Tue, 07 Aug 2012 22:43:09 -0400
Message-ID: <87txwexfwi.fsf@octavius.laptop.org>
References: <1343084183-6070-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42096 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab2HHCnO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 22:43:14 -0400
In-Reply-To: <1343084183-6070-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Mon, 23 Jul 2012 15:56:23
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi Philip,

On Mon, Jul 23 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> On some systems the host controller does not support vccq
> signaling.  This is supplied by a dedicated regulator (vqmmc).
>
> Add support for this regulator.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

I've folded in this trivial cleanup patch, let me know if there's anything
in there you disagree with:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac50d35..828ac6c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1607,11 +1607,10 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	if (host->vqmmc) {
-		ret = regulator_set_voltage(host->vqmmc,
-			3300000, 3300000);
+		ret = regulator_set_voltage(host->vqmmc, 3300000, 3300000);
 		if (ret) {
-			pr_info(DRIVER_NAME ": Switching to 3.3V "
-				"signalling voltage failed\n");
+			pr_warning("%s: Switching to 3.3V signalling voltage "
+				   " failed\n", mmc_hostname(host->mmc));
 			return -EIO;
 		}
 	}
@@ -1623,7 +1622,9 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 	if (!(ctrl & SDHCI_CTRL_VDD_180))
 		return 0;
 
-	pr_info(DRIVER_NAME ": Switching to 3.3V signalling voltage failed\n");
+	pr_warning("%s: 3.3V regulator output did not became stable\n",
+		   mmc_hostname(host->mmc));
+
 	return -EIO;
 }
 
@@ -1700,8 +1701,9 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 	if (host->vmmc)
 		regulator_enable(host->vmmc);
 
-	pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
-		"voltage failed, retrying with S18R set to 0\n");
+	pr_warning("%s: Switching to 1.8V signalling voltage failed, "
+		   "retrying with S18R set to 0\n", mmc_hostname(host->mmc));
+
 	return -EAGAIN;
 }
 
@@ -2834,15 +2836,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	/* if vqmmc regulator and no 1.8V signaling no UHS */
-
+	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
 	if (IS_ERR(host->vqmmc)) {
-		pr_info("%s: no vqmmc regulator found\n",
-			mmc_hostname(mmc));
+		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
 		host->vqmmc = NULL;
-	} else if (regulator_is_supported_voltage(host->vqmmc,
-			1800000, 1800000))
+	}
+	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
 		regulator_enable(host->vqmmc);
 	else
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
