Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E22264C7
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797606; cv=none; b=b0uHYCunaSZHaISRxl3IoITs6Hcchb1DtGWjaSK/vpLeerpCwXhZHP8yNoxmcsqEIKaqgMCDdZd5lWWzG+AJ9jhtFB0OEGGzQP+oiZFP6tC/bFyemukfR0aDmt49JxTQusdSJzsXPmX+dqc6uvsJe0Z4SUCCylgj5yY3/1RKACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797606; c=relaxed/simple;
	bh=20MhMQdvv1/t0Zp4kmuk1IBJifpDZdi1OBLtJtTsFhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Hr5Zn+09z3P0P/s6Ur8e6a7jEHAq+q7boOUZtVbwCzdedGc6cPQersx916Bpgg1VVwG2/G0WIU8tpZH5pO0HzRT1KNmKLF7fHdJu8J9X4Sy7TC3dz9bLjZNk+rhi9LMCKsYQ2nlhSnmP0oDVfTjcJXVDU51UH6rESMDmV4Fz2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jA6BpwlU; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jA6BpwlU"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260211081321epoutp0417e0477ef3eb713e07589684178f120c~TIwlpCidn1137111371epoutp04O
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 08:13:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260211081321epoutp0417e0477ef3eb713e07589684178f120c~TIwlpCidn1137111371epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770797601;
	bh=2X3DXpmtJJK1596LRbkn8ZN54uyZcEpOq2PVoe4i4/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jA6BpwlUHOVJjcuOvp2FuY80iRTVwWkxp++KXqgw2z4CswmOZKBmCfc4abZzCR3C2
	 sS+ldtBNzt/WX6pvjjQENsB1kXUvxaLHbIgVrPgca0WiP7QcLK0AYBRJULLi2X0J6h
	 ydweDubm5bbsmvToyGtCRxY4Cmcnt8LhfrcdbpKs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260211081321epcas5p48f2b59296a74d2bf759a545cafbac63e~TIwlHmWTu3096030960epcas5p4Z;
	Wed, 11 Feb 2026 08:13:21 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f9rm11Ylnz6B9mC; Wed, 11 Feb
	2026 08:13:21 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260211081320epcas5p3fc67d4b1cf4508cb229b0187a78b5dc6~TIwkoI12T2473324733epcas5p35;
	Wed, 11 Feb 2026 08:13:20 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260211081320epsmtip280cd7a17ec98dd20ddee283e16ca69ca~TIwkE1RWM1116511165epsmtip2I;
	Wed, 11 Feb 2026 08:13:20 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH] drivers: dw_mmc: Replace devm_clk_get with
 devm_clk_get_optional
Date: Wed, 11 Feb 2026 16:18:01 +0800
Message-ID: <20260211081801.1213877-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211081320epcas5p3fc67d4b1cf4508cb229b0187a78b5dc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

On Fri, 23 Jan 2026 10:46:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 23 Jan 2026 at 09:51, ping.gao <ping.gao@samsung.com> wrote:
> >
> > By using devm_clk_get_optional, if clk is optional for device and not define in dts
> > it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
> > bail out internally.
> >
> > before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
> > not null,it will panic when call clk_prepare
> > log is below:
> > [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
> > [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> > [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
> > [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
> > [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
> > [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
> > ...
> > [  438.409424] [7:   binder:436_2: 4998] Call trace:
> > [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
> > [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
> > [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
> > [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
> > [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
> > [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
> > [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
> > [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
> > [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
> > [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
> > [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
> > [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
> > [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
> > [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
> > [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
> > [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
> > [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
> > [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
> > [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
> > [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
> > [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
> > [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
> > [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
> > [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
> > [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
> >
> > Signed-off-by: ping.gao <ping.gao@samsung.com>
> 
> You are not versioning your patches, which makes it difficult for me
> to manage them. Again, please read
> Documentation/process/submitting-patches.rst before you continue to
> post any more patches.
> 
> Anyway, I can pick this up as is for now, when Shawn has reviewed it.
> 
> Kind regards
> Uffe

Hi, Shawn:
 could you please review this patch?

best regards
Gaoping

> > ---
> >  drivers/mmc/host/dw_mmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index c5db92bbb094..6bcc1e7233c0 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -3375,7 +3375,7 @@ int dw_mci_probe(struct dw_mci *host)
> >                                              "platform data not available\n");
> >         }
> >
> > -       host->biu_clk = devm_clk_get(host->dev, "biu");
> > +       host->biu_clk = devm_clk_get_optional(host->dev, "biu");
> >         if (IS_ERR(host->biu_clk)) {
> >                 dev_dbg(host->dev, "biu clock not available\n");
> >                 ret = PTR_ERR(host->biu_clk);
> > --
> > 2.50.1
> >
