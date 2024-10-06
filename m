Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78E15575D
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191678; cv=none; b=sMNX9l2AlrJIJsj6MYKuufOG1iNm+5ZcMc6CgooIt2CoX51Tcil3xIPHzFv05rbllozBE5rgls5TI3lysR1dQhZbnN01RdDJ3PxPRLZ/X9Qu4dBmv/VD+NfmBk9zdtXZklnuQdcDkCTybIQUOwVGgFfGeeBlbyizL0HMKpWXURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191678; c=relaxed/simple;
	bh=V6UW7NuNuB+n/REgtfcoMX1aAYAe1YBMTsfM7Xtsclw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T506NBfrOBtJOhYZlANurJnwk4j8NpUvDMFSMWG4gWnx0wOZ4AZ8PdqQoDSjY+myUU9/oXiHMHY+f1x5gbVZFCiRXRsrHddKQ6MfDV7MFy2TyR2dvZvjZBchC6lvIuG1Cj5uDr1XBGZXqySWmIQFWWZ2NvbCN8GE0079hILXVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kjZlxa21; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kjZlxa21"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191673; x=1759727673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6UW7NuNuB+n/REgtfcoMX1aAYAe1YBMTsfM7Xtsclw=;
  b=kjZlxa21dJBXBwpPQGmVYxnUUGhrNGsioHnSuicsK3MP/arLAVaXpKx2
   LWCWQbk/wy8zWTXCSPeBh2Vp5VT7+tGl7QTUOn8qZgIh8t2Q7hPmdfzdV
   W72vBPZqac0A5yB8kwqHnLL2l/RcoSNNffIQN+1htsORAhhj5zVfcVjGv
   ZEnf8V3g/sTrjG5ICWqSI0kWGpgXMQ3bAu0AAshbt28R80ntRfJGOQLWK
   rpcIavicyTvE3QsM0fGKwbW1lqBI2374UYl6/K7fZGmdvW7ekLxi5o2TG
   UCU8Rt3pDbIjZmXVCS8NbVMVA7381nLx0B3CafUB8biBzoCRA9CodD17o
   g==;
X-CSE-ConnectionGUID: 55zEAZ0ISjygo6JRbpxRPw==
X-CSE-MsgGUID: cGHPLIQkQjSnsY48zALnWg==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="27708033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:33 +0800
IronPort-SDR: 67020fbb_L5iBy0HoToVsdDzbYw86y8tmVj4yvI0nLrbiz7wcrGrdLMf
 44VoBhRK9tUCTReVkeeSPfI/S67yPFGV5uv94zA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:19:07 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:30 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 09/10] mmc: core: Prevent HSQ from enabling for SDUC
Date: Sun,  6 Oct 2024 08:11:47 +0300
Message-Id: <20241006051148.160278-10-avri.altman@wdc.com>
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

hsq allows to get more in-flight requests from mmc core, which can be
prepared in advance and be issued asynchronously to the completion of
the preceding request (in atomic context). This is presumably broken
though by the mandatory CMD22 for SDUC.

We plan to make it work, but only as an improvement on top of the
initial support for SDUC.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 63915541c0e4..33e806adcbf7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1558,7 +1558,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (host->cqe_ops && !host->cqe_enabled) {
+	if (!mmc_card_ult_capacity(card) && host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
 			host->cqe_enabled = true;
-- 
2.25.1

