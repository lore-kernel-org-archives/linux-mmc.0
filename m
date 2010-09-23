From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (mmc-next) 3/3] mmc: fix a warning when compile the sdhci d.d.
Date: Thu, 23 Sep 2010 11:14:26 +0200
Message-ID: <1285233266-5039-3-git-send-email-peppe.cavallaro@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:39267 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255Ab0IWJOp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 05:14:45 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57CE9128
	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 09:14:43 +0000 (GMT)
Received: from mail3.ctn.st.com (mail3.ctn.st.com [164.130.116.150])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2135F1EFE
	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 09:14:43 +0000 (GMT)
In-Reply-To: <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch fixes a warning when compile the sdhci:
  pwr may be used uninitialized in sdhci_set_power
Also removes some include files that live in sdhci.h
header file.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5928b0a..058dacd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -18,13 +18,8 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 
-#include <linux/leds.h>
-
-#include <linux/mmc/host.h>
-
 #include "sdhci.h"
 
 #define DRIVER_NAME "sdhci"
@@ -1050,11 +1045,9 @@ out:
 
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

