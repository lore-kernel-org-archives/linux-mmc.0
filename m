From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V6 09/15] mmc: core: Separate out the mmc_switch status check so it can be re-used
Date: Mon, 20 Apr 2015 15:09:50 +0300
Message-ID: <1429531796-21987-10-git-send-email-adrian.hunter@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27511 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbbDTMMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 08:12:50 -0400
In-Reply-To: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Make a separate function to do the mmc_switch status check
so it can be re-used. This is preparation for adding support
for HS400 re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++--------------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4cad5f0..0e9ae1c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -450,6 +450,21 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 	return err;
 }
 
+int mmc_switch_status_error(struct mmc_host *host, u32 status)
+{
+	if (mmc_host_is_spi(host)) {
+		if (status & R1_SPI_ILLEGAL_COMMAND)
+			return -EBADMSG;
+	} else {
+		if (status & 0xFDFFA000)
+			pr_warn("%s: unexpected status %#x after switch\n",
+				mmc_hostname(host), status);
+		if (status & R1_SWITCH_ERROR)
+			return -EBADMSG;
+	}
+	return 0;
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
@@ -558,20 +573,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		}
 	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
 
-	if (mmc_host_is_spi(host)) {
-		if (status & R1_SPI_ILLEGAL_COMMAND) {
-			err = -EBADMSG;
-			goto out;
-		}
-	} else {
-		if (status & 0xFDFFA000)
-			pr_warn("%s: unexpected status %#x after switch\n",
-				mmc_hostname(host), status);
-		if (status & R1_SWITCH_ERROR) {
-			err = -EBADMSG;
-			goto out;
-		}
-	}
+	err = mmc_switch_status_error(host, status);
 out:
 	mmc_retune_release(host);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 6f4b00e..f498f9a 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -27,6 +27,7 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_can_ext_csd(struct mmc_card *card);
+int mmc_switch_status_error(struct mmc_host *host, u32 status);
 
 #endif
 
-- 
1.9.1

