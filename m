From: Daniel Drake <dsd@laptop.org>
Subject: sdhci vccq regulator support drops UHS-I flags
Date: Tue, 30 Oct 2012 14:30:39 -0600
Message-ID: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55801 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934293Ab2J3Uak (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 16:30:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so420792pad.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 13:30:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: prakity@nvidia.com
Cc: linux-mmc@vger.kernel.org

Hi,

Please check this commit:


commit 6231f3de1332b2a8a90e0c598ab6acc8f1eff7c1
Author: Philip Rakity <prakity@marvell.com>
Date:   Mon Jul 23 15:56:23 2012 -0700

    mmc: sdhci: Add regulator support for vccq (voltage regualor)

Particularly this hunk:

+       /* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
+       host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
+       if (IS_ERR(host->vqmmc)) {
+               pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
+               host->vqmmc = NULL;
+       }
+       else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
+               regulator_enable(host->vqmmc);
+       else
+               caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+                      SDHCI_SUPPORT_DDR50);

One effect of this code is that if the system has no vqmmc regulator,
the UHS-I flags are always cleared on the final line, so the ultra
speed mode is always disabled.

Is this intentional or is there a check missing?

Thanks
Daniel
