From: "Du, Alek" <alek.du@intel.com>
Subject: [PATCH V3] sdhci: fix the timeout check window for clock and reset
Date: Wed, 5 Dec 2018 11:14:50 +0800
Message-ID: <20181205111450.300e0478@xdu1-mobl>
References: <20181130150028.732896d8@xdu1-mobl>
        <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
        <20181130221300.4ef2956c@xdu1-mobl>
        <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
        <20181201134251.26573207@xdu1-mobl>
        <20181204090120.63b5f0a4@xdu1-mobl>
        <229dc468-1155-b81f-9fda-b71402387e3f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <229dc468-1155-b81f-9fda-b71402387e3f@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>From bcb38577961823b4f8f2cc0aec7dd450a81b6ddc Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Fri, 30 Nov 2018 14:02:28 +0800
Subject: [PATCH] sdhci: fix the timeout check window for clock and reset

We observed some premature timeouts on a virtualization platform, the log
is like this:

case 1:
[159525.255629] mmc1: Internal clock never stabilised.
[159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
...
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

Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")
Signed-off-by: Alek Du <alek.du@intel.com>
Cc: stable@vger.kernel.org      # v4.12+
---
 drivers/mmc/host/sdhci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..451b08a818a9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -216,8 +216,12 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	timeout = ktime_add_ms(ktime_get(), 100);
 
 	/* hw clears the bit when it's done */
-	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+			break;
+		if (timedout) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
@@ -1608,9 +1612,13 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 
 	/* Wait max 20 ms */
 	timeout = ktime_add_ms(ktime_get(), 20);
-	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-		& SDHCI_CLOCK_INT_STABLE)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
-- 
2.17.1
