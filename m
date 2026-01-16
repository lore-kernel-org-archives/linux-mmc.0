Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C471D6AA;
	Fri, 16 Jan 2026 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524966; cv=none; b=lm3jbicF7M2g+UaODXskBt/87bQJnVImLQmkyYY0twWXL2iHz2NGLohLCLL//wybpBRMp0ZfQzolccoC3CFHXyur7bZftLsmDYriaW/+t+Y2BiHyckzFE2lG775rQWXjV6UWwCTW0L76p+AsrJFgIfa+f7wRvTu7KTdL3NBBnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524966; c=relaxed/simple;
	bh=9PLwdFCUAvqhT1zUrchVxoO7QsP/kCtIKtoni/Hk3sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JnQyKSMT30bizHu+YsdLAdab39wXLrENSBQIDhlhd2oT1PaEiApbny4w1w4rvXjT4Tu34bBDTUye/M7O1KAYF51A5pn5eAgDIhHWkDLUqkCK/VXSfZiMC0oLHzfROctlUX+sF5hcHWVTvpi/IF3uTp2vWJ+QmjsPlJU84rYVvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D4kpb85q; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D4kpb85q"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d5a769d;
	Fri, 16 Jan 2026 08:55:51 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/5] soc: rockchip: grf: Support multiple grf to be handled
Date: Fri, 16 Jan 2026 08:55:29 +0800
Message-Id: <1768524932-163929-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bc44d2e2309cckunm67a197c8691bad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtLGVZLGB1LGEwdTBpLSR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=D4kpb85qC2GrPpUTo4Nwi0DuT/hVkd2gHl0a1do9BUbM6W8IWVMuZuxD4YNnnsiAeOlzg9PNzaIw/5vcTupCkfnFq9GHpdtkqx3YifyRP3XEj35LO37jzdcFrV37Uq8SILLANMxGIeaJPIbXpBSR3yTncpcZXOnCJYMRB9h5EgU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7ONJa0WvvLpdHxmR7sI4inADE7R0rUhqKbxvZUom8Rw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Currently, only the first matched node will be handled. This leads
to jtag switching broken for RK3576, as rk3576-sys-grf is found before
rk3576-ioc-grf. Change the code to scan all the possible node to fix
the problem.

Fixes: e1aaecacfa13 ("soc: rockchip: grf: Add rk3576 default GRF values")
Cc: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---

Changes in v4:
- none

Changes in v3:
- remove of_node_put() (Heiko)

Changes in v2:
- use for_each_matching_node_and_match(Heiko)

 drivers/soc/rockchip/grf.c | 55 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 8974d1c..04937c4 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -217,34 +217,33 @@ static int __init rockchip_grf_init(void)
 	struct regmap *grf;
 	int ret, i;
 
-	np = of_find_matching_node_and_match(NULL, rockchip_grf_dt_match,
-					     &match);
-	if (!np)
-		return -ENODEV;
-	if (!match || !match->data) {
-		pr_err("%s: missing grf data\n", __func__);
-		of_node_put(np);
-		return -EINVAL;
-	}
-
-	grf_info = match->data;
-
-	grf = syscon_node_to_regmap(np);
-	of_node_put(np);
-	if (IS_ERR(grf)) {
-		pr_err("%s: could not get grf syscon\n", __func__);
-		return PTR_ERR(grf);
-	}
-
-	for (i = 0; i < grf_info->num_values; i++) {
-		const struct rockchip_grf_value *val = &grf_info->values[i];
-
-		pr_debug("%s: adjusting %s in %#6x to %#10x\n", __func__,
-			val->desc, val->reg, val->val);
-		ret = regmap_write(grf, val->reg, val->val);
-		if (ret < 0)
-			pr_err("%s: write to %#6x failed with %d\n",
-			       __func__, val->reg, ret);
+	for_each_matching_node_and_match(np, rockchip_grf_dt_match, &match) {
+		if (!of_device_is_available(np))
+			continue;
+		if (!match || !match->data) {
+			pr_err("%s: missing grf data\n", __func__);
+			of_node_put(np);
+			return -EINVAL;
+		}
+
+		grf_info = match->data;
+
+		grf = syscon_node_to_regmap(np);
+		if (IS_ERR(grf)) {
+			pr_err("%s: could not get grf syscon\n", __func__);
+			return PTR_ERR(grf);
+		}
+
+		for (i = 0; i < grf_info->num_values; i++) {
+			const struct rockchip_grf_value *val = &grf_info->values[i];
+
+			pr_debug("%s: adjusting %s in %#6x to %#10x\n", __func__,
+				val->desc, val->reg, val->val);
+			ret = regmap_write(grf, val->reg, val->val);
+			if (ret < 0)
+				pr_err("%s: write to %#6x failed with %d\n",
+					__func__, val->reg, ret);
+		}
 	}
 
 	return 0;
-- 
2.7.4

