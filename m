Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442838F64E
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801328; cv=none; b=bssz1uRFLjELi8weRtqnYKrG3gdgp6wrvGHAqeIxWTHCGB8RRNaV+dUWuy3sPThBOLq/NNIn0eetohGSq5ASA/+H04OTydsCGYMHyNf6Gkeds5DnHDgc7Op2MaK+z95RHDHQmaJtQMBY660gAa0jaxjVWvh1ndaGlDKvPDfFtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801328; c=relaxed/simple;
	bh=0zdvd7jo3XkmnnQ7uPVUVT7vzp3ZM+38PGIFmXn3cek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emTE4VzZjB3g7saAT6t+2JOPpj25PXgss85l5IYTsbOyXU4i4FqglbDlSQ8rrcwMBbFLyUgQIC5OkP881XsTUk7WxgRiHdhNnswYS1zIHNCmUK7keQzS8l6WStwGO+SYAYD8r8eX3S1X44xOBH7qp0i+q62DiHLezDxnvBVC/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DVds4/o9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DVds4/o9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772801324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64q7Zna/vRHXAYNbBWnVwzRImdZzAViaq5gIGKkAeF8=;
	b=DVds4/o9AfpJz7gZmgfkkLGp+A1WC72AODDAPVIMrxZh0oMuCmSxbTH2xKzeVc/zscjw/x
	Soxsglh9f2kGGTQcGK1ZY2+++wzUecVbKIcA74kgrh3PTIm3WdcfB1picudHsW4QmVuhVK
	vK/R9X4B2FP0AjUbJ/xCDUW7HGMzNMQ=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 1/2] mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width
Date: Fri,  6 Mar 2026 20:48:11 +0800
Message-ID: <20260306124812.332098-2-shawn.lin@linux.dev>
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

From: Luke Wang <ziniu.wang_1@nxp.com>

UHS/DDR/HS200 modes require at least 4-bit bus support. Host controllers
that lack relevant capability registers rely on paring properties provided
by firmware, which may incorrectly set these modes. Now that mmc_validate_host_caps()
has been introduced to validate such configuration violations, let's also
add checks for UHS/DDR/HS200 modes.

This fixes an issue where, if the HS200/HS400 property is set while only a
1-bit bus width is used, mmc_select_hs200() returns 0 without actually performing
the mode switch. Consequently, mmc_select_timing() proceeds without falling back to
mmc_select_hs(), leaving the eMMC device operating in legacy mode (26 MHz) instead
of switching to High Speed mode (52 MHz).

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
[Shawn: reword the commit msg and drop HS400 change]
Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95db..d1d4870 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -624,6 +624,15 @@ static int mmc_validate_host_caps(struct mmc_host *host)
 		return -EINVAL;
 	}
 
+	/* UHS/DDR/HS200 modes require at least 4-bit bus */
+	if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
+	    ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS200))) {
+		dev_warn(dev, "drop UHS/DDR/HS200 support since 1-bit bus only\n");
+		host->caps = caps = caps & ~(MMC_CAP_UHS | MMC_CAP_DDR);
+		host->caps2 = caps2 = caps2 & ~MMC_CAP2_HS200;
+	}
+
+	/* HS400 and HS400ES modes require 8-bit bus */
 	if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
 	    !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
 		dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
-- 
2.7.4

