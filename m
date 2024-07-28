Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C4BA20
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154440; cv=none; b=QQ+Er3ntfb/6D7nsfU4ENhkefDcQnfR+jcURmgHJIzSx15YOUqN333FhQ8BmPvpJRFyDWD9CktvMHXC1XWWNCEMZEwHCnNOhLDiDmvHbXSbDu4+jGBFFNfS+b7hY4QIjxzS3sjiTWQ6dRqMwfrQezn/RvimcT/EeMknWq4o22Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154440; c=relaxed/simple;
	bh=bYI8Wmcgv5vMy7rPbYOKjMoL9KGmWTDIgYatyUMjIRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCAYT9VVoehKtZFaVtOypct+M/ujnujvXLHkPLBqprfvWWsLVSHT7/wDzC94ptCrsLQhj9GCilUwcxhkjf2boePG1XubbwPWQjZuflSuZyfDfb8xUDL4LLB9i3MLGt6VU785DpXoAPTV3V7wc3n4gfKlNAW1hCK0qeyyJPvIh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kevmg83o; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kevmg83o"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154438; x=1753690438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYI8Wmcgv5vMy7rPbYOKjMoL9KGmWTDIgYatyUMjIRw=;
  b=kevmg83oTdwaaCp0fNRzmq4Y2RRbI79F38Noj+qOL9tklAE/ttENm/SE
   Us719xpxbyTZfq6RiJ9VbYlXIpPJqvANuSgrkfIfgYdmZVDnj179p4nC3
   04ftaxx5MG9j5jMO4pchq2NwqjLj4J5CdVH5YMRYw/Ilk9/QN+Gdf7KG9
   vwc2AfPZBJW8lbvuU0JVHaeivN8p2N1dwHhWuDQFxroCkT6s5WObwsGv5
   mIdsmQm/WfWlv5SSYywXNYgN1xqceBafdakxR8acvphmyQNkDOva3Zzm6
   9aOEHsxXVBy6/JQIZmOuXkCYPjNPmGazeWUhEOHsCLZ2tJ4j7U4Ht48Ih
   w==;
X-CSE-ConnectionGUID: iJXYVL4MSpSYSfQqI/c9Pw==
X-CSE-MsgGUID: iAx6fwDdQPirEoxoWCBO7g==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909131"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:58 +0800
IronPort-SDR: 66a5f12d_m4p5WKXY9UzqTX5IRBOHKoRyEsT4+CKc5FIQ2wHlhoS9xgZ
 qDyR3Vf33h1qscRwEPYm3WtAyBmM32mrV0zVz3w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:20:13 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:57 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 09/10] mmc: core: Add Ext memory addressing for erase
Date: Sun, 28 Jul 2024 11:11:53 +0300
Message-Id: <20240728081154.1782120-10-avri.altman@wdc.com>
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

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ea28a04e438..e0984b7c5f08 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1660,8 +1660,15 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_START;
-	cmd.arg = from;
+	cmd.arg = from & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host)) {
+		u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
+
+		mmc_send_ext_addr(card->host, ext_addr);
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1675,8 +1682,15 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_END;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_END;
-	cmd.arg = to;
+	cmd.arg = to & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host)) {
+		u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, to);
+
+		mmc_send_ext_addr(card->host, ext_addr);
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

