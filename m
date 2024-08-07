Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A48198E86
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010715; cv=none; b=M1/nrQPnHHsVaush7gGc3W3DjuGmGsUKBU8rTLfAuWa9Y0aV3cKx7W5WGOjdHRDgRPjII99RbfZxJw6Mv3UF042liULlIwRHhRNZ4QepuyiKuN3tnrRWBiXVeEMelY0VcT/+tbN35iAl3XOPiDiXE5l6A+lKVJEqGOE4ezzrLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010715; c=relaxed/simple;
	bh=k4mDYAkeb/fiZjjyfKZZvjDoyB3+P9fEVHfV+YOvaOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOD7SgHOgkdkPzX0707F7ZfNlxoToJKunCHdxvn88oPdRP5UzvweZ2wGFGsr96ENqLEh1HletmQXxvz6PhJJPo2anjJxxXqH5nNB1BUXPg5wa0C8BlyzT0ZClW750HFsPw2um32/3Nc+XfwO8HH15giIW6/ZiLa2XsjmFdhA4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rRltALGE; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rRltALGE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010713; x=1754546713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4mDYAkeb/fiZjjyfKZZvjDoyB3+P9fEVHfV+YOvaOw=;
  b=rRltALGE8lqTIxOXpCLZJ5a1nLy17lvTcQOKd9pjihva2xVSOuEc/0Q+
   0w6KY5YwLifTyxmAnVEtKOHb3qs0IyUMulXSqFdD1D5HN6nmD0fo3UyKt
   nXdH8+ZJB07Z28qEkIlNlZRnHoXK3N/t6Tvyv+iQL6UBy6UoXmMUHjlSR
   dKD2Eu3seNYu8glt0iHDG1bP5JyY7MCGX7Ej3EDQDksSuJfHh9IYivs9a
   n3g8oV/jx8X1xdllriaHWo9UOo0CVicGIOMhRKdcoNKkHgtmr71JXYJrf
   sID81snkv0cOA0HRXZjmeoNLHcES4sUm/8h+7P+TC7M3Op6CRjWzlEbD1
   w==;
X-CSE-ConnectionGUID: zlx8++V2SvuQK86Emutq+g==
X-CSE-MsgGUID: H3CaxLQlQ0Obyup/+zlSLw==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039345"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:05:13 +0800
IronPort-SDR: 66b3009e_25zw/x2N+bQ5ijwE2aJt6bQhqD2AAjwYAFuAILmqdgPdK2D
 IjxiOT7ybIX7t6vygDEWMJ3JqnNUWzc/QPmhDBg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:35 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:05:12 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 10/10] mmc: core: Adjust ACMD22 to SDUC
Date: Wed,  7 Aug 2024 09:03:09 +0300
Message-Id: <20240807060309.2403023-11-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACMD22 is used to verify the previously write operation.  Normally, it
returns the number of written sectors as u32.  SDUC, however, returns it
as u64.  This is a superfluous requirement, as the previously write
operation could not be more than the block layer limits, just make room
for a u64 and ignore the 2nd dword.

Moreover, SD cards expect to be allowed the full 500msec busy period
post write operations.  This is true for standard capacity SD, and even
more so for high volume SD cards, specifically SDUC.  If CMD13 return an
error bit, the recovery flow is entered regardless of the busy period.
Thus, better enforce the busy period for SDUC, otherwise it might return
a bogus bytes written.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 55b9fc34fdd4..cb268af26982 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -948,13 +948,20 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
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
@@ -963,7 +970,16 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.blksz = 4;
+	/*
+	 * Normally, ACMD22 returns the number of written sectors as u32.
+	 * SDUC, however, returns it as u64.  This is a superfluous
+	 * requirement, as the previously write operation could not be more
+	 * than the block layer limits, just make room for a u64 and ignore
+	 * the 2nd dword.
+	 */
+	resp_sz = mmc_card_is_sduc(card->host) ? 8 : 4;
+
+	data.blksz = resp_sz;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
@@ -973,11 +989,11 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-	blocks = kmalloc(4, GFP_KERNEL);
+	blocks = kmalloc(resp_sz, GFP_KERNEL);
 	if (!blocks)
 		return -ENOMEM;
 
-	sg_init_one(&sg, blocks, 4);
+	sg_init_one(&sg, blocks, resp_sz);
 
 	mmc_wait_for_req(card->host, &mrq);
 
-- 
2.25.1

