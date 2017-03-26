From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] mmc: sdhci: Disable runtime pm when the sdio_irq is enabled
Date: Sun, 26 Mar 2017 13:14:45 +0200
Message-ID: <20170326111445.1316-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdCZLOt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 26 Mar 2017 07:14:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, Dong Aisheng <b29396@freescale.com>, Ian W MORRISON <ianwmorrison@gmail.com>

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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch replacing "mmc: sdhci: sdio-intel: Set
 SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk"
Changes in v3:
-Always get / put the runtime pm-ref instead of using a quirk, as (almost)
 all sdhci controllers need this
-Use pm_runtime_get_noresume / pm_runtime_put_noidle as the caller must
 already have claimed the mmc-host so we will already be runtime-resumed
 when called
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9c1a099..63bc33a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1830,6 +1830,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
+	if (enable)
+		pm_runtime_get_noresume(host->mmc->parent);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (enable)
 		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
@@ -1838,6 +1841,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!enable)
+		pm_runtime_put_noidle(host->mmc->parent);
 }
 
 static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-- 
2.9.3

