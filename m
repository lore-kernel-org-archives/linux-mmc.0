Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9731E0F0
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582191; cv=none; b=rkizhDYkApUxLVGL2MjKl4XmwO+jitsBBxlIf0dgREB4tbCv960d8AUMc7YphfX3fIimB4+tR8C3xKwloTd//NfJdPjZqDN6U/Azk3ZxQnmxPObhL2TKh+g5DIH8RAei3cPXnry5oaCNdHzeKxuooXV6F/lvDkP4/9DCnNvqKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582191; c=relaxed/simple;
	bh=HVX/Wt2hx1JxWQ0eGmrkX1gFyOjvF6XpXj5vmMWwcfU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ZC31lQGAA59x0EIRIt55aNCq+Ez9P+lVb1UIrLuYunfqX7KnGUgrhJajFXa6WTltOgs4Y1rX66dpL12DGhHjnnrgllDDkZQtzkH7/aPtKGLaWoy8C8FtuLQ/CxCuq1SOTlgpfml5s0g9by4Apn5gFqHU9KA3ENnBbF8y2H+yL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pv0zd5+/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pv0zd5+/"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260105030301epoutp0445d02039ab9e6a0bea9851879a3ef7ac~HtqD8MX6s2663026630epoutp04L
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 03:03:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260105030301epoutp0445d02039ab9e6a0bea9851879a3ef7ac~HtqD8MX6s2663026630epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767582181;
	bh=t4lDD3WCnMMhQlykdje1f6FHEkgbmJwv/kN8YwZTrUE=;
	h=From:To:Subject:Date:References:From;
	b=Pv0zd5+/QgqyS31R9djabbswqwxnupb1Qo9pKPQKMJLs31d68lwWxjr8qBVp0/sEc
	 yanCamkMflCvaJchMtOGPm+/C4ZgjDII74FBgC6CUokWXCPEvxfbQQeYoMAx2QU6XK
	 lxBYqbJomrdiGa9IK6rrTnsy/kBrWwMNEmfZCqF0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260105030300epcas5p2926fade68a4c1cd88ba71e7fa6a46e29~HtqDVAZgx3250432504epcas5p2Q;
	Mon,  5 Jan 2026 03:03:00 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dkzd04Q7nz3hhT9; Mon,  5 Jan
	2026 03:03:00 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260105030300epcas5p14bacc43f692cb7a7c46fd32ff5779004~HtqC9lLge1213112131epcas5p1t;
	Mon,  5 Jan 2026 03:03:00 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260105030259epsmtip124fe4762b0d1c0bf93c5f01527f94eba~HtqCaBKRJ2346223462epsmtip1F;
	Mon,  5 Jan 2026 03:02:59 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: RE:RE:RE:[PATCH] MMC:dw_mmc:when enable biu_clk should check
 whether this clk
Date: Mon,  5 Jan 2026 11:07:03 +0800
Message-ID: <20260105030703.1265749-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Hi: 1> when probe , because I not request biu_clk in dts , so it won't
	generate -EPROBE_DEFER 2> when probe , biu request like below :
	host->biu_clk = devm_clk_get(host->dev, "biu"); if (IS_ERR(host->biu_clk)) {
	dev_dbg(host->dev, "biu clock not available\n"); <<<<<< only report error ,
	probe still can run normal , I think it's no problem } else { ret =
	clk_prepare_enable(host->biu_clk); if (ret) { dev_err(host->dev, "failed to
 enable biu clock\n"); return ret; } } 3> when disable in suspend : int
	dw_mci_runtime_suspend(struct device *dev)
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260105030300epcas5p14bacc43f692cb7a7c46fd32ff5779004
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260105030300epcas5p14bacc43f692cb7a7c46fd32ff5779004
References: <CGME20260105030300epcas5p14bacc43f692cb7a7c46fd32ff5779004@epcas5p1.samsung.com>

	if (host->use_dma && host->dma_ops->exit)
		host->dma_ops->exit(host);

	dw_mci_ciu_clk_dis(host);

	if (host->slot &&
	    (mmc_can_gpio_cd(host->slot->mmc) || !mmc_card_is_removable(host->slot->mmc)))
		<<<<<<<<<<<<<<<<<when suspend it will disable, but it won't generate any problem ,because clk_disable_unprepare will use "(IS_ERR_OR_NULL(clk))" to check clk and only 
		<<<<<<<<<<<<<<<<<do return 
		clk_disable_unprepare(host->biu_clk);  

	return 0;
}

4> but in runtime_resume use clk_prepare_enable, in this function only use  "if (!clk)" so ERR clk will make panic. I think we should change "if (!clk)" to "if (IS_ERR_OR_NULL(clk))" in clk_prepare
int dw_mci_runtime_resume(struct device *dev)
{
...
	if (host->slot &&
	    (mmc_can_gpio_cd(host->slot->mmc) || !mmc_card_is_removable(host->slot->mmc))) {
		ret = clk_prepare_enable(host->biu_clk); 
		if (ret)
			return ret;
	}
}
 Gaoping
 
 
 
 Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jan 04, 2026 at 03:38:42PM +0800, Shawn Lin wrote:
>> Hi Sevastian,
>>
>> 
>>> Hi,
>>>
>>> On Sun, Jan 04, 2026 at 10:55:48AM +0800, Shawn Lin wrote:
>>>> 2026/01/04  10:38, ping.gao
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
