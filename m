Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6122156F
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158316; cv=none; b=duQAo7lJmGbifIXl/RYM1zFcgCOyELA8aMlQc3VBhLfuJwtNvrp7MVAxWGSO3OnzvvTSUfoUfVKUJeulIIk41K8Mu52AGiCIkKOCwdzxJSsWwCDxYiuzCdozTFt7GYNGmUv/ly/0pTQGbeOaQsfaru097sud63tTaTsgQkEcClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158316; c=relaxed/simple;
	bh=uTMJ9l0r63/LJTtY6CTa9e88NhY2wag90snqQBwAD5c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=TYkeq8iaB5OZKPz5WEZ1W7PgjVAe932vRqqn471gYO5A7qExzN+Oc1llwBG/WTZUQx9qiOkWtdFhNql9ojTncY1ov6mblvBVM3vATr8rGjWNFJK99S3E0hFnUg7cjr9JShQRJ20bbF5TOIJEdR/wXdGUT4AVU/r7hXOS8XC2J6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fevL4Bsy; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fevL4Bsy"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260123085151epoutp02923b88c4ad3d9079697b42d24f6289ee~NUBxRuJgw1650516505epoutp028
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 08:51:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260123085151epoutp02923b88c4ad3d9079697b42d24f6289ee~NUBxRuJgw1650516505epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769158311;
	bh=CKHP6ZlZ2SfMMnfTu33Mh/XqWqhdnfxn6P0CP/3rVto=;
	h=From:To:Subject:Date:References:From;
	b=fevL4BsyCNS9FmYWK4IvkGT9LUhYrp8LrFbzlxLbOj7k+aZOOIKWwegcHl0p3GzBi
	 Egpg+kHBvYMtZEklTxb38xBkUsJDYQLPwXaehYLgu3EqDWfEyKr6NJWkD7D6ZtwuvX
	 th9Xveve9VIKlx1TbIOC4infWvBpxDCJGgnsXLXM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260123085150epcas5p2d24c80d2533e2686ae44851c933af356~NUBwx8Xsz0573405734epcas5p2I;
	Fri, 23 Jan 2026 08:51:50 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dyBWB4RNyz2SSKX; Fri, 23 Jan
	2026 08:51:50 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260123085150epcas5p42f2cc04843ae7657380b2968261246cb~NUBwacDK80358703587epcas5p4b;
	Fri, 23 Jan 2026 08:51:50 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260123085149epsmtip150ee5a375d81d7371abf8766781cc373~NUBv8EOkD1815018150epsmtip1O;
	Fri, 23 Jan 2026 08:51:49 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, hy50.seo@samsung.com,
	kwangwon.min@samsung.com, ping.gao@samsung.com
Subject: [PATCH] drivers: dw_mmc: Replace  devm_clk_get with
 devm_clk_get_optional
Date: Fri, 23 Jan 2026 16:56:13 +0800
Message-ID: <20260123085613.182773-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

By using devm_clk_get_optional, if clk is optional for device and not define in dts
it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
bail out internally.

before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
not null,it will panic when call clk_prepare
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
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..6bcc1e7233c0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3375,7 +3375,7 @@ int dw_mci_probe(struct dw_mci *host)
 					     "platform data not available\n");
 	}
 
-	host->biu_clk = devm_clk_get(host->dev, "biu");
+	host->biu_clk = devm_clk_get_optional(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
 		ret = PTR_ERR(host->biu_clk);
-- 
2.50.1

