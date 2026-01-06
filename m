Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55729D27E
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666184; cv=none; b=fMo8D0BYZfrVS6uqoxfv3l731tKXwBAOH1HzLEqCHL+A/FXQhLir9vxSn25rMaY/LEtzHeYaX/iJg0/cSEzq0184TgJVdZ/ha0M+bmhfQGB7mc6JYGF0HVXmT0p55WMGpRrwGCI+035EeYoTC93oPJhC2wQdzQflbfLLeaAwfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666184; c=relaxed/simple;
	bh=YOrot0LEW3GAAVcymHOm+3Su0VziVUmhmNTcgs1P5aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U5OdiBUaS4IcEs5i6rxSGv2oK1kun7MGk+GRx4N8/W1RqTydxJO7JJuYR4d+D979zmEJr34ofX33j7nLFbtyF9MLsD+UV6SnhfA4ZPgVh1Ro6MxSJmee4jgcrjPX2zKNgcpOOVeUBbcI1+3aXx9EEVjnWKD9WQooSLd9u6jXpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QVqrAzMV; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QVqrAzMV"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c4ab5d;
	Tue, 6 Jan 2026 10:22:52 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 11/18] mmc: dw_mmc: Remove redundant struct mmc_data forward declaration
Date: Tue,  6 Jan 2026 10:17:02 +0800
Message-Id: <1767665829-183001-12-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911d418109cckunmc69ba49b79ca8b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpPGFZPGkMZTRpNQkpPSUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QVqrAzMVAJ0AdpEbHWn1LA3b9a8lAIUUKUreAFjBW+x9Yy2ktH8OLVYPukbTOXKF5qFdNxpYIobwBfqtqXZS3SlnGo5/JFkDt2F2L0dtidsrryz/iFpHQ29oggg488lof19QVKyzAXDILxWUcjK9ekfk9qy7KEE68MhKSB7z930=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9JqveH1q89zKrS+ZUzQa0GPhaamaVqMikmKfVrUaRnc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The header file linux/mmc/core.h, which is already included in dw_mmc.h,
contains the forward declaration of struct mmc_data. There's no need to
redeclare it here.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 76bf8a7..5c17bcc 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -43,8 +43,6 @@ enum dw_mci_cookie {
 	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
 };
 
-struct mmc_data;
-
 enum {
 	TRANS_MODE_PIO = 0,
 	TRANS_MODE_IDMAC,
-- 
2.7.4

