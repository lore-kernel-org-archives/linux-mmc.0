Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355B2F1FC3;
	Sun,  4 Jan 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767512647; cv=none; b=LYNlm3MD3AlKe7eqOEAPPGo9iTu1SenfYl/+CQ4lyTvl+nrZLAxePzamKgbmYne2mYKykjjZeKXLqQAXJEmmELcO8+i9q70y3K4DSPgHJqSny0wjh5zRd2QHAoiXFnkPj+MwMLUn5fcqa2O2p+UlhcNZcQKQUJENl9LIUBrzwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767512647; c=relaxed/simple;
	bh=p70oK93HH7CrYXYRLl4I5CfAolEJGNeJxtZJ5YBxTn4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NaLua8pIXdYxaiasV9q6T1M7eT6Zt1h1MhMKUq+ousZAiTbrwFV7Vop+gQ8fmziMOg4XLmxzmlPon6vCQNoUwk3P4bGE/PMi4ndLrfix78sFTOzeGbMXIR5AD+SSkkToA8SOM5cDcDoM/hDAAKskdV+sX2YxeE2wjdnD4Ulkv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Yv28H2r1; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Yv28H2r1"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f6ac22c2;
	Sun, 4 Jan 2026 15:38:44 +0800 (GMT+08:00)
Message-ID: <59dd1721-8913-4d62-9201-72bd17985b48@rock-chips.com>
Date: Sun, 4 Jan 2026 15:38:42 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, "ping.gao" <ping.gao@samsung.com>,
 jh80.chung@samsung.com, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
To: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <CGME20260104023451epcas5p391708610b5ce46d0e2a5f4bfbad01c71@epcas5p3.samsung.com>
 <20260104023857.213329-1-ping.gao@samsung.com>
 <b30a4977-7202-4771-8977-ff03e8453d16@rock-chips.com>
 <aVn9K96d5CD5m_Y4@venus>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aVn9K96d5CD5m_Y4@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b87f1b77c09cckunmaef818ed65d655
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1NGFZDQhoYTx5NHkxDSUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Yv28H2r1qfvX6cZumNRB/7ouDlaVf59vGWVZsSa87zF1eW3jWXLZbeM0dxDEG9eAFj6zvllNCAtiWqm1vZLWkWxfnlyi8HjrAeHACvBsXRq/d8M2HsWKqoZhZjgPVpZajqFzTtsLb2KNvFC4OU09Oyhcj+0Z/3/ItC0jwNUeU1E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=d+I2XDi/dhlGSMHJal1vJfXJjqYueXb4+BuDFUs2SuU=;
	h=date:mime-version:subject:message-id:from;

Hi Sevastian,

在 2026/01/04 星期日 14:01, Sebastian Reichel 写道:
> Hi,
> 
> On Sun, Jan 04, 2026 at 10:55:48AM +0800, Shawn Lin wrote:
>> 在 2026/01/04 星期日 10:38, ping.gao 写道:
>>> some vendor doesn't use biu_clk , enable it will panic
>>> log is below:
>>
>> I still don't understand the real issue you tried to solve.
>>
>> host->biu_clk is got via devm_clk_get() in dw_mci_probe(). If
>> succeed, immediately it's enabled a few lines below. Otherwise,
>> dw_mci_probe() returns with failure. Seems you are not enabling it in
>> runtime callbacks, but why clk_prepare_enable(host->biu_clk) is able
>> to work when driver probed?
> 
> Based on the error and this patch, I believe what happens is:
> 
> 1. dw_mci_probe() calls devm_clk_get(host->dev, "biu")
> 2. The clock does not exist on the platform from Ping Gao, so
>     host->biu_clk gets an error pointer assigned
> 3. "biu clock not available" gets printed at debug level
> 4. the error is ignored, but the error pointer is still assigned to
>     host->biu_clk
> 5. in the runtime PM handler clk_prepare_enable is called for
>     host->biu_clk and thus for an error pointer
> 

Thanks for the details. For example,
1. dw_mci_exynos_probe() enables runtime PM before calling
dw_mci_pltfm_register()->dw_mci_probe().
2. biu_clk gets an error and propagate it to dw_mci_pltfm_register(),
3. runtime PM is disabled in dw_mci_exynos_probe() later if seeing error.

Does that mean runtime PM handler is called between step 2 and step 3?
If that is the case, how could we allow this happen because the the
controller's configuaration isn't been finished yet. Or maybe I
misunderstand your point?


> Instead of hacking this up even further (as this patch does),
> the proper fix is to cleanup the probe function. I believe
> the complete biu clock handling in it could be reduced to this:
> 
> 	host->biu_clk = devm_clk_get_optional_enabled(host->dev, "biu");
>      ret = PTR_ERR_OR_ZERO(host->biu_clk);
> 	if (ret)
> 		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");
> 
> That will assign NULL to host->biu_clk when there is no clock
> defined and it is fine to run clk_prepare_enable() with NULL
> as clock pointer. Note, that this will handle the clock enabling
> as part of devm, so you will also have to drop the
> clk_disable_unprepare() calls from the err_clk_biu goto label
> and the extra call from dw_mci_remove().
> 
> Something similar should probably be done for host->ciu_clk, which
> seems to have the same incorrect logic.
> 
> Greetings,
> 
> -- Sebastian
> 
>>> [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
>>> [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
>>> [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
>>> [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
>>> [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
>>> [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
>>> ...
>>> [  438.409424] [7:   binder:436_2: 4998] Call trace:
>>> [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
>>> [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
>>> [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
>>> [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
>>> [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
>>> [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
>>> [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
>>> [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
>>> [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
>>> [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
>>> [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
>>> [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
>>> [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
>>> [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
>>> [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
>>> [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
>>> [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
>>> [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
>>> [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
>>> [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
>>> [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
>>> [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
>>> [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
>>> [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
>>> [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
>>> Signed-off-by: ping.gao <ping.gao@samsung.com>
>>> ---
>>>    drivers/mmc/host/dw_mmc.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index c5db92bbb094..61f6986f15ef 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
>>>    	if (host->slot &&
>>>    	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
>>>    	     !mmc_card_is_removable(host->slot->mmc))) {
>>> -		ret = clk_prepare_enable(host->biu_clk);
>>> -		if (ret)
>>> -			return ret;
>>> +		if (IS_ERR(host->biu_clk)) {
>>> +			dev_dbg(host->dev, "biu clock not available\n");
>>> +		} else {
>>> +			ret = clk_prepare_enable(host->biu_clk);
>>> +			if (ret) {
>>> +				dev_err(host->dev, "failed to enable biu clock\n");
>>> +				goto err;
>>> +			}
>>> +		}
>>>    	}
>>>    	ret = clk_prepare_enable(host->ciu_clk);
>>
>>

