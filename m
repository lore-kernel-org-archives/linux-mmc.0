Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DBEDE
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571841; cv=none; b=O/k49sBUpYOmWrDWrlCohJhAtdCmUMxCpzVF3jK1EFnEe7rl6lrF3y/fwoaWgu1wbRW+vvuYoOqt/uYMdWVV+Z2HcL+Dv7NHiRgYjvzyEuLcq2O3ho3G20p6idD53/Tj0TDGzEnPZwLFrK4ERvkKyUDuJMas1kF3X3fytOpNBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571841; c=relaxed/simple;
	bh=eRGyXkRNf12FO5hnq5bGdZNbwuDfGdpNMqjWAsTwWJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpVgVDotJyCwU2RNOUr/03LKf2LNS5H9qxDPCumRmTRcQRQ03xJQM7Pyy3smipjQ1mcOXur0NpYuPNQPL3M2rgpys0bxkGJMmz7REfwW4IuL0SdILDIMXDHpesAKi78g+B6dR4ZPCEtGa6JY5bxpJ8lYg7Q/7HXpFbuwy/SDEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oWUZQsgo; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oWUZQsgo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571839; x=1756107839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRGyXkRNf12FO5hnq5bGdZNbwuDfGdpNMqjWAsTwWJU=;
  b=oWUZQsgoHZeFcb6GyB1UuI8eOmgFccyfJECG1lXJqnsDHYV1yX2/dsMp
   xgnEZ00DWNk5mcRs6Cm3WulpwfQbOcBarxHBKVAALOMv54OTP9fDAdEcJ
   Qsjvx/QzdAfruMuzs5P24wWWl8va/TaEe6jRZncIKL/DaTWvIXYN65/t6
   huOJSGLxCUG+hMpjhKR/toshOVYpWDoonH6y2tyQ/ZbVUElxY6aYNpvS0
   +IZcSoQs/DMEZiio17aHr+rumQnRPLWpBJLW2kExEYKfjbKmX+ePYtb/q
   8eu5qCnkDCy09eo9QocZ4jtf1Sdmq96yCBNZUpZtIZ4S2EOqMj6MSDwqe
   A==;
X-CSE-ConnectionGUID: 6pun1QaFTgWp5ZwdK/OhfQ==
X-CSE-MsgGUID: 5C6POaX4RCake3j+3U0bLA==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25888393"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:52 +0800
IronPort-SDR: 66cad2a8_0EjwyK4bnOuNR0QD/D/c7hGu5Uuey7Qk85K2m2l01lyZHe2
 94SlPg7SstmDfC0RClo3YrRn/xSqMSFV0SnWTbw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:43:53 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:51 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
Date: Sun, 25 Aug 2024 10:41:41 +0300
Message-Id: <20240825074141.3171549-10-avri.altman@wdc.com>
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
 drivers/mmc/core/block.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ace701273230..b73fdef1cb0d 100644
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
+	if (mmc_card_ult_capacity(card))
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
+	resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
+
+	data.blksz = resp_sz;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
@@ -973,15 +988,25 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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

