From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v6 2/2] mmc: sdhci: Add support to disable SDR104/SDR50/DDR50 based on capability register 0.
Date: Wed,  6 May 2015 19:12:11 +0530
Message-ID: <1430919731-9016-3-git-send-email-stripathi@apm.com>
References: <1430919731-9016-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:36948 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750737AbbEFNna (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 09:43:30 -0400
In-Reply-To: <1430919731-9016-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

The sdhci framework disables SDR104/SDR50/DDR50 based on only quirk.
This patch adds the support to disable SDR104/SDR50/DDR50 based on
reading the capability register 0.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..e024c64 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3199,7 +3199,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}

-	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
+	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V ||
+	    !(caps[0] & SDHCI_CAN_VDD_180))
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);

--
1.8.2.1

