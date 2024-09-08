Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06A14F9F3
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790940; cv=none; b=Y1alIiWlyIzEGYxQakgdWHWdxpzWmucgX8qGKiXSTeR1NBdx0j2Z+6tOoqns48SOA2k6kjSOOY1hcVcwJnEWNN6WQ6CcCGJqytmhmQtTxS5gLyC2HvZ0IIescbCXsmeo6esoybqeY6rj+n0Tq0H9KPr1PrD+JBTxrJX4g36NJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790940; c=relaxed/simple;
	bh=ut7YKbqGYyCbUNJ0wX6R8NmljR+0Pmh6b14hcLHruu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vD1HZB2X/uJxq/sdlaKaeqKZ1QoVXOFqhJ5//bwe7hjZokA5HPKRF0k7Uxoa6ArU2zxhNVctN9n58E1U6xQ6wn81cGb3pgYvSyfITI3omdRgjAWs120eT+t8Z8svpmlhK71nY2E2I8iSV3r6qbQlSYBPA/38UKAGz+gAg9hoqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YQxuZhJb; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YQxuZhJb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725790939; x=1757326939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ut7YKbqGYyCbUNJ0wX6R8NmljR+0Pmh6b14hcLHruu0=;
  b=YQxuZhJbr8oh5K3V+okUd5vO5filL8D6dXIVKicvwV/k2yTeb5MJUSuF
   oafdCj2+9vDFFf8GwZ2tk7zPayW5/y0/3ebbPiqUlzqCEIn6eBPpp/jX2
   sDLhK9v5774GgiWEtMNTRSLxZW7agsb5bGbo3rC5QwYxHztQT/mQGmvW8
   Qfm/z2Pf/hbYPBUsrlzPy4/j0nPdWQ6yzEMYWIY6PHkY8SEz+7MkUnGE9
   bmIzt6+9vhQjgOQLDwpfX8mdTIi7VCia4ZOZVQcO5ci266vaoisSWXO72
   sALD9BMk6e5JiHAe7zmK3kqJyFHKpb65RVvfENSrGcAxhRqtRaVybRhFh
   g==;
X-CSE-ConnectionGUID: 9pYn1ortShCqSBRXLuIrYg==
X-CSE-MsgGUID: 68YDlHLjQTOW2BhB/Oz5RA==
X-IronPort-AV: E=Sophos;i="6.10,212,1719849600"; 
   d="scan'208";a="25553869"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2024 18:22:17 +0800
IronPort-SDR: 66dd6dfd_L9xZgLjT18Ui1oxodvWyxPiPeYKJGPCffI6GYK0Hs9qIz4A
 w21+O4kI7M+5SwyX+8SMD7QlTTr74r/NnDFA3Vg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 02:27:26 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2024 03:22:15 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v7 03/10] mmc: core: Don't use close-ended rw for SDUC
Date: Sun,  8 Sep 2024 13:20:11 +0300
Message-Id: <20240908102018.3711527-4-avri.altman@wdc.com>
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

The SDUC spec expects CMD22 to get squeezed between CMD23 and the
read/write command, e.g. CMD23->CMD22->CMD18 and CMD23->CMD22->CMD25.
At this early stage of adoption, we want to avoid an amid stream of
fixes & quirks of bogus hw, that tends to apply extra logic specifically
around auto-cmd12 & auto-cmd23.

Let's leave close-ended out for now, and re-consider this should those
cards become ubiquitous, if any.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f58bea534004..05a7745c2a68 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2547,7 +2547,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_host_cmd23(card->host)) {
 		if ((mmc_card_mmc(card) &&
 		     card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-		    (mmc_card_sd(card) &&
+		    (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
 		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
 	}
-- 
2.25.1

