From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for all other voltages
Date: Wed,  2 Sep 2015 01:02:17 +0530
Message-ID: <1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Currently, the sdhci_do_start_signal_voltage_switch() function invokes
controller specific voltage switch configuration only for 1.8v usecase;
but it is required for others as well.

For example, in case of PXA1928 SDH controller, we need to set different
configuration for 3.3, 1.8 and 1.2 volt support (I/O domain power
control register).

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
Note:
Currently ->voltage_switch() callback is only supported
in f_sdh30 driver. And I am not sure on the dependency of execution
sequence for that device. I could have moved ->voltage_switch() call
at one common place (above/below), but was not quite sure about it.
So, replicated/duplicated the call for other voltages.

 drivers/mmc/host/sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3dd295f..b59b76d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1753,6 +1753,10 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
+		/* Some controller need to do more when switching */
+		if (host->ops->voltage_switch)
+			host->ops->voltage_switch(host, MMC_SIGNAL_VOLTAGE_330);
+
 		/* 3.3V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_VDD_180))
@@ -1803,6 +1807,10 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 				return -EIO;
 			}
 		}
+		/* Some controller need to do more when switching */
+		if (host->ops->voltage_switch)
+			host->ops->voltage_switch(host, MMC_SIGNAL_VOLTAGE_120);
+
 		return 0;
 	default:
 		/* No signal voltage switch required */
-- 
1.9.1
