Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D8BA20
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154434; cv=none; b=dPQBAxa1DkF4IqqTJUNucuCHFJC928j2B1wqZtc+LVQvid1zbB0SfkcDxt4f/T51r5zNamCjEl8C9ey6CEbhNP8EufRT4qwp1E48nxn1qCj0NCJuvIpcYYGwexI2PBwaN2FYU8VOMJ3wMZWDG8RI57mK6eYu+jeJVAcmr0Ysclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154434; c=relaxed/simple;
	bh=BoKIbjjurzqYFYYKFBYg+GzXOxVAHzR514QYDJtnOfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oj5Dn+wIO9eso4OeC+gA3aSU0C1yAmnfOkiihIcODpK2++gjv4pWgK07/amVfvqvLxE7u3rDB2+vsWVJVuo7SqDxLBLo8hIANokD0QX7tAw60+EJ6lwZk812ILQPFCb5kFGP6wRmmOvg3YIaGlHGMllFvZ41nZPTqH/Z4F36NhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nUSI2TTD; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nUSI2TTD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154432; x=1753690432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BoKIbjjurzqYFYYKFBYg+GzXOxVAHzR514QYDJtnOfY=;
  b=nUSI2TTDeETKfiGtIXlHzsgZcCuQyF6IMkNZJMiv1GzrXnBvKsrFN+c/
   hxezsee7k4Znw9JpoaRBkqR0p5ztTBmutqGLXh5TunVwD93O+dkyv1tpn
   LXrVgAVvDq/355GXXBSn7wABzNTUy6i7f1GUtX7mKd6+9jyglfR9DWGgX
   Hq4HyV6mC05G5oqDjYbuWcfOJUeS15k6PyLvufzO9E9SmWZFbUuta0piP
   C482B1M2hn2FwvKq61mLURTeV1kI8Lt6DHZXweZJQvEOu1ACDL9SF2z4E
   BYMnh7AkDYZRbO5dL9Q4DWJ6Y80SgY726oU4s0Jl8SMeFzQYiBen3OO9n
   A==;
X-CSE-ConnectionGUID: gelN8qUTTO+eKnpK+jcrDQ==
X-CSE-MsgGUID: Z1EUmgtqQTGfPmSIuo/T3w==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909126"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:51 +0800
IronPort-SDR: 66a5f125_UnVa6ZV0c42B3xhNdwztVQ9e2HFtrBIcpvcLn2wgmx/nsM5
 sE4sJQP6ZEF5i9iI9Ln4OBQ+W5M2pv74GoZlD+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:20:06 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:50 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 07/10] mmc: host: Add close-ended Ext memory addressing
Date: Sun, 28 Jul 2024 11:11:51 +0300
Message-Id: <20240728081154.1782120-8-avri.altman@wdc.com>
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

