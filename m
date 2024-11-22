Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213115AAD9
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268570; cv=none; b=NotPPjKc5vHvPbs+xxZpV21/NVWnwlcJszoVm7dluHKPQMQ3UQzweFY7yq+Ph4zqy+kUu30rrXe+WxNARbWWvNLh7nvC0eVyy0ry9WjU0MufuUZoixDcZfvQRbBVhFFBbozhe2L/0VlaRsCQa8mAaORIRGkvRd6m61FzVKZXP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268570; c=relaxed/simple;
	bh=Fg7FsOwNPgQ9DerFuUvdptXo5Ra+9775P1GiOl7oYPI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K9c539JkdyBJUpUxJGiOHR4cpzjDaVHQqgPnn72Z1prRuiBA7r8tRgcyjBT81nlUnFlhySHa8F0CIgc4tuSHctxInq58U1qDpkw/meafKGUb7f6UGDNrMILtqxfKxEpkX/gkV1Xh5BzSvnqmQrCDvc5ToIXtU/tC0Lm1Ed5NblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NgKX+KXi; arc=none smtp.client-ip=115.236.121.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NgKX+KXi"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 389c0758;
	Fri, 22 Nov 2024 17:37:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: YiFeng Zhao <zyf@rock-chips.com>,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: sdio: Respect quirk_max_rate for non-UHS mode
Date: Fri, 22 Nov 2024 17:37:22 +0800
Message-Id: <1732268242-72799-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhoZSlYfGB5MGE5KH01PGkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93533bcfed09cckunm389c0758
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6URw6HzIvHT4xE0MaKTgZ
	LwlPCyFVSlVKTEhJSU1DSU5LS0xIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU1ITzcG
DKIM-Signature:a=rsa-sha256;
	b=NgKX+KXikG2xR2Rt9WA/oRMPueHVqFMCA19+bb6+Fuecc3JquS3bblaEiNXkKnXpNI36c4t9HZhqglvjVmLepE+LtyLmXpv6ALETg91WrZnTC/0eMTmw05jesyBdXH+dFLufrLSUcS3uc17xQ70WnxlMwy/4MpE5lGAuD6CQAM0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=XZ5Rdgt0+I5mdNw2VLdFeQ2mmt31FvncmfVhhbzXS/k=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The same limitation was done in UHS mode, so fix it in
non-UHS mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4fb247f..b31ca2b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -458,6 +458,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (mmc_card_sd_combo(card))
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
-- 
2.7.4

