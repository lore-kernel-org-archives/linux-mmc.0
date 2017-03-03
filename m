From: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
Subject: [v2, 4/7] mmc: sdhci: add a quirk to restore delay in tuning
Date: Fri, 3 Mar 2017 16:18:46 +0800
Message-ID: <1488529129-23560-5-git-send-email-yangbo.lu@nxp.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488529129-23560-1-git-send-email-yangbo.lu-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>, Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

There was a mdelay between tuning cycles which is removed since
eMMC spec didn't require that. However it's observed that eSDHC
needed this delay for HS200 successful tuning. Maybe it's also
needed for some other controllers. This patch is to add a quirk
to fix it.

Fixes: 197160d52e85 ("mmc: sdhci: remove mdelay in eMMC tuning")
Signed-off-by: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
---
Changes for v2:
	- None
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a7..5d204d7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2094,7 +2094,8 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
 		}
 
 		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
+		if ((opcode == MMC_SEND_TUNING_BLOCK) ||
+		    (host->quirks2 & SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES))
 			mdelay(1);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adf..b89589c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -427,6 +427,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Delay is needed between tuning cycles */
+#define SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
