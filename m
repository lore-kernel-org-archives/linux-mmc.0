Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21D15445E
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191643; cv=none; b=CXp8tigy33ZHsBACaikC49RtRuNOb0wVvUskheWk/nWrM/CkA30ac8cbLtk4/W0NqpQ2L6X6hX+8i0DnYizBXXWR/tBz9i1pDSbtVlnT5+c0jWeWbroY+hdfbGXGUyEgEE9YhmBMGda62sbRwRIyaOm+aIYWrXIzBdknM4D2fDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191643; c=relaxed/simple;
	bh=m3VsLbpnZ3si/iS7YSyA+gIYLFcFzxIFalSZHOCsDXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRmZNLuygyDWgEiANRDI7knB5Ntyzs+VQ6gETCERSBZElcF7f1zOJzqud1Q5QXUnq9oUXdC5xyuTKyRRvvYrhMgOAKTpE9gz8w2siso44WsyRwyIb5oTTy02lkNs8oEEhXqS4tA+ZQ6TqpTXlK1UHw9BMVoKS6mfZiI35USo7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QrW1H65j; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QrW1H65j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191641; x=1759727641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3VsLbpnZ3si/iS7YSyA+gIYLFcFzxIFalSZHOCsDXc=;
  b=QrW1H65jIaRf0gACVwqKmE+vHrLcw035sTxwIDZyGHzdEcxju/EjKGkb
   P7nFWQCSwD3lxZFI4Cz2AgWojakzbRygUUkjR/lG2EnUOOOUtBbLVBxzv
   tmQn9+q37PHq2tJcG/sALM17KElDKBqywP1iHXuaHYblshz3nzELc6MEa
   L2z+82Tc/NF4Q3T1cLk2xSTaCFsyHiqOiPyBbzoCmk91/dXGWZqInOmKy
   bkztoF+rlZLzdfulM7c1mB2SjUDr8ZxVn2EMpPD1PifWF92FfDlKArnN9
   ABGmK4HK+x+h4yG7eeKT+z5Y/RseO85nYKNoi7xdOq7+ve1xtwlnCwe27
   w==;
X-CSE-ConnectionGUID: 9ib7TM44TrCingI1YdPeFg==
X-CSE-MsgGUID: 3LvUNyW/Q2Wk3qXf8b6JKA==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="29406953"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:13:59 +0800
IronPort-SDR: 67020f99_5C3c2rl453sjwsTkyEX4xdEFmZtwPMuSPr6vUHr2A7TwBsa
 /Anc8w3yo2eLz73hbldRB3Zat6dHv9nvXK82KJw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:34 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:13:57 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 02/10] mmc: sd: Add Extension memory addressing
Date: Sun,  6 Oct 2024 08:11:40 +0300
Message-Id: <20241006051148.160278-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241006051148.160278-1-avri.altman@wdc.com>
References: <20241006051148.160278-1-avri.altman@wdc.com>
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd_ops.c | 15 +++++++++++++++
 drivers/mmc/core/sd_ops.h |  1 +
 include/linux/mmc/sd.h    |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index f93c392040ae..50d1380e93b8 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sd.h>
 
 #include "core.h"
+#include "card.h"
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
@@ -188,6 +189,20 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
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

