Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9ABA20
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154444; cv=none; b=cMWfb7LiaST9c0wz+VVGKNEfKCBMuAtvdzx5OH2/Ek0sbMPKlbMN9lp8z86MKoyphS73Q/ilUJQhcliDQs4eM+REswiMHiO9b0VL0owmcz+rsolbS0MwCqE6/Bxc6Lw80i1gG/zBAwCsRHoN6wcD/zFE5n65zbyw+OzmHLlEXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154444; c=relaxed/simple;
	bh=+w4oSb3yz6ee+7ajXZSShcLSd9D1+IKCm4KjM0VdI5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaDQtgTTleej81xVBANHf4phjMphwH5bLntZ/Gvx74dgrRnwPnUj7UooChY+/UfwoPtc8Ex2orx27kI7+kSfm4TWvseqhiGQjPqZOj2UMM35Rtc8YXuqKD6GyCyfWc73RNt1sIAVXgjkjvNHFWQGrxZPWk/DoFmiDtp7KDSeFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mwzNDlDK; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mwzNDlDK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154442; x=1753690442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+w4oSb3yz6ee+7ajXZSShcLSd9D1+IKCm4KjM0VdI5E=;
  b=mwzNDlDKmYMZaL0ABOxpd520C/96oVJ37fjo9+eleXwayizY5luc30x7
   XkZGU2FOAaYOBEyR0eBrKe6nsTdwih9tXrv6nXr58vF/VBOG8mYggk6gh
   kijWh0ZRu/Si4cXmrOK+sRSDt6KQ8o0TqJlSpWvYakrOzoCtLJdrmAeUM
   rQcLKbvaajd+Qf3yYTgRg43dd1x/HR/QpXlEA+9k9HWEakgvfiKhutmqZ
   MhQUrBq1lPeJuXnrVewWPTwBEOwgoHAxfpSqZUxI+2lTDm/LlfgTysb77
   H/N3ZDjNXgj5zDIyyukmsKuFz9ibeYAEnEb8pQ48hEshOBKX6zdAbrqrI
   Q==;
X-CSE-ConnectionGUID: 2ZSkAENCS9uCwkEEiRa1bQ==
X-CSE-MsgGUID: vrnXyI2uRBOhRAGu5qr3qg==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909135"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:14:02 +0800
IronPort-SDR: 66a5f130_mEtiD63Q9LBa4IWxIl5ImALQ+qivT2cDeeCOaqFgAqu72Qa
 ZxdevP2gF32LMpjgVUYRqisr5IutAFfjDn9/yIA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:20:17 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:14:00 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 10/10] mmc: core: Adjust ACMD22 to SDUC
Date: Sun, 28 Jul 2024 11:11:54 +0300
Message-Id: <20240728081154.1782120-11-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240728081154.1782120-1-avri.altman@wdc.com>
References: <20240728081154.1782120-1-avri.altman@wdc.com>
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
index db171f496117..59fdc6f964f1 100644
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

