Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7E234964
	for <linux-mmc@vger.kernel.org>; Sun,  4 Jan 2026 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494103; cv=none; b=r2fqNXUqvS8GuwdxmNUaJWmy6+e3jseDOuVB3pfdRaF54Rs0h6bDwFwa1DMKzelshDU/tR7e9Ek6nkigXe13L71mqK56LO14Jvj/qjR9pw5Uf5awtTK5G7XF5iyKLIg8pUiiRiostydVnES4T36p404HQO3XSDcxwhRBUuETu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494103; c=relaxed/simple;
	bh=EUZvGoTdOkUWYz8P6OHC2+RZ6IOmZtCaGzoocb3YJ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=h9eh489Yrq14r+LjFO3zG0qfCxIGh7UXhbpRBTJP0Zl8wMGhmiyyxr/PxyChVM/7WR/YZr9fwuQdTpZ7aKXAKu26FuY3Ruup6nJHtRM9ydvTCLnZe7MkWHCtSL6mV6byKAYNBT/OpNbOqsI/ftcTrC+Zylp3gieQjYSxv0kSVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Wcfww2a6; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wcfww2a6"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260104023452epoutp04bb4dc08325641a5c3f420aea6272e629~HZoMlqJLz0280902809epoutp04F
	for <linux-mmc@vger.kernel.org>; Sun,  4 Jan 2026 02:34:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260104023452epoutp04bb4dc08325641a5c3f420aea6272e629~HZoMlqJLz0280902809epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767494092;
	bh=RG/kY7Qlq4V2JzQcj5RVgZGOBVJiwVK0kGaENg9BWe4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Wcfww2a6wM7OM6g1RPuwCl4Xa5PPvo85+l/yHq0izURmvQVD1ct/xOt586rPUkojL
	 ipL8DeH8I7UM5JJu0lxJXRpeFsgMM+LnqT9sTg6nCFBQMIioqahHWmEev7Dlmj3Lty
	 uQxKiD9W9gPaVf3CNFulRIHVnxRuosKLehafAfJ8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260104023451epcas5p12513a78a61d77e700880c29f07db4c71~HZoMFlguT2353023530epcas5p16;
	Sun,  4 Jan 2026 02:34:51 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dkM2z4gQfz2SSKY; Sun,  4 Jan
	2026 02:34:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71~HZoLmPQ3I2916929169epcas5p3x;
	Sun,  4 Jan 2026 02:34:51 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260104023450epsmtip2b15bdfc581168772419101d71a96651a~HZoLEBF-E3184731847epsmtip2L;
	Sun,  4 Jan 2026 02:34:50 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
Date: Sun,  4 Jan 2026 10:38:57 +0800
Message-ID: <20260104023857.213329-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71
References: <CGME20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71@epcas5p3.samsung.com>

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

