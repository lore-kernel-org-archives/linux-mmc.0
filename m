Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2A26AC6
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620707; cv=none; b=rwAdiLvZL910sXSBkR+oxbBTolj0YphFy9g9wx8Q6akkxb9WkMtFmjKfKvlLRIV5hsIqStz/FqY5MkN0Vor5JBWYQ4+ZeR3oiJMYLOkq7gRdyLXTwRA1br96WpSkJT7ktZexdVpmQ3hr3KU1F3Z6uPVloaqLgOlrkD1531aeaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620707; c=relaxed/simple;
	bh=d4lvohduuTMH/7EOfcbNDz75oylRlCQeHu/iGIKubz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMBlSl6N3/eqw0qhXV51QcQWa0k+DGyl+b1UWVs0IOxvxbVeq1FJefRoYEG1XaKt4t41R/rOX9eaaAnc6khVfF7Fm0V6MJkhCxX9cHCZeeN4X7+md4tr4cBbiR66nyMzZ96Q2gHGK52/8r3HvTXBMoqyvtxdQM7oLG/yGwNqxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RUxvP51I; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUxvP51I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620705; x=1755156705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4lvohduuTMH/7EOfcbNDz75oylRlCQeHu/iGIKubz0=;
  b=RUxvP51Id1jXrAneWIXmMcvlZwH3T/s2hKK0bbFT6cY1ZEZSYUQGjxW6
   kft5IQ9RjtV+/Z/pRlzy/wDK9Zo0nF0AE0j4rRt2wjRYzKZ+2CsdDTe5X
   e3BpbsPJrRYL9K2mzzD61sdraNfzbY+iG2/9lQOorYXsV1b5gS4jle69V
   CBCmUgAa5u8S7LZzs/PiDxqcHyTybRvD5kEXHUNakvv86vEQ4+tpk+wDg
   7asCjoNtzMCLHMJvoDsOjD5aiLhHhxekI6qlFn8/kRhX5iBTxoHqyBUgJ
   Sn+vEVwV0gS/Zh9wTAbiQoqTwsZPU0NUsudULGrGjiyzmze3r10Ley44c
   A==;
X-CSE-ConnectionGUID: 9M74X8GSSSiEoL2mp31cnQ==
X-CSE-MsgGUID: 3Y8AMvAtS16I15egP38z4Q==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957229"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:45 +0800
IronPort-SDR: 66bc4f5e_R5Ogwd2lxhqPZqERVfjK0K+xy6BceloGEwPUaGeoY9JJGwQ
 LIjBB+HYUVxQY5IG4z9GmhlIkff7eLBirR0+MLQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:59 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:44 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 07/10] mmc: host: Add close-ended Ext memory addressing
Date: Wed, 14 Aug 2024 10:29:31 +0300
Message-Id: <20240814072934.2559911-8-avri.altman@wdc.com>
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

In a close-ended multi-block data transfer, CMD23 shall precede CMD22.
Handle that logic once the sbc is done.

Host drivers that handle their own sbc logic, e.g. bcm2835 etc. are out
of scope of this change.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/host/sdhci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f62b489c9e9c..75a91d0ed16a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1791,9 +1791,36 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
+static struct mmc_command *sdhci_get_sbc_ext(struct sdhci_host *host,
+					     struct mmc_command *cmd)
+{
+	if (mmc_card_is_sduc(host->mmc)) {
+		/*  Finished CMD22, now send actual command */
+		if (cmd == cmd->mrq->ext)
+			return cmd->mrq->cmd;
+	}
+
+	/* Finished CMD23 */
+	if (cmd == cmd->mrq->sbc) {
+		if (mmc_card_is_sduc(host->mmc)) {
+			/* send CMD22 after CMD23 */
+			if (WARN_ON(!cmd->mrq->ext))
+				return NULL;
+			else
+				return cmd->mrq->ext;
+		} else {
+			/* Finished CMD23, now send actual command */
+			return cmd->mrq->cmd;
+		}
+	}
+
+	return NULL;
+}
+
 static void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
+	struct mmc_command *sbc_ext = NULL;
 
 	host->cmd = NULL;
 
@@ -1828,14 +1855,13 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
-	/* Finished CMD23, now send actual command. */
-	if (cmd == cmd->mrq->sbc) {
-		if (!sdhci_send_command(host, cmd->mrq->cmd)) {
+	sbc_ext = sdhci_get_sbc_ext(host, cmd);
+	if (sbc_ext) {
+		if (!sdhci_send_command(host, sbc_ext)) {
 			WARN_ON(host->deferred_cmd);
 			host->deferred_cmd = cmd->mrq->cmd;
 		}
 	} else {
-
 		/* Processed actual command. */
 		if (host->data && host->data_early)
 			sdhci_finish_data(host);
-- 
2.25.1

