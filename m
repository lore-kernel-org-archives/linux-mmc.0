Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com [101.71.155.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F91367;
	Mon,  5 Jan 2026 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577591; cv=none; b=ZlfYcZGH67MRtOfxlliE1/e9RRTB2LmfyHD80kDZma66pxUEHddhAFdu7qeBA0sVl48R+ISg97yHqjwtMyQyc7NXe0JvI+/WOZH2ly6lieF4eSQAZ1zTLiPF4v1wSDaoM/unH2oM7qSf3SgvuUKfnpPzMg65ZFM3kXSfYLKPsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577591; c=relaxed/simple;
	bh=MYUQO0TOvZ5iAfqYXpbY29gT4aSoaQay8A1y73+vvnc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IPHGQJ21pThpKVlIvnRANfI48sEGxFDtAxyqM5lUklf3Z7/n4tGMOhB4mn5HXSiEJ67FKRXVVJZri4MFQBQdlnG9K6/2RbEQu9ulxutEJpbrBGWOlGPOpLkZFJ8LkAJS/MNbDd7np0Z22r/lbmkiR5e0xKNF1RWfZsX8cbqBK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D2Q54oQj; arc=none smtp.client-ip=101.71.155.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D2Q54oQj"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f75adb6e;
	Mon, 5 Jan 2026 08:30:45 +0800 (GMT+08:00)
Message-ID: <93eeb6d3-db4e-4a82-a20f-f5481415c861@rock-chips.com>
Date: Mon, 5 Jan 2026 08:30:42 +0800
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
 <59dd1721-8913-4d62-9201-72bd17985b48@rock-chips.com>
 <aVp5IMvHKR8CtqSz@venus>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aVp5IMvHKR8CtqSz@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b8b903f5109cckunm7d7121086c3c7d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgeHVZKT0xOGktLTh4aGklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=D2Q54oQj957M5MXDKPWrirClaGT54QWE2rDDVXXNIO+Yp4zbLAgwBb04V1QRJt3hUjuQ1jsAT4uJGdS0iM4Q4oNENALirlpemM/XCYah5683hOxvOgamKHgdP3YkEYjNGh7EhqkRxTpr7J4eDbHuKXbYpiLpOkGquz4Wu4yKRVk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=S9oJFW0zQSJwPnYl/FryNtZ1dJFvucV+R9kj/LBYUto=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/04 星期日 22:48, Sebastian Reichel 写道:
> Hi,
> 
> On Sun, Jan 04, 2026 at 03:38:42PM +0800, Shawn Lin wrote:
>> Hi Sevastian,
>>
>> 在 2026/01/04 星期日 14:01, Sebastian Reichel 写道:
>>> Hi,
>>>
>>> On Sun, Jan 04, 2026 at 10:55:48AM +0800, Shawn Lin wrote:
>>>> 在 2026/01/04 星期日 10:38, ping.gao 写道:
>>>>> some vendor doesn't use biu_clk , enable it will panic
>>>>> log is below:
>>>>
>>>> I still don't understand the real issue you tried to solve.
>>>>
>>>> host->biu_clk is got via devm_clk_get() in dw_mci_probe(). If
>>>> succeed, immediately it's enabled a few lines below. Otherwise,
>>>> dw_mci_probe() returns with failure. Seems you are not enabling it in
>>>> runtime callbacks, but why clk_prepare_enable(host->biu_clk) is able
>>>> to work when driver probed?
>>>
>>> Based on the error and this patch, I believe what happens is:
>>>
>>> 1. dw_mci_probe() calls devm_clk_get(host->dev, "biu")
>>> 2. The clock does not exist on the platform from Ping Gao, so
>>>      host->biu_clk gets an error pointer assigned
>>> 3. "biu clock not available" gets printed at debug level
>>> 4. the error is ignored, but the error pointer is still assigned to
>>>      host->biu_clk
>>> 5. in the runtime PM handler clk_prepare_enable is called for
>>>      host->biu_clk and thus for an error pointer
>>>
>>
>> Thanks for the details. For example,
>> 1. dw_mci_exynos_probe() enables runtime PM before calling
>> dw_mci_pltfm_register()->dw_mci_probe().
>> 2. biu_clk gets an error and propagate it to dw_mci_pltfm_register(),
> 
> The error propagation does not happen. This is the current code in
> dw_mci_probe():
> 
>      host->biu_clk = devm_clk_get(host->dev, "biu");
> 	if (IS_ERR(host->biu_clk)) {
> 		dev_dbg(host->dev, "biu clock not available\n");
> 		ret = PTR_ERR(host->biu_clk);
> 		if (ret == -EPROBE_DEFER)
> 			return ret;
>          /* --- no return here --- */
> 	} else {
> 		ret = clk_prepare_enable(host->biu_clk);
> 		if (ret) {
> 			dev_err(host->dev, "failed to enable biu clock\n");
> 			return ret;
> 		}
>      }
> 
> This code continues probing for any error code that is not
> -EPROBE_DEFER. My understanding is, that this has been done
> intensionally, since the clock does not exist on some platforms.
> 

I never thought of biu_clk isn't been provided as it's for accessing
register/fifo/interrupt/DMA requested by dwc databook. I was
suprised it's the optional case for some platforms. What I was thinking
is all based on that defer case.

> Effectively this is an open coded devm_clk_get_optional with
> the difference that you may not use any clk_* operations on the
> error code. A minimal fix would be to assign "host->biu_clk = NULL;"
> at the end of the error handling code, which would open code
> more of the devm_clk_get_optional() behaviour.

Yes, if it's optional case for some platforms, we should use
devm_clk_get_optional() instead, both for biu_clk and ciu_clk.
Although I will also be surprised to see ciu_clk is also
optional, the code should be consistent.

> 
> Obviously there is no point in having this open coded and the
> helper existed since ages, so I strongly suggest to just use
> that. Either devm_clk_get_optional() or even better
> devm_clk_get_optional_enabled(). This results in:
> 
>   - less code, which is easier to understand
>   - fixing the bug at hand
>   - proper error handling for errors that are neither -EPROBE_DEFER
>     nor -ENOENT.
>   - better error/debug messaging behaviour for -EPROBE_DEFER when
>     using dev_err_probe() instead of the dev_dbg print.
> 
> Greetings,
> 
> -- Sebastian
> 
>> 3. runtime PM is disabled in dw_mci_exynos_probe() later if seeing error.
>>
>> Does that mean runtime PM handler is called between step 2 and step 3?
>> If that is the case, how could we allow this happen because the the
>> controller's configuaration isn't been finished yet. Or maybe I
>> misunderstand your point?
>>
>>
>>> Instead of hacking this up even further (as this patch does),
>>> the proper fix is to cleanup the probe function. I believe
>>> the complete biu clock handling in it could be reduced to this:
>>>
>>> 	host->biu_clk = devm_clk_get_optional_enabled(host->dev, "biu");
>>>       ret = PTR_ERR_OR_ZERO(host->biu_clk);
>>> 	if (ret)
>>> 		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");
>>>
>>> That will assign NULL to host->biu_clk when there is no clock
>>> defined and it is fine to run clk_prepare_enable() with NULL
>>> as clock pointer. Note, that this will handle the clock enabling
>>> as part of devm, so you will also have to drop the
>>> clk_disable_unprepare() calls from the err_clk_biu goto label
>>> and the extra call from dw_mci_remove().
>>>
>>> Something similar should probably be done for host->ciu_clk, which
>>> seems to have the same incorrect logic.
>>>
>>> Greetings,
>>>
>>> -- Sebastian
>>>
>>>>> [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
>>>>> [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
>>>>> [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
>>>>> [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>>> [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
>>>>> [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
>>>>> [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
>>>>> ...
>>>>> [  438.409424] [7:   binder:436_2: 4998] Call trace:
>>>>> [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
>>>>> [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
>>>>> [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
>>>>> [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
>>>>> [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
>>>>> [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
>>>>> [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
>>>>> [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
>>>>> [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
>>>>> [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
>>>>> [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
>>>>> [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
>>>>> [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
>>>>> [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
>>>>> [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
>>>>> [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
>>>>> [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
>>>>> [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
>>>>> [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
>>>>> [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
>>>>> [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
>>>>> [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
>>>>> [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
>>>>> [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
>>>>> [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
>>>>> Signed-off-by: ping.gao <ping.gao@samsung.com>
>>>>> ---
>>>>>     drivers/mmc/host/dw_mmc.c | 12 +++++++++---
>>>>>     1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>> index c5db92bbb094..61f6986f15ef 100644
>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>> @@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
>>>>>     	if (host->slot &&
>>>>>     	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
>>>>>     	     !mmc_card_is_removable(host->slot->mmc))) {
>>>>> -		ret = clk_prepare_enable(host->biu_clk);
>>>>> -		if (ret)
>>>>> -			return ret;
>>>>> +		if (IS_ERR(host->biu_clk)) {
>>>>> +			dev_dbg(host->dev, "biu clock not available\n");
>>>>> +		} else {
>>>>> +			ret = clk_prepare_enable(host->biu_clk);
>>>>> +			if (ret) {
>>>>> +				dev_err(host->dev, "failed to enable biu clock\n");
>>>>> +				goto err;
>>>>> +			}
>>>>> +		}
>>>>>     	}
>>>>>     	ret = clk_prepare_enable(host->ciu_clk);
>>>>
>>>>
>>

