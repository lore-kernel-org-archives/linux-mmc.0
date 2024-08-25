Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAFEDE
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571820; cv=none; b=c6xxOJxNkdUkHO49gl3v4g5NZ7ylRwQ2ykhMy98egJgyGmZjuBzyWdSQwEib/qSHV38POF/FjTdqT9e57PcMFY/SO4iLQlCnXy9G+6PAuXlgVq5kdCkoC9b8QS/hbPZXQAvFqJ0++AlNsH4iYKokZ7a148ud/sbnw5UIKbJiQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571820; c=relaxed/simple;
	bh=p4mm+jRORols3uszoL5zcbC2+6C+0onRtRnaw9DzQHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sfxtrgnx4M6pdj7+F5wgNgTsmMt3C7SdXQq/MxetqMWWze/ChXyFx3KTqSPegBNeOjgG1uuWR902ZyKkJ2paUEtKfoORU5O2WEtlIr1fz2B0femlSF1pNOPK3DaeDPntD00zgiBY7ubKAgs2vG5A1DCds0IOz+RqmJdJtnMV/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qBAIVDpl; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qBAIVDpl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571820; x=1756107820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4mm+jRORols3uszoL5zcbC2+6C+0onRtRnaw9DzQHE=;
  b=qBAIVDplz4GRlZSoZEI6RiHVgX9Skxd9v6GIZgkvPN6mYf2H7lksGHsU
   R9c75VaEaE7Myd6XGxfPz8wdHBS/C+rqOmUUDufih81/7yijuCeeqDR3p
   WUda9or9MsZcHsUzB+e5oWHT3wlv1bkyET2bxLvEU5tGKO5lotd+KVvVE
   zEvXpwgbmjZIxgQU+3U1RdFbflZCKsAc6C1RbVtuErIgQyO2F7xneXBcV
   fczTBMoSvUxW2abAO0F8QO6I5l20XnIMJ8zSMyoKR50k6Jj85n2KKAz/A
   J4jC9EY0osmpS1zSTKb1tQldvEl1mQJta8dCWVgk6GGlsIqHlTWQFOURg
   g==;
X-CSE-ConnectionGUID: wCrv4p5CTvaup7hNP8Ey9A==
X-CSE-MsgGUID: FTanwsgnTnWc6fjJFMSbPg==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:39 +0800
IronPort-SDR: 66cad3ef_H8p3PXSmQNKM73xC5QqwGI+T6/UN3A6g1hoDkC0xU2DfjBf
 5XEeZj8/ATIn2qRcmzl31pkVkZtPh6YmKdgskww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:19 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:38 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
Date: Sun, 25 Aug 2024 10:41:38 +0300
Message-Id: <20240825074141.3171549-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f62b489c9e9c..70c967029fe3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1791,9 +1791,38 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
+static struct mmc_command *sdhci_get_sbc_ext(struct sdhci_host *host,
+					     struct mmc_command *cmd)
+{
+	bool is_sduc = mmc_card_ult_capacity(host->mmc->card);
+
+	if (is_sduc) {
+		/*  Finished CMD22, now send actual command */
+		if (cmd == cmd->mrq->ext)
+			return cmd->mrq->cmd;
+	}
+
+	/* Finished CMD23 */
+	if (cmd == cmd->mrq->sbc) {
+		if (is_sduc) {
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
 
@@ -1828,14 +1857,13 @@ static void sdhci_finish_command(struct sdhci_host *host)
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

