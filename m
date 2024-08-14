Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF826AC6
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620699; cv=none; b=qt2EvIJfGuzsmIKVgS2S21gWPH+fK6T2N2XbM8n+2xi76C3jUjsJQpgZTQ2PqWhnNkEqfyBScb/jcgjTLrWe2kqVQsmXBl6ObAI8BO6JPKFKvpNjyarLUQj5vkUL7gfq6/ebjrDnmWC0soK40+Jp3EByAgVcElMOsDC5H7pt1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620699; c=relaxed/simple;
	bh=1xXxO/Gm/rhGc4TzBWZqtNWlhoFeOjAhfoSRlZd+6a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pB937H7WhcuxAAFpIdnU51FxrBTV8Mu/LiEK/MrSkiUZVA+nBvZxBwO1GgS3lee+CGYdoSC5VTyQT7pm/71hoI6DcSG8u+nwT94kYaOe7QpYUwteMDgINQoXYmU1nUyCNpOrCHLaA7wQL8BHQnS5e3gLpBi7szLkqMtHj9NScHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R6HgHSmE; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R6HgHSmE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620697; x=1755156697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xXxO/Gm/rhGc4TzBWZqtNWlhoFeOjAhfoSRlZd+6a8=;
  b=R6HgHSmE7I5IehKEH7mtQIS68xkJR5Ivj+7nu1Y95i7U3VEZWQWnC86C
   d7Eler+/7YSlTI98bqGPCLP3qUGMmwURamCpOWD/mEq8tMAbgygEnkjKt
   +J1tDLiSLNbEQvSCBzQE4aCkirSL89m/qTMZX05TWkKSon3mtZqDhR8Qp
   YsLYXhouOo68YUiD9X0rrAgSHxqPBC7n/SFJ41YCNW8FwtITPah4hy8OH
   ZNY349EWvjwtjO3Ql+dbNNDUTO5Dqij64aMJYFi2V0pyFTr3vWzCSc7we
   wPv+b0r61fRfWYVtYHqoZoPbyIPajMLRR815cetcc9htOJW3zl+2LPst2
   Q==;
X-CSE-ConnectionGUID: xpWzhxqVQfWSBN5G3SALfg==
X-CSE-MsgGUID: atlqKR68TUqsZsal04bTjA==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957217"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:37 +0800
IronPort-SDR: 66bc4f56_Q7JYvg73dIpueyvEvxvkwJrat7TKQKAKFd4WZpI8ds6EEHi
 IdR++owhh454ZuHyHBV4vmMgVSIMD6CFI7EFt7w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:51 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:36 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 05/10] mmc: host: Always use manual-cmd23 in SDUC
Date: Wed, 14 Aug 2024 10:29:29 +0300
Message-Id: <20240814072934.2559911-6-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Multi-Block read/write, CMD23 must precede CMD22.  Therefore always
use manual cmd23 so that we'll be able to control the sequence of
commands.  Also, add an applicable mmc_command member for both
mmc_blk_request and mmc_request to accommodate the address extension
command.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/queue.h | 1 +
 drivers/mmc/host/sdhci.c | 4 ++--
 include/linux/mmc/core.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 1498840a4ea0..7e191d7f0461 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;
 struct mmc_blk_request {
 	struct mmc_request	mrq;
 	struct mmc_command	sbc;
+	struct mmc_command	ext;
 	struct mmc_command	cmd;
 	struct mmc_command	stop;
 	struct mmc_data		data;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b91c9e96635..f62b489c9e9c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1399,13 +1399,13 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
 				    struct mmc_request *mrq)
 {
-	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+	return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23) && !mrq->ext;
 }
 
 static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
 				      struct mmc_request *mrq)
 {
-	return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
+	return mrq->sbc && (mrq->ext || !(host->flags & SDHCI_AUTO_CMD23));
 }
 
 static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2c7928a50907..5560e70cb8d4 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -142,6 +142,7 @@ struct mmc_data {
 struct mmc_host;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
+	struct mmc_command	*ext;		/* SD_ADDR_EXT for SDUC */
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 	struct mmc_command	*stop;
-- 
2.25.1

