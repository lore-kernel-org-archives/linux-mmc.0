Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2EEC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191661; cv=none; b=KDqKCqmNtOAo+l5KV0RNqyoAW7PSwHEoYg6cCOlC6vNNRwtDqH6byeoH6EqvC3h9DvTEUaUNV7kPfoXt+JjEm/LdLxZ5kyWcxWHHhxBQCw4joCPoskckswqDVGVOhaHRHtHMbCOmy6LpLn5meQMwUcY91CDd4l7qydGkNnnli1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191661; c=relaxed/simple;
	bh=3wprHQrSZqGP0YWgVuzGkwQk8ALqtO2KWYXfyoqZ6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6Mvz1b1okO+xtZOE1EhefL82IDAaTNcK8O6CX4A4UZD4exkFsZY2NSQBeY4Z5KwcJpLe1Vus57f+/HC2TrptDeAo0EsByni3T4Dz2wv6kTV66dI9pRfC0tR0ULk9RZLNVU8ipHyLln+fa79TftcllWaDi7K3T2SaaC89IZz408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iTEsOvBr; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iTEsOvBr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191660; x=1759727660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3wprHQrSZqGP0YWgVuzGkwQk8ALqtO2KWYXfyoqZ6CU=;
  b=iTEsOvBrFmyYbi+6SVfFTqEMQUF58WOwi9EvcLruL0OjVhHz6ro2lFDM
   oMeK3J5ETQMJDJLlBnIkq3GIGzB7QiZYn0KM5/GqeBN2OG4QUYWTA38ub
   ypjeQynEs2Tr5dz8zYSciDBeBaY7QLR2rpHiZrdFAh8qL/JQ/1rf5OjJP
   XuBIwJpQwh936djp2PON5aQb9vF9RSdIMSaeI3/6bOD7/q2O7ZZxxtbxz
   RqmcfZ5ok2dPNc+CLDYfx1G90CGH2iNNNDAAn0RpXl0qlRwveWavPYiVm
   UbebPcgEofYP0B6+Iy/xqTMgnfVSSbfSvXBJma6D16m0MK0EFa8EcTGGA
   w==;
X-CSE-ConnectionGUID: ijmmMQ9OQeivrPjdYf6OGQ==
X-CSE-MsgGUID: jiokcaJtQne9DEpqo91shg==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708020"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:19 +0800
IronPort-SDR: 67020fad_vzVu2lGSc7NW6J9sNweYVV8h9iD4CfSe43dH5k2OW3y0YDV
 h8U2QQ6gmhXn2UdDPn5eC36mQgajII9pa58XFww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:54 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:17 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 06/10] mmc: core: Add Ext memory addressing for erase
Date: Sun,  6 Oct 2024 08:11:44 +0300
Message-Id: <20241006051148.160278-7-avri.altman@wdc.com>
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

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06f63fbaadfb..01a7142eada3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1647,6 +1647,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = MMC_ERASE_GROUP_START;
 	cmd.arg = from;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = from >> 32;
+		cmd.has_ext_addr = true;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1662,6 +1668,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = MMC_ERASE_GROUP_END;
 	cmd.arg = to;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_ult_capacity(card)) {
+		cmd.ext_addr = to >> 32;
+		cmd.has_ext_addr = true;
+	}
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

