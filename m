Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E51B4C28
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761582; cv=none; b=EK9qx2pZ5zOG1tnyi5b5sah0aMaNB/Zeqc+pqBDw7ytHXuezcUyAaDLzubVEsTEq1A9OT9QKvgUMmS3SQSNpeUu5n2IQYMo7VMmwq0lOTVn8/LB4huQR40meNRmeJU0cL+aZyxLCynS5rxrfwde0r9SwTn44cflSSqbYgVnSp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761582; c=relaxed/simple;
	bh=mALUPf3FPFFX6gxqtKNtXzYrbP2To5mgKG+kOazI+p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTb8AIqQ78bnNGR9Mw5Uo4QefbaSt7q70xvR2PTb/xgU9X6mUHJVxqxc4l7PCjrWSXawfrSdGB+JWh+jDQDP+0a29ONuQZEHfpLzgMGO/psNMezxCdfMzWD5Ayg1AnSZaZEPxnJsKbiAGR3/Mc+lsLG9YoVE/0ZjgvpvLfOhrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hJSBif5s; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hJSBif5s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761581; x=1756297581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mALUPf3FPFFX6gxqtKNtXzYrbP2To5mgKG+kOazI+p0=;
  b=hJSBif5sn/ty6Yh53Kfp8arifIR8/yYohMdRZ9aNR8wzs2qpWIkqHsx2
   lZfXTbYgzNSS3CxwCvTYdS8zkrRO+MGQerYW73DfG97Uj5Q+u3j18gbT/
   LR8qSARh/RLjUmtHlwPKyANbBSl1mlgGJjssReLMo1ObI3W/s2QwJ5jFL
   6UmdwWT5dB/3Venx+mu1P3Bw80Bd0ush31zDkzu+FvjdPPjNymD9MTfsC
   tK1aIHIkvsyX2dqKZpRXjWJJmRZ1HlkLvobV5H2lo56KnoTWj6+1dL+t7
   vZMlr23ZeBMiUZTMJr3BBBbEGCI3sLlPqktPohqliPoSREPUWOAYtsP/x
   A==;
X-CSE-ConnectionGUID: gTME89hnQzmxKGwXNRphoQ==
X-CSE-MsgGUID: hmzp+UOeRuKL4LXKFAZP0g==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25277630"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:26:14 +0800
IronPort-SDR: 66cdb7d3_BSAeNr9dXE8raT4POj5whNC4FLak08kDOp8S8HTpBPZi+ui
 07kt6ZLA+Lz3Ky+2avvHHTNIJTHqprKP9+uQMLg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:26:11 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:26:12 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 7/9] mmc: core: Adjust ACMD22 to SDUC
Date: Tue, 27 Aug 2024 15:23:40 +0300
Message-Id: <20240827122342.3314173-8-avri.altman@wdc.com>
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

ACMD22 is used to verify the previously write operation.  Normally, it
returns the number of written sectors as u32.  SDUC, however, returns it
as u64.  This is not a superfluous requirement, because SDUC writes may
exceeds 2TB.  For Linux mmc however, the previously write operation
could not be more than the block layer limits, thus we make room for a
u64 and cast the returning value to u32.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0484d7031c0c..894bd53c49b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -48,6 +48,7 @@
 #include <linux/mmc/sd.h>
 
 #include <linux/uaccess.h>
+#include <asm/unaligned.h>
 
 #include "queue.h"
 #include "block.h"
@@ -948,11 +949,10 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	int err;
 	u32 result;
 	__be32 *blocks;
-
+	u8 resp_sz;
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
-
 	struct scatterlist sg;
 
 	err = mmc_app_cmd(card->host, card);
@@ -963,7 +963,14 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.blksz = 4;
+	/*
+	 * Normally, ACMD22 returns the number of written sectors as u32.
+	 * SDUC, however, returns it as u64.  This is not a superfluous
+	 * requirement, because SDUC writes may exceed 2TB.
+	 */
+	resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
+
+	data.blksz = resp_sz;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
@@ -973,15 +980,25 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
+		u64 blocks_64 = get_unaligned_be64(blocks);
+		/*
+		 * For Linux mmc however, the previously write operation could
+		 * not be more than the block layer limits, thus just make room
+		 * for a u64 and cast the response back to u32.
+		 */
+		result = blocks_64 > UINT_MAX ? UINT_MAX : (u32)blocks_64;
+	} else {
+		result = ntohl(*blocks);
+	}
 	kfree(blocks);
 
 	if (cmd.error || data.error)
-- 
2.25.1

