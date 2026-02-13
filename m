Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAC271471
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960609; cv=none; b=FDl49xujJCWyIizYsEM2YfGIvcKSYuGJQ7LkckjVI+Y6XHtJU1Ow2Zuz99aQSB8YOubeQaOc0aXoggF5RvLkKdS1YxAyX0gorn16ns0pmF5IoS8zQ/zYgmOYcgt6B982b0jpIeqj/mM8ryGBzSmEtcUVLJ1jOz8GCMBGb574Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960609; c=relaxed/simple;
	bh=CggM2mHSN1GAi7yfUd4TMGBw6EKyJOevirHZuA3kvaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BzI8YW5zlHpLINSjSKPJIhtKboVbHz3IuOfcXmAZVEFP2FO3vmsnuyKGC5euFUk8BqeQZqTx5YPW7lfSsr8PLsIRjVKyGbdmKX13vMWA3MNx6ydw1z3V6O5U9xufh2IUYJfY9eOuVQMh0GLGMQ8IjA6hJHfStDoEL+sK4NH1JAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AQJqqUj7; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AQJqqUj7"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260213053005epoutp04474ce35c459a6d23745d02fad8149f4b~Tt0m_uxEa2531325313epoutp04F
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:30:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260213053005epoutp04474ce35c459a6d23745d02fad8149f4b~Tt0m_uxEa2531325313epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770960605;
	bh=odccMulAmDT3XHgDvrKdd8CLSnGU7dDKkomAg2ZSRLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQJqqUj7gULOoJWJgRqgn2fUAdUmbKKCTpQoTvPc9/LhUZKWaAbEur8FdQvnS1ygL
	 iSIE4SlvGK9Qm/o1R4+kOPa51/5ExZ7p3t+lXr+3PFj21RP0xUQkmk0yT1kMfhi75u
	 GF3IMsPjv5tGVeNAE/8ES+xEgx+kte0UGAU8K1Is=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260213053005epcas5p1e769a5ce07fd65d57cd7a9f80ba34bc2~Tt0mpDxvN1920819208epcas5p13;
	Fri, 13 Feb 2026 05:30:05 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fC12j2n3zz6B9mK; Fri, 13 Feb
	2026 05:30:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213053005epcas5p2604fbaec7d6e7129efdf0621850d54f4~Tt0mMe6VD3104531045epcas5p21;
	Fri, 13 Feb 2026 05:30:05 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260213053004epsmtip18d85eca30ed576ad1b127cbce711e2eb~Tt0lo0bbC1032510325epsmtip1D;
	Fri, 13 Feb 2026 05:30:04 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: [PATCH v3 3/3] mmc: dw_mmc: Using devm_clk_get_optional() for
 biu_clk
Date: Fri, 13 Feb 2026 13:34:48 +0800
Message-ID: <20260213053448.1337571-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213053005epcas5p2604fbaec7d6e7129efdf0621850d54f4
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

