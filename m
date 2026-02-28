Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AC346FB0
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259632; cv=none; b=odcpmgGgPJi6GaGMzqBJJUwmud9Id7xWToojXuZWy/MNtrYcpm5CcE9fpqRUTclWVke5nAout7UbShAu4K4GDvYLJk8eVwlp/8qIJynEn5d+BaUWkIoJE5vEFkaqxHW/VfjOqwI/vM6TOUBjGI9Ge1FAjQshFCsyiFWqBt1BGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259632; c=relaxed/simple;
	bh=nB1il0sYdv3OYTLXoH1UkbpvCamedfC0unIAzz3vQdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qjdLlwHDm8exgwmS/QHsQ4HRVRRWe147v2DxL/hzWPQzEBEvXmYsAizjPxjyaROTqSy4fEv5CfWXOyscOEF5zAdCgxQD1dmVYdi2VFow5w1I8Cg/R6giO3Lpna5G12uiM+grIScnEUIJK+SvxbHO8DsITRIZ3bUDKQYtJZPrGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sVZuXIyt; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sVZuXIyt"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260228062028epoutp04a76ecc618a9e7e8f6fa045b53dddd6ae~YVL4TlhyA2724027240epoutp042
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260228062028epoutp04a76ecc618a9e7e8f6fa045b53dddd6ae~YVL4TlhyA2724027240epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772259628;
	bh=+Sl8YfpTNqfjAMuMncatjZ6vJnJeyuHkz0bfA8is8t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVZuXIytul0u6SIuiMiNFVYVgFNdRFtk3gzs8WvPiihp3BgaRslS0J+cS2Be5Qbsm
	 OjcBNt1DbWajUOL0SXOpm5CEKuEbrHEqaz2drUifjQJY6hyHugpoh7/5TodSJynx03
	 mRDDSrkcZQIUCVWshWKai1GGvNjPCyCKE5Ca/JKg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260228062027epcas5p2af16c703526602ce051755f4be141dd5~YVL3GqUWD2344523445epcas5p22;
	Sat, 28 Feb 2026 06:20:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fNFRv2rGjz2SSKX; Sat, 28 Feb
	2026 06:20:27 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260228062026epcas5p2389be640a10d12934ce8696fbf6286c7~YVL2a4CAo1169611696epcas5p2z;
	Sat, 28 Feb 2026 06:20:26 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260228062025epsmtip2d35db1c119d519a8b7e8044b8a6fab5a~YVL1uGOs41943819438epsmtip2h;
	Sat, 28 Feb 2026 06:20:25 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kwangwon.min@samsung.com, hy50.seo@samsung.com, Ping Gao
	<ping.gao@samsung.com>
Subject: [PATCH v4 3/3] mmc: dw_mmc: Using devm_clk_get_optional() for
 biu_clk
Date: Sat, 28 Feb 2026 14:24:57 +0800
Message-ID: <20260228062457.3210099-4-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228062457.3210099-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260228062026epcas5p2389be640a10d12934ce8696fbf6286c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260228062026epcas5p2389be640a10d12934ce8696fbf6286c7
References: <20260228062457.3210099-1-ping.gao@samsung.com>
	<CGME20260228062026epcas5p2389be640a10d12934ce8696fbf6286c7@epcas5p2.samsung.com>

From: Ping Gao <ping.gao@samsung.com>

By using devm_clk_get_optional, if clk is optional for device and not define in dts
it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
bail out internally.

before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
not null,it will panic when call clk_prepare
log is below:
[7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
[7:   binder:436_2: 4998] Mem abort info:
[7:   binder:436_2: 4998]   ESR = 0x0000000096000005
[7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
[7:   binder:436_2: 4998]   SET = 0, FnV = 0
[7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
[7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
...
[7:   binder:436_2: 4998] Call trace:
[7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
[7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
[7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
[7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
[7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
[7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
[7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
[7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
[7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
[7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
[7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
[7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
[7:   binder:436_2: 4998]  state_store+0x104/0x144
[7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
[7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
[7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
[7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
[7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
[7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
[7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
[7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
[7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
[7:   binder:436_2: 4998]  el0_svc+0x38/0x68
[7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
[7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac

Signed-off-by: Ping Gao <ping.gao@samsung.com>
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

