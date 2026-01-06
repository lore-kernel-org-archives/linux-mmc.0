Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com [220.197.32.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578B3C0C
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668383; cv=none; b=cEXuKudEqkf8OPjpymrTMQQBpT1wiLmKYFAx9i8LFvXt+9MAAdB8l1cWqL3vfbwM8e2djNHwyMKzGQDtwYlzkZE6i5hQIrPw1unmvQHhOMqOiIvA65IjPSnw2n62GnxRMJ2bge8GCxtcrJeD02JI8OeaaUHshuPToEN1EMol60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668383; c=relaxed/simple;
	bh=S84WoLsCkZfwRTlZTdgHzqohC2jDZ4uDUorOm6zwm2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nTST6cJwEQ7UG1jWR78DcHJykA5rCkNiEdTry8PtYRBdxBAccHCrJSlugGGYyQDC4qn0Tc9e+pZpAvLdsJdn1X27n5oK8P+Xa6BXxWrtkriasp16+PMc8CqFWl1mvg0vRHJUf0uORO3owF3NnnfFDg6/fPzK0g4trE2AAelev28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=J4UfExen; arc=none smtp.client-ip=220.197.32.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="J4UfExen"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c4adaa;
	Tue, 6 Jan 2026 10:24:11 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 15/18] mmc: dw_mmc: Remove check before calling mmc_regulator_set_vqmmc()
Date: Tue,  6 Jan 2026 10:17:06 +0800
Message-Id: <1767665829-183001-16-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911e78af09cckunmc69ba49b79cf61
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpDQ1YeSEwZHUJISRlDSR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=J4UfExenNDo4Xz3zKjUlqt5qIXxxBAsKJVHTYnneAWFxwx4ZcP6iNc0N68uM1FAdOqtI6RRCmEFofK4wqsWw9K4WubR5xiY1JPAnXDogqvKpqRusna5hKa1UrNi+XsA2ieZH6N5OkH4hVNfJT8OePGi/qAlaikqbR374dEPQ3oI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HTwDGYl2rBKmd+HGYTlUbLl/GFqw4EBe2/lF8PwLilY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The vqmmc regulator is acquired as optional via devm_regulator_get_optional().
The helper function mmc_regulator_set_vqmmc() currently returns -EINVAL when
vqmmc is not present. This patch justifies why this error code is acceptable
within the dwc driver's usage context.

The function is invoked in two scenarios:
1. In mmc_set_initial_signal_voltage(): The return value is ignored, so
   returning -EINVAL is harmless.
2. In mmc_host_set_uhs_voltage(): This higher-level UHS voltage setting
   procedure should not be attempted if the vqmmc regulator is not available
   in the first place. Thus, signaling an error is the correct behavior.

In both call paths, returning -EINVAL for a missing optional regulator
does not introduce regressions.

So this patch removes the check and still returns error to the core, instead
of zero, if vqmmc isn't present.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-k3.c | 10 ++++------
 drivers/mmc/host/dw_mmc.c    | 14 ++++++--------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23c3031..4c313fc 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -417,12 +417,10 @@ static int dw_mci_hi3660_switch_voltage(struct dw_mci *host,
 	if (ret)
 		return ret;
 
-	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = mmc_regulator_set_vqmmc(mmc, ios);
-		if (ret < 0) {
-			dev_err(host->dev, "Regulator set error %d\n", ret);
-			return ret;
-		}
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret < 0) {
+		dev_err(host->dev, "Regulator set error %d\n", ret);
+		return ret;
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2ad7d74..fdc9dd7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1461,14 +1461,12 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		uhs |= v18;
 
-	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = mmc_regulator_set_vqmmc(mmc, ios);
-		if (ret < 0) {
-			dev_dbg(&mmc->class_dev,
-					 "Regulator set error %d - %s V\n",
-					 ret, uhs & v18 ? "1.8" : "3.3");
-			return ret;
-		}
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret < 0) {
+		dev_dbg(&mmc->class_dev,
+			 "Regulator set error %d - %s V\n",
+			 ret, uhs & v18 ? "1.8" : "3.3");
+		return ret;
 	}
 	mci_writel(host, UHS_REG, uhs);
 
-- 
2.7.4

