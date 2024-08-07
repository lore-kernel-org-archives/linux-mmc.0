Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA8198E86
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010711; cv=none; b=og0zOYYjZZHlA1K8AkmZXhyxeOGORmrEVYah3Sp5zsyz5lVuXxMn2NDA1pB8Xfn7mmUSfIRDElOrmUDVfq/+YbQKjaKgGk5SAAn5LsAct96xU/21qi+8IGuEsTtRiYyaTYY5GB80PLYGb54ulgFMyIqa2WhmLx+ePefmkok1swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010711; c=relaxed/simple;
	bh=oS2WvIIaNV5PmJ0CQTKdBv1ZzMtV6p3ggJdzvkjwHyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6gkvukeoLznvDugz44e4ghXCuWm8CCO/Bj+IN5uh3Wav9JsdmTyMMWUQ6Ipb42qABkNZlDWAygxT8oY09Ofzmr6hc7l0YI9Jpz2OVm7uGR4GQkvXxeh47nPTVzwfamOp0KZtmegWHhujS5THmYLAdQ8Zo8QiT+cQDMN6TiAkD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jQIWrYkV; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jQIWrYkV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010710; x=1754546710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oS2WvIIaNV5PmJ0CQTKdBv1ZzMtV6p3ggJdzvkjwHyU=;
  b=jQIWrYkVLc+Wg2RpXeizRURR/ItDxG+16DnPtZHut7mWbJITDUwP2g2v
   UBlf/djsK+vidSEapMpHgahPs3PujNW4o0N3G/zz3zhqj2xwQxGOevnSI
   uYZFL6RfIwQGfTCRuEz+2NWtMQ3MK5EhRHgRUSPgER3tBB8EWuV6o/xDE
   LnEhDveuR1hSu/7Ka0+dQh4fvVzb9QclHcW2KA2GuXqVcR6xHLdrTBYmZ
   Rx3uxiCef/iOjIsXbBghL6u+5HtAoVgelfFpKJJxm6oIB6CoIiumWTgqT
   ETE6UpZRvUNVKBE2AOJ1NUvkgHQ9o+8lDLs2UmoxvgWC1avCXcPFoUNn7
   g==;
X-CSE-ConnectionGUID: 3nBwnIMYSQmbKPjGcKbBzg==
X-CSE-MsgGUID: 7tSxm0wORiKpYi2aA7LPwQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039336"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:05:10 +0800
IronPort-SDR: 66b3009b_uMiOXCy/D/GadthD9frVvBmMcGiMxvqZBgym8qlGW5rrk6z
 JQzPUAgWkX0wwz9KYFtDjMd7//GYfiqq1dtS7yw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:31 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:05:09 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 09/10] mmc: core: Add Ext memory addressing for erase
Date: Wed,  7 Aug 2024 09:03:08 +0300
Message-Id: <20240807060309.2403023-10-avri.altman@wdc.com>
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

CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
address and 38 bit erase stop address.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ea28a04e438..7f724f6a1332 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1660,8 +1660,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_START;
-	cmd.arg = from;
+	cmd.arg = from & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host))
+		mmc_send_ext_addr(card->host, from);
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group start error %d, "
@@ -1675,8 +1679,12 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 		cmd.opcode = SD_ERASE_WR_BLK_END;
 	else
 		cmd.opcode = MMC_ERASE_GROUP_END;
-	cmd.arg = to;
+	cmd.arg = to & 0xFFFFFFFF;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	if (mmc_card_is_sduc(card->host))
+		mmc_send_ext_addr(card->host, to);
+
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: group end error %d, status %#x\n",
-- 
2.25.1

