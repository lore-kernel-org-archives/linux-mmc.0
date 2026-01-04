Received: from mail-m3282.qiye.163.com (mail-m3282.qiye.163.com [220.197.32.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735A82866;
	Sun,  4 Jan 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767495669; cv=none; b=Bdo1Uz4bZo7D30NFw+QVJXv4IblKJ734hoN+7vFdluao+9fMkyBI4yWEo+M8243kA/MI2SpjQi+MzCyMgUNEffYS4t7iX1O0eXekVH/UBqCXdldfBGiUCsTx8BlN8JYqS4pIU9RB3ezZtaG4ISb0TvE1mbr3VGdb9mpsBvV69jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767495669; c=relaxed/simple;
	bh=sztPBXkWTLW2yR2Zdmxd8Hemf46lJfL7SstoacAwLps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dOs+QySRoLDDCDhhRxDQuGwmobCDCifNI8MrSdO5UO6DLQjjw4LZKZdsScgCIOLsdMiDvn58+gFXRsMXRrT56NQ1QahuY5FP84eHsGg0KaE5MUJDSvajUiC9cIroHjp8g1CyQxJye8zMcS75ZiojVBudueoIkFjoTugZ91TkBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Py/9Pdsg; arc=none smtp.client-ip=220.197.32.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Py/9Pdsg"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f64b64de;
	Sun, 4 Jan 2026 10:55:48 +0800 (GMT+08:00)
Message-ID: <b30a4977-7202-4771-8977-ff03e8453d16@rock-chips.com>
Date: Sun, 4 Jan 2026 10:55:48 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71@epcas5p3.samsung.com>
 <20260104023857.213329-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260104023857.213329-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b86eeb1f709cckunm99322d94616e47
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9OHlZMHh8dGExDGB8eGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Py/9Pdsgx3ZykXfFVg8Ca+DrBWXkBCZ0gkUFcwsRavTlpZgBmRFu7u9kpELkRUshEQzZYeGZz76aP1vpoUPboiI/9f186reBsLZugMyKBwenSGeigQ8dqRx8CuYHGODluLq6P5wSdlFTMnaryc+5L9BW4knMYUIrCNdOZjKoeD8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=fqc+H6gPmJx2X5KZxr+r30pQvj8UMLMvGDY3TCVIM4s=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/04 星期日 10:38, ping.gao 写道:
> some vendor doesn't use biu_clk , enable it will panic
> log is below:

I still don't understand the real issue you tried to solve.

host->biu_clk is got via devm_clk_get() in dw_mci_probe(). If
succeed, immediately it's enabled a few lines below. Otherwise,
dw_mci_probe() returns with failure. Seems you are not enabling it in
runtime callbacks, but why clk_prepare_enable(host->biu_clk) is able
to work when driver probed?


> [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
> [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
> [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
> [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
> [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
> ...
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
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..61f6986f15ef 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
>   	if (host->slot &&
>   	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
>   	     !mmc_card_is_removable(host->slot->mmc))) {
> -		ret = clk_prepare_enable(host->biu_clk);
> -		if (ret)
> -			return ret;
> +		if (IS_ERR(host->biu_clk)) {
> +			dev_dbg(host->dev, "biu clock not available\n");
> +		} else {
> +			ret = clk_prepare_enable(host->biu_clk);
> +			if (ret) {
> +				dev_err(host->dev, "failed to enable biu clock\n");
> +				goto err;
> +			}
> +		}
>   	}
>   
>   	ret = clk_prepare_enable(host->ciu_clk);

