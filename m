Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0A14F9F3
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790942; cv=none; b=V606R/t2bQrNTRt/WJfFAruuZHY9bKFzHiGHI+hqfthB0WPoT2ZsIavaOoTVkwCd+I9RjXXMnz6AVhpCoNOCtFMSYIdJYuGc1ltLWHYxJdGr31CbI+/sKgcpsOFt6FYe9pU9RxrPcsUR8bguEO7pyeUYKMH9K3PVCwQ+Qmg9n0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790942; c=relaxed/simple;
	bh=V0H1R/07QQ0AdlV4nx+kg5YIDmVJWtgRKA8iwpqbBIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loGGMSpC9LL1AWxoYiLsp2nhJWn/nlcczyHkTjtq3t3F37NaidtSDUxFsTA/Wc9s/my63H9XAHzJB0823w0QYkZn8aMMF6++u1eW9mPgJazGVDts0UfBoFeM6H8Z/VguyOX3IlUNEKeZ3y0/4GCLQ71GntcZXPelIGXXOJiXi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hsP/TXLa; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hsP/TXLa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790941; x=1757326941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0H1R/07QQ0AdlV4nx+kg5YIDmVJWtgRKA8iwpqbBIc=;
  b=hsP/TXLaNGDMo31ThPwdy3PcigFLGIgOhPZLrerzXdfdBWqcGm1tK+fN
   qFqWPlyE7FN9wgbaZTN31L9UoNHwqdvtTCyU8wNyg2J3gt7/SPvtj1/G6
   3FSyj8UmibiM7jQV1vRvgmAZI3eGbhjbbF1W9N170JwJBsxXAFIjaxEzT
   aMx/gdqrZAALG6j9ab/wkOO2YjM7C6TKiH4w+nVOXoGa9S3wbn/9QwPnw
   1g0Qzug08AjXk7CvTG8OeyRyC+PwDGzLiuNoNICKGoQLtVbx59GjhdCrp
   uXvesgVGrqrI9SGqz27oD2rnnnYtceRPwqxiMi4jCUbWnOD3AZ80SXNjd
   Q==;
X-CSE-ConnectionGUID: ON2Sf1EwQAGYDwde8+5vOg==
X-CSE-MsgGUID: uTNKOudKRgajxvyUcYXxAw==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553873"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:21 +0800
IronPort-SDR: 66dd6e01_AvhU7/i8qrr40r4khOEk8lLqAuSzldxgrbtjkjjycMA+d0+
 LzaDM00QcBTCyF/72sqjln2VsJgHTFOqgY0u51Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:30 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:19 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
Date: Sun,  8 Sep 2024 13:20:12 +0300
Message-Id: <20240908102018.3711527-5-avri.altman@wdc.com>
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

For open-ended read/write - just send CMD22 before issuing the command.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 5 +++++
 drivers/mmc/core/core.c  | 3 +++
 include/linux/mmc/core.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05a7745c2a68..ba2ed413be5c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1759,6 +1759,11 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
 	}
+
+	if (mmc_card_ult_capacity(card)) {
+		brq->cmd.ext_addr = blk_rq_pos(req) >> 32;
+		brq->cmd.has_ext_addr = true;
+	}
 }
 
 #define MMC_MAX_RETRIES		5
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
index f0ac2e469b32..c86df8443a88 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -96,6 +96,11 @@ struct mmc_command {
 	unsigned int		busy_timeout;	/* busy detect timeout in ms */
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
+
+	/* for SDUC */
+	bool has_ext_addr;
+	u8 ext_addr;
+	u16 reserved;
 };
 
 struct mmc_data {
-- 
2.25.1

