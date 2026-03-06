Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3738F22A
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801343; cv=none; b=QN6Bwgw7mKWMm+345WVx/You4FrAMzbr3WxenV5T9RjtEFqbfELEfgeAvJPB8+5VAvOq/z0iRcBJtFjzC+CX5/PQiOnxNPCWCK0VMzEWqbqbMmbP6rwRxg1+Fqys54/jt0ZYIwxD6XRw4Fs0etN/tjlLXroSH+jqgBQv0zRe1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801343; c=relaxed/simple;
	bh=JbExdKzUwwyfRHgBvr0rFW9aATwFbDeRsoJmU3+eNf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBf8BLpDekcOcb834Fhnrfhj9Q45X20Qx2WZy6xY2QtM52gmJarpjeOHyvObeS99JIvF7e1YcMA8hdpcxti3WuyiYXoU+zT+WB+r5lzLpZOlGR6Ib8IRQYJJ8gSz+lmEjM59kynHGnxAe2O7DxWbJURR4jteLR9ccYqQEXruSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RINaxeIK; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RINaxeIK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772801340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK7/4vGewWQtAPSrvxbnFnbwvQe/Plx7g0ShrxlaYlM=;
	b=RINaxeIKTobd/N7F4nnE+yzemBpku7kjAiwy2xRNsfmfRTbmvpYx/dI8rUz0sWIgwWqre0
	mUnaqEpFpEv9N/KFVSWj7P2HmghO2Ai9C3WIf9M8zIYNeJKFLOH5lp00kgxDLuGxFVeZEm
	26UWS4A0vXdmh/Gwm2mSFYcR8O4WK7Q=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 2/2] mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()
Date: Fri,  6 Mar 2026 20:48:12 +0800
Message-ID: <20260306124812.332098-3-shawn.lin@linux.dev>
In-Reply-To: <20260306124812.332098-1-shawn.lin@linux.dev>
References: <20260306124812.332098-1-shawn.lin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bus width support for UHS mode is now validated in mmc_validate_host_caps().
Therefore, we can safely remove the explicit MMC_CAP_4_BIT_DATA check from
mmc_host_can_uhs(). As part of this cleanup, simplify the condition by using the
consolidated MMC_CAP_UHS flag.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/host.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 5941d68..6bce5a4 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -56,11 +56,7 @@ static inline int mmc_host_can_access_boot(struct mmc_host *host)
 
 static inline int mmc_host_can_uhs(struct mmc_host *host)
 {
-	return host->caps &
-		(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-		 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
-		 MMC_CAP_UHS_DDR50) &&
-	       host->caps & MMC_CAP_4_BIT_DATA;
+	return host->caps & MMC_CAP_UHS;
 }
 
 static inline bool mmc_card_hs200(struct mmc_card *card)
-- 
2.7.4

