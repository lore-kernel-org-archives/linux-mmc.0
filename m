Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512626F06B
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790957; cv=none; b=EW9+oHSu8WmO7SdVZrWp+x0/vGXUrhqPXcStU3WMRlUEzwkqznDF2ybfOXmjNHBJYuGtcNQE1CEYyMx5pSdSS/rIhDUpksknHqf6T2nHxmEAGxKh1In/BTKKzvsNS2b1bjcgvXmozuAehGktfWRcmb7xVM/oSSj8iRZV9vJ8KZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790957; c=relaxed/simple;
	bh=1JaQc5SS+ZS0y2N+fbsd3RSuH7ReLEBD3nAnCl1NFFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xakdr4iGTCicf4PG6btnk9icKlYlulcTRBrlrv+8VKvur0ipGfk6pX0n44mdJ6qs5T2nAZEyn0RZ9ObRNyVz9yXsSwT0b1crsbkoK4HQsKZikmOvDnb+TzMG09Pj7AGQPQtfD61N1LyJIHdRAmuhtN/SVACL43RHHSWeamq/BLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h4u0Hixx; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h4u0Hixx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790955; x=1757326955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JaQc5SS+ZS0y2N+fbsd3RSuH7ReLEBD3nAnCl1NFFA=;
  b=h4u0HixxuH2/KTxlIsBTVxBeqyleuHBagacykqztHPx1hFuBHSyy29Ce
   ZtziGp8FpScki8QJ59WC4B2VU3px+Tj44LruJuHorO3413OAdrYuyFuEA
   eMt3ti43bcjHbjoD8+NMnHgYZfupptZ6iwBC9PkuF1qo93lGhqV8zP5Gn
   fu5gayBNF3qFwAtXW7OTtTZQ8Y9+nF+sbPOsUeIM71rbMT2Xsdvp8m36S
   QBDPLjPUUQSFvGoQaAz//Rz65XZ9u09OPTeJWNrVkit+Oq1G+XvPZQeuc
   8+qjlDut+rIspU+0Bnrl50yq/TRvJzPYk2EDwjklmDnSNeq1W/BKyVBi3
   g==;
X-CSE-ConnectionGUID: mDasXLdJSEiJRAiWRtktIA==
X-CSE-MsgGUID: WGI05CZbRlG00X2pWeUyEA==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553885"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:35 +0800
IronPort-SDR: 66dd6e0f_IfaT6Xx2MYWmH0+gYRpc9hv4ZttYgh0xt8VtB35Gb9Erg3K
 /nyUGq2oFrgT19F0tUeHBS/HvNsgHrecsHzK4ow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:44 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:33 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 07/10] mmc: core: Adjust ACMD22 to SDUC
Date: Sun,  8 Sep 2024 13:20:15 +0300
Message-Id: <20240908102018.3711527-8-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908102018.3711527-1-avri.altman@wdc.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
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
index 308d7c1dd0b0..74b56198ce42 100644
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

