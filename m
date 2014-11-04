From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Possible regression with commit 52221610d
Date: Tue, 4 Nov 2014 12:05:04 +0900
Message-ID: <54584260.8030602@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12084 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKDDF2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 22:05:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Sachin Kamat <spk.linux@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

Hi guys,

On the NVIDIA shield (tegra114-roth) platform, I have noticed that MMC 
stopped working completely on recent kernels. MMC devices will not show 
up and the message "mmc1: Controller never released inhibit bit(s)." 
shows up repeatedly in the console.

After bisecting I tracked commit 
52221610dd84dc3e9196554f0292ca9e8ab3541d ("mmc: sdhci: Improve external 
VDD regulator support") as the one that introduced this issue, which 
seems somehow surprising to me since it has been around for a while and 
nobody else complained about this AFAICT.

The following diff solves the issue for me, however I don't know whether 
it also reverts the intended purpose of the initial patch:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ada1a3ea3a87..615701bb8ea3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1235,13 +1235,6 @@ static void sdhci_set_power(struct sdhci_host 
*host, unsigned char mode,
         struct mmc_host *mmc = host->mmc;
         u8 pwr = 0;

-       if (!IS_ERR(mmc->supply.vmmc)) {
-               spin_unlock_irq(&host->lock);
-               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-               spin_lock_irq(&host->lock);
-               return;
-       }
-
         if (mode != MMC_POWER_OFF) {
                 switch (1 << vdd) {
                 case MMC_VDD_165_195:
@@ -1300,6 +1293,12 @@ static void sdhci_set_power(struct sdhci_host 
*host, unsigned char mode,
                 if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
                         mdelay(10);
         }
+
+       if (!IS_ERR(mmc->supply.vmmc)) {
+               spin_unlock_irq(&host->lock);
+               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+               spin_lock_irq(&host->lock);
+       }
  }

Does this look like the right approach? If not, would you have any 
suggestion as to how to solve this problem?

Thanks,
Alex.
