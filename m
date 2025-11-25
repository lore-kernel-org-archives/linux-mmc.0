Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AB2F12C6
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114147; cv=none; b=bR+L8mNc3JLwkCHzFojfJQwRCZUnv8GAGRRiFYAM8alhXtLGXwBN1lt+nkTBzT41j47JH2b++7slOE2s/guynPfS27Eea61DluMnWoO/2jX1f1JvGKbCJi8ZMe/bvxtrv9E7bUS4XemzlvlghzsSsOD61Ong6+fja1N7QsKmMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114147; c=relaxed/simple;
	bh=9FR35gERsFWdpFU+IaEkUEJwyb2ILvEvPLhzM75KUbY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qRDZp6yZk3s9TE2uNt65SF3to5kH0YEYY4IBWsbToBUQktmx52h4GjTkKlJEqf0Dkhd6F6HaV4/5eN+gbifmET+PHTwPN5ndbWg8iHKHlDlXLI/lLEUVPHBzvMxpBhD7U7EtKIR+L2d0nARHnED2zKnZFee3Mp21SAjEcLqMbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QKUl8hy2; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QKUl8hy2"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae234a15;
	Wed, 26 Nov 2025 07:26:56 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/2] sdhci-of-dwcmshc improvement and fix for Rockchip SoCs
Date: Wed, 26 Nov 2025 07:26:38 +0800
Message-Id: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9abd57746f09cckunm0d7ff06b4d7bf9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5OTVZKH09OGhgZSEsZTxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QKUl8hy2l1gEYZ3Vb0kP1lUImclzr+mnPtZUWs2txZyv2Rt0+Cq7a987iHwLdRpmAxgLhGxaChBQrHNPhrx/cYamnmR1waqt/uZHDlrScDEfC7Y5XgVaVKzXk6BiMxtTOj/QsLTBcGKXr9Mv6ZhoY3QA2KX2AGACIAR0WVzGt8k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=sYABF2vZsyG5tO/eVEdXik09oQ3ruKdaNaX4VN3Q0As=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This's v2 of these two patches which adds ack-by tags collected and
rebase on top of linux-next.

The first patch fixes the auto-gating problem of dwc IP when using CQE.
The second one improves the performance of CQE by reducing CIT.


Changes in v2:
- rebase and add acked-by tag

Shawn Lin (2):
  mmc: sdhci-of-dwcmshc: Disable internal clock auto gate for Rockchip
    SOCs
  mmc: sdhci-of-dwcmshc: reduce CIT for better performance

 drivers/mmc/host/cqhci.h            | 1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.7.4

