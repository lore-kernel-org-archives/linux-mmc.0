Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45882E7F11;
	Fri, 23 Jan 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171086; cv=none; b=HDCJt4EJetnoMLg+lIPxOzhhClYNxEefwnAAEjp2vn2+zMD2wZ87JYE/imHuAmmEbor/yEMEhwtSLO/9AJUuVQ/cElYW60uSZQFoMKg4UZlcoovsPWKA7Z1LL8lirjeU+ImwC4RuVLTr6kqRe71Pf6dwuVR9QRfBl+zn7eiwbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171086; c=relaxed/simple;
	bh=/0anf8W8F688Pcefl2iIScs+826ZJL01MUHHYclCHPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z8yXSBnG7Tt7+lBFtXNu5q9emQaw8YQd+MzExKfDLXBB8v8DCI9bCNFFNlA3xUVQmag+0M3PhNrNrhusmfdEOhAWQLAmnNPnmSYt4bc9MjWDtb6aXfGlligkQvq9dOXZ2jP8FmOp04SkXiRZ3cw9LxhL7VrrVd8s9UiK5WWopWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=J4HIcYoF; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="J4HIcYoF"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31c0b4b12;
	Fri, 23 Jan 2026 20:24:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/3] mmc: dw_mmc: Remove mshc alias support
Date: Fri, 23 Jan 2026 20:24:09 +0800
Message-Id: <1769171049-74327-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bead02d3009cckunm9fc1f74e1df715
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5PGlZIH0lLSE9KHkJDSUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=J4HIcYoFyiE5ZXAU1Qi1RcA3nJDEOy7gNMOkIydFCkx1o5QCxEl8XHs4Rguu0BPlw6raPCAe4/H/ifS6N7OMYM/3bNw9lG3jJOWh6c8wBfrad04lLyRXWSjDerfyvbGTiITWX/4Ok9Zsm/r+AbY8mVzl4mH/+tQi/oxDO14Mhz4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kA6UWnSApNuXEqPHoMKu9WTrSs0y5Kcyf2773WqKu/M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Remove the long-deprecated mshc alias support, as the mmc core already
provides alias functionality through the standard mmc alias. This eliminates
the redundant dual-alias system. The driver now obtains the controller ID
from struct mmc_host::index(supplied by mmc alias) instead of the legacy mshc
alias.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a328a36..8cbaa9e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2846,13 +2846,10 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
 	if (drv_data)
 		mmc->caps |= drv_data->common_caps;
 
-	if (host->dev->of_node) {
-		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-		if (ctrl_id < 0)
-			ctrl_id = 0;
-	} else {
+	if (host->dev->of_node)
+		ctrl_id = mmc->index;
+	else
 		ctrl_id = to_platform_device(host->dev)->id;
-	}
 
 	if (drv_data && drv_data->caps) {
 		if (ctrl_id >= drv_data->num_caps) {
-- 
2.7.4

