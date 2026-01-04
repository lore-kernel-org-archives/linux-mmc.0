Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2F4C98
	for <linux-mmc@vger.kernel.org>; Sun,  4 Jan 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767517326; cv=none; b=hZVQ+wEO6p/Bt2Y+Xi+/nXDMjVMQhVV+Y62lhL4DlhaxJzmkr7oIUq2PzVjA2tMwyHKtPDX8dyxKl/OKetg36zc3NRNVj0To+WL5JsFc+AnxktOzuQE/OX0W5TKLfjpU5Kj/OftuK8MrcOj7tIMghAT1Ta+DopfMwJ0IBuiJrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767517326; c=relaxed/simple;
	bh=adIuPgx9by/i84uUt6DEMc6S+0T4NB3Muedw0ABust8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=rOQYMJkRui7Kiw5QEgfOInex8QN5Atz+aTzYz8HZiBp0X7WZTPg/RizxHVeZLA9hPtl88MzpqjHu18Hrz9EebZyTRKzHE1E1itOtEqj+qWvqkVU3sc3dIMANCBFJhlJk4nLyIEC6yay2J8ppNePpYg7VKg9sGw5YdS/O0ovO8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j778jI7c; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j778jI7c"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260104090200epoutp0177c5ec70c34eb63b6ab57f7d20c268be~He6NrNesN1044210442epoutp01N
	for <linux-mmc@vger.kernel.org>; Sun,  4 Jan 2026 09:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260104090200epoutp0177c5ec70c34eb63b6ab57f7d20c268be~He6NrNesN1044210442epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767517320;
	bh=FT4bDmv5s42DTXH7CguPQp747oLws+iTLS4o6ZEIpDI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j778jI7cpCm22U1CSZtxb6DriNswPqRv+BuQnUsufe8drKTdv2NdBbKJHbX3/u3J5
	 KJFOZeZWxL4QyV0XR+wNriQnddlobe6DuuRTQKf8QGaMWTTDvmHHehHOr3YYWKLBKj
	 WTUlS/mDbUGJVFX+FI7G2HW1+J1oX7t6fYx9hVYk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260104090200epcas5p46de16fed23959d889d98927f6cb4a8ff~He6NcLbC21416414164epcas5p41;
	Sun,  4 Jan 2026 09:02:00 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dkWdh24mLz3hhT4; Sun,  4 Jan
	2026 09:02:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260104090159epcas5p40fb957238b0ceca496e9ed0a6c00bb93~He6NFW4FN1416514165epcas5p4m;
	Sun,  4 Jan 2026 09:01:59 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260104090159epsmtip2d3850b22efc757551f8e90cee148f244~He6Mc6qnu0142901429epsmtip27;
	Sun,  4 Jan 2026 09:01:59 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: RE:RE:[PATCH] MMC:dw_mmc:when enable biu_clk should check whether
 this clk
Date: Sun,  4 Jan 2026 17:06:05 +0800
Message-ID: <20260104090605.214347-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260104090159epcas5p40fb957238b0ceca496e9ed0a6c00bb93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260104090159epcas5p40fb957238b0ceca496e9ed0a6c00bb93
References: <CGME20260104090159epcas5p40fb957238b0ceca496e9ed0a6c00bb93@epcas5p4.samsung.com>

        if (!clk) <<<<<<<<<<<<<<here should modify like  "if (IS_ERR_OR_NULL(clk))"

                return 0;



        return clk_core_prepare_lock(clk->core);

}
because other function use this to check clk in enable or disable , for example :
void clk_disable(struct clk *clk)

{

        if (IS_ERR_OR_NULL(clk))

                return;



        clk_core_disable_lock(clk->core);

}

If you agree , I will resend my patch.
some vendor doesn't use biu_clk , enable it will panic
log is below:
[  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
[  438.400877] [7:   binder:436_2: 4998] Mem abort info:
[  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
[  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
[  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
[  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
[  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
...
[  438.409424] [7:   binder:436_2: 4998] Call trace:
[  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
[  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
[  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
[  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
[  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
[  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
[  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
[  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
[  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
[  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
[  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
[  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
[  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
[  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
[  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
[  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
[  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
[  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
[  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
[  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
[  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
[  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
[  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
[  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
[  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..61f6986f15ef 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (host->slot &&
 	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
 	     !mmc_card_is_removable(host->slot->mmc))) {
-		ret = clk_prepare_enable(host->biu_clk);
-		if (ret)
-			return ret;
+		if (IS_ERR(host->biu_clk)) {
+			dev_dbg(host->dev, "biu clock not available\n");
+		} else {
+			ret = clk_prepare_enable(host->biu_clk);
+			if (ret) {
+				dev_err(host->dev, "failed to enable biu clock\n");
+				goto err;
+			}
+		}
 	}
 
 	ret = clk_prepare_enable(host->ciu_clk);
-- 
2.50.1

