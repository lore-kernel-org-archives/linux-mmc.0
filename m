Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D561DC195
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461722; cv=none; b=amZUz05IaR9bBiapQjzBuf531o6NoFkAAIXrjOIbweISbMHUkDwktr/ThmjGf7If30NrmigpgiLseAB+soyEON5eLVE0DdZ3OTPOhyF4+LStSYcRoZySfYhFC8uTGAO4pC9HLiWymQGq1TP1qDoTI12Se+yjP3jkPbGRITgJLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461722; c=relaxed/simple;
	bh=J7BRimgDTB3gQ7GzelloksKWPPZjlzVNXO/zTu+7qRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrFovzThTda6AB9RDdZRB/m2GpFCW2abrZqPUdF+7TRyYECRMu8lD9++hzBQRBouunWufEfNuiqzt+XEuf+OVwAaaRryke8ltK+vscZNfOL8bN7N5S/GD5aP8sE0PGVg19JME6t8mtKh/tBzRs/9/oVSu3EEmM0ARIW3/yeQUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eFbku2XO; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eFbku2XO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461720; x=1756997720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7BRimgDTB3gQ7GzelloksKWPPZjlzVNXO/zTu+7qRg=;
  b=eFbku2XOL0rcBujjMp09686Y0lZC/riqONqv4f1vCsll4nZbODy87h0o
   fiMwKcl4J2sgiQSkjKqL0QU1JDPWmtbvjnt5LzcnWB5Ud2CQx3UJvJ6eZ
   NTOH1Uli51JCeQihjiH7lp7y1O5xmL0Cf9hqdGbe3IeQXX4lj4OpNCIgL
   BZQeLng68pWGYwkdIEriZ44dGV3nO1JuXl+hwoksDpA156TZHlqbmeZiK
   azs/uGPJoWDFhXnKScFioDaegVlT7dfcUJvW3vGAN7yfpyB+NazAHHgLP
   nSgVRzzoi8k1EP8iNROY+SzSHmKSbrzWlb0dq+3cFyAdoca9TqKli2NA9
   w==;
X-CSE-ConnectionGUID: 30++wD6eT0qMiJ3GuIQk+w==
X-CSE-MsgGUID: ZkEfpjS3So6xDI0kwwnUgg==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26723706"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:17 +0800
IronPort-SDR: 66d866b7_brdmg1Ep9xH1pTW9HHYbhE/w/lcRHjn3hDN/GD5qqqRLbew
 EDW3ZqqX9+YrifgIOnJCVw6WxCqixtc50wFf8qQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 06:55:03 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:15 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 7/9] mmc: core: Adjust ACMD22 to SDUC
Date: Wed,  4 Sep 2024 17:52:54 +0300
Message-Id: <20240904145256.3670679-8-avri.altman@wdc.com>
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
index 50d37c4f5a50..f36611512a1d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -50,6 +50,7 @@
 #include <linux/mmc/sd.h>
 
 #include <linux/uaccess.h>
+#include <asm/unaligned.h>
 
 #include "queue.h"
 #include "block.h"
@@ -994,11 +995,10 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
@@ -1009,7 +1009,14 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
@@ -1019,15 +1026,25 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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

