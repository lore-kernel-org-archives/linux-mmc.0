Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE039902E
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146883; cv=none; b=MOEK7Cm1ErjX3vVrqxID8TFkdWFtvdaCmqtWI3vOFVujjji48BN8obIsPHrIdtlNBvWO3l7gVevZabb36cp5c8c769cnpNmuERSOaGTxxHXpGPA/2d6/st4kP1TjQjArug74sVA6IjX/CWvVJ+GRjIBqlGiRvHOm2ar/0ACYNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146883; c=relaxed/simple;
	bh=wLbUbF6n+qyKrp2fBoAD7uQGHXFHJ6ESpWiXZrqCZgo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=FasPqpAVL8i36pe04DGMn7W1wp7Bay7RqEFlHnlb7Fe6xsCx1aaXkhYKCvL/1NdIYw4HqeFAZ8OrzzwnjUA9zFA4DwfaidLGU5FHawABHKkKfw7+bwRNf7mNJnX+2cBl0WbVWiyuet2MGJWL349+1NlIV0rYlLYp0TePt3EIheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ouz4n1kZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ouz4n1kZ"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260123054113epoutp03cf0be1b6883c7a9812787928a3e56ca6~NRbVWjvw81325113251epoutp03x
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 05:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260123054113epoutp03cf0be1b6883c7a9812787928a3e56ca6~NRbVWjvw81325113251epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769146873;
	bh=F/eGPpLX6QFOnASLMv6k2wOcYsOpxsncs2cEl8SqSJY=;
	h=From:To:Subject:Date:References:From;
	b=ouz4n1kZ9dxlXBtctqsdKYyhS2uCcOXEN5LOdlbc1+V+SaQm6F18K9H6rUaBUl4do
	 graSv5j2j3cL1Zus/orYUy7xzA/sl2JIioa4QoRjd9DOCR1OLWRNR2tEhNIU6sQ1No
	 RVgOn2qFvyIeXigclG0jNN+9O0Bsn0awOI424LUc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260123054113epcas5p313215c3cf5a7f51cd72806ffdf04178b~NRbVE-A4d0860908609epcas5p3s;
	Fri, 23 Jan 2026 05:41:13 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dy6HF3947z6B9mD; Fri, 23 Jan
	2026 05:41:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260123054113epcas5p26e6418eb49d2caa8e3ad048d14386189~NRbU6dskI1320913209epcas5p2w;
	Fri, 23 Jan 2026 05:41:13 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260123054112epsmtip1cd31d6deacc8a8fdb3cf2a074f4416d4~NRbUWlLvX3125931259epsmtip1d;
	Fri, 23 Jan 2026 05:41:12 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, hy50.seo@samsung.com,
	kwangwon.min@samsung.com, ping.gao@samsung.com
Subject: [PATCH] drivers: mmc: Replace manual
 devm_clk_get/clk_prepare_enable with devm_clk_get_optional_enabled
Date: Fri, 23 Jan 2026 13:45:27 +0800
Message-ID: <20260123054527.4151947-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260123054113epcas5p26e6418eb49d2caa8e3ad048d14386189
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123054113epcas5p26e6418eb49d2caa8e3ad048d14386189
References: <CGME20260123054113epcas5p26e6418eb49d2caa8e3ad048d14386189@epcas5p2.samsung.com>

By using , we:
- Automatically handle optional clocks (return NULL if not present).
- Ensure the clock is enabled upon acquisition.
This change reduces code complexity and improves reliability.

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
 drivers/mmc/host/dw_mmc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 61f6986f15ef..18981d010b62 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3375,20 +3375,10 @@ int dw_mci_probe(struct dw_mci *host)
 					     "platform data not available\n");
 	}
 
-	host->biu_clk = devm_clk_get(host->dev, "biu");
-	if (IS_ERR(host->biu_clk)) {
-		dev_dbg(host->dev, "biu clock not available\n");
-		ret = PTR_ERR(host->biu_clk);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-
-	} else {
-		ret = clk_prepare_enable(host->biu_clk);
-		if (ret) {
-			dev_err(host->dev, "failed to enable biu clock\n");
-			return ret;
-		}
-	}
+	host->biu_clk = devm_clk_get_optional_enabled(host->dev, "biu");
+	ret = PTR_ERR_OR_ZERO(host->biu_clk);
+	if (ret)
+		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");
 
 	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
-- 
2.50.1

