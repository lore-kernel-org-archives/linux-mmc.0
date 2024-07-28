Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33FCA62
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154488; cv=none; b=oUByICGXITeKUCGBKVGQ+RRHDIiVhyokOAuUR9egcWsgsjE6jH68tSYbqjk7mCJF6TaLX5PKGrbsKNlG8P9AE+dPdaism7ed5COGzhFkcQfMf66kva1GryY1T96mSFE3RyRMV0eVc9Bsjeh6MJsREbbVUtg5c59+6jRT4QAPvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154488; c=relaxed/simple;
	bh=2kwH4Vt8a7i9oZ37i7o0f8oMETvYf0/kaB14dJeKXg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYshojgWL4o8knZJaH6gqLYT9qFC6iaYBp/pjlOcgYVSV2w/tkdkC2AbQaOupo2W/Unb5sTJw4TdNiPI2DEJJL+tUewGIJfHoZ30xrKiINsqWuVhQwJqqizkAIXQzO6DvE4qZBno29BMnPQPBhQl0XfSCJruOc35GnpbyzkReTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X/aj7QbG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X/aj7QbG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154486; x=1753690486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kwH4Vt8a7i9oZ37i7o0f8oMETvYf0/kaB14dJeKXg8=;
  b=X/aj7QbGLTZXQAVbvW7pd0Wua64Ory3KPqn41F/wK4BTvnSTVriW9/ut
   Ne/Q9tWXeGeefdSAiJSsrUQuViEp2XEYfIuDvw2g1tUZifcpos2Nkum7H
   0hbcecD9KbmXAK3PlUs9W+yzlP31A6FqWGGrZlSR/qR9EtOIkEeChAF/q
   eUtFqqE32QHPuIs0I6oYAEsmSoi8H46qSQOxksHK/bbZuIyR11DlTEnhi
   buL3SDCzpam311NfPSTjSmJiZiz66ee1gQtMLzpI757/62k8b5DYsp4TM
   fMQBODNo2PNS4GhyNrTY6yKvd5gQDf1odmSvuZiw8UpppHHh6DaIJ0z3t
   A==;
X-CSE-ConnectionGUID: R8uIL85lQQOD6Voauc4StQ==
X-CSE-MsgGUID: Hifiw68ISZmbkBLlziAsrw==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909119"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:39 +0800
IronPort-SDR: 66a5f11a_ms7IgA7rpN4atuw4Q2KW3nuVmeVXfzahlx/MqrLPF5gLi4f
 Hh1kJ1pnJD8s377/oSUKzzJhyTRprx2wd61Cqaw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:54 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:38 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 05/10] mmc: host: Always use manual-cmd23 in SDUC
Date: Sun, 28 Jul 2024 11:11:49 +0300
Message-Id: <20240728081154.1782120-6-avri.altman@wdc.com>
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

In Multi-Block read/write, CMD23 must precede CMD22.  Therefore always
use manual cmd23 so that we'll be able to control the sequence of
commands.  Also, add an applicable mmc_command member for both
mmc_blk_request and mmc_request to accommodate the address extension
command.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/queue.h | 1 +
 drivers/mmc/host/sdhci.c | 4 ++--
 include/linux/mmc/core.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 9ade3bcbb714..d903fd8a45b5 100644
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

