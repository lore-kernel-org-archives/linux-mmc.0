From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (mmc-next) 2/3] mmc: fix a warning when compile the sdhci d.d. (V2)
Date: Tue, 28 Sep 2010 10:41:28 +0200
Message-ID: <1285663289-20283-2-git-send-email-peppe.cavallaro@st.com>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:38760 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758878Ab0I1Ilu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 04:41:50 -0400
In-Reply-To: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: w.sang@pengutronix.de, Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch fixes a warning when compile the sdhci:
  pwr may be used uninitialized in sdhci_set_power

Tested with the following compiler versions: 4.2.4 and 4.4.4

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96c7f60..d3f924b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1050,11 +1050,9 @@ out:
 
 static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
-	u8 pwr;
+	u8 pwr = 0;
 
-	if (power == (unsigned short)-1)
-		pwr = 0;
-	else {
+	if (power != (unsigned short)-1) {
 		switch (1 << power) {
 		case MMC_VDD_165_195:
 			pwr = SDHCI_POWER_180;
-- 
1.5.5.6

