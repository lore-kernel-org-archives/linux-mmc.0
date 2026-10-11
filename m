Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com [220.197.31.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E813D53C;
	Sun, 11 Oct 2026 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725144; cv=none; b=Llle7TME+tby83IvVg1ldJB1VX9Dhg15ap2BXfFTtYyjNG0uwH1Q4u0armVgc5s4c+WKiUhDfnohkmzS9eB8TFRTnp+liXDaiaR5ft7R4MCgdHwjhPkSRAfugLydXEH6PlAvKdO07TaVdVzz9iikMbuuxNURvsJkT9ofdkuPbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725144; c=relaxed/simple;
	bh=fiWoY3BEOtHssWq+r++jzfPZnv1egSTT94UTTXEZtsQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E2X+BztpajqYbKo7EWt945UxPS5JcdaHDN9vophZqfbmLmRVECe/Hkwg5WQGD6ZnNcVJpHY3LrekNVQC4rVZ5SiynoeQP6SgrQz2vi3DcEcoAoNJn2ICoJ/7hynU8B6ERQ2LPchDcQsK+mZlpsnSr1+jBaOJj8rTkBnVXW9RUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OFQEm717; arc=none smtp.client-ip=220.197.31.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OFQEm717"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 509d35e02;
	Sun, 11 Oct 2026 20:50:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH] mmc: core: fix wrong comments in mmc_ops.c
Date: Sun, 11 Oct 2026 20:49:44 +0800
Message-Id: <1791722984-123689-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa12b035e5a03a4kunmb540dde913413d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkpPGlYeQkhCSBlPTE
	1OGB9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OFQEm7171/Iwl5uI4uBP/OXZ8aACI+lmDl7a8YmfPWn4ylL/WngTD99eVnC5Wyjxmis6rqMG/YBBOkBxn4pqHp812oxlbfy/buc886YzJLjbwTGVtMvFfIHhTb8YNljjSJ6hIKtKMCvFrmVggnXgKihy0ixyfvBFs+9XtvBEWwI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=iTYBvoCP8g1dcH19a3fvwCH8cuAxkekioHWPayYF9uE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

When seeking to use mmc_send_bus_test for eMMC HS mode tuning
to workaround a vendor product, issues were found with these comments:

1. In mmc_send_adtc_data(), the comment refers to "CSR and CID",
   but the branch handles MMC_SEND_CSD/MMC_SEND_CID, so it should say
   "CSD and CID".

2. In mmc_send_bus_test(), the NOTE HACK comment about reading CSD or
   CID with the R2 response type was copied from mmc_send_adtc_data()
   and is irrelevant here: the bus test commands do not read CSD/CID and
   use the R1 response correctly. Drop it.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/mmc_ops.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d59ff82f..fda728d 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -319,7 +319,7 @@ int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
 
 	if (opcode == MMC_SEND_CSD || opcode == MMC_SEND_CID) {
 		/*
-		 * The spec states that CSR and CID accesses have a timeout
+		 * The spec states that CSD and CID accesses have a timeout
 		 * of 64 clock cycles.
 		 */
 		data.timeout_ns = 0;
@@ -815,11 +815,6 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 	cmd.opcode = opcode;
 	cmd.arg = 0;
 
-	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
-	 * rely on callers to never use this with "native" calls for reading
-	 * CSD or CID.  Native versions of those commands use the R2 type,
-	 * not R1 plus a data block.
-	 */
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = len;
-- 
2.7.4

