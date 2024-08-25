Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FDEDE
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571817; cv=none; b=baxcVljQrMSU30EEQCGoe/OoYfJs6OOmZ0/jETtuRdunkkfQDEORuiEunbJfLBFIB8Q9RbzSUGfB3ijY6CBYyn6RYjqnO+GAJ9Vju+vuWRSv2GacfjgyBHrujchhExnH1/VTtT8GtQV0IqcHYWaKwjhoXpcV9w79/uncQhoKxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571817; c=relaxed/simple;
	bh=XzWoprbPUJNm54nfwNUfNao74B+GBJ/I17Z5BydHUeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCZs81qp+VLZZprtCsiFCQxDuqIeXduY/U5IHtYy5Q0FH0gCDui+vEJTud1R7a9EBRjc8rvxYBFcPN4hDSideWUpCsJrNjp79dxmPzmp3JVMHZlhBWVjaAwif7rkaWaFyanK5uaaoBmOluYPddWbl7g5COW5H8Rtapu9WS3fjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UD0rsPxI; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UD0rsPxI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571816; x=1756107816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XzWoprbPUJNm54nfwNUfNao74B+GBJ/I17Z5BydHUeA=;
  b=UD0rsPxIytbp9ykjmwrV6/y32wEtAacpavokyiFA+ibjlup/ynbXAELs
   53NVQT6fVQnPrUBKOC7VqBbAizIoz+2pEJuBiL1KHtFtDOpWBLi/kFrFH
   8dFhS+mWapX181ML5kIdZv7DpgwbLH5yHjPbU2bxbnjb5XVbimuw81B3r
   +fy7DsG3kxEF9fqryVzRxb2XlQMOzkbMxohWmTQo4GsZmgv3kPWt/37BK
   GrKzRPglwtbILo38MUGuUQIAhN+aEgGAfEz1isD35syO9uoPyf/ldzxdR
   d5UqLr0QzNvQOxyFFdQX4BCHHXezAqGRVsDGw/RKCGzZ+0C/xzYyuW672
   w==;
X-CSE-ConnectionGUID: q8ty/t3gQR+bnp8tZJ+ZvQ==
X-CSE-MsgGUID: iPoNT7PuTWOYDCEys6ZWfA==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100432"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:36 +0800
IronPort-SDR: 66cad3eb_Pk/qfYgJu2TtmNO9kJXdlJ5fbUcG/aVUtsJQdL1bAo6t16E
 BfvTXb4n5E6VKqKjqxpa2sSbHXrHPZGlmAKaLsw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:15 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:34 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 5/9] mmc: host: Always use manual-cmd23 in SDUC
Date: Sun, 25 Aug 2024 10:41:37 +0300
Message-Id: <20240825074141.3171549-6-avri.altman@wdc.com>
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

In Multi-Block read/write, CMD23 must precede CMD22.  Therefore always
use manual cmd23 so that we'll be able to control the sequence of
commands.  Also, add an applicable mmc_command member for both
mmc_blk_request and mmc_request to accommodate the address extension
command.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.25.1

