Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3D3451BA;
	Fri, 16 Jan 2026 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537511; cv=none; b=DcUBN7u0neLQSdCUNcJwMSdV1q9XtqLT+83aFdmPrneJ/Ya0/0qg2T5NP8hOlfKrCkqQGiA+Z2b55u5q0RZLcRt42m2WQN+pIGQeKErDvgoPmhIUqoYg9/pzLh8IDVXC2BjabK6yY1QySU9k8j6/PfhzcCHB50a8ujOy2EFr+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537511; c=relaxed/simple;
	bh=g7z058j0bXnvPif7XVhdeZ+uRvtQkc8Jng+4GNjGSPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HNvcsx7/mKEpdfAW4ZPOKIo6l+ck9QTUlihkWTeSkev8E2Qzbf1BBh4QPlWVUhb1kpjSiZfgwouVmqfsEzm2QNSehVkYuFHpPX5C26UA4YMK52SUh0s9MawGV76KymQKtKfVJ9ttNrTnbEiXsTt80E3E0k8q6KdMgVVwqmoYzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Az7SyuAU; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Az7SyuAU"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d5a7694;
	Fri, 16 Jan 2026 08:55:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	John Clark <inindev@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/5] soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition
Date: Fri, 16 Jan 2026 08:55:28 +0800
Message-Id: <1768524932-163929-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bc44d1e0e09cckunm67a197c8691b92
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkaGVZLHR4YS0xKQkNNT01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Az7SyuAUsr1Kaaw39Ol+k9Zngda81VWTEhn6ToWZDfpSRplqEzQ4Vbv0h4qn3vjujzFHP6BGP+ououQ1kXj+iD/dJ2BPNw1TZD5N8rptzmRogwffUmsy2MMhG0zC/PRPkaLNS3u73ag2hG/ECooPmprBsTVp20GRhuOJq3xhhCI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=AczjdJsFb095JkSpdZQoyE7UxR51PLqYbEkqBrM85Jc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

RK3576_IOCGRF_MISC_CON is IOC_GRF + 0x40F0, fix it.

Fixes: e1aaecacfa13 ("soc: rockchip: grf: Add rk3576 default GRF values")
Cc: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/rockchip/grf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 27bfa09..8974d1c 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -146,7 +146,7 @@ static const struct rockchip_grf_info rk3576_sysgrf __initconst = {
 	.num_values = ARRAY_SIZE(rk3576_defaults_sys_grf),
 };
 
-#define RK3576_IOCGRF_MISC_CON		0x04F0
+#define RK3576_IOCGRF_MISC_CON		0x40F0
 
 static const struct rockchip_grf_value rk3576_defaults_ioc_grf[] __initconst = {
 	{ "jtag switching", RK3576_IOCGRF_MISC_CON, FIELD_PREP_WM16_CONST(BIT(1), 0) },
-- 
2.7.4

