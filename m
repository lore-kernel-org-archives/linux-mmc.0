From: "Du, Alek" <alek.du@intel.com>
Subject: [PATCH V2] sdhci: fix the timeout check window for clock and reset
Date: Tue, 4 Dec 2018 09:01:20 +0800
Message-ID: <20181204090120.63b5f0a4@xdu1-mobl>
References: <20181130150028.732896d8@xdu1-mobl>
        <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
        <20181130221300.4ef2956c@xdu1-mobl>
        <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
        <20181201134251.26573207@xdu1-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181201134251.26573207@xdu1-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>From 87692fc090978bde8fe872f02d0023a57af6b492 Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Fri, 30 Nov 2018 14:02:28 +0800
Subject: [PATCH] sdhci: fix the timeout check window for clock and reset

We observed some fake timeouts on some devices, the log is like this:

case 1:
[159525.255629] mmc1: Internal clock never stabilised.
[159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
[159525.256277] mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[159525.256523] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[159525.256752] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000000
[159525.256979] mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
>From the clock control register dump, we are pretty sure the clock was
stablized.

case 2:
[  914.550127] mmc1: Reset 0x2 never completed.
[  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002

After checking the sdhci code, we found the timeout check actually has a
little window that the CPU can be scheduled out and when it comes back,
the original time set or check is not valid.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/mmc/host/sdhci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..af01f7d16eae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again, since there is a window between
+			   bit check and time check */
+			if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+				break;
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
+		} else {
+			udelay(10);
 		}
-		udelay(10);
 	}
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -1611,12 +1616,19 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again since there is a window between
+			   status check and time check */
+			if ((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+					& SDHCI_CLOCK_INT_STABLE)
+				break;
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		udelay(10);
+		else {
+			udelay(10);
+		}
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
2.17.1
