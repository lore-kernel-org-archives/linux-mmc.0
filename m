Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B464EC5
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191658; cv=none; b=PpeUxZ8YQ9luZvl2Q7CVo2BGQB2OMe9EHerIMqAma4C2qtY8BDy+TPhh0LEBf1mBlrWVa+9hoQvlz0tYcaann9kjNDKYR+uOXW209bwC+Sem8iW/VY5JOL2byH6OcpcXlccpJdvig+J6zE+9IpdjySKhG8MVewWtLE5FrV1s/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191658; c=relaxed/simple;
	bh=oyL9jNJbWslPhLQcqAYJmtGJml7z8vl0lUFT8e9OcwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0xQ2hmUv73ZJD0KW9pXf6xWPExtpt+bkAeHy00cBVjQksb8hzgYb99FFv75dEBsE8VJSWR8Va3Z7UTPE0cLJ/pY64utD70UyMuTxhZkL6+eBVgP5NbQ50i2FzqCD1aCbA8NFysFM6598AS8TlxsAlEypUa2smZspYbOg4Out6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PiHnHs9c; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PiHnHs9c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191656; x=1759727656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyL9jNJbWslPhLQcqAYJmtGJml7z8vl0lUFT8e9OcwY=;
  b=PiHnHs9cgvUCPRi1tgvbfpdqfMokBqcDcCv31sHQ+xQk+mgIN+wwf/FE
   4yUZzF01COdBtWxJNLTlHgNM/cjMLcza4irSd/qA/6KfXyHCLB9gTa13a
   J/tXiioHjRkECvHSg81be7JJn84mdp44FpsErvBWsjZjMhZUR1vaX4nYK
   ecbt2hNWgADTPC890yM0NOOshlrP24I83nQ2d6Lrryiim4Kp6ap+EIJ8z
   lgkZ83qWgXdhSpidUiw3bxnLDBILA9BvpP9dkF7uXOCdsjZYaZHpg+1AR
   QtXhEwXlsQZqROn8Z+pBzh16fiJ1L1bKPzTdcJjFC0DGLN37iicdvUDXg
   Q==;
X-CSE-ConnectionGUID: EpmAw7E9RvKWIBxBqMz9xw==
X-CSE-MsgGUID: MNmOt7ZPTUCvBHtGiiXETg==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708012"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:10 +0800
IronPort-SDR: 67020fa4_qK1hplAHYUR85hPBzqup/W4kD6OQXryzpo1mfd5NfbzVAll
 RleSh4q8RYCLr7w0Vk45zShkKo1GaT7dRVprl2w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:45 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:08 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 04/10] mmc: core: Add open-ended Ext memory addressing
Date: Sun,  6 Oct 2024 08:11:42 +0300
Message-Id: <20241006051148.160278-5-avri.altman@wdc.com>
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

For open-ended read/write - just send CMD22 before issuing the command.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 5 +++++
 drivers/mmc/core/core.c  | 3 +++
 include/linux/mmc/core.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f4817ea3017b..c9325febc31a 100644
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
index f0ac2e469b32..a890a71288ef 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -96,6 +96,10 @@ struct mmc_command {
 	unsigned int		busy_timeout;	/* busy detect timeout in ms */
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
+
+	/* for SDUC */
+	bool has_ext_addr;
+	u8 ext_addr;
 };
 
 struct mmc_data {
-- 
2.25.1

