Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C326AC6
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620724; cv=none; b=s0Uf+SO7SLx2pulao6APlH1HByG73MxWVlrmDSnzxL0Quosw9LW/qTapRIoGJXpYJiy8eqo5ZeGaAk8FxVN7ZxtRWOWPWtUS6j9WSFf5Bk35D9qQZnRix3d58NTWET9wSEHkrmf9g0DwZx/nndeZfPHVTTiNioIllGXLDXARXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620724; c=relaxed/simple;
	bh=7XEihxW0L1AkZEU7mqoDETJl6uIMK+bfuS8qzxIkS38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUO9YsFwDNtJl0E0KfIBsDhxgG9O2P/7wfuUkKZh36wfgtN+Qu1eshUCvGiBT9mQvnZscOVp49sGaO3hVTabU9lKKBRmnVgl9Nnb5uWbs+vn/xL2JfEX0tMF5JKt28Jt+FUYEfeYd/bhb/vZpNH0KiqU2z5iUv+DU2KNuqThCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y1sFa+AX; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y1sFa+AX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620722; x=1755156722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XEihxW0L1AkZEU7mqoDETJl6uIMK+bfuS8qzxIkS38=;
  b=Y1sFa+AXyEvUNDiODMF0CjREUwwFakT8Q/e/9sjqcvsoKy3GHU6K+BQ/
   tjXBfWrJGrX/zfIoI2vh5e/b4nncsOSMimJnf9FrEPhfFYZrbz775yQ9A
   TWWUzxBfv0MD3+V98DWjlsRm5waDDMmS4vjWvbrkq640yOna+jr9b5rXQ
   fbhkWI2INZx/3ABIiOCB/BbxASN8gWUKXhO85YSYUamKZcBskj6nAFt1C
   JbDVSEFwHeUg/2Gcm9ZqeqhC4pRrTzMF3dd+oqMOayMB+Ko36momQbX1f
   UkkT95u3jOFP5zlABgUKlufR4EFuVJlDJzXWj4Gio6AAfjNCheB78uRM7
   Q==;
X-CSE-ConnectionGUID: O9KhZ6pLSmmqQ12JFKcl0Q==
X-CSE-MsgGUID: RDaTL6XTTeO4JR7KUnv0AA==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="23625177"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:32:01 +0800
IronPort-SDR: 66bc50c3_nIJV0PBrnY+r3I0GWfgyymmnZXLv4iNaII000nxEhvW2pp3
 k47IhTQQAq21Rc0iX4/JxfHzFWqC7OGycjoryfA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:37:55 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:32:00 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
Date: Wed, 14 Aug 2024 10:29:34 +0300
Message-Id: <20240814072934.2559911-11-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
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

Moreover, SD cards expect to be allowed the full 500msec busy period
post write operations.  This is true for standard capacity SD, and even
more so for high volume SD cards, specifically SDUC.  If CMD13 return an
error bit, the recovery flow is entered regardless of the busy period.
Thus, better enforce the busy period for SDUC, otherwise it might return
a bogus bytes written.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 43 ++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 30cb8b0d5742..cc5ec94a4be1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -48,6 +48,7 @@
 #include <linux/mmc/sd.h>
 
 #include <linux/uaccess.h>
+#include <asm/unaligned.h>
 
 #include "queue.h"
 #include "block.h"
@@ -948,13 +949,20 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
 
+	/*
+	 * SD cards, specifically high volume cards, expect to be allowed with the
+	 * full 500msec busy period post write. Otherwise, they may not indicate
+	 * correctly the number of bytes written.
+	 */
+	if (mmc_card_is_sduc(card->host))
+		mmc_delay(500);
+
 	err = mmc_app_cmd(card->host, card);
 	if (err)
 		return err;
@@ -963,7 +971,14 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.blksz = 4;
+	/*
+	 * Normally, ACMD22 returns the number of written sectors as u32.
+	 * SDUC, however, returns it as u64.  This is not a superfluous
+	 * requirement, because SDUC writes may exceed 2TB.
+	 */
+	resp_sz = mmc_card_is_sduc(card->host) ? 8 : 4;
+
+	data.blksz = resp_sz;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
@@ -973,15 +988,31 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
+	if (mmc_card_is_sduc(card->host)) {
+		u64 blocks_64 = get_unaligned_be64(blocks);
+		/*
+		 * For Linux mmc however, the previously write operation could
+		 * not be more than the block layer limits, thus just make room
+		 * for a u64 and cast the response back to u32.
+		 */
+
+		if (blocks_64 > UINT_MAX) {
+			/* avoid any test robot warnings */
+			result = UINT_MAX;
+		} else {
+			result = (u32)blocks_64;
+		}
+	} else {
+		result = ntohl(*blocks);
+	}
 	kfree(blocks);
 
 	if (cmd.error || data.error)
-- 
2.25.1

