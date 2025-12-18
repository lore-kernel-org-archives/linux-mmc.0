Received: from mail-m49217.qiye.163.com (mail-m49217.qiye.163.com [45.254.49.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631F137930
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066803; cv=none; b=Zrr+4iwm4d9eEnOqktyWXvvJu3FNiSsnwEyEst/47uMCNZYgZOuSLlNienZafpF/Zq4UYSW3VWkFCVJrZ2ZVUv9ETp7OjQhMPA1SVmPHibhoSwUpAbZoFcY2b4YwEDDEb97erGs9YZAzc1zYUaqb8GsYDswuilnJlSlEQO8m/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066803; c=relaxed/simple;
	bh=921JjO54SX2drfoZPaYEmIcWyo/Ea1SCMZgro1wSrnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RBQLPX+TYTI/9+CzfkShwiSsMMzy3XlPu7fTKutvhwg/oMxGUKeyl/VK0PvBA7Vd3N1KGKiMbwyoO/a0UzC5y8TbnKtZ5j0v53tOZMhBou9mjHuxfZP9UkD05xznS6hMUc+49nIstKG+IJRuUyQ1YkOSnFZZ1ISsv316fp/uzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jGSNPumi; arc=none smtp.client-ip=45.254.49.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jGSNPumi"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb47f;
	Thu, 18 Dec 2025 22:06:31 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 15/18] mmc: dw_mmc: Remove check before calling mmc_regulator_set_vqmmc()
Date: Thu, 18 Dec 2025 22:00:42 +0800
Message-Id: <1766066445-14144-16-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c8a5ac09cckunm1f354c4b783a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9CHlYdQ0tKTR9KQ0ofTR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jGSNPumiqmk9Z0EgbUNQuo+KrksQXDMWDnL9nc6oudumM+oKzAmipTap14TsDZGRJMrslQ7BrCi3Twb0aFVyaSOIdME/MareoHMik+0220DSo79E54KdgyMdGBGt0wc++/S9wdXjVrEkxUaZjFbUqsOkb0Us0oU/qj9cGhM9NX4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4DM9Q+HuTpfTrdeXDiSVlDwtWz0nvjFh7YlPPzYrlRw=;
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
index bd8e810..9ba12e0 100644
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

