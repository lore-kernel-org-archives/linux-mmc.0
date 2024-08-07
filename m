Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C561198E78
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010704; cv=none; b=XEPuQ40rPWh1o9nUrTAmMLXxfy+w3a08GDrPg/YeTTD7iEmwm+CZthKiwJmxadiMesX1FmB+S5WBhAMX2u1Iq69SRMnalm7szJJKZFwaWZvUfozIRSHSdoJf9ycwKTzvd6BJzmKtbkTsy2TLWAvwV8j25HVeZCj9Zie1YcmnyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010704; c=relaxed/simple;
	bh=BoKIbjjurzqYFYYKFBYg+GzXOxVAHzR514QYDJtnOfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGnSgejrAQXkX6KH57b7BaT2sbusBTR9INkoZ8mmrkdSZ1PUPOLRJpHs7XRFtWL3BHjY+z5U5/Ln9kqLujXa7UvBt84ol4aHN/lLuCiyWWk3rBD1hHyc21o52Yx+9GWSK2iwTqsLxe1J0je3wrAIgFTpS6hSUDfee3/DEPZKADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZeTLzhlp; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZeTLzhlp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010703; x=1754546703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BoKIbjjurzqYFYYKFBYg+GzXOxVAHzR514QYDJtnOfY=;
  b=ZeTLzhlpdgWZ0vfkWry9kllFziN6KFozHn3oEvB0ruM9Lez5uRnRfrY1
   ezLBgKMTPrurhJiEcnMkksc0EnJbns5vD2iueo1C01/ZNXlCMi68HlYpg
   HC+TUy822wBPN5rxzoCrGVgCbS13Bg64qTaQqmrqj4qBp9SmSy66/Lwf+
   Pn2JifCZ/uN5zsSPg3cYaIavmitoDF+iyQLm9JNvS1rmOEJ31JsBGrOrS
   mL82h7xPdIdxR2IaLa7dNa8a4Cyjdnh2VB+3bEml/0NhmgI1Q+zZx42dd
   Qadci1LgcgzQ8JQUc5KWeA4hfagTsZK65/ItHWNpmkLRC1WVnuFHCWgN0
   w==;
X-CSE-ConnectionGUID: q1RL4oZGQTCiFnC1s7fOYw==
X-CSE-MsgGUID: qAmVPpXVQ92tAtuU1t3CTA==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:05:03 +0800
IronPort-SDR: 66b30095_ptqlXW6Rjhm5rQWCuZb86/tUcAK32JoyQOWYkdpYKD1Rc01
 xp9WWUi0/oeHQfNNMhT8r+mffR34o2+PJVCAASA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:25 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:05:03 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 07/10] mmc: host: Add close-ended Ext memory addressing
Date: Wed,  7 Aug 2024 09:03:06 +0300
Message-Id: <20240807060309.2403023-8-avri.altman@wdc.com>
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

In a close-ended multi-block data transfer, CMD23 shall precede CMD22.
Handle that logic once the sbc is done.

Host drivers that handle their own sbc logic, e.g. bcm2835 etc. are out
of scope of this change.

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

