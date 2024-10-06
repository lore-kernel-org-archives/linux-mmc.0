Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E5EC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191669; cv=none; b=A6X3wlkProCorpXDVYr8+iqyVADykrojx7BnqzA5uny/1Wwk1fRc7HCyLh+93db0HF9GmmUjNHnbPFnP9yBbf45b285OF3G0CD12ab7za2jOo4iibxhs/RVgiLkdBE8NASPLNFD10rWZ3nXE7GbSCxRHqtzrFQbOlwdDWVl1ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191669; c=relaxed/simple;
	bh=doegz9SBlRtnv3e5ZHqxDZff1ZS5/Z6OOTfMNlOGprw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuviexLBpT2NaAUE6FoYmwLf057H5hT0kvtEGtpAk2Hhlay2gOe3LLl6JeFn2Rw7JN3YuMasf0+zSxor6sQWjxmr/y5KqhMO9sR4JmcEYZBuMUaEdopYEIRXMpt5J+RLWRGVvrCGvycUALFPwbb61OD9CARdW7fdy38CyZVdQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jcrbj+I1; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jcrbj+I1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191664; x=1759727664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=doegz9SBlRtnv3e5ZHqxDZff1ZS5/Z6OOTfMNlOGprw=;
  b=jcrbj+I1Bh+chNBCeoi1kkpDdkajkIRib68T5NM4FWjpxKqpG82zGGQ/
   FDxNnblR+GejdkZTnyhD+lOMb4SdOapQe34q/WhZMnnd3tn4L/1uOilJx
   63AFwsaWiMYzIiJG7W6edeG/LTVxAiANGzwAI344p0S38w6muv5ZF9B/P
   D7da2ByQBOW7tg+RO4gXzXdqNbVmvCl2gsp8mft9lW5kHCjVvraUPLw0T
   CiKlojvi2Y/xXzYVJVc0lmAhCLUjArMm8y5RIuGcGOR9RoO8GqO09XgMF
   1Rybr12fp/CrveGLognPtKtlAUXTzlxjDONgSW/xRajRj4Enk5hFuqu4o
   g==;
X-CSE-ConnectionGUID: qmaTq/h7TH2xn8zFiaXAHA==
X-CSE-MsgGUID: c3zewypNR9qkZGqHeCwJVQ==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708027"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:24 +0800
IronPort-SDR: 67020fb2_lmNOCPc5ZJniGZYyjWFLjv7l78KA+TqUSF0Tb8KfJajkyQP
 cJqLx8h/ZpLKDlDEk8yY8ZxywvUghdPlzlhCu/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:58 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:21 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 07/10] mmc: core: Adjust ACMD22 to SDUC
Date: Sun,  6 Oct 2024 08:11:45 +0300
Message-Id: <20241006051148.160278-8-avri.altman@wdc.com>
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

ACMD22 is used to verify the previously write operation.  Normally, it
returns the number of written sectors as u32.  SDUC, however, returns it
as u64.  This is not a superfluous requirement, because SDUC writes may
exceeds 2TB.  For Linux mmc however, the previously write operation
could not be more than the block layer limits, thus we make room for a
u64 and cast the returning value to u32.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 26a67d2033f0..b4d58fde3ee5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -50,6 +50,7 @@
 #include <linux/mmc/sd.h>
 
 #include <linux/uaccess.h>
+#include <asm/unaligned.h>
 
 #include "queue.h"
 #include "block.h"
@@ -993,11 +994,10 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	int err;
 	u32 result;
 	__be32 *blocks;
-
+	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
-
 	struct scatterlist sg;
 
 	err = mmc_app_cmd(card->host, card);
@@ -1008,7 +1008,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.blksz = 4;
+	data.blksz = resp_sz;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
@@ -1018,15 +1018,27 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-	blocks = kmalloc(4, GFP_KERNEL);
+	blocks = kmalloc(resp_sz, GFP_KERNEL);
 	if (!blocks)
 		return -ENOMEM;
 
-	sg_init_one(&sg, blocks, 4);
+	sg_init_one(&sg, blocks, resp_sz);
 
 	mmc_wait_for_req(card->host, &mrq);
 
-	result = ntohl(*blocks);
+	if (mmc_card_ult_capacity(card)) {
+		/*
+		 * Normally, ACMD22 returns the number of written sectors as
+		 * u32. SDUC, however, returns it as u64.  This is not a
+		 * superfluous requirement, because SDUC writes may exceed 2TB.
+		 * For Linux mmc however, the previously write operation could
+		 * not be more than the block layer limits, thus just make room
+		 * for a u64 and cast the response back to u32.
+		 */
+		result = clamp_val(get_unaligned_be64(blocks), 0, UINT_MAX);
+	} else {
+		result = ntohl(*blocks);
+	}
 	kfree(blocks);
 
 	if (cmd.error || data.error)
-- 
2.25.1

