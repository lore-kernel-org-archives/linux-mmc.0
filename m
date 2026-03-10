Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702262D73B9
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106597; cv=none; b=BdfBqgi49VvBL1carOKPnAvDkqkOLNC5OB/t43hLyC9WCnzcjMtGhPSheGRQjFgQIMMNtDbLP868wBuXkqVUG0zoYvme46E7rM3epWEOSIDTouL/dsJrpPLyv488wt6O5TI1TR7SMTZQwo5egJeAn2b2ltcIF7wCIXpnQEF/uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106597; c=relaxed/simple;
	bh=/qKAOIJ0NX3GbEw6+YUJhRjb5HhBV/tjXYkWPcivcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzU9rxzBKCPahDUdTFPsKHn2Yx8Y4d7KL1PItblJKZp3gN49Ewl4VjIbvNQWjMRbM6VhYYo50OdMJLhcSML9wtt1Zfl/pep7OwXyp0fk/FL1f73eSNBvEeZzBxszvoa7Ss6Z228BdUuZBuUgYj7wdOtJXoRhNj69MMLxm83lVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pFbI+NSK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pFbI+NSK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773106594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWb2hP/vwy/BPvTLlDNQG898rPYUV2APKxHUe9a/gEY=;
	b=pFbI+NSKMGnN2brpDY64jNbobYtntPbIeNOn6ed6wFk4YCctRjX5hgwixveYUE21fG9OM/
	JvXGNtnpapo/d3C4kjowu5nTJVfiiej4Qvg+IjaW3b7WtelrSzVRUGENz3j0eDVOUqS698
	/bXc6JyGtIvBr8m9itRarHxS5yXKLOM=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 2/2] mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()
Date: Tue, 10 Mar 2026 09:35:53 +0800
Message-ID: <20260310013553.29332-3-shawn.lin@linux.dev>
In-Reply-To: <20260310013553.29332-1-shawn.lin@linux.dev>
References: <20260310013553.29332-1-shawn.lin@linux.dev>
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
mmc_host_can_uhs(). As part of this cleanup, simplify the condition by using
the consolidated MMC_CAP_UHS flag.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

Changes in v2: None

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

