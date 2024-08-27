Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9501B3F35
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761546; cv=none; b=CF5oxrJojr3vVfaDSEeXBU4ZgtEqXgMlrsPepjFifFEs/cqIrqd7axMY9MBSfIoRiNmfJcGN8G64uQIL0+6+PM0GsDHiSWC4AobwTAzcRzdQaVMHSDkq8ai167xG2xfgdRx0Iic4wQN9Qpg0cL3jKqMOp5Bn8z3T4sAFfEjfY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761546; c=relaxed/simple;
	bh=1C3ZDjJvdQW6CN1CEo3gpeR5vxvDjSm3Bzqf/F0Fvc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SN5ARh3BiibMV70rfWgPufVB3SoDhwZ6YDe7tUH25JyOiTT+qTO4yDx0gALxJao0ouv1oNMAY7iw7WUF1RNp62+9E/5CAjNMRBm9JEWSNod3JI+ss1AOB/gIo8pzYrLJsWmpqs5VyXc+ndbCkFb9V1EuNaDN8PPoT0NwDG8AGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VWokzJyE; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VWokzJyE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761543; x=1756297543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1C3ZDjJvdQW6CN1CEo3gpeR5vxvDjSm3Bzqf/F0Fvc4=;
  b=VWokzJyEdO+DbyVZd9S4xAVwY5KYP8taY14mpyJO21ek0cb9r7p3ORU3
   cQKdGrbHsv7/i/p9MXURdIwhzAmxoZJ9h67KHVlVqtqLjLcLTYdr1f5hO
   T+spmfhm1972e5DSn4nNXYog6CsaE4Q4FHngOn9CxRDb8dZAiHY9sDCdg
   XIXLJJu8lfpheeZ+adTZOSzLdmNEaSMz0h/XEPyl0LRyWo5lZ9vReQgS5
   fdlPqQcifssPeWxsPwVGtpvEQGV9G/zMHJWMBXWFBJYRnZe8aOqOzdP8x
   w7Tb/U01BuWivp2ZkgrLB3anbYvazU7ksRj3OY4ZPhDJGpAZiUh1NMX/I
   A==;
X-CSE-ConnectionGUID: XwYHlW3aQnavbLjzCfw+lA==
X-CSE-MsgGUID: xeUlIJoRTDaxU1aZ2yscgQ==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25318690"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:25:42 +0800
IronPort-SDR: 66cdb7b3_52OnJ3i39LdnDtRYWdH1YaTqJg5aCHPjkaZt7gRnz6HtCIL
 ELBiAoqv6LHdLsQ801Wh/PAZDPuJZXicBpIuOeA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:25:40 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:41 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 2/9] mmc: sd: Add Extension memory addressing
Date: Tue, 27 Aug 2024 15:23:35 +0300
Message-Id: <20240827122342.3314173-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
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
index 8b9b34286ef3..33f6f33bc109 100644
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
 
+int mmc_send_ext_addr(struct mmc_host *host, sector_t addr)
+{
+	struct mmc_command cmd = {
+		.opcode = SD_ADDR_EXT,
+		.arg = (u32)(addr >> 32),
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
index 7667fc223b74..462efd43acfa 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+int mmc_send_ext_addr(struct mmc_host *host, sector_t addr);
 
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

