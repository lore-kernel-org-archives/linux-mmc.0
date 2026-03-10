Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F3259CB2
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106592; cv=none; b=UOAUWtgBlMet7s1SkiXUsrFxyWgCZ1bQjL15bh8s2L4YK3Mx7+SCW+nDTmsm4JDPRrUjMIiKLTpIQkdz9r4XnzYwMc9uN/KtNgCnhzVc+WHduZQtqPK+SNTW+rzmywe7R8W8sZEO6T2vvJEIrVlgLzAdFurx4ProjfCylEYonG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106592; c=relaxed/simple;
	bh=+OaUca71CU/FvqxCan7e2S41KmT79DxVBZHgOhBOup0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfOly3FKebagH7z7BiFGtoWbuoZodbT5wTnPL5Ojv1mS97BGC3RrvU4lMDIe/xDqB5cZkRQxFBa2ogNPn6fAg9hiohXkjMGlSfkUBFzxW/wygbLWlCAxu1bBhHYn53eR+2PIjd3nsVjxlpqz0+su/CYYKeXaeYdPyRHQlfV4bWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gridBMbT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gridBMbT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773106588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1mjzxfbDxngcsAG/hf/dGkg3fbfOSG1YvvdS6E5FPc=;
	b=gridBMbTHeuj71cYIp60NaLHfsSj0AW24MnLg3XrPxESFHyQZCQHkiLs/p7XOm8+oH/kw2
	qAKUchjec9/8Ab7TtKzlrDmJlu+f0OY+fQdU4QerO93+fhU/gDDXd3IqE+PYUz260vRsKw
	UU13WwLGXcro8W0LxbVkBQp5dcNEJ5o=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 1/2] mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width
Date: Tue, 10 Mar 2026 09:35:52 +0800
Message-ID: <20260310013553.29332-2-shawn.lin@linux.dev>
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

From: Luke Wang <ziniu.wang_1@nxp.com>

UHS/DDR/HS200 modes require at least 4-bit bus support. Host controllers
that lack relevant capability registers rely on paring properties provided
by firmware, which may incorrectly set these modes. Now that mmc_validate_host_caps()
has been introduced to validate such configuration violations, let's also
add checks for UHS/DDR/HS200 modes.

This fixes an issue where, if the HS200/HS400 property is set while only
a 1-bit bus width is used, mmc_select_hs200() returns 0 without actually
performing the mode switch. Consequently, mmc_select_timing() proceeds
without falling back to mmc_select_hs(), leaving the eMMC device operating
in legacy mode (26 MHz) instead of switching to High Speed mode (52 MHz).

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
[Shawn: reword the commit msg and rework the code]
Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

Changes in v2:
- updating the temporary variables in the middle and update host's caps(2)
  in the final. (Ulf)

 drivers/mmc/core/host.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95db..a457c88 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -624,12 +624,24 @@ static int mmc_validate_host_caps(struct mmc_host *host)
 		return -EINVAL;
 	}
 
+	/* UHS/DDR/HS200 modes require at least 4-bit bus */
+	if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
+	    ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS200))) {
+		dev_warn(dev, "drop UHS/DDR/HS200 support since 1-bit bus only\n");
+		caps &= ~(MMC_CAP_UHS | MMC_CAP_DDR);
+		caps2 &= ~MMC_CAP2_HS200;
+	}
+
+	/* HS400 and HS400ES modes require 8-bit bus */
 	if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
 	    !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
 		dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
-		host->caps2 = caps2 & ~MMC_CAP2_HS400_ES & ~MMC_CAP2_HS400;
+		caps2 &= ~(MMC_CAP2_HS400_ES | MMC_CAP2_HS400);
 	}
 
+	host->caps = caps;
+	host->caps2 = caps2;
+
 	return 0;
 }
 
-- 
2.7.4

