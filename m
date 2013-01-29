From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 4/5] mmc: sdhci: fix the bug that emmc DDR mode can't work by default
Date: Tue, 29 Jan 2013 16:21:08 +0800
Message-ID: <1359447669-20089-5-git-send-email-kliu5@marvell.com>
References: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:43974 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab3A2IUs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 03:20:48 -0500
In-Reply-To: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kl>

According to SD host controller spec (Host Control 2 Register,
offset 0x3E<3:0>), 1.8v signaling (0x3E<3>) must be enabled for
UHS-I modes. Otherwise all UHS-I modes will _NOT_ take effect.
Emmc chip working with DDR mode need host select UHS-I DDR50 mode.
So 1.8v signaling must also be enabled for emmc DDR mode.

In sdhci.c, 1.8v signaling is only enabled when the function
sdhci_do_1_8v_signal_voltage_switch is called. But in current code,
emmc working with DDR mode won't call this function to change the
voltage to 1.8v. So 1.8v signal enabling is disabled by default
for emmc DDR. Therefore, emmc DDR50 will _NOT_ take effect in this case.
1.8v signal enabling can be added in specific driver callback function
set_uhs_signaling. In fact only sdhci-pxav3.c did this. But it should
be fixed in sdhci.c since the spec required this explicitly. Then the
callback function can be removed.
This patch enable the 1.8v signaling for mmc DDR50 mode in sdhci.c.

Below is more infomation from spec:
In JEDEC spec, emmc chip which support DDR mode may work under signal
1.8v or 3v. So current code just keep default signal voltage
and won't switch to 1.8v.

But in SD host spec, 1.8v signal must be enabled for all UHS-I modes
taking effect. current code missed this for emmc DDR50 mode.

Because DDR mode shall can work under both signal 1.8v and 3v according
to JEDEC spec,  So always switching to 1.8v in mmc core code is
unreasonable. It's the SD host controller's requirement that 1.8v
signal must be enabled for DDR50, which conflict with JEDEC spec.
So correct this in host driver.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1591912..d4bd1c3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1504,8 +1504,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
 			else if (ios->timing == MMC_TIMING_UHS_SDR104)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
-			else if (ios->timing == MMC_TIMING_UHS_DDR50)
+			else if (ios->timing == MMC_TIMING_UHS_DDR50) {
+				struct mmc_card	*card;
+
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+				card = container_of(&(host->mmc),
+					struct mmc_card, host);
+				if (mmc_card_mmc(card))
+					ctrl_2 |= SDHCI_CTRL_VDD_180;
+			}
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		}
 
-- 
1.7.9.5

