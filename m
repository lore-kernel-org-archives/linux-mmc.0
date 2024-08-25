Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028B17C64
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571807; cv=none; b=dSjdQGgWZBpfJ/FdLLtdpbqaDRcHPkYCWMeAYJI2Af38u9hx8YVMoG7u/wf6uPbLPj0Gvu4KC/xjZ+enHg8EwuNx0j88w+gZaZQ6P3X1M6OJjBaRP67aSnpc1n0w35cKXLDoCflAD23/MbMBy4Et/nHyrj+L0seRS9XTg0unZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571807; c=relaxed/simple;
	bh=Zg5j+3+EJ3+UYUWuGhE5R/+Nn+j0oXQyYnXnwkRUz1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrCkiYgv4uTpl+U71szESqsscOlE80+aBFeBhjWKPlnTHv4PSsN6BbZqee9W/YqOAtDwrocwx5qTi8983qDW22eOkG54iHxpv9wlMloFdQyV4gDnlXjN4xaVmtQPDGI9jPcU71qkEcjTsPj4C6AbtCQA3xcv/o7JIDyyLuwc8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UWksceQK; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UWksceQK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571806; x=1756107806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zg5j+3+EJ3+UYUWuGhE5R/+Nn+j0oXQyYnXnwkRUz1A=;
  b=UWksceQKSODEf9Hi6DmVWTyu7yxwE31a/qWfeFCAkvM0LqOW9q/cayw5
   cDaWVXQfb0q1z1EyzCgK88DDOmCvVWrHA1fP58MLLuHyvBgcmIhkkijZN
   5esWgqTCsuilBI7YPe8Gq8xbMGsrKjUN/SWbd7wSYQW50ApIX4sqRJpXt
   zJksBSIqmlVWKDu4QWrRyPdxj0tBnG+wUHhkJpULYJ6QaXE/wNAH9+UJ9
   03E7JyNDw00p3gzY++Vck+1FQBim8jwCTbTYkPeT7L0yxadbImclrMbyz
   DaNQtiyu3ymXD99wY4bNVCILfGrtfieipf10OhtA/0DpLDdMVCg0FiuVq
   A==;
X-CSE-ConnectionGUID: mg53y5zOQU2ZMsfgIB9iwg==
X-CSE-MsgGUID: fW8Ww/pcS9en80WQ7iBN+Q==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100417"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:24 +0800
IronPort-SDR: 66cad3e0_zIH9SIl85lZJkTrVx1h8xD6LA+mxijWXZvyhd+GIdHzy7w9
 GhQD2NIvSEndBZ/H+P94n7LxhQ57istNk3IKbcA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:04 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:23 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 2/9] mmc: sd: Add Extension memory addressing
Date: Sun, 25 Aug 2024 10:41:34 +0300
Message-Id: <20240825074141.3171549-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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
index 8b9b34286ef3..780c5dd7266f 100644
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
+		.arg = (u32)((addr >> 32) & 0x3F),
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

