Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E3198A05
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010698; cv=none; b=oslIQuI/R4VVwuDtkGliBJW6EbVAY19dDakrsL4v/AMkHaxhmYbdpmTIzAREwVfE3kR1nZz/6Hho6NFPQT0h4lNQzMDIUbneTiLhBz6D9HFcRf0O7/5CL2T+Ih2eyXLiLx9pNqUj1d+eLkiqlkHwhGl2t7927gROGfC5CF8hDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010698; c=relaxed/simple;
	bh=2kwH4Vt8a7i9oZ37i7o0f8oMETvYf0/kaB14dJeKXg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhWP7UfF6mL0uEUt836saFr9pN/6z5ykevUqn9wQR9DxO7yIjjx/dqk+zBybey6CwyfSssurOKdctsIf5wXBHKGOFJzwEDZxj7YKj+NNvYRjPyBEd0nbyep1mFQFOi8RZxnWEow5wFKoPPX+BmNZga+Qj40drIRydmnCvsJr3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FZJYO60+; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FZJYO60+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010697; x=1754546697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kwH4Vt8a7i9oZ37i7o0f8oMETvYf0/kaB14dJeKXg8=;
  b=FZJYO60+QvCcNYqkCF3pXrVUGCLTMUcgyi9r6xEgnPnpYe+m/LiFifFI
   ACEasvMMBrP3OXBaxtRxNBeOIamB/kMx/rwlfR8VILSOrrJbD0gEQeVti
   faL8OOykTVi1fUJXgmMEGg3IdtVgSU77gD/Vzgits/qg9oEKwrACrujeA
   Exc/SsDnOaFNbxgwJoex9Rgt0c9xhUXskoiSykjTBieHTut7d/T99lE7E
   jivWPcHVFog72HcCRfR/7jf9z5EfImOtGxOShbm3jbefNQosl/4AIxUtt
   i7R8CHCcYfjXUaBgY7/YQ2M1982aWk4GU4AaHjDpzydvmXxQC15Pr96O5
   Q==;
X-CSE-ConnectionGUID: 6xd+K1UdTbSHVRJVWf63PQ==
X-CSE-MsgGUID: 3+zVYMBhQFOQwc2DtdriFQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039310"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:04:56 +0800
IronPort-SDR: 66b3008e_bjEecZVCckZquI9CorkoMh4rw3MkNExaD6VgxhifVe/IusC
 OtZbS9t6gGGog3Pu71AvjxH6jDEh3CCNfLcluZQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:18 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:56 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 05/10] mmc: host: Always use manual-cmd23 in SDUC
Date: Wed,  7 Aug 2024 09:03:04 +0300
Message-Id: <20240807060309.2403023-6-avri.altman@wdc.com>
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

