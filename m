Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD21DC052
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461697; cv=none; b=NjAblDTOEfWJWxZJ4KHZlk1m5RXWqdCJ1fgCTWB0/ZGepdPn5H6MFe08FU3tbfDmBLGntT3LxrhfH+saXymdRYcAMxxnAh5V5HEN9NBhqN1Nba3cczJgc0symSXM/SU41IXA2FwQj07oXvwRz2Kbe0ybk/4ycAtgvUYmF+7uv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461697; c=relaxed/simple;
	bh=Ub0lndVMY6lfNseWMFJzCdw2VkRyDkJDPb3uHcbJC3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khyjazrBou/qUz2L2oLcAiydbS094x4cxUf6pe+mLYFILvFVOCzsW+Qfu5fKEttxAwxIMmBVXh4Rr1qVFBU7v2x2WD9IncOgXf/R9g34exhLH2gyRJ7SGW8QAXW81UyaAOBuTQ/a6N+6HQYZOSD03sUSddh+1Kh/6v17xUAQvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jMd/7va4; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jMd/7va4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461695; x=1756997695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ub0lndVMY6lfNseWMFJzCdw2VkRyDkJDPb3uHcbJC3w=;
  b=jMd/7va4cHoyJ1pcJ3EBCR8CpHvXsOkYx+VIsibIJrHUoDT3vksM8OYD
   WjTJM8blB1ctQmMLl2MKBDQ7P5LaDHeKkLgJPPf1E5glJIOOxzbjSHUjG
   pWw50VJpG3an/XIrNriArpN7trvngEveVcYCpSuwlneY87pZ6wAaHharE
   o31ltF+9CgeyB/cgrHWAChn0DguMKEj+3F/Wb7zzV/hfhC70N2B1Yr2LS
   29wY1l5V38dOf2Gb9630GjDSMw+r5FgV1wBcPi3YKAOxQdA2UQuv7yQdm
   +bFIrVGYQeFjBuB+cfvQFeRuu945aUpkc6gv26eXBznViLURqWR14Iitc
   Q==;
X-CSE-ConnectionGUID: JwVCVdfxTGC2lp+NvHjd+w==
X-CSE-MsgGUID: 11v+kzacTveAmTbh2aEnNQ==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26291283"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:54:49 +0800
IronPort-SDR: 66d867e2_+gZVcdbrq10/Gxb8BwGD1db9F6fiPs4bin2tvLb07oAw8FN
 mLxPq6MEgM7xzu/UYzbhSHNZlqtmNDDnHsG7UnA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:00:02 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:54:48 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 2/9] mmc: sd: Add Extension memory addressing
Date: Wed,  4 Sep 2024 17:52:49 +0300
Message-Id: <20240904145256.3670679-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
bits are required to access the entire memory space of all sectors.
Those extra 6 bits are to be carried by CMD22 prior of sending
read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.

CMD22 will carry the higher order 6 bits, and must precedes any of the
above commands even if it targets sector < 2TB.

No error related to address or length is indicated in CMD22 but rather
in the read/write command itself.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd_ops.c | 16 ++++++++++++++++
 drivers/mmc/core/sd_ops.h |  1 +
 include/linux/mmc/sd.h    |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 8b9b34286ef3..4397e5e06dd8 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sd.h>
 
 #include "core.h"
+#include "card.h"
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
@@ -188,6 +189,21 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return 0;
 }
 
+int mmc_send_ext_addr(struct mmc_host *host, u32 addr)
+{
+	struct mmc_command cmd = {
+		.opcode = SD_ADDR_EXT,
+		.arg = addr,
+		.flags = MMC_RSP_R1 | MMC_CMD_AC,
+	};
+
+	if (!mmc_card_ult_capacity(host->card))
+		return 0;
+
+	return mmc_wait_for_cmd(host, &cmd, 0);
+}
+EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
+
 static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
 			      u32 *resp)
 {
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 7667fc223b74..fd3f10b9cf86 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+int mmc_send_ext_addr(struct mmc_host *host, u32 addr);
 
 #endif
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 865cc0ca8543..af5fc70e09a2 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -15,6 +15,9 @@
 #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
 #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
 
+/* Class 2 */
+#define SD_ADDR_EXT		 22   /* ac   [5:0]              R1  */
+
   /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
 
-- 
2.25.1

