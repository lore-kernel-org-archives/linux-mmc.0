Received: from mail-m1973181.qiye.163.com (mail-m1973181.qiye.163.com [220.197.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E11E5207;
	Wed, 11 Feb 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804089; cv=none; b=Lk+Oux/yDA4UOGcXeZQCa57JKtsWV6wqrmalaCYASGTzXd0uBpapVRapBrboBni73p9GNq0P1J4dLHBnDWpf4rnVFmz1CGXkmWPrF5aHLODrgZD6yYwQtF/H+Xdbc8N27BhRNI+KTB6p8KiZlLfqmcr34I4v6kaQ7NBlL4dv7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804089; c=relaxed/simple;
	bh=a8ZgvVf85/uYBc3J36dF/nDj7fI8Zabe7eqxgLEp8Xg=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h1iy4hwaXmqULMkZuLVFiNPgOqGcc4KYZSzauahdDfLILBw3pELB5SpO3kpGYAe2pyXdnmWRWWrK8HBy44pLLpPW8T/oyJzZt8kMa7fjjyp85AAR/FzKYPGrLG8aU6m07vreu3MCmxLxeV8s3d0bzOY8MGm5s7wXAUydJsk1ZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BZ7bcFDf; arc=none smtp.client-ip=220.197.31.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BZ7bcFDf"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33db74222;
	Wed, 11 Feb 2026 17:56:07 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com,
 sebastian.reichel@collabora.com, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, hy50.seo@samsung.com, kwangwon.min@samsung.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dw_mmc: Replace devm_clk_get with
 devm_clk_get_optional
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260123085613.182773-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <91ec13ea-7e33-0cc8-8b5f-0c849862f958@rock-chips.com>
Date: Wed, 11 Feb 2026 17:56:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260123085613.182773-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c4c2126ad09cckunme5592c66f3a10
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktOSFYYTEIZSxhPTUJJHUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BZ7bcFDfzkMfUVw9qZey7cBOVBF/i9wMrK2FFuPkm11VdgnIWdh/yqswAEFzvwngpH74TZTr2+y+fdHDxgQcXX7oCIzwqawlbGPfsSuwy1zqiAjLZMHefP4PzPHrmj6o7HrT4g4M1N/mCIDru8y/PVErxEPVwJAEZNSE8PO4FUA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ek7j3g2ZKp5A89TceMjDXZ5UQL5Vs88rrwAQRiKON4g=;
	h=date:mime-version:subject:message-id:from;

Hi Ping Gao

在 2026/01/23 星期五 16:56, ping.gao 写道:
> By using devm_clk_get_optional, if clk is optional for device and not define in dts
> it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
> bail out internally.
> 

Sorry for not noticing this patch as the versioning problem.

You should improve the commit title to match the convention like:
mmc: dw_mmc: Using devm_clk_get_optional() for biu_clk

> before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
> not null,it will panic when call clk_prepare
> log is below:
> [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
> [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
> [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
> [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
> [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
> ...

The​ timestamp could be trimmed.

> [  438.409424] [7:   binder:436_2: 4998] Call trace:
> [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
> [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
> [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
> [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
> [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
> [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
> [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
> [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
> [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
> [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
> [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
> [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
> [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
> [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
> [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
> [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
> [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
> [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
> [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
> [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
> [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
> [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
> [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
> [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
> [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
> 
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..6bcc1e7233c0 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3375,7 +3375,7 @@ int dw_mci_probe(struct dw_mci *host)
>   					     "platform data not available\n");
>   	}
>   
> -	host->biu_clk = devm_clk_get(host->dev, "biu");
> +	host->biu_clk = devm_clk_get_optional(host->dev, "biu");

You change biu_clk to optional, so you need to update
Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
because minItems says 2 there.

And you also change the behaviour of drivers/mmc/host/dw_mmc-k3.c
which tries to set/get biu_clk and setup cards, it's apparently rely on
dw_mmc core to make biu_clk a must one.

So I suggest you at least need a extra 3rd patch to help dw_mmc-k3
identify missing biu_clk case.

For the next submission, please order the patchset as
1. synopsys-dw-mshc.yaml change
2. dw_mmc-k3 change
3. dw_mmc.c change

>   	if (IS_ERR(host->biu_clk)) {
>   		dev_dbg(host->dev, "biu clock not available\n");
>   		ret = PTR_ERR(host->biu_clk);
> 
