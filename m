From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] mmc: sdhci: intel: Disable runtime pm when the sdio_irq is enabled.
Date: Wed, 15 Mar 2017 17:31:45 +0100
Message-ID: <20170315163145.15475-2-hdegoede@redhat.com>
References: <20170315163145.15475-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbdCOQcJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Mar 2017 12:32:09 -0400
In-Reply-To: <20170315163145.15475-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, Dong Aisheng <b29396@freescale.com>

SDIO cards may need clock to send the card interrupt to the host.

On a cherrytrail tablet with a RTL8723BS wifi chip, without this patch
pinging the tablet results in:

PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=78.6 ms
64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1760 ms
64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=753 ms
64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=3.88 ms
64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=795 ms
64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1841 ms
64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=810 ms
64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1860 ms
64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=812 ms
64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=48.6 ms

Where as with this patch I get:

PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=3.96 ms
64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1.97 ms
64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=17.2 ms
64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=2.46 ms
64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=2.83 ms
64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1.40 ms
64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=2.10 ms
64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1.40 ms
64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=2.04 ms
64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=1.40 ms

Cc: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch replacing "mmc: sdhci: sdio-intel: Set
 SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk"
---
 drivers/mmc/host/sdhci-acpi.c     | 1 +
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci.c          | 6 ++++++
 drivers/mmc/host/sdhci.h          | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 237f318..53b431a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -288,6 +288,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+		   SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
 		   MMC_CAP_WAIT_WHILE_BUSY,
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 982b3e3..a3b242e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -498,6 +498,7 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+			SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM |
 			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_sdio_probe_slot,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a7..59c5cad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1828,6 +1828,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
+	if ((host->quirks2 & SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM) && enable)
+		pm_runtime_get(host->mmc->parent);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (enable)
 		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
@@ -1836,6 +1839,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if ((host->quirks2 & SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM) && !enable)
+		pm_runtime_put(host->mmc->parent);
 }
 
 static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adf..b72c38d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -427,6 +427,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Must not runtime suspend when sdio_irq is enabled */
+#define SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM		(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.9.3

