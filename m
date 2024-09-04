Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77431DC1B6
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461699; cv=none; b=Ngpi16TgDqxKsOsRWEDoyADEqh4k3QyVj/uC/B7GTmEF2p35LffQgOYtF+ZXJwjXKP+UaqBYI/T0Zbl2jW19YigVCpYFa4+KYgEO40U4m04VePSIkJq2IEVs080z7mpCtXZTPH8Z91cBw/AY/et+FlvtgGD7zYSOTxEzKR2lXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461699; c=relaxed/simple;
	bh=4VuUPzTesSxUAChHA57T853CzlVBKYFJS48go8EjY3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkWt2gup00uSsYcWSCH/LUSdlIXflV3glJV3mfN5rnK50ygqH5KmxKXkEiIE84eMETtRp7eeDlB5y5DN/RQy680FQEGz8iaZRxMVzDeTupEDp/21zI/27MU4q+yN5RYYQ0EhmU7PvsW0JMi4dG2Pzr9TTtW6+VNwMT+pquvaBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MpBNGQSX; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpBNGQSX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461697; x=1756997697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4VuUPzTesSxUAChHA57T853CzlVBKYFJS48go8EjY3w=;
  b=MpBNGQSX+OhAor4a/rXXmipt2OlupFsLbSREd5piiwXe6ttp1crRfEOm
   pusREscqOqlSPbUq2jCXPrT95OAb7Bp6q7S9L/Qnszl/ThlBOcif6Zttc
   FcMP5K8gFL46Hk2nrxvn0rO0x9Ql4OOl8/hiFz5rsxFMJIzL9z/2G6hL/
   om2EuE3hey2+XiEP9uhxTgIau3385+VjBwzf91OCDz2fmfvaWnik1nGj3
   xVtY9a1+m7TGYIuScncVuuWZ6NgE4lI4fZygeYNzj7stWQKHuy3hhHQYc
   SSKiHGiOyEob4r8eMSnmwTdORn9TZlTSOEOvOjSXc6m8JCur8SaTjnWB7
   w==;
X-CSE-ConnectionGUID: uBLBcy55THib7H9Dl1pMUA==
X-CSE-MsgGUID: aT+cXJoATA2LPWgoJTD8Lw==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26291288"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:54:56 +0800
IronPort-SDR: 66d867ea_1ACLABYzJ3KlkjJ70ULF5/+91XvwyVvzEMdzxnRZ6Wfc8C3
 /AsUvaPtuHe+1JbRvhmOtneaYXUh3qkbuIpY6ig==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:00:10 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:54:56 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Date: Wed,  4 Sep 2024 17:52:50 +0300
Message-Id: <20240904145256.3670679-4-avri.altman@wdc.com>
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

For open-ended read/write - just send CMD22 before issuing the command.
While at it, make sure that the rw command arg is properly casting the
lower 32 bits, as it can be larger now.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 6 +++++-
 drivers/mmc/core/core.c  | 3 +++
 include/linux/mmc/core.h | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index cc7318089cf2..54469261bc25 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -226,6 +226,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 static int mmc_spi_err_check(struct mmc_card *card);
 static int mmc_blk_busy_cb(void *cb_data, bool *busy);
+static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -1710,7 +1711,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	brq->mrq.cmd = &brq->cmd;
 
-	brq->cmd.arg = blk_rq_pos(req);
+	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
 	if (!mmc_card_blockaddr(card))
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
@@ -1758,6 +1759,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+	} else if (mmc_card_ult_capacity(card)) {
+		brq->cmd.ext_addr = (blk_rq_pos(req) >> 32) & 0x3F;
+		brq->cmd.has_ext_addr = 1;
 	}
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..a0b2999684b3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	if (mrq->cmd && mrq->cmd->has_ext_addr)
+		mmc_send_ext_addr(host, mrq->cmd->ext_addr);
+
 	init_completion(&mrq->cmd_completion);
 
 	mmc_retune_hold(host);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f0ac2e469b32..41c21c216584 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -76,6 +76,11 @@ struct mmc_command {
  */
 #define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_MASK)
 
+	/* for SDUC */
+	u8 has_ext_addr;
+	u8 ext_addr;
+	u16 reserved;
+
 	unsigned int		retries;	/* max number of retries */
 	int			error;		/* command error */
 
-- 
2.25.1

